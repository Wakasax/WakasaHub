local Button = {}

function Button:New(name, properties)
    local btn = {
        Name = name,
        Type = "Button",
        Properties = properties or {}
    }
    
    function btn:Render(theme)
        -- Implementação real do botão usando o tema
        print(string.format("[UI] Renderizando botão '%s' com tema %s", self.Name, theme.Name))
    end
    
    return btn
end

return Button