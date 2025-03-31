local Performance = {}

function Performance:Optimize()
    settings().Rendering.QualityLevel = 1
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("ContentProvider"):ClearCache()
end

function Performance:SetFPSUnlock(fps)
    if setfpscap then
        setfpscap(fps)
    end
end

return Performance