-- Carrega a OrionLib
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Configuração da janela principal
local Window = OrionLib:MakeWindow({
    Name = "LunaPack Dev Logger",
    HidePremium = true,
    ConfigFolder = "LunaPackLogs"
})

-- Variáveis do sistema
local logs = {}
local logCooldowns = {}
local MAX_LOGS = 50
local loggingEnabled = true
local lastFunctionCopied = ""

-- Função principal para adicionar logs
function AddLog(logType, message, functionCode)
    if not loggingEnabled then return end
    
    -- Verifica se o log já foi registrado recentemente
    local logKey = logType .. message
    if logCooldowns[logKey] and (os.time() - logCooldowns[logKey] < 2) then
        return
    end
    
    logCooldowns[logKey] = os.time()
    
    -- Formata o log
    local timestamp = os.date("[%H:%M:%S]")
    local logEntry = {
        text = string.format("%s %s: %s", timestamp, logType:upper(), message),
        code = functionCode or "N/A"
    }
    
    -- Adiciona ao histórico
    table.insert(logs, 1, logEntry)
    
    -- Limita o número de logs
    if #logs > MAX_LOGS then
        table.remove(logs, MAX_LOGS + 1)
    end
    
    -- Atualiza a UI
    UpdateLogDisplay()
end

-- Atualiza a exibição dos logs
function UpdateLogDisplay()
    if not Window.CurrentTab or Window.CurrentTab.Name ~= "Logs" then return end
    
    Window.CurrentTab:Clear()
    Window.CurrentTab:AddSection({
        Name = "Histórico de Logs"
    })
    
    for i, log in ipairs(logs) do
        local paragraph = Window.CurrentTab:AddParagraph(log.text, "")
        
        Window.CurrentTab:AddButton({
            Name = "📋 Copiar Código #"..i,
            Callback = function()
                setclipboard(log.code)
                lastFunctionCopied = log.code
                OrionLib:MakeNotification({
                    Name = "Código copiado!",
                    Content = "Função copiada para área de transferência",
                    Time = 3
                })
            end
        })
    end
end

-- Aba de Configuração
local ConfigTab = Window:MakeTab({
    Name = "Configurações",
    Icon = "rbxassetid://7733765392"
})

ConfigTab:AddToggle({
    Name = "Ativar Registro de Logs",
    Default = true,
    Callback = function(value)
        loggingEnabled = value
        AddLog("SISTEMA", value and "Logs ativados" or "Logs desativados")
    end
})

ConfigTab:AddButton({
    Name = "Limpar Todos os Logs",
    Callback = function()
        logs = {}
        logCooldowns = {}
        UpdateLogDisplay()
        AddLog("SISTEMA", "Todos os logs foram limpos")
    end
})

-- Aba de Logs
local LogTab = Window:MakeTab({
    Name = "Logs",
    Icon = "rbxassetid://7734053491"
})

-- Exemplos de uso com funções reais
local function CollectOrb(orbName)
    local funcCode = [[
        local function CollectOrb(orbName)
            print("Coletando orb: "..orbName)
            -- Código de coleta aqui
        end
    ]]
    
    AddLog("ORB", "Orb coletada: "..orbName, funcCode)
    -- Código real de coleta aqui
end

local function TakeDamage(amount)
    local funcCode = [[
        local function TakeDamage(amount)
            print("Recebeu dano: "..amount)
            -- Código de dano aqui
        end
    ]]
    
    AddLog("DANO", "Recebeu "..amount.." de dano", funcCode)
    -- Código real de dano aqui
end

-- Inicialização
UpdateLogDisplay()
AddLog("SISTEMA", "Logger iniciado com sucesso", "Código de inicialização")

-- Funções de exemplo (simulando eventos)
task.spawn(function()
    while true do
        wait(5)
        CollectOrb("Orb Azul")
        TakeDamage(10)
    end
end)

-- Retorna a interface para uso externo
return {
    AddLog = AddLog,
    ToggleLogging = function(value) loggingEnabled = value end
}