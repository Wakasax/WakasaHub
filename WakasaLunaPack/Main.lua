if game.PlaceId == 7215881810 then
    -- Carrega a OrionLib
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

    -- Cria a janela principal
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "Wakasa",
        IntroEnabled = false
    })

    -- Variáveis globais
    _G.autobola = false  -- Controle do auto-farm
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    -- Função para coletar orbs instantaneamente
    local function coletarOrbs()
        local world = player.leaderstats.WORLD.value
        local OrbFolder = game.workspace.Map.Stages.Boosts:FindFirstChild(world)
        
        if OrbFolder then
            for _, orb in pairs(OrbFolder:GetChildren()) do
                if orb:FindFirstChild("PrimaryPart") then
                    -- Simula o toque para coletar
                    firetouchinterest(char.HumanoidRootPart, orb.PrimaryPart, 0)
                    firetouchinterest(char.HumanoidRootPart, orb.PrimaryPart, 1)
                end
            end
        end
    end

    -- Sistema de auto-farm
    local function autobola()
        while _G.autobola and task.wait(0.1) do  -- Delay ajustável
            pcall(function()  -- Prevende erros
                coletarOrbs()
            end)
        end
    end

    -- GUI
    local Maintab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    Maintab:AddSection({
        Name = "Auto-Farm"
    })

    Maintab:AddToggle({
        Name = "Coletar Orbs Automático",
        Default = false,
        Callback = function(Value)
            _G.autobola = Value
            if Value then
                OrionLib:MakeNotification({
                    Name = "Modo ativado!",
                    Content = "Coletando orbs automaticamente...",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                autobola()  -- Inicia o loop
            else
                OrionLib:MakeNotification({
                    Name = "Modo desativado",
                    Content = "Auto-farm pausado",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end    
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub carregado!",
        Content = "Bem-vindo ao autofarm de orbs",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

if game.PlaceId == 286090429 then
    -- Carrega a OrionLib
    local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

    -- Cria a janela principal
    local Window = OrionLib:MakeWindow({
        Name = "WakasaHub",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "Wakasa",
        IntroEnabled = false
    })

    -- Variáveis globais
    _G.autobola = false  -- Controle do auto-farm
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    -- Função para coletar orbs instantaneamente
    local function coletarOrbs()
        local world = player.leaderstats.WORLD.value
        local OrbFolder = game.workspace.Map.Stages.Boosts:FindFirstChild(world)
        
        if OrbFolder then
            for _, orb in pairs(OrbFolder:GetChildren()) do
                if orb:FindFirstChild("PrimaryPart") then
                    -- Simula o toque para coletar
                    firetouchinterest(char.HumanoidRootPart, orb.PrimaryPart, 0)
                    firetouchinterest(char.HumanoidRootPart, orb.PrimaryPart, 1)
                end
            end
        end
    end

    -- Sistema de auto-farm
    local function autobola()
        while _G.autobola and task.wait(0.1) do  -- Delay ajustável
            pcall(function()  -- Prevende erros
                coletarOrbs()
            end)
        end
    end

    -- GUI
    local Maintab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    Maintab:AddSection({
        Name = "Auto-Farm"
    })

    Maintab:AddToggle({
        Name = "Coletar Orbs Automático",
        Default = false,
        Callback = function(Value)
            _G.autobola = Value
            if Value then
                OrionLib:MakeNotification({
                    Name = "Modo ativado!",
                    Content = "Coletando orbs automaticamente...",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
                autobola()  -- Inicia o loop
            else
                OrionLib:MakeNotification({
                    Name = "Modo desativado",
                    Content = "Auto-farm pausado",
                    Image = "rbxassetid://4483345998",
                    Time = 3
                })
            end
        end    
    })

    -- Notificação inicial
    OrionLib:MakeNotification({
        Name = "WakasaHub carregado!",
        Content = "Bem-vindo ao autofarm de orbs",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

