local Utilities = {}

function Utilities:CleanWorkspace()
    for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored and obj:GetMass() < 0.5 then
            obj:Destroy()
        end
    end
end

return Utilities