if game.PlaceId == 76764413804358 then

    -- Carregando libs
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    -- Criando a janela
    local Window = Fluent:CreateWindow({
        Title = "Luna Hub - Bubble Gum Simulator: INFINITY",
        SubTitle = "by Kzinn",
        TabWidth = 110,
        Size = UDim2.fromOffset(480, 320),
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl,
        MinimizeIcon = "rbxassetid://90892367670466",  -- Ícone de minimizar
    })

    -- Criando as tabs
    local Tabs = {
        Farm = Window:AddTab({ Title = "• Farm", Icon = "rbxassetid://4483345998" }),
        Pets = Window:AddTab({ Title = "• Pets", Icon = "rbxassetid://6031763426" }),
        Eggs = Window:AddTab({ Title = "• Eggs", Icon = "rbxassetid://6031763426" }),
        Settings = Window:AddTab({ Title = "• Settings", Icon = "rbxassetid://18319394996" })
    }

    Window:SelectTab(1)

    -- Variáveis
    _G.AutoBlow = false
    _G.AutoSell = false
    _G.AutoEquipBest = false
    _G.FlyEnabled = false
    _G.FlySpeed = 200
    _G.FlyDirection = Vector3.zero

    -- Remotes
    local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9)

    -- Funções para ação
    function _G.DoAutoBlow()
        while _G.AutoBlow do
            pcall(function()
                RemoteEvent:FireServer({ "BlowBubble" })
            end)
            task.wait()
        end
    end

    function _G.DoAutoSell()
        while _G.AutoSell do
            pcall(function()
                RemoteEvent:FireServer({ "SellBubble", "Sell" })
            end)
            task.wait()
        end
    end

    function _G.DoEquipBest()
        while _G.AutoEquipBest do
            pcall(function()
                RemoteEvent:FireServer({ "EquipBest" })
            end)
            task.wait(5)
        end
    end

    -- Fly Function
    function _G.EnableFly()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoidRoot = char:WaitForChild("HumanoidRootPart")

        -- Criando o BodyVelocity para o Fly
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Velocity = Vector3.zero
        bodyVel.MaxForce = Vector3.new(1, 1, 1) * 1e5
        bodyVel.Name = "Luna_Fly"
        bodyVel.Parent = humanoidRoot

        -- Função para movimentação com WASD
        local uis = game:GetService("UserInputService")

        local inputConn
        inputConn = uis.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.W then _G.FlyDirection = Vector3.new(0, 0, -1) end
            if input.KeyCode == Enum.KeyCode.S then _G.FlyDirection = Vector3.new(0, 0, 1) end
            if input.KeyCode == Enum.KeyCode.A then _G.FlyDirection = Vector3.new(-1, 0, 0) end
            if input.KeyCode == Enum.KeyCode.D then _G.FlyDirection = Vector3.new(1, 0, 0) end
        end)

        local stopConn
        stopConn = uis.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
                _G.FlyDirection = Vector3.zero
            end
        end)

        -- Atualizando a velocidade do voo
        while _G.FlyEnabled and bodyVel.Parent do
            bodyVel.Velocity = (humanoidRoot.CFrame:VectorToWorldSpace(_G.FlyDirection)) * _G.FlySpeed
            task.wait(0.1)
        end

        -- Desconectando os eventos de entrada
        inputConn:Disconnect()
        stopConn:Disconnect()
        bodyVel:Destroy()
    end

    -- Abas de funcionalidades
    Tabs.Farm:AddToggle("AutoBlow", { Title = "Soprar sem Delay", Default = false }):OnChanged(function(v)
        _G.AutoBlow = v
        if v then task.spawn(_G.DoAutoBlow) end
    end)

    Tabs.Farm:AddToggle("AutoSell", { Title = "Vender sem Teleporte", Default = false }):OnChanged(function(v)
        _G.AutoSell = v
        if v then task.spawn(_G.DoAutoSell) end
    end)

    Tabs.Farm:AddToggle("Fly", { Title = "Fly (WASD)", Default = false }):OnChanged(function(v)
        _G.FlyEnabled = v
        if v then task.spawn(_G.EnableFly) end
    end)

    Tabs.Farm:AddSlider("FlySpeed", {
        Title = "Velocidade do Fly",
        Min = 50,
        Max = 500,
        Default = 100,
        Rounding = 0,
        Callback = function(v)
            _G.FlySpeed = v
        end
    })

    Tabs.Pets:AddToggle("EquipBest", { Title = "Auto Equipar Melhores Pets", Default = false }):OnChanged(function(v)
        _G.AutoEquipBest = v
        if v then task.spawn(_G.DoEquipBest) end
    end)

    -- Aba de ovos
    local EggList = {}
    local Dropdown
    local SelectedEgg

    local function UpdateEggList()
        table.clear(EggList)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Egg") then
                table.insert(EggList, v.Name)
            end
        end
        if Dropdown then Dropdown:SetOptions(EggList) end
    end

    Dropdown = Tabs.Eggs:AddDropdown("EggsNearby", {
        Title = "Selecionar Ovo",
        Values = EggList,
        Multi = false,
        Default = nil
    })

    Dropdown:OnChanged(function(option)
        SelectedEgg = option
    end)

    Tabs.Eggs:AddButton({
        Title = "Atualizar lista de ovos",
        Callback = UpdateEggList
    })

    Tabs.Eggs:AddButton({
        Title = "Abrir Ovo Selecionado",
        Callback = function()
            if SelectedEgg then
                for _ = 1, 100 do
                    RemoteEvent:FireServer({ "OpenEgg", SelectedEgg })
                    task.wait()
                end
            end
        end
    })

    -- Settings
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("LunaHub")
    SaveManager:SetFolder("LunaHub/BubbleGumSimulatorINFINITY")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

end
