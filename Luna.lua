if game.PlaceId == 4058282580 then

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({
        Name = "Luna Hub", 
        HidePremium = false, 
        SaveConfig = true, 
        ConfigFolder = "Luna", 
        IntroEnable = false
    })

    -- Variáveis
    _G.AutoAtk = false
    _G.AutoSell = false
    _G.AutoLuva = false
    _G.AutoDNA = false

    -- Funções
    function AutoAtk()
        while _G.AutoAtk do
            pcall(function()
                local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local trainBtn = playerGui:FindFirstChild("TrainButton", true)
                    if trainBtn and (trainBtn:IsA("ImageButton") or trainBtn:IsA("TextButton")) then
                        trainBtn:Activate()
                    end
                end
            end)
            task.wait(0.1)
        end
    end

    function AutoSell()
        while _G.AutoSell do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
            end)
            task.wait(0.1)
        end
    end

    function AutoLuva()
        while _G.AutoLuva do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
            end)
            task.wait(0.1)
        end
    end

    function AutoDNA()
        while _G.AutoDNA do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
            end)
            task.wait(0.1)
        end
    end

    -- GUI
    local MainTab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MainTab:AddSection({
        Name = "Auto-Farm"
    })

    MainTab:AddToggle({
        Name = "Auto Força",
        Default = false,
        Callback = function(Value)
            _G.AutoAtk = Value
            if Value then
                task.spawn(AutoAtk)
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto Sell",
        Default = false,
        Callback = function(Value)
            _G.AutoSell = Value
            if Value then
                task.spawn(AutoSell)
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto Luva",
        Default = false,
        Callback = function(Value)
            _G.AutoLuva = Value
            if Value then
                task.spawn(AutoLuva)
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto DNA",
        Default = false,
        Callback = function(Value)
            _G.AutoDNA = Value
            if Value then
                task.spawn(AutoDNA)
            end
        end
    })

end


if game.PlaceId == 74260430392611 then

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({
        Name = "Luna Hub", 
        HidePremium = false, 
        SaveConfig = true, 
        ConfigFolder = "Luna", 
        IntroEnable = false
    })

    -- Variáveis
    _G.AutoFarm = false
    _G.AutoPet = false
    _G.AutoTP = false

    -- Funções de Farm
    function AutoFarm()
        while _G.AutoFarm do
            pcall(function()
                -- Substitua isso com a lógica de farm real, por exemplo:
                local utf8Char = utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)
                game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8Char].RF[utf8Char]:InvokeServer()
            end)
            task.wait(1)
        end
    end

    -- Funções de Pet
    function AutoPet()
        while _G.AutoPet do
            pcall(function()
                -- Lógica de Pet (comprar ou interagir com pets)
                local utf8Char = utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)
                game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8Char].RF[utf8Char]:InvokeServer("pet")
            end)
            task.wait(1)
        end
    end

    -- Funções de Teleporte (TP)
    function AutoTP()
        while _G.AutoTP do
            pcall(function()
                -- Lógica de Teleporte (ir para locais específicos no mapa)
                local utf8Char = utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)
                game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8Char].RF[utf8Char]:InvokeServer("teleport")
            end)
            task.wait(1)
        end
    end

    -- GUI
    local FarmTab = Window:MakeTab({
        Name = "Farm",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    FarmTab:AddSection({
        Name = "Auto-Farm"
    })

    FarmTab:AddToggle({
        Name = "Auto Farm",
        Default = false,
        Callback = function(Value)
            _G.AutoFarm = Value
            if Value then
                task.spawn(AutoFarm)
            end
        end
    })

    -- PetTab
    local PetTab = Window:MakeTab({
        Name = "Pet",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    PetTab:AddSection({
        Name = "Auto Pet"
    })

    PetTab:AddToggle({
        Name = "Auto Pet",
        Default = false,
        Callback = function(Value)
            _G.AutoPet = Value
            if Value then
                task.spawn(AutoPet)
            end
        end
    })

    -- TPTab
    local TPTab = Window:MakeTab({
        Name = "TP",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    TPTab:AddSection({
        Name = "Auto Teleport"
    })

    TPTab:AddToggle({
        Name = "Auto TP",
        Default = false,
        Callback = function(Value)
            _G.AutoTP = Value
            if Value then
                task.spawn(AutoTP)
            end
        end
    })

end
