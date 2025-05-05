
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    
    
    local Window = Fluent:CreateWindow({
        Title = "Luna Hub",
        SubTitle = "",
        TabWidth = 100,
        Size = UDim2.fromOffset(430, 300), --tamanho da UI
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "• Infor", Icon = "rbxassetid://18831448204" }),
        Settings = Window:AddTab({ Title = "• Settings", Icon = "rbxassetid://18319394996" })
    }
    Window:SelectTab(1)

    local click = Tabs.Main:AddToggle("Auto click", {Title = "Auto click", Default = false})

    click:OnChanged(function()
        while click.Value do
           
            wait(1)
            game:GetService("ReplicatedStorage"):WaitForChild("\207\155\207\157\206\182\206\183\206\179\206\182\206\182\207\157\206\178"):WaitForChild("\208\147\208\168\208\130\208\131\208\130\208\148\208\168\208\146\208\148\208\150"):FireServer(unpack(args))
          
    end
end)
