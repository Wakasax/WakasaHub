if game.PlaceId == 76764413804358 then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "Luna Hub | Bubble Gum Simulator: INFINITY",
        SubTitle = "by Kzinn",
        TabWidth = 120,
        Size = UDim2.fromOffset(500, 350),
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })

    local Tabs = {
        Farm = Window:AddTab({ Title = "Farm", Icon = "rbxassetid://18354794798" }),
        Pets = Window:AddTab({ Title = "Pets", Icon = "rbxassetid://18354795539" }),
        Eggs = Window:AddTab({ Title = "Eggs", Icon = "rbxassetid://18354796142" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "rbxassetid://18319394996" })
    }

    Window:SelectTab(1)

    -- Farm
    local blowing = Tabs.Farm:AddToggle("Blow", { Title = "Auto Blow", Default = false })
    blowing:OnChanged(function()
        while blowing.Value do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer({ "BlowBubble" })
            task.wait()
        end
    end)

    local selling = Tabs.Farm:AddToggle("Sell", { Title = "Auto Sell", Default = false })
    selling:OnChanged(function()
        while selling.Value do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer({ "SellBubble", "Sell" })
            task.wait(1)
        end
    end)

    local flying = Tabs.Farm:AddToggle("Fly", { Title = "Enable Fly", Default = false })
    local flySpeed = Tabs.Farm:AddSlider("FlySpeed", {
        Title = "Fly Speed",
        Description = "Controla a velocidade do fly",
        Default = 100,
        Min = 50,
        Max = 300
    })

    local UIS = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local flyingNow = false
    local flyConn

    flying:OnChanged(function(state)
        if state then
            flyingNow = true
            flyConn = game:GetService("RunService").RenderStepped:Connect(function()
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    root.Velocity = Vector3.new(0, flySpeed.Value, 0)
                end
            end)
        else
            flyingNow = false
            if flyConn then flyConn:Disconnect() end
        end
    end)

    -- Pets
    Tabs.Pets:AddButton({
        Title = "Equipar Melhores Pets",
        Description = "Usa o melhor conjunto de pets disponível",
        Callback = function()
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer({ "EquipBest" })
        end
    })

    -- Eggs
    local currentEggs = {}

    local function findNearbyEggs()
        currentEggs = {}
        for _, egg in ipairs(workspace:GetDescendants()) do
            if egg:IsA("Model") and egg:FindFirstChild("Egg") then
                table.insert(currentEggs, egg.Name)
            end
        end
    end

    findNearbyEggs()

    local eggDropdown = Tabs.Eggs:AddDropdown("EggList", {
        Title = "Selecionar Ovo",
        Values = currentEggs,
        Multi = false
    })

    Tabs.Eggs:AddButton({
        Title = "🔄 Atualizar Lista de Ovos",
        Description = "Busca novamente os ovos próximos",
        Callback = function()
            findNearbyEggs()
            eggDropdown:SetValues(currentEggs)
        end
    })

    Tabs.Eggs:AddButton({
        Title = "🐣 Abrir Ovo Selecionado (Instantâneo)",
        Callback = function()
            local selected = eggDropdown.Value
            if selected then
                for _ = 1, 100 do
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent", 9e9):FireServer({ "OpenEgg", selected })
                    task.wait()
                end
            end
        end
    })

    -- SaveManager
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("LunaHub")
    SaveManager:SetFolder("LunaHub/BubbleGumInfinity")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
end
