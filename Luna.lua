local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Luna HUB",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Wakasa dev"
})

local npcList = {}
local selectedNPC = nil
local autoFarmActive = false
local npcDropdown

-- Busca TODOS os NPCs vivos na pasta, sem limite de raio
local function getAllNpcs()
    local npcs = {}
    for _, npc in pairs(workspace.Npc.OnePiece:GetChildren()) do
        if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            table.insert(npcs, npc)
        end
    end
    return npcs
end

local function reloadNpcList()
    npcList = getAllNpcs()
    local names = {}
    for _, npc in ipairs(npcList) do
        table.insert(names, npc.Name)
    end
    if npcDropdown then
        npcDropdown:Refresh(names, true)
    end
end

local function teleportToNPC(npc)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    end
end

local function autofarmLoop()
    while autoFarmActive do
        for _, npc in ipairs(npcList) do
            if npc and npc.Parent and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                teleportToNPC(npc)
                while autoFarmActive and npc.Parent and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 do
                    local args = {
                        "GainStrength",
                        {}
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Input"):FireServer(unpack(args))
                    wait(0.2)
                end
                wait(0.2)
            end
        end
        reloadNpcList()
        wait(0.5)
    end
end

local Main = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://106596759054976",
    PremiumOnly = false
})

Main:AddSection({
    Name = "DK nao gosta de trabalhar (CLT)"
})

Main:AddButton({
    Name = "Recarregar NPCs",
    Callback = reloadNpcList
})

npcDropdown = Main:AddDropdown({
    Name = "Selecionar NPC",
    Default = "",
    Options = {},
    Callback = function(selected)
        selectedNPC = nil
        for _, npc in ipairs(npcList) do
            if npc.Name == selected then
                selectedNPC = npc
                break
            end
        end
    end
})

Main:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarmActive = state
        if state then
            spawn(autofarmLoop)
        end
    end
})

-- INF SPIN EGG SYSTEM (OnePiece)
local infSpinEgg = false

Main:AddToggle({
    Name = "Inf Spin Egg (OnePiece)",
    Default = false,
    Callback = function(state)
        infSpinEgg = state
        if state then
            spawn(function()
                while infSpinEgg do
                    local args = {
                        "Hatch",
                        "OnePiece"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Egg"):WaitForChild("EggHatch"):InvokeServer(unpack(args))
                    wait(0.05) -- turbo!
                end
            end)
        end
    end
})

reloadNpcList()
OrionLib:Init()
