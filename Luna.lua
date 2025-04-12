local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Luna Hub",
    SubTitle = "By Kzinn",
    TabWidth = 120,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl,
    MinimizeIcon = "rbxassetid://90892367670466"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Farm", Icon = "rbxassetid://18831448204" }),
    Pets = Window:AddTab({ Title = "Pets", Icon = "rbxassetid://18319394996" }),
    TP = Window:AddTab({ Title = "TP", Icon = "rbxassetid://18319245617" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "rbxassetid://18319394996" }),
}

Window:SelectTab(1)

-- Game-specific logic
local placeId = game.PlaceId

-----------------------------
-- 📦 Boxing (4058282580)
-----------------------------
if placeId == 4058282580 then
    local AutoFarm = Tabs.Main:AddToggle("auto_farm", { Title = "Auto Farm", Default = false })
    local AutoSell = Tabs.Main:AddToggle("auto_sell", { Title = "Auto Sell", Default = false })
    local AutoGlove = Tabs.Main:AddToggle("auto_glove", { Title = "Auto Luva", Default = false })
    local AutoDNA = Tabs.Main:AddToggle("auto_dna", { Title = "Auto DNA", Default = false })

    AutoFarm:OnChanged(function(bool)
        while AutoFarm.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Attack:FireServer()
            end)
            task.wait(0.15)
        end
    end)

    AutoSell:OnChanged(function(bool)
        while AutoSell.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.SellRequest:FireServer()
            end)
            task.wait(1)
        end
    end)

    AutoGlove:OnChanged(function(bool)
        while AutoGlove.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAllGlove:FireServer()
            end)
            task.wait(1.5)
        end
    end)

    AutoDNA:OnChanged(function(bool)
        while AutoDNA.Value do
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAllDNA:FireServer()
            end)
            task.wait(1.5)
        end
    end)

-----------------------------
-- 🌟 Rebirth Champions Ultimate (74260430392611)
-----------------------------
elseif placeId == 74260430392611 then
    local Knit = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit")
    local Services = Knit:WaitForChild("Services")

    local function GetRemote(serviceIndex, remoteIndex)
        return Services:GetChildren()[serviceIndex]:WaitForChild("RE"):GetChildren()[remoteIndex]
    end

    local AutoClick = Tabs.Main:AddToggle("auto_click", { Title = "Auto Click", Default = false })

    AutoClick:OnChanged(function(bool)
        while AutoClick.Value do
            pcall(function()
                local args = { "Farm", 1 }
                GetRemote(23, 3):FireServer(unpack(args))
            end)
            task.wait(0.1)
        end
    end)

    local AutoEgg = Tabs.Pets:AddToggle("auto_egg", { Title = "Auto Egg", Default = false })

    AutoEgg:OnChanged(function(bool)
        while AutoEgg.Value do
            pcall(function()
                local args = {}
                GetRemote(22, 3):FireServer(unpack(args))
            end)
            task.wait(1)
        end
    end)
end

-----------------------------
-- ⚙️ Configurações
-----------------------------
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("LunaHub")
SaveManager:SetFolder("LunaHub/Configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
