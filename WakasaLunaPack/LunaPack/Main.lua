-- Wakasa Luna Pack Universal
-- By: Wakasa
-- Versão: 2.0.0 (Multi-Executor)
-- GitHub: https://github.com/Wakasax/WakasaHub

local LunaPack = {
    Version = "2.0.0",
    Executor = "Unknown",
    Config = {},
    Modules = {},
    UI = nil
}

-- 🔍 Detecta o executor automaticamente
function LunaPack:DetectExecutor()
    local executors = {
        ["Synapse"] = (syn and not is_sirhurt_closure),
        ["ScriptWare"] = (identifyexecutor and string.find(string.lower(identifyexecutor()), "scriptware")),
        ["Vega X"] = (VegaX and VegaX.HttpGet ~= nil),
        ["Krnl"] = (KRNL_LOADED or krnl ~= nil),
        ["Fluxus"] = (getexecutorname and string.find(string.lower(getexecutorname()), "fluxus"))
    }

    for name, check in pairs(executors) do
        if check then
            self.Executor = name
            break
        end
    end
end

-- 📥 Sistema de carregamento universal
function LunaPack:HttpGet(url)
    local success, content
    if self.Executor == "Vega X" then
        success, content = pcall(VegaX.HttpGet, url)
    elseif self.Executor == "Synapse" then
        success, content = pcall(syn.request, { Url = url }).Body
    else
        success, content = pcall(game.HttpGet, game, url)
    end
    return success and content or nil
end

-- 📂 Sistema de arquivos universal
function LunaPack:SaveFile(path, content)
    if self.Executor == "Vega X" then
        VegaX.FileSystem.Write(path, content)
    elseif self.Executor == "Synapse" then
        writefile(path, content)
    else
        if not isfolder("WakasaLunaPack") then
            makefolder("WakasaLunaPack")
        end
        writefile(path, content)
    end
end

-- 🔄 Carrega módulos
function LunaPack:LoadModule(name, path)
    local url = "https://raw.githubusercontent.com/Wakasax/WakasaHub/main/LunaPack/" .. path
    local content = self:HttpGet(url)
    
    if content then
        local func, err = loadstring(content)
        if func then
            self.Modules[name] = func()
            return true
        else
            warn("[LunaPack] Erro ao carregar " .. name .. ":", err)
        end
    end
    return false
end

-- 🚀 Inicialização
function LunaPack:Init()
    self:DetectExecutor()
    print("[LunaPack] Executor detectado:", self.Executor)

    -- Carrega módulos essenciais
    self:LoadModule("Performance", "Modules/Performance.lua")
    self:LoadModule("Graphics", "Modules/Graphics.lua")
    self:LoadModule("UILibrary", "UI/Library.lua")

    -- Configurações padrão
    if not self:LoadConfig() then
        self.Config = {
            UnlockFPS = true,
            TargetFPS = 144,
            Theme = "Dark"
        }
        self:SaveConfig()
    end

    -- Inicia a UI
    if self.Modules.UILibrary then
        self.UI = self.Modules.UILibrary:CreateWindow("LunaPack v" .. self.Version)
        self:SetupUI()
    end

    -- Aplica otimizações
    if self.Modules.Performance then
        self.Modules.Performance:Optimize()
    end

    warn("[LunaPack] Client carregado com sucesso!")
end

-- ▶️ Inicia o client
LunaPack:Init()
return LunaPack