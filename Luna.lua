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


if game.PlaceId == 74260430392611 then
    -- Rebirth Champions: Ultimate

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({Name = "Luna Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Luna", IntroEnable = false})

    -- Função para abrir ovos
    local function OpenEgg(eggId)
        game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)].RF[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)]:InvokeServer(eggId)
    end

    -- Função para duplicar pets de acordo com raridade
    local function DuplicatePetByRarity(rarity)
        -- Aqui vamos buscar pets com base na raridade e duplicá-los
        game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)].RF[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)]:InvokeServer(rarity)
    end

    -- Função para resgatar todas as recompensas de tempo
    local function ClaimAllTimeRewards()
        -- Lógica para resgatar recompensas de tempo
        game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)].RF[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)]:InvokeServer("ClaimTimeRewards")
    end

    -- Aba Auto-Click, Duplicar Pets e Resgatar Recompensas
    local AutoTab = Window:MakeTab({
        Name = "Auto",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Auto Clicker
    AutoTab:AddToggle({
        Name = "Auto Click",
        Default = false,
        Callback = function(state)
            if state then
                -- Ativa o Auto Click
                while true do
                    wait(0.1)  -- Intervalo entre os cliques
                    game:GetService("ReplicatedStorage").Packages.Knit.Services[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)].RF[utf8.char(106, 97, 103, 32, 107, 228, 110, 110, 101, 114, 32, 101, 110, 32, 98, 111, 116, 44, 32, 104, 111, 110, 32, 104, 101, 116, 101, 114, 32, 97, 110, 110, 97, 44, 32, 97, 110, 110, 97, 32, 104, 101, 116, 101, 114, 32, 104, 111, 110)]:InvokeServer()
                end
            end
        end
    })

    -- Auto Pet Duplicator
    AutoTab:AddToggle({
        Name = "Auto Duplicate Pet",
        Default = false,
        Callback = function(state)
            if state then
                -- Ativa o duplicador de pets baseado na raridade
                local selectedRarity = "Raro"  -- Exemplo de raridade, você pode fazer isso de forma dinâmica
                while true do
                    wait(5)  -- Intervalo entre duplicações de pets
                    DuplicatePetByRarity(selectedRarity)
                end
            end
        end
    })

    -- Resgatar Recompensas de Tempo
    AutoTab:AddToggle({
        Name = "Auto Claim Time Rewards",
        Default = false,
        Callback = function(state)
            if state then
                -- Ativa o resgate automático de recompensas de tempo
                while true do
                    wait(10)  -- Intervalo entre os resgates
                    ClaimAllTimeRewards()
                end
            end
        end
    })

    -- Aba Eggs
    local EggsTab = Window:MakeTab({
        Name = "Eggs",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    -- Lista de Eggs
    EggsTab:AddSection({
        Name = "Egg Farm"
    })

    -- Exemplo de lista de raridades de pets
    EggsTab:AddDropdown({
        Name = "Escolha a Raridade",
        Default = "Comum",
        Options = {"Comum", "Raro", "Épico", "Lendário"},
        Callback = function(selectedRarity)
            -- Atualiza a raridade selecionada para o duplicador
            selectedRarity = selectedRarity
        end
    })

    -- Botão de Refresh
    EggsTab:AddButton({
        Name = "Refresh Eggs",
        Callback = function()
            -- Código para fazer a função de "Refresh" nos ovos
            OpenEgg("id_egg_example")  -- Você pode passar o id correto do ovo aqui
        end
    })
end
