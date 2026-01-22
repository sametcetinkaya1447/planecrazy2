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

local torso = char.Torso
-- rest
local conn
conn = RunService.Heartbeat:Connect(function()
	if not dummy or not dummy:IsDescendantOf(game) then
	    if conn then conn:Disconnect()
		print("dummy removed stopping the loop")
		end
	    conn = nil
	    return
	end
	torso.CanCollide = false

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

loadstring(game:HttpGet('https://raw.githubusercontent.com/sametcetinkaya1447/planecrazy2/refs/heads/main/folder/wingsspawner.lua'))()
