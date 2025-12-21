-- credits to nuggetsrcz for the jeep model it wouldnt be possible without him
--part1 spawns the dummy car
if game.Workspace:FindFirstChild("UncrushableJeep") then
	game.Workspace.UncrushableJeep:Destroy()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer


-- ==========================================
-- TUNING
-- ==========================================

local SPEED = 130
local TORQUE = 30000 
local TURN_ANGLE = 35 
local STEER_SPEED = 4

local CHASSIS_SIZE = Vector3.new(7, 1, 14)
local WHEEL_SIZE = 3.5
local WHEEL_WIDTH = 1
local OFFSET_HEIGHT = 5

-- SUSPENSION SETTINGS
local SUSPENSION_LENGTH = 2
local STIFFNESS = 15000  
local DAMPING = 600      
local WHEEL_TRAVEL = 3   -- Range of motion

local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local carModel = Instance.new("Model")
carModel.Name = "UncrushableJeep"
carModel.Parent = Workspace

-- 1. CHASSIS
local chassis = Instance.new("Part")
chassis.Name = "Chassis"
chassis.CanCollide = false
chassis.Size = CHASSIS_SIZE
chassis.Color = Color3.fromRGB(85, 107, 47) 
chassis.Material = Enum.Material.Metal
chassis.Position = rootPart.Position + (rootPart.CFrame.LookVector * 15) + Vector3.new(0, OFFSET_HEIGHT, 0)
chassis.CFrame = CFrame.new(chassis.Position, chassis.Position + rootPart.CFrame.LookVector)
chassis.CustomPhysicalProperties = PhysicalProperties.new(0.5, 0.3, 0.5, 1, 1) 
chassis.Parent = carModel

-- HELPER: CREATE HUB
local function createHub(name, position)
	local hub = Instance.new("Part")
	hub.Name = name .. "_Hub"
	hub.Size = Vector3.new(1, 1, 1)
	hub.Transparency = 1 
	hub.CanCollide = false
	hub.Position = position
	hub.Massless = true 
	hub.Parent = carModel
	return hub
end

-- HELPER: CREATE WHEEL
local function createWheel(name)
	local wheel = Instance.new("Part")
	wheel.Name = name
	wheel.Shape = Enum.PartType.Cylinder
	wheel.Size = Vector3.new(WHEEL_WIDTH, WHEEL_SIZE, WHEEL_SIZE) 
	wheel.Color = Color3.fromRGB(25, 25, 25)
	wheel.Material = Enum.Material.Rubber
	wheel.CustomPhysicalProperties = PhysicalProperties.new(10, 2.5, 0.5, 100, 100) 
	wheel.Parent = carModel
	return wheel
end

local function connectSuspension(cornerName, isFront, xOffset, zOffset)
	local mountPos = chassis.CFrame:PointToWorldSpace(Vector3.new(xOffset, -0.5, zOffset))
	
	-- Create Hub Lower than chassis
	local hub = createHub(cornerName, mountPos - Vector3.new(0, SUSPENSION_LENGTH, 0))
	local wheel = createWheel(cornerName)
	
	wheel.CFrame = hub.CFrame * CFrame.Angles(0, 0, math.rad(90)) 

	-- NO COLLISION
	local noCollide = Instance.new("NoCollisionConstraint")
	noCollide.Part0 = chassis
	noCollide.Part1 = wheel
	noCollide.Parent = carModel

	-- ATTACHMENTS
	local attChassis = Instance.new("Attachment")
	attChassis.Name = "Att_Chassis_" .. cornerName
	attChassis.Position = Vector3.new(xOffset, -0.5, zOffset)
	attChassis.Orientation = Vector3.new(0, 0, -90) 
	attChassis.Parent = chassis

	local attHub = Instance.new("Attachment")
	attHub.Name = "Att_Hub_" .. cornerName
	attHub.Orientation = Vector3.new(0, 0, -90)
	attHub.Parent = hub

	-- *** SPRING (THE FIX) ***
	local spring = Instance.new("SpringConstraint")
	spring.Attachment0 = attChassis
	spring.Attachment1 = attHub
	spring.FreeLength = SUSPENSION_LENGTH
	spring.Stiffness = STIFFNESS
	spring.Damping = DAMPING
	spring.Visible = false 
	spring.Coils = 4
	spring.Radius = 0.5
	spring.Color = BrickColor.new("Gold")
	

	spring.LimitsEnabled = true
	spring.MinLength = 1 -- The spring creates a hard stop if it gets shorter than 1 stud
	spring.MaxLength = 10 
	
	spring.Parent = chassis

	-- *** PRISMATIC ***
	local prismatic = Instance.new("PrismaticConstraint")
	prismatic.Attachment0 = attChassis
	prismatic.Attachment1 = attHub
	prismatic.ActuatorType = Enum.ActuatorType.None
	prismatic.LimitsEnabled = true
	
	prismatic.LowerLimit = 0.2           
	prismatic.UpperLimit = WHEEL_TRAVEL   
	
	prismatic.Parent = chassis

	-- MOTOR
	local attAxle = Instance.new("Attachment")
	attAxle.Position = Vector3.new(0,0,0)
	attAxle.Parent = hub
	
	local attWheel = Instance.new("Attachment")
	attWheel.Parent = wheel

	local hinge = Instance.new("HingeConstraint")
	hinge.Attachment0 = attAxle
	hinge.Attachment1 = attWheel
	hinge.Parent = hub

	if not isFront then
		hinge.ActuatorType = Enum.ActuatorType.Motor
		hinge.MotorMaxAcceleration = 400 
		hinge.MotorMaxTorque = TORQUE
	else
		hinge.ActuatorType = Enum.ActuatorType.None
	end

	return {
		Hinge = hinge,
		SteerAttachment = attChassis, 
		IsFront = isFront
	}
end

local wx = (CHASSIS_SIZE.X / 2) + 0.5
local wz = (CHASSIS_SIZE.Z / 2) - 1.5

local wheels = {
	connectSuspension("FL", true, -wx, -wz),
	connectSuspension("FR", true, wx, -wz),
	connectSuspension("BL", false, -wx, wz),
	connectSuspension("BR", false, wx, wz)
}


local currentSteerAngle = 0

print("UNCRUSHABLE JEEP LOADED.")
local heartbeatConn

heartbeatConn = RunService.Heartbeat:Connect(function(dt)
    if not carModel or not carModel.Parent or not chassis or not chassis.Parent then
        if heartbeatConn then
            heartbeatConn:Disconnect()
            heartbeatConn = nil
        end
        return
    end

    local throttle = 0
    local steerInput = 0

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then throttle = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then throttle = -1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then steerInput = -1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then steerInput = 1 end
    
    -- Flip
    if UserInputService:IsKeyDown(Enum.KeyCode.R) then
        chassis.CFrame = CFrame.new(chassis.Position + Vector3.new(0,3,0))
        chassis.AssemblyLinearVelocity = Vector3.new(0,0,0)
        chassis.AssemblyAngularVelocity = Vector3.new(0,0,0)
    end

    -- Drive
    for _, wData in pairs(wheels) do
        if not wData.IsFront then
            wData.Hinge.AngularVelocity = -throttle * SPEED
        end
    end

    -- Steer
    local targetAngle = -steerInput * TURN_ANGLE
    currentSteerAngle = currentSteerAngle + (targetAngle - currentSteerAngle) * (STEER_SPEED * dt)

    for _, wData in pairs(wheels) do
        if wData.IsFront then
            wData.SteerAttachment.Orientation = Vector3.new(0, currentSteerAngle, -90)
        end
    end
end)



for i, part in pairs(carModel:GetChildren()) do
    if part:IsA("BasePart") then
        part.Transparency = 1
    end
end

-- part2 builds the JEEP
task.wait(2)
local HttpService = game:GetService("HttpService")
local RS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local aircraft = workspace[player.Name .. " Aircraft"]
local p = game.Players.LocalPlayer
local pname = p.Name
local rootRef = workspace[p.Name .. " Aircraft"].HalfPlate.BlockStd


--local data = HttpService:JSONDecode(readfile("welddata.json"))
local data = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/sametcetinkaya1447/planecrazy2/refs/heads/main/folder/welddata.json"))

local availableModels = {}

for _, m in ipairs(aircraft:GetChildren()) do
    if m:IsA("Model") then
        if not availableModels[m.Name] then
            availableModels[m.Name] = {}
        end
        table.insert(availableModels[m.Name], m)
    end
end

local function buildCF(partEntry)
    local pos = Vector3.new(partEntry.pos[1], partEntry.pos[2], partEntry.pos[3])
    local rx, ry, rz = partEntry.rot[1], partEntry.rot[2], partEntry.rot[3]
    return CFrame.new(pos) * CFrame.fromEulerAnglesXYZ(rx, ry, rz)
end

for _, savedModel in ipairs(data) do
    
    local name = savedModel.name
    local queue = availableModels[name]
    
    if not queue or #queue == 0 then
        warn("Not enough model copies for:", name)
        continue
    end
    
    local currentModelInstance = table.remove(queue, 1)

    for _, partData in ipairs(savedModel.parts) do
        
        local part = currentModelInstance:FindFirstChild(partData.name, true)
        
        if part then
            local relCF = buildCF(partData)
            local targetWorld = rootRef.CFrame * relCF
            local offset = rootRef.CFrame:ToObjectSpace(targetWorld)

            RS.BlockRemotes.MotorLock:FireServer(
                "MotorWeld",
                rootRef,
                true,
                rootRef,
                part,
                offset,
                true
            )
        else

             warn("Part not found:", partData.name, "inside", name)
        end
    end
end

print("Welding done (Corrected Method).")

task.wait(2)
local player = game:GetService("Players").LocalPlayer
local characterName = "Ru2ez9z8dh"
local myaircraft = workspace:FindFirstChild(p.Name .. " Aircraft") or workspace[p.Name .. " Aircraft"]

local aircraftModel = workspace:FindFirstChild(player.Name .. " Aircraft")
local RunService = game:GetService("RunService")

local wheelparts1 = {}
local wheelparts2 = {}

for _, v in pairs(myaircraft:GetDescendants()) do
    if v.Name == "Union" and v.Parent.Name == "TinyHalfBall" and v.Color == Color3.fromRGB(0,0,0) then
        table.insert(wheelparts2, v)
    elseif v.Name == "BlockStd" and v.Parent.Name == "TinyBall" and v.Color == Color3.fromRGB(0,0,0) then
        table.insert(wheelparts1, v)
    end
end


local function modifypart(part)
    if not part then return end
    part.CanCollide = false
    local bf = part:FindFirstChild("ZeroGravityForce")
    if not bf then
        bf = Instance.new("BodyForce")
        bf.Name = "ZeroGravityForce"
        bf.Parent = part
    end
    bf.Force = Vector3.new(0, part:GetMass() * workspace.Gravity, 0)
    part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
end

for _, part in pairs(myaircraft:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("Part") or part:IsA("WedgePart") or part:IsA("UnionOperation") then
        part.CanCollide = false
        part.Anchored = false
        modifypart(part)
    end
end

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

    -- Apply the movement
    local finalCFrame = targetCFrame
    if offsetCFrame then
        finalCFrame = targetCFrame * offsetCFrame
    end

    bp.Position = finalCFrame.Position
    bg.CFrame = finalCFrame
end

--updateBodyMover(workspace["Ru2ez9z8dh Aircraft"].Cylinder1p5.Part, workspace.Ru2ez9z8dh.Head)
local radius = 1.5
local totalPerWheel = 20
local tiltCF = CFrame.Angles(math.rad(180), math.rad(90), 0)

for w = 1, #wheelparts1 do
    local anchor = wheelparts1[w]
    local center = anchor.Position  -- wheel center

    local startIndex = (w - 1) * totalPerWheel + 1
    local endIndex = w * totalPerWheel

    for i = startIndex, endIndex do
        local idx = i - startIndex
        local angle = math.rad((idx / totalPerWheel) * 360)

        local x = math.cos(angle) * radius
        local z = math.sin(angle) * radius
        local worldPos = center + Vector3.new(x, 0, z)

        -- world-space orientation
        local worldCF = CFrame.new(worldPos, center) * tiltCF
        
        -- RELATIVE offset for weld
        local relativeCF = anchor.CFrame:ToObjectSpace(worldCF)

        weld(anchor, wheelparts2[i], relativeCF)
    end
end


local block1 = workspace[pname .. " Aircraft"].HalfPlate.BlockStd

local block2 = workspace.UncrushableJeep.Chassis
local jeep = workspace.UncrushableJeep
local fl,fr,bl,br = jeep.FL,jeep.FR,jeep.BL,jeep.BR
local offset = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(90))
local turnLeft = CFrame.Angles(math.rad(90), math.rad(-90), math.rad(90))
local rotateLeft = CFrame.Angles(0, math.rad(0), math.rad(90))

--updateBodyMover(workspace["Ru2ez9z8dh Aircraft"].HalfPlate.BlockStd,workspace.UncrushableJeep.Chassis,  CFrame.new(0,5,0)*CFrame.Angles(0,math.rad(90),0))

local heartbeatConnection

heartbeatConnection = RunService.Stepped:Connect(function(_, dt)

    if not block1 or not block2 then
        heartbeatConnection:Disconnect()
        return
    end

    updateBodyMover(block1, block2, CFrame.new(0,-1,0.8))

    updateBodyMover(wheelparts1[1], fl.CFrame * offset)
    updateBodyMover(wheelparts1[2], fr.CFrame * offset)
    updateBodyMover(wheelparts1[3], bl.CFrame * offset)
    updateBodyMover(wheelparts1[4], br.CFrame * offset)

end)
