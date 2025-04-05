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

-- Função principal para adicionar logs
function AddLog(logType, message)
    -- Verifica se o log já foi registrado recentemente (anti-spam)
    local logKey = logType .. message
    if logCooldowns[logKey] and (os.time() - logCooldowns[logKey] < 2) then
        return
    end
    
    logCooldowns[logKey] = os.time()
    
    -- Formata o log
    local timestamp = os.date("[%H:%M:%S]")
    local logEntry = string.format("%s %s: %s", timestamp, logType:upper(), message)
    
    -- Adiciona ao histórico
    table.insert(logs, 1, logEntry)
    
    -- Limita o número de logs armazenados
    if #logs > MAX_LOGS then
        table.remove(logs, MAX_LOGS + 1)
    end
    
    -- Atualiza a UI se a aba estiver aberta
    if Window.CurrentTab and Window.CurrentTab.Name == "Logs" then
        UpdateLogDisplay()
    end
end

-- Atualiza a exibição dos logs na interface
function UpdateLogDisplay()
    if not Window.CurrentTab then return end
    
    Window.CurrentTab:Clear()
    Window.CurrentTab:AddSection({
        Name = "Histórico de Logs"
    })
    
    for _, log in ipairs(logs) do
        Window.CurrentTab:AddParagraph(log, "")
    end
end

-- Cria a aba de logs
local LogTab = Window:MakeTab({
    Name = "Logs",
    Icon = "rbxassetid://7734053491"
})

-- Botão para atualizar manualmente
LogTab:AddButton({
    Name = "Atualizar Logs",
    Callback = UpdateLogDisplay
})

-- Botão para limpar todos os logs
LogTab:AddButton({
    Name = "Limpar Logs",
    Callback = function()
        logs = {}
        logCooldowns = {}
        UpdateLogDisplay()
        AddLog("SISTEMA", "Logs limpos com sucesso")
    end
})

-- Exemplo de uso:
AddLog("SISTEMA", "Logger iniciado com sucesso")
AddLog("MUNDO", "Carregado: Mundo 3")
AddLog("ORB", "Orb Azul coletada")

-- Inicializa a exibição
UpdateLogDisplay()

-- Retorna a função AddLog para uso externo
return {
    AddLog = AddLog
}