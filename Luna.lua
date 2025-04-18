if game.PlaceId == 4058282580 then

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "thx Hubi", HidePremium = false, SaveConfig = true, ConfigFolder = "Devi thx", IntroEnable = false})

local Main = Window:MakeTab({
    Name = "auto farmi",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
 
local Section = Main:AddSection({
    Name = "a"
})
  
   Main:AddToggle({
    Name = "auto vende",
    Default = false,
    Callback = function(Value) game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()  
            task.wait(0.1)
    end    
})
end



if game.PleaceId == 74260430392611 then
    

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "ghost hub", HidePremium = false, SaveConfig = true, ConfigFolder = "ghost", IntroEnable = false})

    local main = Window:MakeTab({
        Name = "auto farm",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local Section = main:AddSection({
        Name = "auto farm"
    })

    local clicking = false

    main:AddToggle({
        Name = "AutoClick",
        Default = false,
        Callback = function(Value)
        clicking = Value

            task.spawn(function()
                while clicking do
                    pcall(function()
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end)

                    task.wait(0.1)
                end
            end)
        end
    })

end
