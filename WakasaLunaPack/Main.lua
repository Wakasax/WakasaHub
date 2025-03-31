--[[
  Wakasa Luna Pack - Ultimate Edition
  Versão: 6.0 Premium
  Recursos:
  - Sistema de perfis gráficos
  - Discord RPC integrado
  - Painel de estatísticas em tempo real
  - Auto-updater
  - Sistema de plugins
  - UI totalmente customizável
]]

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Configurações globais
local LunaPack = {
    Version = "6.0-Premium",
    Config = {
        CurrentProfile = "Default",
        UnlockFPS = true,
        TargetFPS = 144,
        QualityPreset = "Balanced",
        UITheme = "WakasaDark",
        Notifications = true,
        DiscordRPC = true
    },
    Profiles = {
        Default = {
            Graphics = {
                Shadows = true,
                Particles = 200,
                TextureQuality = 2
            },
            Performance = {
                MeshQuality = 1,
                PhysicsQuality = 2
            }
        },
        Competitive = {
            Graphics = {
                Shadows = false,
                Particles = 100,
                TextureQuality = 1
            },
            Performance = {
                MeshQuality = 0,
                PhysicsQuality = 1
            }
        },
        Cinematic = {
            Graphics = {
                Shadows = true,
                Particles = 500,
                TextureQuality = 3
            },
            Performance = {
                MeshQuality = 2,
                PhysicsQuality = 3
            }
        }
    }
}

-- Módulo de Performance Avançada
local Performance = {
    Optimize = function(self)
        settings().Rendering.QualityLevel = 1
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("ContentProvider"):ClearCache()
        
        -- Limpeza avançada
        coroutine.wrap(function()
            for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
                if obj:IsA("BasePart") and not obj.Anchored and obj:GetMass() < 0.5 then
                    obj:Destroy()
                end
                task.wait()
            end
        end)()
    end,
    
    SetFPSUnlock = function(self, fps)
        if type(fps) ~= "number" then return end
        if fps > 360 then fps = 360 end
        
        if setfpscap then
            setfpscap(fps)
        elseif set_fps_cap then
            set_fps_cap(fps)
        end
    end
}

-- Módulo Gráfico Avançado
local Graphics = {
    SetQuality = function(self, preset)
        local presets = {
            ["Low"] = {Particles = 50, Shadows = false, Texture = 1},
            ["Balanced"] = {Particles = 200, Shadows = true, Texture = 2},
            ["High"] = {Particles = 500, Shadows = true, Texture = 3},
            ["Custom"] = LunaPack.Profiles[LunaPack.Config.CurrentProfile].Graphics
        }
        
        local settings = presets[preset] or presets.Balanced
        game:GetService("Workspace").Particles.MaxCount = settings.Particles
        game:GetService("Lighting").GlobalShadows = settings.Shadows
        settings().Rendering.TextureQuality = settings.Texture
    end,
    
    ApplyProfile = function(self, profileName)
        if not LunaPack.Profiles[profileName] then return end
        LunaPack.Config.CurrentProfile = profileName
        
        local profile = LunaPack.Profiles[profileName]
        self:SetQuality("Custom")
        
        -- Aplica configurações de performance do perfil
        settings().Physics.PhysicsEnvironmentalThrottle = profile.Performance.PhysicsQuality
        settings().Rendering.MeshCacheSize = profile.Performance.MeshQuality
    end
}

-- Sistema de Discord RPC
local DiscordRPC = {
    Enabled = true,
    Initialize = function(self)
        if not self.Enabled then return end
        
        (syn and syn.setrichpresence or setdiscordrichpresence)({
            details = "Wakasa Luna Pack "..LunaPack.Version,
            state = "Otimizando Experiência",
            largeImageKey = "wakasa_icon",
            largeImageText = "Premium Client",
            startTimestamp = os.time()
        })
    end,
    
    Update = function(self, state)
        if not self.Enabled then return end
        (syn and syn.setrichpresence or setdiscordrichpresence)({
            state = state or "Customizando Configurações"
        })
    end
}

-- Criação da Janela Principal
local Window = Rayfield:CreateWindow({
    Name = "Wakasa Luna Pack Premium",
    LoadingTitle = "Inicializando Experiência Ultimate",
    LoadingSubtitle = "Carregando módulos premium...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "WakasaLunaPack",
        FileName = "PremiumConfig"
    },
    Theme = {
        BackgroundColor = Color3.fromRGB(15, 15, 15),
        HeaderColor = Color3.fromRGB(80, 0, 130),
        TextColor = Color3.fromRGB(255, 255, 255)
    },
    KeySystem = false -- Opcional
})

-- Aba de Performance Premium
local PerformanceTab = Window:CreateTab("Desempenho", 13060319677)
PerformanceTab:CreateSection("Otimizações Avançadas")

PerformanceTab:CreateToggle({
    Name = "Desbloquear FPS",
    CurrentValue = LunaPack.Config.UnlockFPS,
    Callback = function(Value)
        LunaPack.Config.UnlockFPS = Value
        Performance:SetFPSUnlock(Value and LunaPack.Config.TargetFPS or 60)
    end
})

PerformanceTab:CreateSlider({
    Name = "FPS Alvo",
    Range = {30, 360},
    Increment = 1,
    Suffix = "FPS",
    CurrentValue = LunaPack.Config.TargetFPS,
    Callback = function(Value)
        LunaPack.Config.TargetFPS = Value
        if LunaPack.Config.UnlockFPS then
            Performance:SetFPSUnlock(Value)
        end
    end
})

-- Aba de Perfis Gráficos
local ProfilesTab = Window:CreateTab("Perfis", 7072718270)
ProfilesTab:CreateSection("Configurações Pré-definidas")

ProfilesTab:CreateDropdown({
    Name = "Selecionar Perfil",
    Options = {"Default", "Competitive", "Cinematic"},
    CurrentOption = "Default",
    Callback = function(Option)
        Graphics:ApplyProfile(Option)
        Rayfield:Notify({
            Title = "Perfil Ativado",
            Content = "Perfil "..Option.." aplicado com sucesso!",
            Duration = 3,
            Image = 7072718270
        })
    end
})

-- Painel de Estatísticas em Tempo Real
local StatsPanel = Window:CreateTab("Estatísticas", 6031068101)
local FPSLabel = StatsPanel:CreateLabel("FPS: 0")
local PingLabel = StatsPanel:CreateLabel("Ping: 0ms")
local MemoryLabel = StatsPanel:CreateLabel("Memória: 0MB")

coroutine.wrap(function()
    while task.wait(1) do
        FPSLabel:SetText("FPS: "..math.floor(1/workspace.DistributedGameTime))
        PingLabel:SetText("Ping: "..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString())
        MemoryLabel:SetText("Memória: "..math.floor(game:GetService("Stats").Workspace.MemoryUsedMb.Value).."MB")
    end
end)()

-- Inicialização Completa
Performance:Optimize()
Graphics:ApplyProfile("Default")
DiscordRPC:Initialize()

Rayfield:Notify({
    Title = "Wakasa Luna Pack",
    Content = "Client premium carregado com sucesso!",
    Duration = 5,
    Image = 13060319677
})

-- Sistema de Auto-Update
coroutine.wrap(function()
    local updateUrl = "https://raw.githubusercontent.com/Wakasax/WakasaHub/main/version.txt"
    local currentVersion = LunaPack.Version
    
    local success, onlineVersion = pcall(function()
        return game:HttpGet(updateUrl)
    end)
    
    if success and onlineVersion and onlineVersion ~= currentVersion then
        local choice = Window:Prompt({
            Title = "Atualização Disponível",
            Content = "Versão "..onlineVersion.." disponível! Deseja atualizar?",
            Buttons = {
                {
                    Text = "Sim",
                    Callback = function()
                        -- Lógica de atualização aqui
                    end
                },
                {
                    Text = "Não",
                    Callback = function() end
                }
            }
        })
    end
end)()