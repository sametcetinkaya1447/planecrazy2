--part 1
if game.Workspace:FindFirstChild("Dummy") then
	game.Workspace.Dummy:Destroy()
end
local STOP_EXECUTION = false


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")


local StarterGui = game:GetService("StarterGui")

local function notify(msg)
    StarterGui:SetCore("SendNotification", {
        Title = "Error",
        Text = msg,
        Duration = 8,
        Button1 = "OK"
    })
end

local player = game:GetService("Players").LocalPlayer
local characterName = player.Character.Name
local myaircraft = workspace:FindFirstChild(characterName .. " Aircraft") 
local aircraftModel = workspace:FindFirstChild(player.Name .. " Aircraft")

local fingerparts1 = {}
local fingerparts2 = {}
local haloparts = {}
local centerparts = {}

for i, v in pairs(myaircraft:GetDescendants()) do
    if v.Name == "Post" and v.Parent.Name == "Post" and v.Color == Color3.fromRGB(0,0,0) then
        table.insert(fingerparts1, v)
    elseif v.Name == "Post" and v.Parent.Name == "Post" and v.Color == Color3.fromRGB(248,248,248) then
        table.insert(fingerparts2, v)
    elseif v.Name == "Post" and v.Parent.Name == "Post" and v.Color == Color3.fromRGB(0,0,1) then
        table.insert(haloparts, v)
    elseif v.Name == "BlockStd" and v.Parent.Name == "TinyBall" then
        table.insert(centerparts, v)
    end
end

print(#fingerparts2, #fingerparts1, #haloparts, #centerparts)




-- expected amount of parts
--10 post blocks and paint them to 248,248,248
--20 post blocks and paint them to 0,0,0
--40 post blocks and paint them to 0,0,1
--3 tiny ball and paint them to 248,248,248




if #fingerparts2 < 10 then
    notify("Not enough WHITE post blocks.\nPlace 10 post blocks and paint them (248,248,248).")
    return
end

if #fingerparts1 < 20 then
    notify("Not enough BLACK post blocks.\nPlace 20 post blocks and paint them (0,0,0).")
    return
end

if #haloparts < 40 then
    notify("Not enough post blocks.\nPlace 40 post blocks and paint them (0,0,1).")
    return
end

if #centerparts < 3 then
    notify("Not enough center balls.\nPlace 3 tiny balls and paint them (248,248,248).")
    return
end

print("started")

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


task.wait(4.5)

local player = game:GetService("Players").LocalPlayer
local model = workspace:FindFirstChild(player.Name)

if model then
	for _, v in ipairs(model:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end

--part2
task.wait(1)
task.spawn(function()

loadstring(game:HttpGet('https://raw.githubusercontent.com/sametcetinkaya1447/planecrazy2/refs/heads/main/folder/ravenger.lua'))()
--part 3
end)

task.wait(1)
task.spawn(function()



print("total fingerparts1", #fingerparts1)
print("total fingerparts2", #fingerparts2)
print("total haloparts", #haloparts)



-- expected amount of parts
--10 post blocks and paint them to 248,248,248
--20 post blocks and paint them to 0,0,0
--40 post blocks and paint them to 0,0,1
--3 tiny ball and paint them to 248,248,248


-- Remote Function
local function weld(part1, part2, cframe)
    local args = {
        [1] = "MotorWeld",
        [2] = aircraftModel.MotorBlock, 
        [3] = true,
        [4] = part1,
        [5] = part2,
        [6] = cframe,
        [7] = true 
    }
    game.ReplicatedStorage.BlockRemotes.MotorLock:FireServer(unpack(args))
end

local function modifypart(part)
if not part  then return end
part.CanCollide = false
local bf = part:FindFirstChild("ZeroGravityForce")
if not bf then
    bf = Instance.new("BodyForce")
    bf.Name = "ZeroGravityForce"
    bf.Parent = part
end


bf.Force = Vector3.new(0, part:GetMass() * workspace.Gravity, 0)

-- clear velocity
part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
end

local Player = game.Players.LocalPlayer
for _, part in pairs(game.Workspace[Player.Name .. " Aircraft"]:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("Part") or part:IsA("WedgePart") then
        part.CanCollide = false
        part.Anchored = false
        modifypart(part)
    end
end


for i = 1,10 do 
    weld(fingerparts1[i],fingerparts1[i+10], CFrame.new(0,1.7,0.7) * CFrame.Angles(math.rad(45),0,0))
    weld(fingerparts1[i+10],fingerparts2[i], CFrame.new(0,1.5,0) * CFrame.Angles(math.rad(0),math.rad(45),0))
end




assert(#centerparts >= 3, "Need 3 center balls")
assert(#haloparts >= 40, "Need 40 halo Post parts")

local centerBig   = centerparts[1]
local centerSmall1 = centerparts[2]
local centerSmall2 = centerparts[3]

local bigRing = {}
local smallRing1 = {}
local smallRing2 = {}

for i = 1, 40 do
    if i <= 20 then
        bigRing[#bigRing + 1] = haloparts[i]
    elseif i <= 30 then
        smallRing1[#smallRing1 + 1] = haloparts[i]
    else
        smallRing2[#smallRing2 + 1] = haloparts[i]
    end
end

-- ring builder
local function buildRing(centerPart, parts, radius)
    local count = #parts

    for i = 1, count do
        local part = parts[i]
        local angle = (i - 1) / count * math.pi * 2

        local worldCF =
            centerPart.CFrame
            * CFrame.new(
                math.cos(angle) * radius,
                0,
                math.sin(angle) * radius
            )
            * CFrame.Angles(0, -angle, 0)
            * CFrame.Angles(0, math.rad(90), math.rad(90))

        local relativeCF = centerPart.CFrame:ToObjectSpace(worldCF)
        weld(centerPart, part, relativeCF)
    end
end

-- build circles
buildRing(centerBig,    bigRing,    2.2) -- big ring (20)
buildRing(centerSmall1, smallRing1, 1.5) -- small ring
buildRing(centerSmall2, smallRing2, 1.5) -- smallest ring



local function updateBodyMover(part, target, offsetCFrame)
    if not part then return end

    local targetCFrame = target
    if typeof(target) == "Instance" and target:IsA("BasePart") then
        targetCFrame = target.CFrame
    elseif typeof(target) ~= "CFrame" then
        warn("Invalid target passed to updateBodyMover")
        return
    end

    local bp = part:FindFirstChild("BodyPosition")
    if not bp then
        bp = Instance.new("BodyPosition")
        bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bp.P = 50000
        bp.D = 800
        bp.Parent = part
    end

    local bg = part:FindFirstChild("BodyGyro")
    if not bg then
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.P = 30000
        bg.D = 500
        bg.Parent = part
    end

    local finalCFrame = targetCFrame
    if offsetCFrame then
        finalCFrame = targetCFrame * offsetCFrame
    end

    bp.Position = finalCFrame.Position
    bg.CFrame = finalCFrame
end





local offset = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(90))
local circleoffsets = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(90))

local heartbeatConnection 
local RunService = game:GetService("RunService")





local playerName = game.Players.LocalPlayer.Name

local lclaw1 = workspace[playerName].Model:GetChildren()[61]
local lclaw2 = workspace[playerName].Model:GetChildren()[59]
local claw3  = workspace[playerName].Model:GetChildren()[37]
local lclaw4 = workspace[playerName].Model:GetChildren()[39]
local lclaw5 = workspace[playerName].Model:GetChildren()[63]

local rclaw1 = workspace[playerName].Model:GetChildren()[15]
local rclaw2 = workspace[playerName].Model.Part
local rclaw3 = workspace[playerName].Model:GetChildren()[17]
local rclaw4 = workspace[playerName].Model:GetChildren()[9]
local rclaw5 = workspace[playerName].Model:GetChildren()[11]
local circle1 = workspace[playerName].Model:GetChildren()[73]
local circle2 = workspace[playerName].Model:GetChildren()[35]
local circle3 = workspace[playerName].Model.Handle
heartbeatConnection = RunService.Stepped:Connect(function(_, dt)

updateBodyMover(fingerparts1[1], lclaw1, offset)
updateBodyMover(fingerparts1[2], lclaw2, offset)
updateBodyMover(fingerparts1[3], claw3, offset)
updateBodyMover(fingerparts1[4], lclaw4, offset)
updateBodyMover(fingerparts1[5], lclaw5, offset)

updateBodyMover(fingerparts1[6], rclaw1, offset)
updateBodyMover(fingerparts1[7], rclaw2, offset)
updateBodyMover(fingerparts1[8], rclaw3, offset)
updateBodyMover(fingerparts1[9], rclaw4, offset)
updateBodyMover(fingerparts1[10], rclaw5, offset)

updateBodyMover(centerparts[1], circle1, offset)
updateBodyMover(centerparts[2], circle2, circleoffsets)
updateBodyMover(centerparts[3], circle3, circleoffsets)

--updateBodyMover(swordpart1, fakesword1, offset)


end)
end)
