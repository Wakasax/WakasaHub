
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

    local attack = Tabs.Main:AddToggle("Auto attack", {Title = "Auto attack", Default = false})

    attack.spawn(function()
        while Tabs.Main.Toggles.AutoClickToggle.Value do
            if ClickRemote then
                pcall(function()
                    ClickRemote:FireServer()
                end)
            end
            task.wait(0.1)
        end
    end)
