--[[
  LunaPack Universal v2.0
  Suporte para múltiplos jogos
  Desenvolvido por KzinnX
  
  Jogos suportados:
  - Arsenal (3035114590)
  - Flood Escape 2 (7235547883)
]]

local LunaPack = {}

-- Serviços essenciais
local LP_GameServices = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    RunService = game:GetService("RunService")
}

-- Configurações por jogo
local LP_GameConfigs = {
    [3035114590] = { -- Arsenal
        Features = {
            AutoClick = {
                Enabled = false,
                Events = {
                    "Combat", "Combat2", "Combat3", "Combat4", "Combat5"
                },
                Delay = 0.01
            }
        }
    },
    [7235547883] = { -- Flood Escape 2
        Features = {
            AntiKick = {
                Enabled = false,
                NewUserId = 1216025046
            },
            ForceTP = {
                Enabled = false
            }
        }
    }
}

-- Verifica se o jogo atual é suportado
local LP_CurrentGame = LP_GameConfigs[game.PlaceId]
if not LP_CurrentGame then
    warn("LunaPack: Jogo não suportado!")
    return
end

-- Carrega a OrionLib
local LP_OrionLib
local function LP_LoadOrion()
    local success, result = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
    end)
    if success then
        LP_OrionLib = result
        return true
    else
        warn("LunaPack: Falha ao carregar OrionLib - "..tostring(result))
        return false
    end
end

-- Funções para Arsenal
local function LP_AutoClick()
    while LP_CurrentGame.Features.AutoClick.Enabled do
        for _, eventName in ipairs(LP_CurrentGame.Features.AutoClick.Events) do
            pcall(function()
                local event = LP_GameServices.ReplicatedStorage.Remotes[eventName]
                if event then
                    event:FireServer()
                end
            end)
        end
        wait(LP_CurrentGame.Features.AutoClick.Delay)
    end
end

-- Funções para Flood Escape 2
local function LP_AntiKick()
    pcall(function()
        LP_GameServices.Players.LocalPlayer.UserId = LP_CurrentGame.Features.AntiKick.NewUserId
        print("LunaPack: Anti-Kick ativado")
    end)
end

local function LP_ForceTP()
    pcall(function()
        local backpack = LP_GameServices.Players.LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            local antbug = backpack:FindFirstChild("Antbug")
            if antbug then
                antbug:Destroy()
                print("LunaPack: Force TP ativado")
            end
        end
    end)
end

-- Cria a interface
local function LP_CreateUI()
    if not LP_LoadOrion() then return end

    local LP_Window = LP_OrionLib:MakeWindow({
        Name = "LunaPack Universal",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "LunaPackConfig",
        IntroEnabled = false
    })

    -- Interface para Arsenal
    if game.PlaceId == 3035114590 then
        local MainTab = LP_Window:MakeTab({
            Name = "Auto-Farm",
            Icon = "rbxassetid://4483345998"
        })
        
        MainTab:AddSection({Name = "PRINCIPAIS"})
        
        MainTab:AddToggle({
            Name = "Auto-Click",
            Default = false,
            Callback = function(Value)
                LP_CurrentGame.Features.AutoClick.Enabled = Value
                if Value then
                    coroutine.wrap(LP_AutoClick)()
                end
            end    
        })
    
    -- Interface para Flood Escape 2
    elseif game.PlaceId == 7235547883 then
        local PlayerTab = LP_Window:MakeTab({
            Name = "Player",
            Icon = "rbxassetid://4483345998"
        })
        
        PlayerTab:AddSection({Name = "Jogador"})
        
        PlayerTab:AddButton({
            Name = "Anti-Kick!",
            Callback = LP_AntiKick
        })
        
        PlayerTab:AddButton({
            Name = "Force TP",
            Callback = LP_ForceTP
        })
    end

    LP_OrionLib:Init()
end

-- Inicialização
LP_CreateUI()

return LunaPack