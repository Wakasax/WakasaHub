if game.PlaceId == 7215881810 then
    -- Carrega a OrionLib
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

    -- Cria a janela principal
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub - RemoteSpy",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "WakasaSpy",
        IntroEnabled = false
    })

    -- Variáveis globais
    local logs = {}
    local MAX_LOGS = 50
    local player = game.Players.LocalPlayer
    local remoteSpyEnabled = false

    -- Função para registrar chamadas remotas
    local function logRemoteCall(remote, args, callType)
        local timestamp = os.date("[%H:%M:%S]")
        local remoteName = remote.Name
        local remotePath = game:GetService("HttpService"):JSONEncode(remote:GetFullName())
        
        local logEntry = {
            text = string.format("%s %s: %s (%s)", timestamp, callType:upper(), remoteName, #args > 0 and table.concat(args, ", ") or "sem argumentos"),
            code = string.format("-- Chamada %s\nlocal args = %s\n%s:%s(unpack(args))", 
                               callType, 
                               game:GetService("HttpService"):JSONEncode(args),
                               remotePath,
                               callType == "event" and "FireServer" or "InvokeServer"),
            time = os.time()
        }
        
        table.insert(logs, 1, logEntry)
        if #logs > MAX_LOGS then
            table.remove(logs)
        end
        UpdateLogDisplay()
    end

    -- Hook para RemoteEvents
    local originalFireServer
    originalFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
        if remoteSpyEnabled then
            logRemoteCall(self, {...}, "event")
        end
        return originalFireServer(self, ...)
    end)

    -- Hook para RemoteFunctions
    local originalInvokeServer
    originalInvokeServer = hookfunction(Instance.new("RemoteFunction").InvokeServer, function(self, ...)
        if remoteSpyEnabled then
            logRemoteCall(self, {...}, "function")
        end
        return originalInvokeServer(self, ...)
    end)

    -- Atualiza a exibição de logs
    local function UpdateLogDisplay()
        if not LogTab then return end
        
        LogTab:Clear()
        
        -- Mostra o último log
        if #logs > 0 then
            LogTab:AddSection({
                Name = "ÚLTIMA CHAMADA REGISTRADA"
            })
            
            LogTab:AddParagraph(logs[1].text, "")
            
            -- Botão para copiar código
            LogTab:AddButton({
                Name = "📋 Copiar Chamada",
                Callback = function()
                    setclipboard(logs[1].code)
                    OrionLib:MakeNotification({
                        Name = "Copiado!",
                        Content = "Código da chamada copiado",
                        Time = 2
                    })
                end
            })
        end
        
        -- Mostra histórico
        LogTab:AddSection({
            Name = string.format("HISTÓRICO (Últimos %d)", math.min(5, #logs))
        })
        
        for i = 1, math.min(5, #logs) do
            LogTab:AddParagraph(string.format("%d. %s", i, logs[i].text), "")
        end
    end

    -- Cria a aba de RemoteSpy
    local LogTab = Window:MakeTab({
        Name = "RemoteSpy",
        Icon = "rbxassetid://7733960981",
        PremiumOnly = false
    })

    -- Cria a aba de configuração
    local ConfigTab = Window:MakeTab({
        Name = "Config",
        Icon = "rbxassetid://7733765392",
        PremiumOnly = false
    })

    ConfigTab:AddToggle({
        Name = "Ativar RemoteSpy",
        Default = false,
        Callback = function(Value)
            remoteSpyEnabled = Value
            OrionLib:MakeNotification({
                Name = Value and "RemoteSpy Ativado" or "RemoteSpy Desativado",
                Content = Value and "Monitorando chamadas remotas..." or "Monitoramento desativado",
                Time = 3
            })
        end
    })

    ConfigTab:AddButton({
        Name = "Limpar Logs",
        Callback = function()
            logs = {}
            UpdateLogDisplay()
            OrionLib:MakeNotification({
                Name = "Logs Limpos",
                Content = "Todos os registros foram removidos",
                Time = 2
            })
        end
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub RemoteSpy carregado!",
        Content = "Pressione F9 para ver os logs",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    -- Atualização inicial
    UpdateLogDisplay()
end