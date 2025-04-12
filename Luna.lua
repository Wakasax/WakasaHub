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

if game.PlaceId == 14732650387 then

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({Name = "Luna Hub | Rebirth Champions", HidePremium = false, SaveConfig = true, ConfigFolder = "Luna", IntroEnable = false})

    -- valores
    _G.AutoClick = false
    _G.AutoClaim = false
    _G.AutoEgg = false
    _G.SelectedEgg = nil
    _G.AutoDupe = false
    _G.DupeBasic = false
    _G.DupeRare = false
    _G.DupeEpic = false
    _G.DupeLegendary = false
    _G.DupeSecret = false

    -- funções
    function AutoClick()
        while _G.AutoClick do
            pcall(function()
                game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer()
            end)
            wait(0.1)
        end
    end

    function AutoClaim()
        while _G.AutoClaim do
            pcall(function()
                for i = 1,10 do
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.RewardService.RF.Claim:InvokeServer(i)
                    wait(0.1)
                end
            end)
            wait(30)
        end
    end

    function AutoEgg()
        while _G.AutoEgg and _G.SelectedEgg do
            pcall(function()
                game:GetService("ReplicatedStorage").Packages.Knit.Services.EggService.RF.Hatch:InvokeServer(_G.SelectedEgg, 1)
            end)
            wait(1)
        end
    end

    function AutoDupe()
        while _G.AutoDupe do
            pcall(function()
                local pets = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").Pets:GetChildren()
                for _,v in pairs(pets) do
                    if v:IsA("Frame") then
                        local rarity = v:FindFirstChild("Rarity") and v.Rarity.Text
                        if rarity then
                            if (rarity == "Basic" and _G.DupeBasic) or
                               (rarity == "Rare" and _G.DupeRare) or
                               (rarity == "Epic" and _G.DupeEpic) or
                               (rarity == "Legendary" and _G.DupeLegendary) or
                               (rarity == "Secret" and _G.DupeSecret) then
                                game:GetService("ReplicatedStorage").Packages.Knit.Services.PetService.RF.Dupe:InvokeServer(v.Name)
                            end
                        end
                    end
                end
            end)
            wait(5)
        end
    end

    -- aba main
    local MainTab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MainTab:AddToggle({
        Name = "Auto Click",
        Default = false,
        Callback = function(Value)
            _G.AutoClick = Value
            if Value then
                AutoClick()
            end
        end
    })

    MainTab:AddToggle({
        Name = "Auto Claim Recompensas",
        Default = false,
        Callback = function(Value)
            _G.AutoClaim = Value
            if Value then
                AutoClaim()
            end
        end
    })

    -- aba eggs
    local EggsTab = Window:MakeTab({
        Name = "Eggs",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local eggList = {}
    for _,v in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
        if v:IsA("Model") then
            table.insert(eggList, v.Name)
        end
    end

    EggsTab:AddDropdown({
        Name = "Selecionar Ovo",
        Default = "",
        Options = eggList,
        Callback = function(Value)
            _G.SelectedEgg = Value
        end
    })

    EggsTab:AddToggle({
        Name = "Auto Abrir Ovo",
        Default = false,
        Callback = function(Value)
            _G.AutoEgg = Value
            if Value then
                AutoEgg()
            end
        end
    })

    -- aba dupe
    local DupeTab = Window:MakeTab({
        Name = "Dupe",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    DupeTab:AddToggle({
        Name = "Auto Dupe",
        Default = false,
        Callback = function(Value)
            _G.AutoDupe = Value
            if Value then
                AutoDupe()
            end
        end
    })

    DupeTab:AddToggle({Name = "Dupe Basic", Default = false, Callback = function(v) _G.DupeBasic = v end})
    DupeTab:AddToggle({Name = "Dupe Rare", Default = false, Callback = function(v) _G.DupeRare = v end})
    DupeTab:AddToggle({Name = "Dupe Epic", Default = false, Callback = function(v) _G.DupeEpic = v end})
    DupeTab:AddToggle({Name = "Dupe Legendary", Default = false, Callback = function(v) _G.DupeLegendary = v end})
    DupeTab:AddToggle({Name = "Dupe Secret", Default = false, Callback = function(v) _G.DupeSecret = v end})

end
