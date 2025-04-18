if game.PlaceId == 4058282580 then

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Kzinnx", IntroEnable = false})

    --variavel
    _G.AutoSell = false

    --function
    function AutoSell()
        while AutoSell.value do
            game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
            task.wait(1)

        end

    local Main = Window:MakeTab({
            Name = "Luna",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
    })
    local Section = Main:AddSection({
        Name = "Auto-farm"
    })

    Main:AddToggle({
        Name = "Auto-sell",
        Default = false,
        Callback = function(Value)
            _G.AutoSell(value)
            if value then
                task.spawn(AutoSell)
            end

        end    
    })



    end






end


if game.PlaceId == 85896571713843 then -- bubble gum simulator inf

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Luna"})

    local Main = Window:MakeTab({
        Name = "Luna",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local Main = Tab:AddSection({
        Name = "Auto-farm"
    })

    Main:AddToggle({
        Name = "auto soprar",
        Default = false,
        Callback = function(Value)

        end
    })
    Main:AddToggle({
        Name = "auto vender",
        Default = false,
        Callback = function(Value)

        end
    })






end
