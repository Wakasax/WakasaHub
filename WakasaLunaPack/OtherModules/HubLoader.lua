-- WakasaHub Loader
-- By: Wakasa
-- Version: 1.0

local WakasaHub = {
    Modules = {},
    Config = {
        AutoUpdate = true,
        DefaultModules = {"LunaPack"}
    }
}

function WakasaHub:LoadModule(moduleName)
    local moduleUrl = "https://raw.githubusercontent.com/Wakasax/WakasaHub/main/"..moduleName.."/Main.lua"
    
    local success, result = pcall(function()
        return loadstring(game:HttpGet(moduleUrl))()
    end)
    
    if success then
        self.Modules[moduleName] = result
        print("[WakasaHub] Módulo carregado:", moduleName)
        return true
    else
        warn("[WakasaHub] Falha ao carregar "..moduleName..":", result)
        return false
    end
end

function WakasaHub:Init()
    -- Carrega módulos padrão
    for _, module in pairs(self.Config.DefaultModules) do
        self:LoadModule(module)
    end
    
    -- Interface do hub
    self:CreateUI()
    
    print("[WakasaHub] Inicializado com sucesso!")
end

function WakasaHub:CreateUI()
    -- Sua implementação UI do hub aqui
end

-- Inicialização
WakasaHub:Init()
return WakasaHub