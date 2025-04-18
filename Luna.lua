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
