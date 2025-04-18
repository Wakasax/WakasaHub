

if game.PlaceId == 4058282580 then
    


    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Kzinnx", IntroEnable = false})



    local Main = Window:MakeTab({
            Name = "Luna",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
    })
    local Section = Main:AddSection({
        Name = "Auto-farm"
    })

    Main:AddToggle({
        Name = "Auto-sell",
        Default = false,
        pcall = function(Value)
            game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()  
            task.wait(0.1)

        end    
    })
end



if game.PlaceId == 74260430392611 then
    


    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Kzinnx", IntroEnable = false})

local autoClickEnabled = false


local function startAutoClick()
    task.spawn(function()
        while autoClickEnabled do
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            task.wait(0.1)
        end
    end)
end





    local Main = Window:MakeTab({
            Name = "Luna",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
    })
    local Section = Main:AddSection({
        Name = "Auto-farm"
    })
Main:AddToggle({
    Name = "AutoClick",
    Default = false,
    Callback = function(state)
        autoClickEnabled = state
        if autoClickEnabled then
            startAutoClick()
        end
    end
})


end


if game.PlaceId == 85896571713843 then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "Luna Hub ",
        SubTitle = "by Kzinnx",
        TabWidth = 100,
        Size = UDim2.fromOffset(430, 300),
        Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://106596759054976" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }
    Window:SelectTab(1)

    local clicker = Tabs.Main:AddToggle("auto clicker", {Title = "auto clicker", Default = false })

    clicker:OnChanged(function()
        while clicker.Value do
            wait(0.1)

            local args = {
                [1] = "BlowBubble"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end)

    local vender = Tabs.Main:AddToggle("vender", {Title = "vender", Default = false })

    vender:OnChanged(function()
        while vender.Value do
            wait(0.1)
            
            local args = {
                [1] = "SellBubble"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end)

--settings do fluent
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

end


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Luna Hub - Aimbot",
    SubTitle = "by kzinnx",
    TabWidth = 160,
    Size = UDim2.fromOffset(490, 400),
    Acrylic = true,
    Theme = "Purple",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tab = Window:AddTab({ Title = "Aimbot", Icon = "rbxassetid://106596759054976" })

local Toggle, AimbotEnabled = false, false
local FOV = 100

Tab:AddToggle("Aimbot", {
    Title = "Ativar Aimbot",
    Default = false,
    Callback = function(value)
        AimbotEnabled = value
    end
})

Tab:AddSlider("FOVSlider", {
    Title = "FOV",
    Description = "so nao xita ate o talo",
    Default = 100,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(value)
        FOV = value
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)

            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude

                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    if not AimbotEnabled then return end

    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local head = target.Character.Head.Position
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, head)
    end

--settings do fluent
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
end)
