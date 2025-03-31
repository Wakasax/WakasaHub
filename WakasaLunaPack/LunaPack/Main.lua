--[[
  Wakasa Luna Pack Client
  By: Wakasa
  Version: 1.2.0
  Repository: https://github.com/Wakasax/WakasaHub
]]

local LunaPack = {
    Version = "1.2.0",
    Author = "Wakasa",
    Config = {},
    Modules = {},
    UI = nil,
    IsStandalone = not _G.WakasaHub,
    DebugMode = false
}

-- Serviços essenciais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- Constantes
local CONFIG_PATH = "WakasaLunaPack/Config.json"
local REPO_BASE = "https://raw.githubusercontent.com/Wakasax/WakasaHub/main/"
local UPDATE_INTERVAL = 60 * 30 -- 30 minutos

--[[
  ======================
  FUNÇÕES PRINCIPAIS
  ======================
]]

function LunaPack:Init()
    self:SetupFolders()
    self:LoadConfig()
    self:LoadModules()
    self:InitUI()
    self:ApplySettings()
    
    self:CheckUpdates(true) -- Verificação inicial
    self:SetupAutoUpdate()
    
    self:DebugPrint("Client inicializado com sucesso!")
end

--[[
  ======================
  SISTEMA DE CONFIGURAÇÕES
  ======================
]]

function LunaPack:LoadConfig()
    local defaultConfig = {
        UnlockFPS = true,
        TargetFPS = 144,
        GraphicsPreset = "Balanced",
        UITheme = "Dark",
        Notifications = true,
        AutoClean = false,
        AutoUpdate = true,
        LastUpdateCheck = 0
    }

    if not isfile(CONFIG_PATH) then
        self.Config = defaultConfig
        self:SaveConfig()
    else
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(CONFIG_PATH))
        end)
        self.Config = success and result or defaultConfig
    end
end

function LunaPack:SaveConfig()
    self.Config.LastUpdateCheck = os.time()
    writefile(CONFIG_PATH, HttpService:JSONEncode(self.Config))
end

--[[
  ======================
  SISTEMA DE MÓDULOS
  ======================
]]

function LunaPack:LoadModules()
    local moduleList = {
        Performance = "WakasaLunaPack/Modules/Performance.lua",
        Graphics = "WakasaLunaPack/Modules/Graphics.lua",
        Utilities = "WakasaLunaPack/Modules/Utilities.lua",
        UILibrary = "WakasaLunaPack/UI/Library.lua"
    }

    for name, path in pairs(moduleList) do
        if isfile(path) then
            local success, module = pcall(function()
                return loadstring(readfile(path))()
            end)
            
            if success then
                self.Modules[name] = module
                self:DebugPrint("Módulo carregado: "..name)
            else
                warn("[Erro] Falha ao carregar "..name..":", module)
            end
        else
            warn("[Aviso] Arquivo não encontrado:", path)
        end
    end
end

--[[
  ======================
  SISTEMA DE ATUALIZAÇÃO
  ======================
]]

function LunaPack:CheckUpdates(initialCheck)
    if not self.Config.AutoUpdate and not initialCheck then return end
    if os.time() - self.Config.LastUpdateCheck < UPDATE_INTERVAL then return end
    
    local versionUrl = REPO_BASE .. (self.IsStandalone and "LunaPack/version.txt" or "version.txt")
    
    local success, onlineVersion = pcall(function()
        return HttpService:GetAsync(versionUrl, true)
    end)
    
    if success and onlineVersion and onlineVersion ~= self.Version then
        self:DebugPrint("Nova versão disponível: "..onlineVersion)
        
        if self.UI then
            local choice = self.UI:Prompt(
                "Atualização Disponível",
                "Versão "..onlineVersion.." disponível!\nDeseja atualizar agora?",
                {"Sim", "Mais Tarde", "Ignorar Esta Versão"}
            )
            
            if choice == "Sim" then
                self:PerformUpdate()
            elseif choice == "Ignorar Esta Versão" then
                self.Config.LastUpdateCheck = os.time()
                self:SaveConfig()
            end
        else
            self:PerformUpdate()
        end
    elseif initialCheck then
        self:DebugPrint("Você está na versão mais recente: "..self.Version)
    end
    
    self.Config.LastUpdateCheck = os.time()
    self:SaveConfig()
end

function LunaPack:PerformUpdate()
    self:DebugPrint("Iniciando atualização...")
    
    local filesToUpdate = {
        Main = "Main.lua",
        Version = "version.txt",
        Modules = {
            "Performance.lua",
            "Graphics.lua",
            "Utilities.lua"
        }
    }
    
    -- Cria backup
    if not isfolder("WakasaLunaPack/Backup") then
        makefolder("WakasaLunaPack/Backup")
    end
    
    local backupFolder = "WakasaLunaPack/Backup/" .. os.date("%Y-%m-%d_%H-%M-%S")
    makefolder(backupFolder)
    
    -- Atualiza arquivos
    for fileType, fileName in pairs(filesToUpdate) do
        if type(fileName) == "table" then
            for _, moduleFile in ipairs(fileName) do
                self:UpdateFile("Modules/"..moduleFile, backupFolder)
            end
        else
            self:UpdateFile(fileName, backupFolder)
        end
    end
    
    self:DebugPrint("Atualização concluída! Reiniciando...")
    task.wait(2)
    
    -- Reinicia o client
    loadstring(readfile("WakasaLunaPack/Main.lua"))()
end

function LunaPack:UpdateFile(fileName, backupFolder)
    local localPath = "WakasaLunaPack/"..fileName
    local repoPath = self.IsStandalone and "LunaPack/"..fileName or fileName
    
    -- Faz backup
    if isfile(localPath) then
        writefile(backupFolder.."/"..fileName, readfile(localPath))
    end
    
    -- Baixa nova versão
    local success, content = pcall(function()
        return HttpService:GetAsync(REPO_BASE..repoPath, true)
    end)
    
    if success then
        writefile(localPath, content)
        self:DebugPrint("Arquivo atualizado: "..fileName)
    else
        warn("Falha ao atualizar "..fileName..":", content)
    end
end

function LunaPack:SetupAutoUpdate()
    coroutine.wrap(function()
        while task.wait(UPDATE_INTERVAL) do
            self:CheckUpdates()
        end
    end)()
end

--[[
  ======================
  INTERFACE DO USUÁRIO
  ======================
]]

function LunaPack:InitUI()
    if not self.Modules.UILibrary then return end
    
    self.UI = self.Modules.UILibrary:CreateWindow("Wakasa Luna Pack v"..self.Version)
    self.UI:SetTheme(self.Config.UITheme)
    
    -- Tab Início
    local homeTab = self.UI:AddTab("Início")
    homeTab:AddLabel("Bem-vindo ao Wakasa Luna Pack!")
    homeTab:AddButton("Otimizar Jogo", function()
        self:OptimizeGame()
    end)
    
    -- Tab Performance
    local perfTab = self.UI:AddTab("Performance")
    perfTab:AddToggle("Desbloquear FPS", self.Config.UnlockFPS, function(state)
        self.Config.UnlockFPS = state
        self.Modules.Graphics:UnlockFPS(state)
    end)
    
    -- Tab Configurações
    local settingsTab = self.UI:AddTab("Configurações")
    settingsTab:AddButton("Verificar Atualizações", function()
        self:CheckUpdates(true)
    end)
end

--[[
  ======================
  FUNÇÕES UTILITÁRIAS
  ======================
]]

function LunaPack:OptimizeGame()
    if self.Modules.Performance then
        self.Modules.Performance:Optimize()
    end
    
    if self.Modules.Graphics then
        self.Modules.Graphics:ApplyPreset(self.Config.GraphicsPreset)
    end
    
    if self.UI then
        self.UI:Notify("Otimização Completa", "Configurações aplicadas com sucesso!")
    end
end

function LunaPack:SetupFolders()
    local folders = {
        "WakasaLunaPack",
        "WakasaLunaPack/UI",
        "WakasaLunaPack/UI/Themes",
        "WakasaLunaPack/UI/Elements",
        "WakasaLunaPack/Modules",
        "WakasaLunaPack/Backup"
    }
    
    for _, folder in ipairs(folders) do
        if not isfolder(folder) then
            makefolder(folder)
        end
    end
end

function LunaPack:DebugPrint(message)
    if self.DebugMode then
        print("[LunaPack Debug]", message)
    end
end

--[[
  ======================
  INICIALIZAÇÃO
  ======================
]]

if not _G.LunaPackInstance then
    _G.LunaPackInstance = LunaPack
    LunaPack:Init()
end

return LunaPack