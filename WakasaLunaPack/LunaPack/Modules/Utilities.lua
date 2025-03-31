local Utilities = {}

function Utilities:CleanWorkspace()
    local count = 0
    for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored and obj:GetMass() < 0.1 then
            obj:Destroy()
            count += 1
        end
    end
    print(string.format("[Utilities] %d objetos leves removidos", count))
end

function Utilities:Rejoin()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end

function Utilities:ServerHop()
    local Http = game:GetService("HttpService")
    local JobId = game.JobId
    
    local servers = Http:JSONDecode(game:HttpGet(
        "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"
    ))
    
    for _, server in pairs(servers.data) do
        if server.id ~= JobId and server.playing < server.maxPlayers then
            game:GetService("TeleportService"):TeleportToPlaceInstance(
                game.PlaceId,
                server.id
            )
            return
        end
    end
end

return Utilities