local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Image = "rbxassetid://106596759054976"
toggleButton.BackgroundTransparency = 1
toggleButton.ZIndex = 999 -- Garante que fique por cima
toggleButton.Parent = game:GetService("CoreGui")

local isOpen = true
local window = Window -- Usa o objeto do Fluent

toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    window:SetVisible(isOpen)
end)

local Window = Fluent:CreateWindow({
    Title = "Luna Hub",
    SubTitle = "By KzinnX",
    TabWidth = 100,
    Size = UDim2.fromOffset(430, 300), --tamanho da UI
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Luna", Icon = "rbxassetid://18831448204" }),
    Settings = Window:AddTab({ Title = "• Settings", Icon = "rbxassetid://18319394996" })
}
Window:Luna(1)

local attack = Tabs.Luna:AddToggle("Auto attack", {Title = "Auto attack", Default = false})

attack:OnChanged(function()
    while attack.Value do
        wait(0.1)

        game:GetService("ReplicatedStorage"):FindFirstChild("\206\184\206\182\206\184\206\183\207\157\205\177\206\181\207\157\206\180"):FindFirstChild("\208\131\210\144\208\147\208\130\208\145\208\130\208\130\208\148\208\130\208\130"):FireServer(unpack(args))
    end
end)


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
