-- Uso básico
AddLog("COMBAT", "Player took 10 damage", [[
    local function applyDamage(player, amount)
        player.Humanoid:TakeDamage(amount)
    end
]])

-- Controle programático
LunaPack.ToggleLogging(false) -- Desativa logs