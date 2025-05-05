
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

    local autoClickEnabled = false

    local function startAutoClick()
        task.spawn(function()
            while autoClickEnabled do
                local ClickRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):FindFirstChild("Click")
                if ClickRemote then
                    pcall(function()
                        ClickRemote:FireServer()
                    end)
                end
                task.wait(0.1) -- evita travar o jogo
            end
        end)
    end
    
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
    
