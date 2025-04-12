if game.PlaceId == 91927205587272 then

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "KzinnX", IntroEnable == false})

    --valor
    _G.attack = false 


    --function
    function autoclick()
        while _G.attack == true do
            game:GetService("ReplicatedStorage"):FindFirstChild("\206\184\206\182\206\184\206\183\207\157\205\177\206\181\207\157\206\180"):FindFirstChild("\208\131\210\144\208\147\208\130\208\145\208\130\208\130\208\148\208\130\208\130"):FireServer(unpack(args))

            wait(0.1)
        end        
    end

    local Luna = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://106596759054976",
        PremiumOnly = false
    })
    local Section = Luna:AddSection({
        Name = "Auto Farm :D"
    })

    Luna:AddToggle({
        Name = "Auto-Click",
        Default = false,
        Callback = function(Value)
            _G.attack = Value
            if Value then
                task.spawn(autoclick)
            end
        end    
    })





end    
