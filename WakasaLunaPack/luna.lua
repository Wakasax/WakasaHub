--[[
  LunaPack v1.0 - Arsenal Aimbot
  Desenvolvido por KzinnX
  Features:
  - Aimbot preciso para mobile/PC
  - Configuração FOV
  - Suavidade ajustável
  - Filtro de time
  - Sistema anti-detecção básico
]]

local LunaPack = {}

-- Serviços essenciais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configurações padrão
LunaPack.Settings = {
    Enabled = false,
    TeamCheck = true,
    AimPart = "Head",
    FOV = 100,
    Smoothness = 0.25,
    DrawFOV = false,
    TriggerKey = Enum.UserInputType.MouseButton2
}

-- Inicialização do FOV
local FOVCircle
local function InitializeFOV()
    local success, err = pcall(function()
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Visible = LunaPack.Settings.DrawFOV
        FOVCircle.Thickness = 1
        FOVCircle.Color = Color3.fromRGB(255, 50, 50)
        FOVCircle.Transparency = 0.7
        FOVCircle.Filled = false
        FOVCircle.Radius = LunaPack.Settings.FOV
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end)
    
    if not success then
        warn("[LunaPack] Erro ao criar FOV: "..tostring(err))
        LunaPack.Settings.DrawFOV = false
    end
end

-- Função para verificar alvo válido
local function IsValidTarget(player)
    if not player or player == LocalPlayer then return false end
    
    local success, valid = pcall(function()
        return player.Character and
               player.Character:FindFirstChild("Humanoid") and
               player.Character.Humanoid.Health > 0 and
               player.Character:FindFirstChild(LunaPack.Settings.AimPart) and
               (not LunaPack.Settings.TeamCheck or player.Team ~= LocalPlayer.Team)
    end)
    
    return success and valid
end

-- Encontrar melhor alvo
local function FindBestTarget()
    local closestPlayer = nil
    local shortestDistance = LunaPack.Settings.FOV
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if IsValidTarget(player) then
            local success, screenPos = pcall(function()
                return Camera:WorldToViewportPoint(player.Character[LunaPack.Settings.AimPart].Position)
            end)
            
            if success and screenPos.Z > 0 then
                local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
                local distance = (center - screenPoint).Magnitude
                
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closestPlayer
end

-- Sistema de aimbot
local function AimAtTarget()
    if not LunaPack.Settings.Enabled then return end
    
    local target = FindBestTarget()
    if target then
        local success = pcall(function()
            local targetPos = target.Character[LunaPack.Settings.AimPart].Position
            local cameraPos = Camera.CFrame.Position
            local direction = (targetPos - cameraPos).Unit
            local smoothDirection = Camera.CFrame.LookVector:Lerp(direction, LunaPack.Settings.Smoothness)
            Camera.CFrame = CFrame.new(cameraPos, cameraPos + smoothDirection)
        end)
        
        if not success then
            warn("[LunaPack] Erro durante o aimbot")
        end
    end
end

-- Atualizar FOV
local function UpdateFOV()
    if not FOVCircle then return end
    
    pcall(function()
        FOVCircle.Visible = LunaPack.Settings.DrawFOV
        FOVCircle.Radius = LunaPack.Settings.FOV
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    end)
end

-- Inicialização principal
function LunaPack.Init()
    InitializeFOV()
    
    -- Conexão principal
    local renderConnection
    local function ToggleAimbot(state)
        LunaPack.Settings.Enabled = state
        
        if state then
            if renderConnection then
                renderConnection:Disconnect()
            end
            
            renderConnection = RunService.RenderStepped:Connect(function()
                AimAtTarget()
                UpdateFOV()
            end)
        elseif renderConnection then
            renderConnection:Disconnect()
            renderConnection = nil
        end
    end

    -- Controle por tecla
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == LunaPack.Settings.TriggerKey then
            ToggleAimbot(true)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == LunaPack.Settings.TriggerKey then
            ToggleAimbot(false)
        end
    end)

    -- Limpeza ao reiniciar
    LocalPlayer.CharacterAdded:Connect(function()
        if renderConnection then
            renderConnection:Disconnect()
        end
    end)
end

-- Interface simples (opcional)
function LunaPack.CreateUI()
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
    
    local Window = OrionLib:MakeWindow({
        Name = "LunaPack v1.0",
        HidePremium = false,
        SaveConfig = false,
        ConfigFolder = "LunaPackConfig"
    })

    local MainTab = Window:MakeTab({
        Name = "Aimbot",
        Icon = "rbxassetid://4483345998"
    })

    MainTab:AddToggle({
        Name = "Ativar Aimbot",
        Default = false,
        Callback = function(Value)
            LunaPack.Settings.Enabled = Value
        end
    })

    MainTab:AddSlider({
        Name = "FOV",
        Min = 30,
        Max = 300,
        Default = 100,
        Callback = function(Value)
            LunaPack.Settings.FOV = Value
        end
    })

    MainTab:AddSlider({
        Name = "Suavidade",
        Min = 0.05,
        Max = 1,
        Default = 0.25,
        Callback = function(Value)
            LunaPack.Settings.Smoothness = Value
        end
    })

    MainTab:AddToggle({
        Name = "Filtrar Time",
        Default = true,
        Callback = function(Value)
            LunaPack.Settings.TeamCheck = Value
        end
    })

    MainTab:AddDropdown({
        Name = "Parte do Corpo",
        Default = "Head",
        Options = {"Head", "UpperTorso", "HumanoidRootPart"},
        Callback = function(Value)
            LunaPack.Settings.AimPart = Value
        end
    })

    OrionLib:Init()
end

-- Auto-inicialização
LunaPack.Init()

-- Retorna a API (opcional)
return LunaPack