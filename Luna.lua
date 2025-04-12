if game.PlaceId == 4058282580 then
    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

    local Window = OrionLib:MakeWindow({
        Name = "Luna Hub",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "Luna",
        IntroEnable = false
    })

    -- Valores Globais
    _G.AutoAtk = false
    _G.AutoSell = false
    _G.AutoLuva = false
    _G.AutoDNA = false

    -- Funções
    function AutoAtk()
        while _G.AutoAtk do
            game:GetService("ReplicatedStorage").Events.Attack:FireServer()
            task.wait(0.1)
        end
    end

    function AutoDNA()
        while _G.AutoDNA do
            game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
            task.wait(0.1)
        end
    end

    function AutoSell()
        while _G.AutoSell do
            game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
            task.wait(0.1)
        end
    end

    function AutoLuva()
        while _G.AutoLuva do
            game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
            task.wait(0.1)
        end
    end

    -- GUI Principal
    local MainTab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local Section = MainTab:AddSection({
        Name = "Auto-Farm :D"
    })

    MainTab:AddToggle({
        Name = "Auto Sell",
        Default = false,
        Callback = function(Value)
            _G.AutoSell = Value
            if Value then
                AutoSell()
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto DNA",
        Default = false,
        Callback = function(Value)
            _G.AutoDNA = Value
            if Value then
                AutoDNA()
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto Luva",
        Default = false,
        Callback = function(Value)
            _G.AutoLuva = Value
            if Value then
                AutoLuva()
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto Força",
        Default = false,
        Callback = function(Value)
            _G.AutoAtk = Value
            if Value then
                AutoAtk()
            end
        end
    })
end


--[[
  Game: Rebirth Champions: Ultimate
  PlaceId: 74260430392611
--]]

local PlaceId = game.PlaceId
if PlaceId ~= 74260430392611 then return end

local Knit = game:GetService("ReplicatedStorage").Packages.Knit
local Services = Knit.Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function decode(str)
    return utf8.char(table.unpack(str))
end

local RemotePath = decode({106,97,103,32,107,228,110,110,101,114,32,101,110,32,98,111,116,44,32,104,111,110,32,104,101,116,101,114,32,97,110,110,97,44,32,97,110,110,97,32,104,101,116,101,114,32,104,111,110})
local RF = Services[RemotePath].RF
local RE = Services[RemotePath].RE

local active = {
    AutoClick = false,
    AutoClaim = false,
    OpenEgg = false
}

local selectedRarities = {}
local selectedEgg = nil

-- UI
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/kzinnui/scripts/main/lib.lua"))()
local win = lib:CreateWindow("Rebirth Champions: Ultimate")

local farmTab = win:CreateTab("Farm")
local eggTab = win:CreateTab("Eggs")

-- Funções
local function autoClick()
    while active.AutoClick do
        task.wait()
        RE[RemotePath]:FireServer("Farm", 1)
    end
end

local function autoClaim()
    while active.AutoClaim do
        task.wait(1)
        RF[RemotePath]:InvokeServer(1)
    end
end

local function openEgg()
    while active.OpenEgg do
        task.wait(2)
        if selectedEgg and selectedEgg ~= "" then
            RE[RemotePath]:FireServer({selectedEgg})
        end
    end
end

-- Refresh ovos
local function getEggs()
    local eggs = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Egg") then
            table.insert(eggs, v.Name)
        end
    end
    return eggs
end

-- Interface
farmTab:AddToggle("Auto Click", false, function(v)
    active.AutoClick = v
    if v then autoClick() end
end)

farmTab:AddToggle("Auto Claim Rewards", false, function(v)
    active.AutoClaim = v
    if v then autoClaim() end
end)

eggTab:AddButton("Refresh Eggs", function()
    eggTab:ClearDropdowns("Egg List")
    local eggs = getEggs()
    eggTab:AddDropdown("Egg List", eggs, function(v)
        selectedEgg = v
    end)
end)

eggTab:AddToggle("Open Egg", false, function(v)
    active.OpenEgg = v
    if v then openEgg() end
end)

eggTab:AddLabel("Dupe Pets by Rarity:")
local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"}
for _, rarity in ipairs(rarities) do
    eggTab:AddToggle(rarity, false, function(v)
        selectedRarities[rarity] = v
    end)
end

-- Sistema de duplicação (teórico)
RE[RemotePath]:FireServer("EquipBest")
