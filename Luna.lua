
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

    local ClickRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):FindFirstChild("Click") -- ajuste o caminho conforme o jogo

    Tabs.Main:AddToggle("AutoClick", {
        Title = "Auto Click",
        Default = false,
        Callback = function(state)
            _G.AutoClick = state
            if state then
                task.spawn(function()
                    while _G.AutoClick do
                        if ClickRemote then
                            ClickRemote:FireServer()
                        end
                        task.wait(0.1)
                    end
                end)
            end
        end
    })
