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

-- WakasaHub Aimbot Mobile para Arsenal
if game.PlaceId == 286090429 then -- ID do Arsenal
    -- Carrega a OrionLib corretamente
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    
    -- Cria a janela principal
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub Mobile",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "WakasaArsenalConfig",
        IntroEnabled = false
    })

    -- Serviços essenciais
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    -- Configurações padrão
    local Settings = {
        Enabled = false,
        TeamCheck = true,
        AimPart = "Head",
        FOV = 120,
        Smoothness = 0.25,
        AutoFire = false,
        DrawFOV = true,
        FOVColor = Color3.fromRGB(255, 0, 0),
        TouchArea = 0.2
    }

    -- Criação do FOV Circle
    local FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = Settings.DrawFOV
    FOVCircle.Thickness = 2
    FOVCircle.Color = Settings.FOVColor
    FOVCircle.Transparency = 0.5
    FOVCircle.Filled = false
    FOVCircle.Radius = Settings.FOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    -- Funções principais
    local function IsValidPlayer(player)
        return player ~= LocalPlayer and 
               player.Character and 
               player.Character:FindFirstChild("Humanoid") and 
               player.Character.Humanoid.Health > 0 and
               player.Character:FindFirstChild(Settings.AimPart) and
               (not Settings.TeamCheck or player.Team ~= LocalPlayer.Team)
    end

    local function GetClosestPlayer()
        local closestDistance = Settings.FOV
        local closestPlayer = nil
        
        for _, player in ipairs(Players:GetPlayers()) do
            if IsValidPlayer(player) then
                local targetPos = player.Character[Settings.AimPart].Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
                
                if onScreen then
                    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                    local targetPos2D = Vector2.new(screenPos.X, screenPos.Y)
                    local distance = (center - targetPos2D).Magnitude
                    
                    if distance < closestDistance then
                        closestPlayer = player
                        closestDistance = distance
                    end
                end
            end
        end
        
        return closestPlayer
    end

    local function SmoothAim(targetPos)
        local cameraPos = Camera.CFrame.Position
        local direction = (targetPos - cameraPos).Unit
        local currentLook = Camera.CFrame.LookVector
        local smoothDirection = currentLook:Lerp(direction, Settings.Smoothness)
        Camera.CFrame = CFrame.new(cameraPos, cameraPos + smoothDirection)
    end

    -- Loop principal
    local aimLoop
    local function StartAimbot()
        aimLoop = RunService.RenderStepped:Connect(function()
            if Settings.Enabled then
                local closestPlayer = GetClosestPlayer()
                if closestPlayer then
                    SmoothAim(closestPlayer.Character[Settings.AimPart].Position)
                end
            end
            
            -- Atualiza FOV
            FOVCircle.Visible = Settings.DrawFOV
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            FOVCircle.Radius = Settings.FOV
            FOVCircle.Color = Settings.FOVColor
        end)
    end

    local function StopAimbot()
        if aimLoop then
            aimLoop:Disconnect()
            aimLoop = nil
        end
    end

    -- GUI com Orion
    local AimbotTab = Window:MakeTab({
        Name = "Aimbot Mobile",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    AimbotTab:AddSection({
        Name = "Configurações Principais"
    })

    AimbotTab:AddToggle({
        Name = "Ativar Aimbot",
        Default = Settings.Enabled,
        Callback = function(Value)
            Settings.Enabled = Value
            if Value then
                StartAimbot()
            else
                StopAimbot()
            end
        end    
    })

    AimbotTab:AddToggle({
        Name = "Verificar Time",
        Default = Settings.TeamCheck,
        Callback = function(Value)
            Settings.TeamCheck = Value
        end    
    })

    AimbotTab:AddToggle({
        Name = "Mostrar FOV",
        Default = Settings.DrawFOV,
        Callback = function(Value)
            Settings.DrawFOV = Value
        end    
    })

    AimbotTab:AddDropdown({
        Name = "Parte do Corpo",
        Default = Settings.AimPart,
        Options = {"Head", "UpperTorso", "HumanoidRootPart"},
        Callback = function(Value)
            Settings.AimPart = Value
        end    
    })

    AimbotTab:AddSlider({
        Name = "Campo de Visão",
        Min = 50,
        Max = 300,
        Default = Settings.FOV,
        Color = Color3.fromRGB(255,255,255),
        Increment = 5,
        Callback = function(Value)
            Settings.FOV = Value
        end    
    })

    AimbotTab:AddSlider({
        Name = "Suavidade",
        Min = 0.05,
        Max = 0.5,
        Default = Settings.Smoothness,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.01,
        Callback = function(Value)
            Settings.Smoothness = Value
        end    
    })

    AimbotTab:AddColorpicker({
        Name = "Cor do FOV",
        Default = Settings.FOVColor,
        Callback = function(Value)
            Settings.FOVColor = Value
        end    
    })

    -- Inicialização
    OrionLib:MakeNotification({
        Name = "WakasaHub Mobile",
        Content = "Aimbot carregado com sucesso!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    -- Limpeza ao sair
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
        StopAimbot()
    end)
end