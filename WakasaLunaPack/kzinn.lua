--[[
  LunaPack Debugger v1.0
  Sistema completo de logs estilo Krnl para desenvolvimento em Roblox
  Recursos:
  - Visual profissional com abas organizadas
  - Registro de funções com códigos
  - Histórico de eventos
  - Controle de logging
  - Anti-spam inteligente
--]]

-- Carrega a OrionLib
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()
end)

if not success then
    warn("Falha ao carregar OrionLib")
    return
end

-- Configuração principal
local Window = OrionLib:MakeWindow({
    Name = "LunaPack Debugger",
    HidePremium = false,
    SaveConfig = false,
    IntroEnabled = false,
    Icon = "rbxassetid://7734053491"
})

-- Variáveis do sistema
local logs = {}
local logCooldowns = {}
local MAX_LOGS = 30
local loggingEnabled = true

-- Função principal de logging
function AddLog(logType, message, funcCode)
    if not loggingEnabled then return end
    
    -- Anti-spam (2 segundos para logs idênticos)
    local logKey = logType..message
    if logCooldowns[logKey] and (os.time() - logCooldowns[logKey] < 2) then
        return
    end
    logCooldowns[logKey] = os.time()
    
    -- Formatação do log
    local timestamp = os.date("%H:%M:%S")
    local formattedLog = {
        text = string.format("[%s] %s: %s", timestamp, logType:upper(), message),
        code = funcCode or "No code available",
        time = os.time()
    }
    
    -- Adiciona ao histórico
    table.insert(logs, 1, formattedLog)
    if #logs > MAX_LOGS then
        table.remove(logs)
    end
    
    -- Atualiza a UI
    if LogTab then
        UpdateLogDisplay()
    end
end

-- Criação das abas
local LogTab = Window:MakeTab({
    Name = "Event Logs",
    Icon = "rbxassetid://7733960981"
})

local ConfigTab = Window:MakeTab({
    Name = "Configuration",
    Icon = "rbxassetid://7733765392"
})

-- Atualiza a exibição de logs
function UpdateLogDisplay()
    if not LogTab then return end
    
    LogTab:Clear()
    
    -- Cabeçalho
    LogTab:AddSection({
        Name = "LIVE EVENT TRACKING"
    })
    
    -- Último log
    if #logs > 0 then
        LogTab:AddParagraph(logs[1].text, "")
        
        -- Botão para copiar função
        LogTab:AddButton({
            Name = "COPY FUNCTION CODE",
            Callback = function()
                setclipboard(logs[1].code)
                OrionLib:MakeNotification({
                    Name = "Code Copied",
                    Content = "Function copied to clipboard",
                    Time = 2
                })
            end
        })
    else
        LogTab:AddParagraph("No events logged yet...", "")
    end
    
    -- Histórico
    LogTab:AddSection({
        Name = "EVENT HISTORY (last 10)"
    })
    
    for i = 1, math.min(10, #logs) do
        LogTab:AddParagraph(logs[i].text, "")
    end
end

-- Configurações
ConfigTab:AddToggle({
    Name = "Enable Logging",
    Default = true,
    Callback = function(value)
        loggingEnabled = value
        AddLog("SYSTEM", value and "Logging enabled" or "Logging disabled")
    end
})

ConfigTab:AddSlider({
    Name = "Max Logs",
    Min = 10,
    Max = 100,
    Default = 30,
    Color = Color3.fromRGB(255, 170, 0),
    Increment = 5,
    Callback = function(value)
        MAX_LOGS = value
    end
})

ConfigTab:AddButton({
    Name = "Clear All Logs",
    Callback = function()
        logs = {}
        logCooldowns = {}
        UpdateLogDisplay()
        AddLog("SYSTEM", "All logs cleared")
    end
})

-- Debug functions
local function debugHook(eventType)
    return function(...)
        local args = {...}
        local debugInfo = debug.getinfo(2)
        local funcName = debugInfo.name or "anonymous"
        local source = debugInfo.source:match("[^/]+$") or "unknown"
        
        local message = string.format("%s called from %s", funcName, source)
        local code = string.format("-- Function: %s\nlocal function %s(%s)\n    -- Original code\nend", 
            funcName, funcName, table.concat(args, ", "))
        
        AddLog(eventType, message, code)
    end
end

-- Auto-logging de exemplo
task.spawn(function()
    while task.wait(5) do
        if loggingEnabled then
            AddLog("DEBUG", "System heartbeat", [[
                -- Auto-generated keepalive
                local function systemPulse()
                    return os.clock()
                end
            ]])
        end
    end
end)

-- Inicialização
AddLog("SYSTEM", "Debugger initialized", [[
    local LunaPack = {
        AddLog = function(type, msg, code)
            -- Main logging function
        end
    }
]])

UpdateLogDisplay()

return {
    AddLog = AddLog,
    ToggleLogging = function(state) loggingEnabled = state end,
    ClearLogs = function()
        logs = {}
        logCooldowns = {}
    end
}