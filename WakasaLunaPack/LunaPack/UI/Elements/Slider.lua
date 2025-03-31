local Slider = {}

function Slider:New(name, min, max, default)
    local sld = {
        Name = name,
        Type = "Slider",
        Min = min,
        Max = max,
        Value = default
    }
    
    function sld:Render(theme)
        print(string.format(
            "[UI] Renderizando slider '%s' (%d-%d) com tema %s", 
            self.Name, self.Min, self.Max, theme.Name
        ))
    end
    
    return sld
end

return Slider