local Orium = loadstring(game:HttpGet('https://raw.githubusercontent.com/RunDTM/Orium/main/source.lua'))()

getgenv().LunaHub = {
    Config = {
        GameID = 4058282580,
        HubName = "Luna Hub",
        Developer = "kzinnX",
        Version = "1.1"  -- Atualizei a versão
    }
}

if game.PlaceId ~= LunaHub.Config.GameID then return end

local Window = Orium.CreateWindow({
    Title = LunaHub.Config.HubName .. " | v" .. LunaHub.Config.Version,
    Size = UDim2.new(0, 600, 0, 500)  -- Aumentei o tamanho do painel
})

local MainTab = Window.AddTab("Principal")

MainTab.AddButton("Comprar Todas as Luvas", function()
    game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
end)

MainTab.AddButton("Comprar Todo o DNA", function()
    game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
end)

MainTab.AddButton("Vender Força", function()
    game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
end)

MainTab.AddButton("Resetar Stats", function()
    game:GetService("ReplicatedStorage").Events.ResetStats:FireServer()  -- Função para resetar stats
end)

-- Inicializa a UI
Orium.Init()
