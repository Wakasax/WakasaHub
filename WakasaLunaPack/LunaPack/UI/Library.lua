local UILibrary = {}

function UILibrary:CreateButton(name, parent, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Text = name
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)
    return button
end

return UILibrary