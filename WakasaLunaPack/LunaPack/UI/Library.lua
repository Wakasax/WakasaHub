-- Wakasa Luna Pack Client
-- By: Wakasa
-- Version: 1.1.0

local LunaPack = {
    Version = "1.1.0",
    Author = "Wakasa",
    Config = {},
    Modules = {},
    UI = nil
}

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Função principal de inicialização
function LunaPack:Init()
    self:LoadConfig()
    self:LoadModules()
    self:InitUI()
    self:ApplySettings()
    
    self:CheckUpdates()
    
    warn(string.format(
        "\n\n[LunaPack] Client v%s carregado com sucesso!\n%s\n",
        self.Version,
        "https://github.com/WakasaDev/WakasaLunaPack"
    ))
end

-- Carrega configurações
function LunaPack:LoadConfig()
    local defaultConfig = {
        UnlockFPS = true,
        TargetFPS = 144,
        GraphicsPreset = "Balanced",
        UITheme = "Dark",
        Notifications = true,
        AutoClean = false
    }

    if not isfile("WakasaLunaPack/Config.json") then
        self.Config = defaultConfig
        self:SaveConfig()
    else
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("WakasaLunaPack/Config.json"))
        end)
        self.Config = success and result or defaultConfig
    end
end

function LunaPack:SaveConfig()
    writefile(
        "WakasaLunaPack/Config.json",
        game:GetService("HttpService"):JSONEncode(self.Config)
    )
end

-- Carrega módulos
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
                print("[LunaPack] Módulo carregado:", name)
            else
                warn("[LunaPack] Erro ao carregar módulo "..name..":", module)
            end
        else
            warn("[LunaPack] Arquivo não encontrado:", path)
        end
    end
end

-- Inicializa a interface
function LunaPack:InitUI()
    if not self.Modules.UILibrary then
        warn("[LunaPack] Biblioteca UI não encontrada!")
        return
    end

    self.UI = self.Modules.UILibrary:CreateWindow("Wakasa Luna Pack")
    self.UI:SetTheme(self.Config.UITheme or "Dark")

    -- Tab Início
    local homeTab = self.UI:AddTab("Início")
    homeTab:AddLabel("Bem-vindo ao Wakasa Luna Pack!")
    homeTab:AddButton("Otimizar Agora", function()
        self.Modules.Performance:Optimize()
        self.Modules.Graphics:ApplyPreset(self.Config.GraphicsPreset)
        self.UI:Notify("Sucesso", "Otimizações aplicadas!")
    end)

    -- Tab Performance
    local perfTab = self.UI:AddTab("Performance")
    perfTab:AddToggle("Desbloquear FPS", self.Config.UnlockFPS, function(state)
        self.Config.UnlockFPS = state
        self.Modules.Graphics:UnlockFPS(state)
    end)
    
    perfTab:AddSlider("FPS Alvo", {30, 360}, self.Config.TargetFPS, function(value)
        self.Config.TargetFPS = value
        if self.Config.UnlockFPS then
            self.Modules.Graphics:UnlockFPS(true)
        end
    end)

    -- Tab Gráficos
    local graphicsTab = self.UI:AddTab("Gráficos")
    graphicsTab:AddDropdown("Qualidade", {"Baixa", "Balanceada", "Alta"}, self.Config.GraphicsPreset, function(option)
        self.Config.GraphicsPreset = option
        self.Modules.Graphics:ApplyPreset(option)
    end)

    -- Tab Configurações
    local settingsTab = self.UI:AddTab("Configurações")
    settingsTab:AddDropdown("Tema UI", {"Dark", "Light", "Cyber"}, self.Config.UITheme, function(theme)
        self.Config.UITheme = theme
        self.UI:SetTheme(theme)
    end)
    
    settingsTab:AddButton("Salvar Configurações", function()
        self:SaveConfig()
        self.UI:Notify("Configurações", "Configurações salvas com sucesso!")
    end)
end

-- Aplica configurações iniciais
function LunaPack:ApplySettings()
    if self.Modules.Graphics then
        self.Modules.Graphics:ApplyPreset(self.Config.GraphicsPreset)
        self.Modules.Graphics:UnlockFPS(self.Config.UnlockFPS)
    end
    
    if self.Modules.Performance and self.Config.AutoClean then
        self.Modules.Performance:CleanWorkspace()
    end
end

-- Sistema de atualização
function LunaPack:CheckUpdates()
    if not _G.LunaPackLoaded then
        _G.LunaPackLoaded = true
        
        local versionURL = "https://raw.githubusercontent.com/WakasaDev/WakasaLunaPack/main/version.txt"
        local success, onlineVersion = pcall(function()
            return game:HttpGet(versionURL)
        end)
        
        if success and onlineVersion and onlineVersion ~= self.Version then
            task.spawn(function()
                local updateConfirmed = self.UI:Prompt(
                    "Atualização Disponível",
                    "Versão "..onlineVersion.." disponível! Deseja atualizar?",
                    {"Sim", "Depois"}
                )
                
                if updateConfirmed == "Sim" then
                    self:PerformUpdate()
                end
            end)
        end
    end
end

function LunaPack:PerformUpdate()
    local updateFiles = {
        Main = "https://raw.githubusercontent.com/WakasaDev/WakasaLunaPack/main/Main.lua",
        Version = "https://raw.githubusercontent.com/WakasaDev/WakasaLunaPack/main/version.txt"
    }
    
    self.UI:Notify("Atualizando", "Baixando nova versão...")
    
    for name, url in pairs(updateFiles) do
        local path = "WakasaLunaPack/"..(name == "Version" and "version.txt" or "Main.lua")
        writefile(path, game:HttpGet(url))
    end
    
    self.UI:Notify("Sucesso", "Atualização completa! Reiniciando...")
    task.wait(2)
    
    -- Reinicia o client
    loadstring(readfile("WakasaLunaPack/Main.lua"))()
end

-- Inicializa o client
if not _G.LunaPackInstance then
    _G.LunaPackInstance = LunaPack
    LunaPack:Init()
end

return LunaPack