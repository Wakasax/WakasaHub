local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Luna HUB", HidePremium = false, SaveConfig = true, ConfigFolder = "Wakasa dev"})

local npcList = {}
local selectedNPC = nil
local autoFarmActive = false

local function getNearbyNpcs(radius)
    local npcs = {}
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:FindFirstChild("HumanoidRootPart")
    
    if not root then return {} end

    for _, npc in pairs(workspace.NPCs:GetChildren()) do
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
    npcList = getNearbyNpcs(50) -- 50 studs de raio
    local names = {}
    for _, npc in ipairs(npcList) do
        table.insert(names, npc.Name)
    end
    npcDropdown:SetOptions(names)
end

local function autofarm()
    while autoFarmActive and selectedNPC and selectedNPC.Parent do

        print("Vamo la matar essa disgraça:", selectedNPC.Name)

        wait(0.5)
    end
end

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://106596759054976",
	PremiumOnly = false
})

local Section = Main:AddSection({
	Name = "DK nao gosta de trabalhar (CLT)"
})

local reloadBtn = Main:AddButton("Recarregar NPCs", reloadNpcList)

local npcDropdown = Main:AddDropdown("Selecionar NPC", {}, function(selected)

    for _, npc in ipairs(npcList) do
        if npc.Name == selected then
            selectedNPC = npc
            break
        end
    end
end)

local autofarm = Main:AddToggle("Auto Farm", false, function(state)
    autoFarmActive = state
    if state then
        spawn(autofarm)
    end
end)

reloadNpcList()
