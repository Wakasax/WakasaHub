-- Carregar a biblioteca Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Criar a janela principal da Luna Hub
local Window = Fluent:CreateWindow({
    Title = "Luna Hub by KzinnX",
    SubTitle = "Bubble Gum Simulator INFINITY",
    TabWidth = 160,
    Size = UDim2.new(0, 500, 0, 350),
    Theme = "Dark",
    Acrylic = true,
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Criar uma aba
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" })
}

-- Variáveis de controle
local autoFarm = false
local autoSell = false
local autoHatch = false
local infJump = false
local player = game.Players.LocalPlayer

-- Função Auto Farm
local function startAutoFarm()
    while autoFarm do
        for _, coin in pairs(workspace.Coins:GetChildren()) do
            if coin:IsA("BasePart") then
                player.Character.HumanoidRootPart.CFrame = coin.CFrame
                wait(0.1)
            end
        end
        game:GetService("ReplicatedStorage").Events.BlowBubble:FireServer()
        wait(0.5)
    end
end

-- Função Auto Sell
local function startAutoSell()
    while autoSell do
        game:GetService("ReplicatedStorage").Events.SellBubble:FireServer()
        wait(1)
    end
end

-- Função Auto Hatch
local function startAutoHatch()
    while autoHatch do
        game:GetService("ReplicatedStorage").Events.HatchEgg:FireServer("BasicEgg", 1)
        wait(2)
    end
end

-- Função Infinite Jump
local function enableInfJump()
    local userInput = game:GetService("UserInputService")
    userInput.JumpRequest:Connect(function()
        if infJump and player.Character then
            player.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end

-- Adicionar botões à aba principal usando Fluent
Tabs.Main:AddButton({
    Title = "Toggle Auto Farm",
    Description = "Automatically collect coins and blow bubbles",
    Callback = function()
        autoFarm = not autoFarm
        if autoFarm then spawn(startAutoFarm) end
        Fluent:Notify({ Title = "Luna Hub", Content = "Auto Farm: " .. (autoFarm and "ON" or "OFF") })
    end
})

Tabs.Main:AddButton({
    Title = "Toggle Auto Sell",
    Description = "Automatically sell bubbles",
    Callback = function()
        autoSell = not autoSell
        if autoSell then spawn(startAutoSell) end
        Fluent:Notify({ Title = "Luna Hub", Content = "Auto Sell: " .. (autoSell and "ON" or "OFF") })
    end
})

Tabs.Main:AddButton({
    Title = "Toggle Auto Hatch",
    Description = "Automatically hatch Basic Eggs",
    Callback = function()
        autoHatch = not autoHatch
        if autoHatch then spawn(startAutoHatch) end
        Fluent:Notify({ Title = "Luna Hub", Content = "Auto Hatch: " .. (autoHatch and "ON" or "OFF") })
    end
})

Tabs.Main:AddButton({
    Title = "Toggle Infinite Jump",
    Description = "Jump infinitely in the air",
    Callback = function()
        infJump = not infJump
        if infJump then enableInfJump() end
        Fluent:Notify({ Title = "Luna Hub", Content = "Infinite Jump: " .. (infJump and "ON" or "OFF") })
    end
})

-- Notificação inicial
Fluent:Notify({
    Title = "Luna Hub by KzinnX",
    Content = "Script loaded successfully! Enjoy!",
    Duration = 5
})

if game.PlaceId == 4058282580 then
    


    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Kzinnx", IntroEnable = false})



    local Main = Window:MakeTab({
            Name = "Luna",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
    })
    local Section = Main:AddSection({
        Name = "Auto-farm"
    })

    Main:AddToggle({
        Name = "Auto-sell",
        Default = false,
        pcall = function(Value)
            game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()  
            task.wait(0.1)

        end    
    })
end



if game.PlaceId == 74260430392611 then
    


    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Kzinnx", IntroEnable = false})

local autoClickEnabled = false


local function startAutoClick()
    task.spawn(function()
        while autoClickEnabled do
            pcall(function()
                local vim = game:GetService("VirtualInputManager")
                vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            task.wait(0.1)
        end
    end)
end





    local Main = Window:MakeTab({
            Name = "Luna",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
    })
    local Section = Main:AddSection({
        Name = "Auto-farm"
    })
Main:AddToggle({
    Name = "AutoClick",
    Default = false,
    Callback = function(state)
        autoClickEnabled = state
        if autoClickEnabled then
            startAutoClick()
        end
    end
})


end


local Fluent =
    loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "Luna Hub ",
        SubTitle = "by Kzinnx",
        TabWidth = 100,
        Size = UDim2.fromOffset(430, 300),
        Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://106596759054976" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }
    Window:SelectTab(1)

    local clicker = Tabs.Main:AddToggle("auto clicker", {Title = "auto clicker", Default = false })

    clicker:OnChanged(function()
        while clicker.Value do
            wait(0.1)

            local args = {
                [1] = "BlowBubble"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end)

    local vender = Tabs.Main:AddToggle("vender", {Title = "vender", Default = false })

    vender:OnChanged(function()
        while vender.Value do
            wait(0.1)
            
            local args = {
                [1] = "SellBubble"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
        end
    end)

--settings do fluent
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

if game.PlaceId == 17642426372 then
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


