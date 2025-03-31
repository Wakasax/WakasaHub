-- Wakasa Luna Pack Premium
-- Versão 5.0 - Completa
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Configurações
local LunaPack = {
    Version = "5.0",
    Config = {
        Theme = "Dark",
        UnlockFPS = true,
        TargetFPS = 144
    }
}

-- Carrega módulos
local Performance = loadstring(game:HttpGet("https://raw.githubusercontent.com/seuuser/WakasaHub/main/Modules/Performance.lua"))()
local Graphics = loadstring(game:HttpGet("https://raw.githubusercontent.com/seuuser/WakasaHub/main/Modules/Graphics.lua"))()

-- Janela Principal
local Window = Rayfield:CreateWindow({
    Name = "Wakasa Luna Pack",
    LoadingTitle = "Carregando Experiência Premium",
    LoadingSubtitle = "by Wakasa",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "WakasaLunaPack",
        FileName = "Config"
    },
    Theme = {
        BackgroundColor = Color3.fromRGB(15, 15, 15),
        HeaderColor = Color3.fromRGB(80, 0, 130),
        TextColor = Color3.fromRGB(255, 255, 255)
    }
})

-- Aba de Performance
local PerfTab = Window:CreateTab("Performance", 13060319677)
PerfTab:CreateToggle({
    Name = "Desbloquear FPS",
    CurrentValue = true,
    Callback = function(Value)
        Performance:SetFPSUnlock(Value and 144 or 60)
    end
})

-- Aba de Gráficos
local GraphicsTab = Window:CreateTab("Graphics", 7072718270)
GraphicsTab:CreateDropdown({
    Name = "Qualidade Gráfica",
    Options = {"Ultra", "High", "Medium", "Low"},
    CurrentOption = "High",
    Callback = function(Option)
        Graphics:SetQuality(Option)
    end
})

-- Inicialização
Performance:Optimize()
Graphics:SetQuality("High")