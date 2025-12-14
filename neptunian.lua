--part 1
if game.Workspace:FindFirstChild("Dummy") then
	game.Workspace.Dummy:Destroy()
end



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")



local follow = {
	["Torso"] = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true,
}

hum.PlatformStand = true
hum.AutoRotate = false

for _, p in ipairs(char:GetChildren()) do
	if p:IsA("BasePart") then
		p.CanCollide = false
	end
end

local dummy = game:GetObjects("rbxassetid://5195737219")[1]
dummy.Parent = Workspace
dummy.HumanoidRootPart.CFrame = root.CFrame

for _, p in ipairs(dummy:GetDescendants()) do
	if p:IsA("BasePart") then
		p.Transparency = 0.95
		p.CanCollide = false
	end
end


local dh = dummy:WaitForChild("Humanoid")
local dr = dummy:WaitForChild("HumanoidRootPart")

dr.Anchored = false
dh.WalkSpeed = 16
dh.AutoRotate = true

local anim = char:FindFirstChild("Animate")
if anim then
	anim:Clone().Parent = dummy
end


-- rest
local conn
conn = RunService.Heartbeat:Connect(function()
	if not dummy or not dummy:IsDescendantOf(game) then
	    if conn then conn:Disconnect() end
	    conn = nil
	    return
	end


	local dh = dummy:FindFirstChild("Humanoid")
	if not dh then return end

	dh:Move(hum.MoveDirection, false)
	dh.Jump = hum.Jump

	for _, p in ipairs(char:GetChildren()) do
		if p:IsA("BasePart") and follow[p.Name] then
			local d = dummy:FindFirstChild(p.Name)
			if d then
				p.CFrame = d.CFrame
				p.AssemblyLinearVelocity = Vector3.zero
				p.AssemblyAngularVelocity = Vector3.zero
			end
		end
	end
end)


task.wait(1.5)

local player = game:GetService("Players").LocalPlayer
local model = workspace:FindFirstChild(player.Name)

if model then
	for _, v in ipairs(model:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end

task.wait(1)
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
