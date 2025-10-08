function getPlayersName()
    for i, v in pairs(game:GetChildren()) do
        if v.ClassName == "Players" then
            return v.Name
        end
    end
end

local players = getPlayersName()

local localPlayer = game[players].LocalPlayer

coroutine.resume(coroutine.create(function()
    while wait(1) do
        coroutine.resume(coroutine.create(function()
            for _, v in pairs(game[players]:GetPlayers()) do
                if v.Name ~= localPlayer.Name and v.Character then
                    local parts = {
                        "RightUpperLeg",
                        "LeftUpperLeg",
                        "HeadHB",
                        "HumanoidRootPart"
                    }
                    for _, partName in ipairs(parts) do
                        local part = v.Character[partName]
                        if part then
                            part.Transparency = 10
                        end
                    end
                end
            end
        end))
    end
end))

coroutine.resume(coroutine.create(function()
    while wait(1) do
        coroutine.resume(coroutine.create(function()
            for _, v in pairs(game[players]:GetPlayers()) do
                if v.Name ~= localPlayer.Name and v.Character then
                    local parts = {
                        "RightUpperLeg",
                        "LeftUpperLeg",
                        "HeadHB",
                        "HumanoidRootPart"
                    }
                    for _, partName in ipairs(parts) do
                        local part = v.Character[partName]
                        if part then
                            part.CanCollide = false
                            part.Size = Vector3.new(13, 13, 13)
                        end
                    end
                end
            end
        end))
    end
end))
