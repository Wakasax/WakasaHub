if game.PlaceId == 4058282580 then

    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "Luna Hub | Boxing 🥊",
        SubTitle = "By Kzinn",
        TabWidth = 100,
        Size = UDim2.fromOffset(480, 320),
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })

    local Tabs = {
        Farm = Window:AddTab({ Title = "• Farm", Icon = "rbxassetid://18391040132" }),
        TP = Window:AddTab({ Title = "• TP", Icon = "rbxassetid://18330539921" }),
        Settings = Window:AddTab({ Title = "• Settings", Icon = "rbxassetid://18319394996" }),
    }

    Window:SelectTab(1)

    -- // FARM: Auto Ataque (repete remote Attack)
    local autoFarm = Tabs.Farm:AddToggle("AutoFarm", {
        Title = "Auto Ataque",
        Default = false
    })

    autoFarm:OnChanged(function(state)
        while state and autoFarm.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Attack:FireServer()
            end)
            task.wait(0.15)
        end
    end)

    -- // FARM: Auto Sell
    local autoSell = Tabs.Farm:AddToggle("AutoSell", {
        Title = "Auto Vender",
        Default = false
    })

    autoSell:OnChanged(function(state)
        while state and autoSell.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
            end)
            task.wait(0.75)
        end
    end)

    -- // FARM: Auto Glove
    local autoGlove = Tabs.Farm:AddToggle("AutoLuva", {
        Title = "Auto Luva",
        Default = false
    })

    autoGlove:OnChanged(function(state)
        while state and autoGlove.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
            end)
            task.wait(1)
        end
    end)

    -- // FARM: Auto DNA
    local autoDNA = Tabs.Farm:AddToggle("AutoDNA", {
        Title = "Auto DNA",
        Default = false
    })

    autoDNA:OnChanged(function(state)
        while state and autoDNA.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
            end)
            task.wait(1)
        end
    end)

    -- // TP: Coins (usando TweenEvent)
    Tabs.TP:AddButton({
        Title = "Pegar Moeda [Coin]",
        Description = "Teleporta pra moeda usando Tween",
        Callback = function()
            local coin = workspace:WaitForChild("Coins", 9e9):GetChildren()[11]:WaitForChild("Decoration", 9e9)

            local args = {
                [1] = coin,
                [2] = {
                    [1] = 0.5,
                    [2] = Enum.EasingStyle.Quad,
                    [3] = Enum.EasingDirection.Out,
                    [4] = 0,
                    [5] = false,
                    [6] = 0,
                },
                [3] = {
                    ["Transparency"] = 1,
                },
            }

            firesignal(game:GetService("ReplicatedStorage")
                :WaitForChild("Modules", 9e9)
                :WaitForChild("ReplicatedTweening", 9e9)
                :WaitForChild("TweenEvent", 9e9)
                .OnClientEvent, unpack(args))
        end
    })

    -- // Settings (Fluent padrão)
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("LunaHub")
    SaveManager:SetFolder("LunaHub/Boxing")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

end
