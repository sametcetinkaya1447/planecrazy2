loadstring(game:HttpGet('https://raw.githubusercontent.com/sametcetinkaya1447/planecrazy2/refs/heads/main/folder/r15reanimation.lua'))()
task.wait()
task.spawn(function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/sametcetinkaya1447/planecrazy2/refs/heads/main/folder/nep2.lua'))()
--part 3
end)

task.wait(1.5)

task.spawn(function()

task.wait(1)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
print("Player")



local function unweld(part)
	game.ReplicatedStorage.Remotes.UnanchorWelds:FireServer(part, "Break")
end

local aircraft = workspace[Player.Name .. " Aircraft"]
local swordpart = aircraft.Statue.StatueRig.MeshPartAccessory.Handle

unweld(swordpart)


local sword = swordpart



local function alignParts(source, target)
    local bodyGyro = Instance.new("BodyGyro", source)
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.D = 50
    
    local bodyPosition = Instance.new("BodyPosition", source)
    bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyPosition.P = 100000
    bodyPosition.D = 1000
    
    local customRotation = CFrame.Angles(math.rad(0), math.rad(0), math.rad(-40))
    
    RunService.Heartbeat:Connect(function()
        local targetCFrame = target.CFrame
        local offsetPosition = targetCFrame * Vector3.new(-3, 0, 0)
        
        bodyPosition.Position = offsetPosition
        bodyGyro.CFrame = targetCFrame * customRotation
    end)
end

local fakesword = workspace.Dummy.Model.Swordd

alignParts(sword, fakesword)


	
end)
