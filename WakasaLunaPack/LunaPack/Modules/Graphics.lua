local Graphics = {}

function Graphics:ApplyPreset(preset)
    local presets = {
        ["Low"] = {
            QualityLevel = 1,
            Shadows = false,
            Particles = 50,
            TextureQuality = 1
        },
        ["Balanced"] = {
            QualityLevel = 5,
            Shadows = true,
            Particles = 200,
            TextureQuality = 2
        },
        ["High"] = {
            QualityLevel = 10,
            Shadows = true,
            Particles = 500,
            TextureQuality = 3
        }
    }
    
    local settings = presets[preset] or presets["Balanced"]
    
    -- Aplica configurações
    settings().Rendering.QualityLevel = settings.QualityLevel
    game:GetService("Lighting").GlobalShadows = settings.Shadows
    game:GetService("Workspace").Particles.MaxCount = settings.Particles
    settings().Rendering.TextureQuality = settings.TextureQuality
    
    print(string.format("[Graphics] Preset aplicado: %s", preset))
end

function Graphics:UnlockFPS(enabled)
    if enabled then
        if setfpscap then
            setfpscap(360)
            print("[Graphics] FPS desbloqueado (360 max)")
        else
            warn("[Graphics] Função setfpscap não disponível")
        end
    end
end

return Graphics