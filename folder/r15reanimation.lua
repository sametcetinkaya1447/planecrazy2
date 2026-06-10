--part1
if game.Workspace:FindFirstChild("Dummy") then
	game.Workspace.Dummy:Destroy()
end

local Players = game.Players
local RunService = game.RunService
local Workspace = game.Workspace
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

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
--mappings and offsets
local follow = {
	["UpperTorso"]    = { r6name = "Torso",       offset = CFrame.new(0,  0.2,  0) },
	["LowerTorso"]    = { r6name = "Torso",       offset = CFrame.new(0, -0.8,  0) },
	["Head"]          = { r6name = "Head",        offset = CFrame.new(0,  0,    0) },
	["LeftUpperArm"]  = { r6name = "Left Arm",    offset = CFrame.new(0,  0.4,  0) },
	["LeftLowerArm"]  = { r6name = "Left Arm",    offset = CFrame.new(0, -0.2,  0) },
	["LeftHand"]      = { r6name = "Left Arm",    offset = CFrame.new(0, -0.85, 0) },
	["RightUpperArm"] = { r6name = "Right Arm",   offset = CFrame.new(0,  0.4,  0) },
	["RightLowerArm"] = { r6name = "Right Arm",   offset = CFrame.new(0, -0.2,  0) },
	["RightHand"]     = { r6name = "Right Arm",   offset = CFrame.new(0, -0.85, 0) },
	["LeftUpperLeg"]  = { r6name = "Left Leg",    offset = CFrame.new(0,  0.4,  0) },
	["LeftLowerLeg"]  = { r6name = "Left Leg",    offset = CFrame.new(0, -0.2,  0) },
	["LeftFoot"]      = { r6name = "Left Leg",    offset = CFrame.new(0, -0.85, 0) },
	["RightUpperLeg"] = { r6name = "Right Leg",   offset = CFrame.new(0,  0.4,  0) },
	["RightLowerLeg"] = { r6name = "Right Leg",   offset = CFrame.new(0, -0.2,  0) },
	["RightFoot"]     = { r6name = "Right Leg",   offset = CFrame.new(0, -0.85, 0) },
}




local upperTorso = char:WaitForChild("UpperTorso")

local conn
conn = RunService.Heartbeat:Connect(function()
	if not dummy or not dummy:IsDescendantOf(game) then
		if conn then conn:Disconnect() end
		print("dummy removed, stopping loop")
		conn = nil
		return
	end
	upperTorso.CanCollide = false
	local dh = dummy:FindFirstChild("Humanoid")
	if not dh then return end
	dh:Move(hum.MoveDirection, false)
	dh.Jump = hum.Jump

	for r15name, data in pairs(follow) do
		local myPart = char:FindFirstChild(r15name)
		local dBone  = dummy:FindFirstChild(data.r6name)
		if myPart and dBone then
			myPart.CFrame = dBone.CFrame * data.offset
			myPart.AssemblyLinearVelocity  = Vector3.zero
			myPart.AssemblyAngularVelocity = Vector3.zero
		end
	end
end)

task.wait(1.5)
local model = workspace:FindFirstChild(player.Name)
if model then
	for _, v in ipairs(model:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end
