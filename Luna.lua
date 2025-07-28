local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "AutoFarm Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "AutoFarmConfig",
    IntroText = "by Wakasax"
})

local autoSellEnabled = false
local autoSwingEnabled = false

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Auto Sell",
    Default = false,
    Callback = function(Value)
        autoSellEnabled = Value
        OrionLib:MakeNotification({
            Name = "Auto Sell",
            Content = Value and "Enabled" or "Disabled",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

MainTab:AddToggle({
    Name = "Auto Swing",
    Default = false,
    Callback = function(Value)
        autoSwingEnabled = Value
        OrionLib:MakeNotification({
            Name = "Auto Swing",
            Content = Value and "Enabled" or "Disabled",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

-- Settings Tab
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SettingsTab:AddButton({
    Name = "Destroy UI",
    Callback = function()
        OrionLib:Destroy()
    end    
})

-- Auto Sell Loop
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoSellEnabled then
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local root = character:FindFirstChild("HumanoidRootPart")
            local sellArea = workspace:FindFirstChild("sellAreaCircles")
            if root and sellArea then
                for _, area in pairs(sellArea:GetChildren()) do
                    local inner = area:FindFirstChild("circleInner")
                    if inner and inner:FindFirstChild("TouchInterest") then
                        firetouchinterest(root, inner, 0)
                        task.wait(0.1)
                        firetouchinterest(root, inner, 1)
                    end
                end
            end
        end
    end
end)

-- Auto Swing Loop
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoSwingEnabled then
            local player = game:GetService("Players").LocalPlayer
            local ninjaEvent = player:FindFirstChild("ninjaEvent")
            if ninjaEvent then
                ninjaEvent:FireServer("swingKatana")
            end
        end
    end
end)

OrionLib:Init()
