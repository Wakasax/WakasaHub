local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Criar a janela principal do hub
local Window = Fluent:CreateWindow({
    Title = "Luna Hub",
    SubTitle = "by Kzinn",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 480),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl, -- Configura a tecla de minimizar
    CloseKey = Enum.KeyCode.LeftAlt -- Tecla de fechar a janela
})

-- Criar as abas
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Eggs = Window:AddTab({ Title = "Eggs", Icon = "egg" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Variáveis globais (_G) para controle do hub
_G.FlySpeed = 50
_G.EggsOpened = 0

-- Adicionar Toggle para Fly
local ToggleFly = Tabs.Main:AddToggle("Fly", {
    Title = "Activate Fly",
    Default = false,
    Callback = function(Value)
        if Value then
            -- Ativa o fly com a velocidade configurada
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
            bodyVelocity.Velocity = Vector3.new(0, _G.FlySpeed, 0)
            bodyVelocity.Parent = character.HumanoidRootPart
            -- Loop para controlar o movimento
            while ToggleFly.Value do
                wait(0.1)
                bodyVelocity.Velocity = Vector3.new(0, _G.FlySpeed, 0)
            end
            bodyVelocity:Destroy()
        end
    end
})

-- Slider para controlar a velocidade do Fly
Tabs.Settings:AddSlider("FlySpeed", {
    Title = "Fly Speed",
    Min = 10,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        _G.FlySpeed = Value
        print("Fly Speed set to: " .. _G.FlySpeed)
    end
})

-- Função para soprar bolha sem delay
Tabs.Main:AddButton({
    Title = "Blow Bubble",
    Description = "Instantly blow a bubble.",
    Callback = function()
        local args = { [1] = "BlowBubble" }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer(unpack(args))
    end
})

-- Função para vender bolha sem teleportar
Tabs.Main:AddButton({
    Title = "Sell Bubble",
    Description = "Sell bubble instantly without teleport.",
    Callback = function()
        local args = { [1] = "SellBubble", [2] = "Sell" }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer(unpack(args))
    end
})

-- Função para abrir ovos instantaneamente
Tabs.Eggs:AddButton({
    Title = "Open Eggs",
    Description = "Open all available eggs instantly.",
    Callback = function()
        local args = { [1] = "EggOpen" }
        for i = 1, 100 do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer(unpack(args))
        end
        _G.EggsOpened = _G.EggsOpened + 100
        print("Eggs opened: " .. _G.EggsOpened)
    end
})

-- Função de Refresh de ovos
Tabs.Eggs:AddButton({
    Title = "Refresh Eggs",
    Description = "Refresh egg list.",
    Callback = function()
        -- Lógica de refrescar ovos
        print("Eggs list refreshed.")
    end
})

-- Função de salvar configurações
Tabs.Settings:AddButton({
    Title = "Save Settings",
    Description = "Save current settings.",
    Callback = function()
        SaveManager:SaveConfig()
        print("Settings saved.")
    end
})

-- Função para carregar configurações
Tabs.Settings:AddButton({
    Title = "Load Settings",
    Description = "Load saved settings.",
    Callback = function()
        SaveManager:LoadConfig()
        print("Settings loaded.")
    end
})

-- Configurar o salvamento e carregamento de configurações
SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("LunaHub/Settings")
SaveManager:BuildConfigSection(Tabs.Settings)

-- Função para mostrar uma notificação
Fluent:Notify({
    Title = "Luna Hub",
    Content = "Hub has been loaded successfully!",
    Duration = 5
})

-- Configurar a aba inicial
Window:SelectTab(1)

-- Loop de atualização contínua
task.spawn(function()
    while true do
        wait(1)

        -- Aqui você pode adicionar lógica de atualização, como mostrar quantos ovos foram abertos ou outras funções
        print("Eggs Opened: " .. _G.EggsOpened)

        if Fluent.Unloaded then break end
    end
end)
