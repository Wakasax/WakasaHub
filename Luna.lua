if game.PlaceId == 4058282580 then
    

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Luna", IntroEnable = false})

    --Valor

    _G.AutoAtk = true
    _G.AutoSell = true
    _G.AutoLuva = true
    _G.AutoDNA = true
    --function
    function AutoAtk()
        while AutoAtk == true do
            game:GetService("ReplicatedStorage").Events.Attack:FireServer()
            wait(0.1)
        end
        
    end

    function AutoDNA()
        while AutoDNA == true do
            game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()

            wait(0.1)
        end
        
    end

    function AutoSell()
        while AutoSell == true do
            game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
            wait(0.1)
        end
        
    end

    function AutoLuva()
        while AutoLuva == true do
            game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
            wait(0.1)
        end
        
    end


    -- jogador
    local MainTab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    local Section = MainTab:AddSection({
        Name = "Auto-Farm :D"
    })
    MainTab:AddToggle({
        Name = "Auto Geral (todas as funções)",
        Default = false,
        Callback = function(Value)
            _G.AutoAtk = Value
            _G.AutoSell = Value
            _G.AutoLuva = Value
            _G.AutoDNA = Value
        end    
    })





end
