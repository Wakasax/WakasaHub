--[[
    LunaPack Dev Logger v2.0
    Sistema avançado de monitoramento de funções para Roblox
    Desenvolvido por: [SEU NOME AQUI]
    GitHub: [SEU GITHUB AQUI]
]]

-- Carrega a biblioteca Orion com tratamento de erros
local OrionLib
local libSuccess, libError = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
end)

if not libSuccess then
    warn("Falha ao carregar OrionLib: "..tostring(libError))
    return
end

-- Configuração da janela principal
local Window = OrionLib:MakeWindow({
    Name = "LunaPack Dev",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "LunaPackConfig",
    IntroEnabled = false,
    Icon = "rbxassetid://7734053491" -- Ícone personalizado
})

-- Variáveis do sistema
local logs = {}
local MAX_LOGS = 50
local loggingEnabled = true
local developerName = "[SEU NOME AQUI]" -- Seu nome aqui

-- Função principal de logging melhorada
function AddLog(logType, message, funcCode, ...)
    if not loggingEnabled then return end
    
    local args = {...}
    local timestamp = os.date("[%H:%M:%S]")
    local argString = #args > 0 and table.concat(args, ", ") or "sem argumentos"
    
    local logEntry = {
        text = string.format("%s [%s] %s(%s)", timestamp, logType:upper(), message, argString),
        code = funcCode or "-- Nenhum código disponível",
        time = os.time(),
        type = logType
    }
    
    table.insert(logs, 1, logEntry)
    
    -- Mantém apenas os logs mais recentes
    if #logs > MAX_LOGS then
        table.remove(logs)
    end
    
    UpdateLogDisplay()
end

-- Criação das abas
local LogTab = Window:MakeTab({
    Name = "📜 Logs",
    Icon = "rbxassetid://7733960981"
})

local ConfigTab = Window:MakeTab({
    Name = "⚙️ Configuração",
    Icon = "rbxassetid://7733765392"
})

-- Atualiza a exibição de logs
function UpdateLogDisplay()
    LogTab:Clear()
    
    -- Cabeçalho personalizado
    LogTab:AddSection({
        Name = string.format("LunaPack Dev - por %s", developerName)
    })
    
    -- Último log
    if #logs > 0 then
        LogTab:AddSection({
            Name = "ÚLTIMA CHAMADA REGISTRADA"
        })
        
        LogTab:AddParagraph(logs[1].text, "")
        
        -- Botões de ação
        LogTab:AddButton({
            Name = "📋 Copiar Código",
            Callback = function()
                setclipboard(logs[1].code)
                OrionLib:MakeNotification({
                    Name = "Sucesso!",
                    Content = "Código copiado para área de transferência",
                    Time = 3,
                    Image = "rbxassetid://7734053491"
                })
            end
        })
        
        LogTab:AddButton({
            Name = "🗑️ Limpar Este Log",
            Callback = function()
                table.remove(logs, 1)
                UpdateLogDisplay()
            end
        })
    end
    
    -- Histórico
    LogTab:AddSection({
        Name = string.format("HISTÓRICO (Últimos %d)", math.min(5, #logs))
    })
    
    for i = 1, math.min(5, #logs) do
        LogTab:AddParagraph(string.format("%d. %s", i, logs[i].text), "")
    end
end

-- Configurações
ConfigTab:AddToggle({
    Name = "Ativar Logging Automático",
    Default = true,
    Callback = function(value)
        loggingEnabled = value
        AddLog("SISTEMA", value and "Logging ativado" or "Logging desativado")
    end
})

ConfigTab:AddSlider({
    Name = "Máximo de Logs",
    Min = 10,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(0, 170, 255),
    Increment = 5,
    Callback = function(value)
        MAX_LOGS = value
    end
})

ConfigTab:AddButton({
    Name = "🧹 Limpar Todos os Logs",
    Callback = function()
        logs = {}
        UpdateLogDisplay()
        OrionLib:MakeNotification({
            Name = "Logs Limpos",
            Content = "Todos os registros foram removidos",
            Time = 3
        })
    end
})

-- Sistema de hook de funções
function HookFunction(func, funcName)
    local functionName = funcName or debug.getinfo(func, "n").name or "Anonymous"
    
    return function(...)
        local args = {...}
        local funcCode = string.dump(func) and "function() ... end" or tostring(func)
        
        -- Registra a chamada
        AddLog("FUNÇÃO", functionName, funcCode, ...)
        
        -- Executa a função original
        return func(...)
    end
end

-- Exemplo de uso integrado
local function ExampleFunction(a, b)
    return a + b
end

-- Aplica o hook à função de exemplo
ExampleFunction = HookFunction(ExampleFunction, "ExampleFunction")

-- Teste inicial
task.spawn(function()
    wait(2)
    ExampleFunction(5, 10)
    AddLog("SISTEMA", "LunaPack Dev inicializado com sucesso!", [[
        -- Sistema de logging criado por ]]..developerName..[[
        -- Versão: 2.0
        -- Data: ]]..os.date("%x"))
end)

-- Atualização inicial
UpdateLogDisplay()

-- API para uso externo
return {
    AddLog = AddLog,
    HookFunction = HookFunction,
    ToggleLogging = function(state) loggingEnabled = state end,
    ClearLogs = function() logs = {} UpdateLogDisplay() end
}