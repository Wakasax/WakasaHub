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

local function getNearbyNpcs(radius)
    local npcs = {}
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return {} end
    -- Caminho atualizado para workspace.Npc.OnePiece
    for _, npc in pairs(workspace.Npc.OnePiece:GetChildren()) do
        if npc:FindFirstChild("HumanoidRootPart") then
            local dist = (npc.HumanoidRootPart.Position - root.Position).magnitude
            if dist <= radius then
                table.insert(npcs, npc)
            end
        end
    end
    return npcs
end

local function reloadNpcList()
    npcList = getNearbyNpcs(50)
    local names = {}
    for _, npc in ipairs(npcList) do
        table.insert(names, npc.Name)
    end
    if npcDropdown then
        npcDropdown:Refresh(names, true)
    end
end

local function autofarmLoop()
    while autoFarmActive and selectedNPC and selectedNPC.Parent do
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

reloadNpcList()
OrionLib:Init()
