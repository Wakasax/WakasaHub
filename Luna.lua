local Orium = loadstring(game:HttpGet('https://raw.githubusercontent.com/RunDTM/Orium/main/source.lua'))()

getgenv().LunaHub = {
    Config = {
        GameID = 4058282580,
        HubName = "Luna Hub",
        Developer = "kzinnX",
        Version = "1.0"
    }
}

if game.PlaceId ~= LunaHub.Config.GameID then return end

local Window = Orium.CreateWindow({
    Title = LunaHub.Config.HubName .. " | v" .. LunaHub.Config.Version,
    Size = UDim2.new(0, 500, 0, 400)
})

local MainTab = Window.AddTab("Main")

MainTab.AddButton("Comprar todas as Luvas", function()
    game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
end)

MainTab.AddButton("Comprar todo o DNA", function()
    game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
end)

MainTab.AddButton("Vender Força", function()
    game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
end)

Orium.Init()