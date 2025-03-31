local Performance = {}

function Performance:Optimize()
    -- Otimizações básicas
    settings().Rendering.QualityLevel = 1
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FantasySky.Enabled = false
    
    -- FPS Unlock
    if getconnections then
        for _, v in next, getconnections(game:GetService("RunService").Heartbeat) do
            v:Disable()
        end
    end
    
    print("[Performance] Otimizações aplicadas!")
end

return Performance