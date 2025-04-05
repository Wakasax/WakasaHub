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

-- WakasaHub Aimbot Mobile - Versão Estável
if game.PlaceId == 286090429 then -- Arsenal
    -- Carregamento seguro da OrionLib
    local OrionLib
    local function LoadOrion()
        local success, err = pcall(function()
            OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
        end)
        if not success then
            warn("Erro ao carregar OrionLib: "..tostring(err))
            return false
        end
        return true
    end

    if not LoadOrion() then return end

    -- Janela principal (idêntica ao original)
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub Mobile",
        HidePremium = false,
        SaveConfig = false, -- Desativado para evitar erros
        ConfigFolder = "WakasaAimbot",
        IntroEnabled = false
    })

    -- Serviços essenciais
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    -- Configurações à prova de erros
    local Settings = {
        Enabled = false,
        TeamCheck = true,
        AimPart = "Head",
        FOV = 100,
        Smoothness = 0.25,
        DrawFOV = false, -- Melhor para mobile
        FOVColor = Color3.fromRGB(255, 0, 0)
    }

    -- Inicialização segura do FOV
    local FOVCircle
    local function InitFOV()
        local success, err = pcall(function()
            FOVCircle = Drawing.new("Circle")
            FOVCircle.Visible = Settings.DrawFOV
            FOVCircle.Thickness = 2
            FOVCircle.Color = Settings.FOVColor
            FOVCircle.Transparency = 0.5
            FOVCircle.Filled = false
            FOVCircle.Radius = Settings.FOV
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            return true
        end)
        if not success then
            warn("Erro no FOV Circle: "..tostring(err))
            Settings.DrawFOV = false
            return false
        end
        return true
    end

    InitFOV() -- Chama a inicialização

    -- Funções protegidas
    local function SafeIsValid(player)
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

    local function SafeGetClosest()
        local closest, distance = nil, Settings.FOV
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        
        for _, player in ipairs(Players:GetPlayers()) do
            if SafeIsValid(player) then
                local success, screenPos, onScreen = pcall(function()
                    local pos = player.Character[Settings.AimPart].Position
                    return Camera:WorldToViewportPoint(pos), true
                end)
                
                if success and onScreen then
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

    -- Loop principal seguro
    local aimLoop
    local function SafeAimLoop()
        if not Settings.Enabled then return end
        
        local success, target = pcall(SafeGetClosest)
        if success and target then
            pcall(function()
                local targetPos = target.Character[Settings.AimPart].Position
                local camPos = Camera.CFrame.Position
                local dir = (targetPos - camPos).Unit
                local smoothDir = Camera.CFrame.LookVector:Lerp(dir, Settings.Smoothness)
                Camera.CFrame = CFrame.new(camPos, camPos + smoothDir)
            end)
        end
        
        -- Atualização segura do FOV
        if Settings.DrawFOV and FOVCircle then
            pcall(function()
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                FOVCircle.Radius = Settings.FOV
                FOVCircle.Visible = true
            end)
        elseif FOVCircle then
            FOVCircle.Visible = false
        end
    end

    -- Controle do Aimbot
    local function ToggleAimbot(state)
        Settings.Enabled = state
        if state then
            if aimLoop then aimLoop:Disconnect() end
            aimLoop = RunService.RenderStepped:Connect(SafeAimLoop)
            OrionLib:MakeNotification({
                Name = "Aimbot Ativado",
                Content = "Mirando automaticamente",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        elseif aimLoop then
            aimLoop:Disconnect()
            aimLoop = nil
        end
    end

    -- Interface (idêntica ao original)
    local AimbotTab = Window:MakeTab({
        Name = "Aimbot Mobile",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    AimbotTab:AddSection({
        Name = "Configurações"
    })

    AimbotTab:AddToggle({
        Name = "Ativar Aimbot",
        Default = Settings.Enabled,
        Callback = function(Value)
            ToggleAimbot(Value)
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
        Options = {"Head", "UpperTorso"},
        Callback = function(Value)
            Settings.AimPart = Value
        end    
    })

    AimbotTab:AddSlider({
        Name = "Campo de Visão",
        Min = 50,
        Max = 300,
        Default = Settings.FOV,
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
        Increment = 0.01,
        Callback = function(Value)
            Settings.Smoothness = Value
        end    
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub Mobile",
        Content = "Aimbot configurado com sucesso!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    -- Limpeza segura
    local function Cleanup()
        if aimLoop then
            aimLoop:Disconnect()
        end
        if FOVCircle then
            pcall(function() FOVCircle:Remove() end)
        end
    end

    game:BindToClose(Cleanup)
    LocalPlayer.CharacterAdded:Connect(Cleanup)
end