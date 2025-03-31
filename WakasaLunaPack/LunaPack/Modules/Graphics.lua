local Graphics = {}

function Graphics:SetQuality(preset)
    local presets = {
        Ultra = {Particles = 1000, Shadows = true},
        High = {Particles = 500, Shadows = true},
        Medium = {Particles = 200, Shadows = false},
        Low = {Particles = 50, Shadows = false}
    }
    
    local settings = presets[preset] or presets.High
    game:GetService("Workspace").Particles.MaxCount = settings.Particles
    game:GetService("Lighting").GlobalShadows = settings.Shadows
end

return Graphics