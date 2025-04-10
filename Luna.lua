local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source.lua'))()

getgenv().LunaHub = {
    Config = {
        GameID = 4058282580,
        HubName = "Luna Hub",
        Developer = "kzinnX",
        Version = "1.1"
    }
}

if game.PlaceId ~= LunaHub.Config.GameID then return end

local Window = OrionLib:MakeWindow({
    Name = LunaHub.Config.HubName .. " | v" .. LunaHub.Config.Version,
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "LunaHubConfig"
})

local MainTab = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Funções dos botões
MainTab:AddButton({
    Name = "Comprar Todas as Luvas",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
    end
})

MainTab:AddButton({
    Name = "Comprar Todo o DNA",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
    end
})

MainTab:AddButton({
    Name = "Vender Força",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
    end
})

MainTab:AddButton({
    Name = "Resetar Stats",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.ResetStats:FireServer()
    end
})

-- Inicializa a UI
OrionLib:Init()
