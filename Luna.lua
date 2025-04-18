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



if game.PlaceId == 74260430392611 then
    


    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Kzinnx", IntroEnable = false})

local autoClickEnabled = false


local function startAutoClick()
    task.spawn(function()
        while autoClickEnabled do
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            task.wait(0.1)
        end
    end)
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
    Name = "AutoClick",
    Default = false,
    Callback = function(state)
        autoClickEnabled = state
        if autoClickEnabled then
            startAutoClick()
        end
    end
})

end
