
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

    local ClickRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):FindFirstChild("Click") -- ajuste conforme o jogo

Tabs.Main:AddToggle("AutoClickToggle", {
    Title = "Auto Click",
    Default = false,
    Callback = function(state)
        if state then
            task.spawn(function()
                while Tabs.Main.Toggles.AutoClickToggle.Value do
                    if ClickRemote then
                        pcall(function()
                            ClickRemote:FireServer()
                        end)
                    end
                    task.wait(0.1) -- ESSENCIAL para não travar
                end
            end)
        end
    end
})
