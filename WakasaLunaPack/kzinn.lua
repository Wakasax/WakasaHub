if game.PlaceId == 7215881810 then
    -- Carrega a OrionLib
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

    -- Cria a janela principal
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "Wakasa",
        IntroEnabled = false
    })

    -- Variáveis globais
    _G.remotespy = false  -- Controle do remote spy
    local logs = {}
    local player = game.Players.LocalPlayer

    -- Função para registrar chamadas remotas
    local function logRemote(remote, args, callType)
        local timestamp = os.date("[%H:%M:%S]")
        local logEntry = {
            text = string.format("%s %s: %s (%s)", 
                               timestamp, 
                               callType:upper(), 
                               remote.Name, 
                               #args > 0 and table.concat(args, ", ") or "sem argumentos"),
            code = string.format("%s:%s(%s)", 
                               remote:GetFullName(), 
                               callType == "event" and "FireServer" or "InvokeServer", 
                               game:GetService("HttpService"):JSONEncode(args))
        }
        
        table.insert(logs, 1, logEntry)
        UpdateLogDisplay()
    end

    -- Sistema de monitoramento de remotes
    local function monitorRemotes()
        local originalFire = Instance.new("RemoteEvent").FireServer
        local originalInvoke = Instance.new("RemoteFunction").InvokeServer
        
        hookfunction(originalFire, function(self, ...)
            if _G.remotespy then
                logRemote(self, {...}, "event")
            end
            return originalFire(self, ...)
        end)
        
        hookfunction(originalInvoke, function(self, ...)
            if _G.remotespy then
                logRemote(self, {...}, "function")
            end
            return originalInvoke(self, ...)
        end)
    end

    -- Atualiza a exibição de logs
    local function UpdateLogDisplay()
        if not RemoteTab then return end
        
        RemoteTab:Clear()
        
        if #logs > 0 then
            RemoteTab:AddParagraph("Última chamada:", logs[1].text)
            
            RemoteTab:AddButton({
                Name = "Copiar Código",
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
    end

    -- GUI
    local MainTab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local RemoteTab = Window:MakeTab({
        Name = "RemoteSpy",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MainTab:AddSection({
        Name = "Remote Spy"
    })

    MainTab:AddToggle({
        Name = "Ativar Remote Spy",
        Default = false,
        Callback = function(Value)
            _G.remotespy = Value
            if Value then
                OrionLib:MakeNotification({
                    Name = "RemoteSpy ativado!",
                    Content = "Monitorando chamadas remotas...",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                monitorRemotes()
            else
                OrionLib:MakeNotification({
                    Name = "RemoteSpy desativado",
                    Content = "Parou de monitorar chamadas",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end    
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub carregado!",
        Content = "RemoteSpy pronto para uso",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    -- Inicializa o display
    UpdateLogDisplay()
end