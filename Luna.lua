

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


if game.PlaceId == 286090429 then

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
local Settings = Window:AddTab({ Title = "Settings", Icon = "rbxassetid://106596759054976" })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Aimbot = false
local Silent = false
local Hitbox = false
local WallCheck = false
local FOV = 150

Tab:AddToggle("aimbot", {
    Title = "Aimbot",
    Default = false,
    Callback = function(v) Aimbot = v end
})

Tab:AddToggle("silent", {
    Title = "Silent Aim",
    Default = false,
    Callback = function(v) Silent = v end
})

Tab:AddToggle("hitbox", {
    Title = "Hitbox",
    Default = false,
    Callback = function(v) Hitbox = v end
})

Tab:AddToggle("wallcheck", {
    Title = "Wall Check",
    Default = false,
    Callback = function(v) WallCheck = v end
})

Tab:AddSlider("fov", {
    Title = "FOV",
    Default = 150,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(v) FOV = v end
})

local function Closest()
    local closest, dist = nil, FOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
            if onScreen then
                local m = UIS:GetMouseLocation()
                local d = (Vector2.new(pos.X, pos.Y) - m).Magnitude
                if d < dist then
                    dist = d
                    closest = p
                end
            end
        end
    end
    return closest
end

local function CanSee(pos)
    if not WallCheck then return true end
    local ray = Ray.new(Camera.CFrame.Position, (pos - Camera.CFrame.Position).Unit * 1000)
    local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character)
    return hit == nil
end

RunService.RenderStepped:Connect(function()
    if not Aimbot then return end
    local t = Closest()
    if t and t.Character and t.Character:FindFirstChild("Head") then
        local pos = t.Character.Head.Position
        if CanSee(pos) then
            if Hitbox then
                t.Character.Head.Size = Vector3.new(10, 10, 10)
                t.Character.Head.Transparency = 0.5
                t.Character.Head.Material = Enum.Material.Neon
            end
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos)
        end
    end
end)

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if Silent and method == "FireServer" and tostring(self) == "HitPart" then
        local t = Closest()
        if t and t.Character and t.Character:FindFirstChild("Head") then
            if CanSee(t.Character.Head.Position) then
                args[2] = t.Character.Head
                args[3] = t.Character.Head.Position
                return old(self, unpack(args))
            end
        end
    end
    return old(self, ...)
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("LunaHub")
SaveManager:SetFolder("LunaHub/Arsenal")
InterfaceManager:BuildInterfaceSection(Settings)
SaveManager:BuildConfigSection(Settings)

end
