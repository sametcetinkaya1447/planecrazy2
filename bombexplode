local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local aircraft = workspace:FindFirstChild(player.Name .. " Aircraft")
local bombremote = game.ReplicatedStorage.Remotes.Explode

local SHIFT = false
local POWER = 2000
local RADIUS = 12

local function getbombs()
    local list = {}
    for _, obj in ipairs(aircraft:GetDescendants()) do
        local parent = obj.Parent
        if obj.Name == "Decorate" and (parent.Name == "ExplosiveBlock" or parent.Name == "ExplosiveBall") then
            table.insert(list, parent)
        end
    end
    return list
end

local function detonateAt(pos)
    local explosives = getbombs()
    if #explosives == 0 then return end

    local bomb = explosives[1]
    bombremote:FireServer(bomb, POWER, RADIUS, pos)
end

UserInputService.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
        SHIFT = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
        SHIFT = false
    end
end)

mouse.Button1Down:Connect(function()
    if SHIFT then
        local pos = mouse.Hit.Position
        detonateAt(pos)
    end
end)
