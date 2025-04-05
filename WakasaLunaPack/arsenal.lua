-- WakasaHub Aimbot para Arsenal
if game.PlaceId == 286090429 then -- ID do Arsenal
    -- Carrega a OrionLib
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

    -- Cria a janela principal
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub - Arsenal Aimbot",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "WakasaArsenal",
        IntroEnabled = false
    })

    -- Variáveis globais
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

    -- Configurações do Aimbot
    _G.Aimbot = {
        Enabled = false,
        TeamCheck = true,
        AimPart = "Head",
        FOV = 80,
        Smoothness = 0.15,
        TriggerKey = "MouseButton2",
        DrawFOV = true,
        FOVColor = Color3.fromRGB(255, 255, 255)
    }

    -- Criação do círculo de FOV
    local FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = _G.Aimbot.DrawFOV
    FOVCircle.Thickness = 1
    FOVCircle.Color = _G.Aimbot.FOVColor
    FOVCircle.Transparency = 1
    FOVCircle.Filled = false
    FOVCircle.Radius = _G.Aimbot.FOV

    -- Função para verificar se o jogador é válido
    local function IsValidPlayer(player)
        return player ~= LocalPlayer and 
               player.Character and 
               player.Character:FindFirstChild("Humanoid") and 
               player.Character.Humanoid.Health > 0 and
               player.Character:FindFirstChild(_G.Aimbot.AimPart)
    end

    -- Função para encontrar o jogador mais próximo
    local function GetClosestPlayer()
        local closestPlayer = nil
        local shortestDistance = _G.Aimbot.FOV
        
        for _, player in pairs(Players:GetPlayers()) do
            if IsValidPlayer(player) then
                -- Verificação de time
                if _G.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Cálculo de distância
                local character = player.Character
                local targetPos = character[_G.Aimbot.AimPart].Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
                
                if onScreen then
                    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                    local targetScreenPos = Vector2.new(screenPos.X, screenPos.Y)
                    local distance = (mousePos - targetScreenPos).Magnitude
                    
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
        
        return closestPlayer
    end

    -- Função principal do Aimbot
    local function Aim()
        if not _G.Aimbot.Enabled then return end
        
        local closestPlayer = GetClosestPlayer()
        if closestPlayer then
            local character = closestPlayer.Character
            local targetPos = character[_G.Aimbot.AimPart].Position
            local cameraPos = Camera.CFrame.Position
            
            -- Cálculo da direção com suavização
            local direction = (targetPos - cameraPos).Unit
            local currentLook = Camera.CFrame.LookVector
            local smoothDirection = currentLook:Lerp(direction, _G.Aimbot.Smoothness)
            
            -- Aplica a nova direção da câmera
            Camera.CFrame = CFrame.new(cameraPos, cameraPos + smoothDirection)
        end
    end

    -- Conexão do loop principal
    local aimConnection
    local function ToggleAimbot(state)
        if state then
            aimConnection = RunService.RenderStepped:Connect(Aim)
        elseif aimConnection then
            aimConnection:Disconnect()
        end
    end

    -- Ativa/desativa com o botão configurado
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType[_G.Aimbot.TriggerKey] then
            _G.Aimbot.Enabled = true
            ToggleAimbot(true)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType[_G.Aimbot.TriggerKey] then
            _G.Aimbot.Enabled = false
            ToggleAimbot(false)
        end
    end)

    -- Atualiza o círculo de FOV
    RunService.RenderStepped:Connect(function()
        FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        FOVCircle.Radius = _G.Aimbot.FOV
        FOVCircle.Visible = _G.Aimbot.DrawFOV
        FOVCircle.Color = _G.Aimbot.FOVColor
    end)

    -- GUI
    local AimbotTab = Window:MakeTab({
        Name = "Aimbot",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    AimbotTab:AddSection({
        Name = "Configurações Principais"
    })

    AimbotTab:AddToggle({
        Name = "Ativar Aimbot",
        Default = _G.Aimbot.Enabled,
        Callback = function(Value)
            _G.Aimbot.Enabled = Value
            OrionLib:MakeNotification({
                Name = "Aimbot "..(Value and "ativado" or "desativado"),
                Content = Value and "Pronto para mirar!" or "Aimbot desligado",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end    
    })

    AimbotTab:AddToggle({
        Name = "Verificar Time",
        Default = _G.Aimbot.TeamCheck,
        Callback = function(Value)
            _G.Aimbot.TeamCheck = Value
        end    
    })

    AimbotTab:AddToggle({
        Name = "Mostrar FOV",
        Default = _G.Aimbot.DrawFOV,
        Callback = function(Value)
            _G.Aimbot.DrawFOV = Value
        end    
    })

    AimbotTab:AddDropdown({
        Name = "Parte do Corpo",
        Default = _G.Aimbot.AimPart,
        Options = {"Head", "UpperTorso", "HumanoidRootPart"},
        Callback = function(Value)
            _G.Aimbot.AimPart = Value
        end    
    })

    AimbotTab:AddSlider({
        Name = "Campo de Visão (FOV)",
        Min = 10,
        Max = 500,
        Default = _G.Aimbot.FOV,
        Color = Color3.fromRGB(255,255,255),
        Increment = 1,
        Callback = function(Value)
            _G.Aimbot.FOV = Value
        end    
    })

    AimbotTab:AddSlider({
        Name = "Suavidade",
        Min = 0.01,
        Max = 1,
        Default = _G.Aimbot.Smoothness,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.01,
        Callback = function(Value)
            _G.Aimbot.Smoothness = Value
        end    
    })

    AimbotTab:AddDropdown({
        Name = "Tecla de Ativação",
        Default = _G.Aimbot.TriggerKey,
        Options = {"MouseButton2", "MouseButton1", "LeftControl"},
        Callback = function(Value)
            _G.Aimbot.TriggerKey = Value
        end    
    })

    AimbotTab:AddColorpicker({
        Name = "Cor do FOV",
        Default = _G.Aimbot.FOVColor,
        Callback = function(Value)
            _G.Aimbot.FOVColor = Value
        end    
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub Aimbot carregado!",
        Content = "Pressione ".._G.Aimbot.TriggerKey.." para ativar",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end