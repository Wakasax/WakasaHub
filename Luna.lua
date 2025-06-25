-- Luna Hub by Wakasa
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Dex-UI-Library/main/main.lua"))() -- Substitua por uma biblioteca de UI válida
local Window = Library:CreateWindow("Luna Hub - By Wakasa")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Variáveis de controle
local noclipEnabled = false
local noclipConnection = nil
local autoKillEnabled = false

-- Função de Noclip
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        print("Noclip Ativado! - Luna Hub by Wakasa")
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        print("Noclip Desativado! - Luna Hub by Wakasa")
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end
