local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "AutoFarm Hub",
    SubTitle = "by Wakasax",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local autoSellEnabled = false
local autoSwingEnabled = false

Tabs.Main:AddToggle("Auto Sell", {
    Title = "Auto Sell",
    Description = "Toggles Auto Sell functionality.",
    Default = false,
    Callback = function(state)
        autoSellEnabled = state
        if state then
            print("Auto Sell Enabled")
        else
            print("Auto Sell Disabled")
        end
    end
})

Tabs.Main:AddToggle("Auto Swing", {
    Title = "Auto Swing",
    Description = "Toggles Auto Swing functionality.",
    Default = false,
    Callback = function(state)
        autoSwingEnabled = state
        if state then
            print("Auto Swing Enabled")
        else
            print("Auto Swing Disabled")
        end
    end
})

-- Loop para Auto Sell
spawn(function()
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

-- Loop para Auto Swing
spawn(function()
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
