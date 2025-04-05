-- Carrega a biblioteca (usando versão alternativa mais estável)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Cria a janela principal
local Window = OrionLib:MakeWindow({
    Name = "Function Logger",
    HidePremium = true,
    SaveConfig = false
})

-- Variáveis do sistema
local logs = {}
local functionHistory = {}

-- Função principal para registrar logs
function RegisterFunctionCall(funcName, funcCode, ...)
    local args = {...}
    local timestamp = os.date("[%H:%M:%S]")
    local argString = table.concat(args, ", ") or "sem argumentos"
    
    local logEntry = {
        text = string.format("%s %s(%s)", timestamp, funcName, argString),
        code = funcCode
    }
    
    table.insert(logs, 1, logEntry)
    UpdateLogDisplay()
end

-- Cria a aba de logs PRIMEIRO
local LogTab = Window:MakeTab({
    Name = "Function Logs",
    Icon = "rbxassetid://7734053491"
})

-- Atualiza a exibição (AGORA FUNCIONANDO)
function UpdateLogDisplay()
    LogTab:Clear()
    
    -- Mostra o último registro
    if #logs > 0 then
        LogTab:AddSection({
            Name = "ÚLTIMA FUNÇÃO CHAMADA"
        })
        
        LogTab:AddParagraph(logs[1].text, "")
        
        -- Botão para copiar código
        LogTab:AddButton({
            Name = "Copiar Função",
            Callback = function()
                setclipboard(logs[1].code)
                OrionLib:MakeNotification({
                    Name = "Copiado!",
                    Content = "Código da função copiado",
                    Time = 2
                })
            end
        })
    end
    
    -- Mostra histórico
    LogTab:AddSection({
        Name = "Histórico (últimas 5 chamadas)"
    })
    
    for i = 1, math.min(5, #logs) do
        LogTab:AddParagraph(logs[i].text, "")
    end
end

-- Hook para monitorar funções
function HookFunction(func, funcName)
    return function(...)
        local funcCode = string.dump(func) and "function() ... end" or tostring(func)
        RegisterFunctionCall(funcName or "Anonymous", funcCode, ...)
        return func(...)
    end
end

-- Exemplo de uso:
local function TestFunction(a, b)
    return a + b
end

-- Aplica o hook
TestFunction = HookFunction(TestFunction, "TestFunction")

-- Chama a função (isso aparecerá nos logs)
TestFunction(10, 20)

-- Atualiza a exibição inicial
UpdateLogDisplay()