-- Carregar as bibliotecas necessárias
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Criar a janela principal
local Window = Fluent:CreateWindow({
    Title = "Luna Hub",  -- Título da janela
    SubTitle = "Seu script favorito",  -- Subtítulo
    TabWidth = 100,  -- Largura da aba
    Size = UDim2.fromOffset(430, 300),  -- Tamanho da interface
    Acrylic = false,  -- Efeito acrílico
    Theme = "Amethyst",  -- Tema da interface
    MinimizeKey = Enum.KeyCode.LeftControl  -- Tecla de minimizar
})

-- Criar as abas
local Tabs = {
    Main = Window:AddTab({ Title = "• Infor", Icon = "rbxassetid://18831448204" }),
    Settings = Window:AddTab({ Title = "• Settings", Icon = "rbxassetid://18319394996" })
}

-- Selecionar a primeira aba
Window:SelectTab(1)

-- Exemplo de Toggle para Auto Attack
local attack = Tabs.Main:AddToggle("Auto attack", {Title = "Auto attack", Default = false})

attack:OnChanged(function()
    while attack.Value do
        -- Esperar 1 segundo entre as ações
        wait(1)
        -- Remote para ataque
        game:GetService("ReplicatedStorage").Events.Attack:FireServer()
    end
end)

-- Funções para salvar configurações e interface
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()  -- Ignorar configurações de tema
SaveManager:SetIgnoreIndexes({})  -- Ignorar índices específicos
InterfaceManager:SetFolder("FluentScriptHub")  -- Pasta da interface
SaveManager:SetFolder("FluentScriptHub/specific-game")  -- Pasta de configuração do jogo específico

-- Adicionar seções para configurações na aba de Settings
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

