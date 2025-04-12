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

    local Window = OrionLib:MakeWindow({Name = "Luna Hub | Champions", HidePremium = false, SaveConfig = true, ConfigFolder = "LunaChampions", IntroEnable = false})

    -- Valores
    _G.AutoClick = false
    _G.AutoClaim = false
    _G.AutoEgg = false
    _G.AutoDupe = false
    _G.SelectedEgg = nil
    _G.DupeRarities = {
        ["Basic"] = false,
        ["Rare"] = false,
        ["Epic"] = false,
        ["Legendary"] = false,
        ["Secret"] = false
    }

    -- Funções
    function StartAutoClick()
        spawn(function()
            while _G.AutoClick do
                pcall(function()
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer()
                end)
                task.wait(0.1)
            end
        end)
    end

    function StartAutoClaim()
        spawn(function()
            while _G.AutoClaim do
                pcall(function()
                    for i = 1,10 do
                        game:GetService("ReplicatedStorage").Packages.Knit.Services.RewardService.RF.Claim:InvokeServer(i)
                        wait(0.1)
                    end
                end)
                wait(30)
            end
        end)
    end

    function StartAutoEgg()
        spawn(function()
            while _G.AutoEgg and _G.SelectedEgg do
                pcall(function()
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.EggService.RF.Hatch:InvokeServer(_G.SelectedEgg, 1)
                end)
                wait(1)
            end
        end)
    end

    function StartAutoDupe()
        spawn(function()
            while _G.AutoDupe do
                pcall(function()
                    local pets = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").Pets:GetChildren()
                    for _,v in pairs(pets) do
                        if v:IsA("Frame") and _G.DupeRarities[v:FindFirstChild("Rarity").Text] then
                            game:GetService("ReplicatedStorage").Packages.Knit.Services.PetService.RF.Dupe:InvokeServer(v.Name)
                        end
                    end
                end)
                wait(5)
            end
        end)
    end

    function RefreshEggList(dropdown)
        local eggs = {}
        for _,v in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
            if v:IsA("Model") then
                table.insert(eggs, v.Name)
            end
        end
        dropdown:Refresh(eggs, true)
    end

    -- Aba Main
    local MainTab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MainTab:AddToggle({
        Name = "Auto Click",
        Default = false,
        Callback = function(v)
            _G.AutoClick = v
            if v then StartAutoClick() end
        end
    })

    MainTab:AddToggle({
        Name = "Auto Claim Rewards",
        Default = false,
        Callback = function(v)
            _G.AutoClaim = v
            if v then StartAutoClaim() end
        end
    })

    -- Aba Eggs
    local EggsTab = Window:MakeTab({
        Name = "Eggs",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local eggDropdown = EggsTab:AddDropdown({
        Name = "Select Egg",
        Default = "",
        Options = {},
        Callback = function(v)
            _G.SelectedEgg = v
        end
    })

    EggsTab:AddButton({
        Name = "Refresh Egg List",
        Callback = function()
            RefreshEggList(eggDropdown)
        end
    })

    EggsTab:AddToggle({
        Name = "Auto Open Egg",
        Default = false,
        Callback = function(v)
            _G.AutoEgg = v
            if v then StartAutoEgg() end
        end
    })

    -- Aba Dupe
    local DupeTab = Window:MakeTab({
        Name = "Dupe Pets",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    DupeTab:AddToggle({
        Name = "Auto Dupe Pets",
        Default = false,
        Callback = function(v)
            _G.AutoDupe = v
            if v then StartAutoDupe() end
        end
    })

    for rarity,_ in pairs(_G.DupeRarities) do
        DupeTab:AddToggle({
            Name = "Dupe " .. rarity,
            Default = false,
            Callback = function(v)
                _G.DupeRarities[rarity] = v
            end
        })
    end

end
