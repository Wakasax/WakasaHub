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
