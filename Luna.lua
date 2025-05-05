local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()


local Window = Fluent:CreateWindow({
    Title = "With ❤️ Nami Hub",
    SubTitle = "",
    TabWidth = 100,
    Size = UDim2.fromOffset(430, 300), --tamanho da UI
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})

--tabs
local Tabs = {
    Main = Window:AddTab({ Title = "• Infor", Icon = "rbxassetid://18831448204" }),
    Settings = Window:AddTab({ Title = "• Settings", Icon = "rbxassetid://18319394996" })
}
Window:SelectTab(1)

local autoClickEnabled = false
local autoClickTask = nil

local function startAutoClick()
    autoClickTask = task.spawn(function()
        local vim = game:GetService("VirtualInputManager")
        while autoClickEnabled do
            pcall(function()
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

Main:AddSection({
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



--settings do fluent
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
