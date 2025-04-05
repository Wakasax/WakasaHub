-- Carrega a OrionLib
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Configurações principais
local Window = OrionLib:MakeWindow({
    Name = "LunaPack Dev Logger",
    HidePremium = true
})

-- Variáveis do sistema
local logs = {}
local lastCopiedFunction = ""

-- Função para adicionar logs
function AddLog(action, message, funcCode)
    local timestamp = os.date("[%H:%M:%S]")
    local logEntry = {
        text = string.format("%s %s: %s", timestamp, action, message),
        code = funcCode or "Nenhum código disponível"
    }
    
    table.insert(logs, 1, logEntry)
    UpdateLogDisplay()
end

-- Atualiza a exibição de logs
function UpdateLogDisplay()
    if not LogTab then return end
    
    LogTab:Clear()
    
    -- Mostra o último log em um quadrado destacado
    if #logs > 0 then
        LogTab:AddSection({
            Name = "ÚLTIMO LOG REGISTRADO"
        })
        
        LogTab:AddParagraph(logs[1].text, "")
        
        LogTab:AddButton({
            Name = "📋 Copiar Código da Função",
            Callback = function()
                setclipboard(logs[1].code)
                lastCopiedFunction = logs[1].code
                OrionLib:MakeNotification({
                    Name = "Código copiado!",
                    Content = "Função copiada para área de transferência",
                    Time = 3
                })
            end
        })
    end
    
    -- Mostra histórico (opcional)
    LogTab:AddSection({
        Name = "Histórico (últimos 10)"
    })
    
    for i = 1, math.min(10, #logs) do
        LogTab:AddParagraph(logs[i].text, "")
    end
end

-- Aba de Logs
LogTab = Window:MakeTab({
    Name = "Logs",
    Icon = "rbxassetid://7734053491"
})

-- Aba de Controle
local ControlTab = Window:MakeTab({
    Name = "Controle"
})

ControlTab:AddToggle({
    Name = "Ativar Logs Automáticos",
    Default = true,
    Callback = function(value)
        _G.loggingEnabled = value
        AddLog("SISTEMA", value and "Logs ativados" or "Logs desativados")
    end
})

-- Exemplo de uso:
AddLog("SISTEMA", "Logger iniciado", [[
    function AddLog(action, message, funcCode)
        -- Código da função aqui
    end
]])

-- Simula um evento de jogo
task.spawn(function()
    while wait(3) and _G.loggingEnabled do
        AddLog("ORB", "Orb Azul coletada", [[
            local function CollectOrb(color)
                print("Orb "..color.." coletada!")
            end
            CollectOrb("Azul")
        ]])
    end
end)