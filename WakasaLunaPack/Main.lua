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
    _G.autobola = false  -- Controle do auto-farm
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    -- Função para coletar orbs instantaneamente
    local function coletarOrbs()
        local world = player.leaderstats.WORLD.value
        local OrbFolder = game.workspace.Map.Stages.Boosts:FindFirstChild(world)
        
        if OrbFolder then
            for _, orb in pairs(OrbFolder:GetChildren()) do
                if orb:FindFirstChild("PrimaryPart") then
                    -- Simula o toque para coletar
                    firetouchinterest(char.HumanoidRootPart, orb.PrimaryPart, 0)
                    firetouchinterest(char.HumanoidRootPart, orb.PrimaryPart, 1)
                end
            end
        end
    end

    -- Sistema de auto-farm
    local function autobola()
        while _G.autobola and task.wait(0.1) do  -- Delay ajustável
            pcall(function()  -- Prevende erros
                coletarOrbs()
            end)
        end
    end

    -- GUI
    local Maintab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    Maintab:AddSection({
        Name = "Auto-Farm"
    })

    Maintab:AddToggle({
        Name = "Coletar Orbs Automático",
        Default = false,
        Callback = function(Value)
            _G.autobola = Value
            if Value then
                OrionLib:MakeNotification({
                    Name = "Modo ativado!",
                    Content = "Coletando orbs automaticamente...",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                autobola()  -- Inicia o loop
            else
                OrionLib:MakeNotification({
                    Name = "Modo desativado",
                    Content = "Auto-farm pausado",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end    
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub carregado!",
        Content = "Bem-vindo ao autofarm de orbs",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

-- WakasaHub Aimbot Arsenal - Versão Definitiva
if game.PlaceId == 286090429 then -- Arsenal
    -- Carregamento À PROVA DE FALHAS da OrionLib
    local OrionLib
    local function LoadLibrary()
        local success, response = pcall(function()
            local url = "https://raw.githubusercontent.com/shlexware/Orion/main/source"
            local http = game:GetService("HttpService")
            local content = http:GetAsync(url, true)
            OrionLib = loadstring(content)()
            return true
        end)
        
        if not success then
            warn("Falha ao carregar OrionLib: "..tostring(response))
            return false
        end
        return true
    end

    if not LoadLibrary() then return end

    -- Janela principal CONFIGURÁVEL
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub Arsenal",
        HidePremium = false,
        SaveConfig = false, -- Evita erros de salvamento
        ConfigFolder = "WakasaConfig",
        IntroEnabled = false
    })

    -- Serviços ESSENCIAIS
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    -- Configurações PRINCIPAIS
    local Settings = {
        Enabled = false,
        TeamCheck = true,
        AimPart = "Head",
        FOV = 100,
        Smoothness = 0.2,
        DrawFOV = false, -- Desligado por padrão para mobile
        TriggerKey = "MouseButton2"
    }

    -- Sistema de FOV SEGURO
    local FOVCircle
    local function CreateFOV()
        local success, err = pcall(function()
            FOVCircle = Drawing.new("Circle")
            FOVCircle.Visible = Settings.DrawFOV
            FOVCircle.Thickness = 1
            FOVCircle.Color = Color3.new(1, 1, 1)
            FOVCircle.Transparency = 0.5
            FOVCircle.Filled = false
            FOVCircle.Radius = Settings.FOV
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        end)
        if not success then
            warn("Erro no FOV: "..tostring(err))
            Settings.DrawFOV = false
        end
    end

    CreateFOV()

    -- Funções PRINCIPAIS protegidas
    local function IsValidTarget(player)
        if not player or player == LocalPlayer then return false end
        local success, result = pcall(function()
            return player.Character and
                   player.Character:FindFirstChild("Humanoid") and
                   player.Character.Humanoid.Health > 0 and
                   player.Character:FindFirstChild(Settings.AimPart) and
                   (not Settings.TeamCheck or player.Team ~= LocalPlayer.Team)
        end)
        return success and result
    end

    local function GetBestTarget()
        local closest, distance = nil, Settings.FOV
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        
        for _, player in ipairs(Players:GetPlayers()) do
            if IsValidTarget(player) then
                local success, screenPos = pcall(function()
                    return Camera:WorldToViewportPoint(player.Character[Settings.AimPart].Position)
                end)
                
                if success and screenPos.Z > 0 then
                    local pos2D = Vector2.new(screenPos.X, screenPos.Y)
                    local dist = (center - pos2D).Magnitude
                    if dist < distance then
                        closest = player
                        distance = dist
                    end
                end
            end
        end
        return closest
    end

    -- Loop de AIM otimizado
    local AimConnection
    local function AimLoop()
        if not Settings.Enabled then return end
        
        local target = GetBestTarget()
        if target then
            pcall(function()
                local targetPos = target.Character[Settings.AimPart].Position
                local camPos = Camera.CFrame.Position
                local direction = (targetPos - camPos).Unit
                local smooth = Camera.CFrame.LookVector:Lerp(direction, Settings.Smoothness)
                Camera.CFrame = CFrame.new(camPos, camPos + smooth)
            end)
        end
    end

    -- Controle PRINCIPAL
    local function ToggleAimbot(state)
        Settings.Enabled = state
        if state then
            if AimConnection then AimConnection:Disconnect() end
            AimConnection = RunService.RenderStepped:Connect(AimLoop)
        elseif AimConnection then
            AimConnection:Disconnect()
            AimConnection = nil
        end
    end

    -- Interface IDÊNTICA ao seu original
    local MainTab = Window:MakeTab({
        Name = "Aimbot",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MainTab:AddSection({
        Name = "Configurações Principais"
    })

    MainTab:AddToggle({
        Name = "Ativar Aimbot",
        Default = Settings.Enabled,
        Callback = function(Value)
            ToggleAimbot(Value)
            OrionLib:MakeNotification({
                Name = "Status: "..(Value and "ON" or "OFF"),
                Content = Value and "Aimbot ativado" or "Aimbot desativado",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    })

    MainTab:AddToggle({
        Name = "Verificar Time",
        Default = Settings.TeamCheck,
        Callback = function(Value)
            Settings.TeamCheck = Value
        end
    })

    MainTab:AddToggle({
        Name = "Mostrar FOV",
        Default = Settings.DrawFOV,
        Callback = function(Value)
            Settings.DrawFOV = Value
            if FOVCircle then
                FOVCircle.Visible = Value
            end
        end
    })

    MainTab:AddDropdown({
        Name = "Parte do Corpo",
        Default = Settings.AimPart,
        Options = {"Head", "UpperTorso", "HumanoidRootPart"},
        Callback = function(Value)
            Settings.AimPart = Value
        end
    })

    MainTab:AddSlider({
        Name = "Campo de Visão",
        Min = 50,
        Max = 300,
        Default = Settings.FOV,
        Increment = 5,
        Callback = function(Value)
            Settings.FOV = Value
            if FOVCircle then
                FOVCircle.Radius = Value
            end
        end
    })

    MainTab:AddSlider({
        Name = "Suavidade",
        Min = 0.05,
        Max = 1,
        Default = Settings.Smoothness,
        Increment = 0.01,
        Callback = function(Value)
            Settings.Smoothness = Value
        end
    })

    -- Notificação INICIAL
    OrionLib:MakeNotification({
        Name = "WakasaHub Carregado!",
        Content = "Aimbot pronto para uso",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    -- Gerenciamento de ERROS FINAL
    local function SafeCleanup()
        pcall(function()
            if AimConnection then
                AimConnection:Disconnect()
            end
            if FOVCircle then
                FOVCircle:Remove()
            end
        end)
    end

    game:BindToClose(SafeCleanup)
    LocalPlayer.CharacterAdded:Connect(SafeCleanup)
end