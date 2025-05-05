
if game.PlaceId == 86782616351214 then
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "dev wakasa"})

local Main = Window:MakeTab({
	Name = "Farm",
	Icon = "rbxassetid://rbxassetid://106596759054976",
	PremiumOnly = false
})

local Section = Main:AddSection({
	Name = "finge que tem uma frase foda aqui"
})


Main:AddToggle({
	Name = "auto click eu acho testa ai",
	Default = false,
	Callback = function(Value)
        wait(0.5)
        
        game:GetService("ReplicatedStorage"):WaitForChild("\207\155\207\157\206\182\206\183\206\179\206\182\206\182\207\157\206\178"):WaitForChild("\208\147\208\168\208\130\208\131\208\130\208\148\208\168\208\146\208\148\208\150"):FireServer(unpack(args))
	end    
})





end
