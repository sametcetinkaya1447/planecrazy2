-- Services

print("Part1 running")
task.spawn(function()
-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

-- Part pool for limbs
local blockpool = {}
local blockpool2 = {}
local aircraft = Workspace[Player.Name .. " Aircraft"]
--for _, v in ipairs(aircraft:GetDescendants()) do
--    if v.Name == "BlockStd" and v.Parent.Name == "BlockStd" and v.Color == Color3.fromRGB(170, 80, 0) then
--        blockpool[#blockpool + 1] = v
--    end
--end

local torsoBlock = nil
local headBlock = nil

for _, v in ipairs(aircraft:GetDescendants()) do
    if v.Name == "BlockStd" and v.Parent.Name == "BlockStd" then
        if v.Color == Color3.fromRGB(170, 81, 0) then
            torsoBlock = v
        elseif v.Color == Color3.fromRGB(170, 82, 0) then
            headBlock = v
        elseif v.Name == "BlockStd" and v.Parent.Name == "BlockStd" and v.Color == Color3.fromRGB(170, 80, 0) then
            table.insert(blockpool, v)
        elseif v.Name == "BlockStd" and v.Parent.Name == "BlockStd" and v.Color == Color3.fromRGB(170, 79, 0) then
            table.insert(blockpool2, v)
        end
    end
end

-- Apply zero gravity to part
local function modifyPart(part)
    if not part then return end
    
    part.CanCollide = false
    
    local bf = part:FindFirstChild("ZeroGravityForce")
    if not bf then
        bf = Instance.new("BodyForce")
        bf.Name = "ZeroGravityForce"
        bf.Parent = part
    end
    
    bf.Force = Vector3.new(0, part:GetMass() * Workspace.Gravity, 0)
    part.AssemblyLinearVelocity = Vector3.zero
end

-- Apply to all aircraft parts
for _, part in pairs(aircraft:GetDescendants()) do
    if part:IsA("BasePart") then
        modifyPart(part)
    end
end

-- Setup part with BodyGyro and BodyPosition
local function setupPart(part)
    part.CanCollide = false
    
    local bodyGyro = Instance.new("BodyGyro", part)
    bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    bodyGyro.D = 75
    bodyGyro.P = 15000
    
    local bodyPosition = Instance.new("BodyPosition", part)
    bodyPosition.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bodyPosition.P = 75000
    bodyPosition.D = 750
end


for _, part in ipairs(blockpool) do
    setupPart(part)
end

for _, part in ipairs(blockpool2) do
    setupPart(part)
end

if torsoBlock then
    setupPart(torsoBlock)
end

if headBlock then
    setupPart(headBlock)
end


Humanoid.WalkSpeed = 0
Humanoid.WalkSpeed = 0
Humanoid.AutoRotate = false

Character.Animate.Disabled = true

-- rig 
local rig = game:GetObjects("rbxassetid://5195737219")[1]
rig.Name = "Dummy"
rig.Parent = Character
rig.HumanoidRootPart.Anchored = false
rig.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame

-- set transparency
for _, part in ipairs(rig:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("MeshPart") then
        part.Transparency = 0.8
        part.LocalTransparencyModifier = 0.8
    elseif part:IsA("Decal") then
        part.Transparency = 0.8
    end
end

-- anims 
local CAnimate = Character.Animate:Clone()
CAnimate.Parent = rig
CAnimate.Disabled = false
Workspace.CurrentCamera.CameraSubject = rig.Humanoid

-- offsetdata
local rotations = {
    ["Left Arm"] = CFrame.Angles(0, 0, 0),
    ["Right Arm"] = CFrame.Angles(0, 0, 0),
    ["Left Leg"] = CFrame.Angles(0, 0, 0),
    ["Right Leg"] = CFrame.Angles(0, 0, 0),
    ["Torso"] = CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),
    ["Head"] = CFrame.Angles(math.rad(180), math.rad(90), math.rad(180))
}

local updateFrequency = 1/60
local lastUpdate = 0

local function updateCharacter()
    if not rig or not rig.Parent then return end

    local leftArm = rig:FindFirstChild("Left Arm")
    local rightArm = rig:FindFirstChild("Right Arm")
    local leftLeg = rig:FindFirstChild("Left Leg")
    local rightLeg = rig:FindFirstChild("Right Leg")
    local torso = rig:FindFirstChild("Torso")
    local head = rig:FindFirstChild("Head")

    if leftArm and blockpool[1] then
        local bp = blockpool[1]:FindFirstChild("BodyPosition")
        local bg = blockpool[1]:FindFirstChild("BodyGyro")
        if bp and bg then
            bp.Position = leftArm.Position
            bg.CFrame = leftArm.CFrame
        end
    end

    if rightArm and blockpool[2] then
        local bp = blockpool[2]:FindFirstChild("BodyPosition")
        local bg = blockpool[2]:FindFirstChild("BodyGyro")
        if bp and bg then
            bp.Position = rightArm.Position
            bg.CFrame = rightArm.CFrame
        end
    end

    if leftLeg and blockpool2[1] then
        local bp = blockpool2[1]:FindFirstChild("BodyPosition")
        local bg = blockpool2[1]:FindFirstChild("BodyGyro")
        if bp and bg then
            bp.Position = leftLeg.Position
            bg.CFrame = leftLeg.CFrame
        end
    end

    if rightLeg and blockpool2[2] then
        local bp = blockpool2[2]:FindFirstChild("BodyPosition")
        local bg = blockpool2[2]:FindFirstChild("BodyGyro")
        if bp and bg then
            bp.Position = rightLeg.Position
            bg.CFrame = rightLeg.CFrame
        end
    end

    if torso and torsoBlock then
        local bp = torsoBlock:FindFirstChild("BodyPosition")
        local bg = torsoBlock:FindFirstChild("BodyGyro")
        if bp and bg then
            bp.Position = torso.Position
            bg.CFrame = torso.CFrame
        end
    end

    if head and headBlock then
        local bp = headBlock:FindFirstChild("BodyPosition")
        local bg = headBlock:FindFirstChild("BodyGyro")
        if bp and bg then
            bp.Position = head.Position
            bg.CFrame = head.CFrame * (rotations["Head"] or CFrame.identity)
        end
    end

end

Humanoid.Jumping:Connect(function(active)
    if active and rig and rig:FindFirstChild("Humanoid") then
        rig.Humanoid.Jump = true
    end
end)

-- Main update loop
RunService.Heartbeat:Connect(function()
    if not rig or not rig.Parent or not rig:FindFirstChild("Humanoid") then return end
    
    local currentTime = tick()
    if currentTime - lastUpdate >= updateFrequency then
        lastUpdate = currentTime
        

        rig.Humanoid:Move(Humanoid.MoveDirection)
        updateCharacter()
    end
end)
end)

print("Part1 ran")

task.wait(2)



task.spawn(function()
-- original creator is gObl00x thanks for converting the script
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "pcsc scripts";
	Text = "This Convert Is by samet";
	Icon = "rbxthumb://type=Asset&id=106012874026421&w=150&h=150"})
Duration = 15;
----------------------------------------------------------------
-- This edit/convert is by gObl00x ( random_hacke6 *RobloxUser* )--------------------
-- Credits to whoever the hell made the original Script ---------
-- Converted to pc by sametcetinkaya -------------------------------


local player = game:GetService("Players").LocalPlayer
local characterName = "Ru2ez9z8dh"
local myaircraft = workspace:FindFirstChild(player.Name .. " Aircraft") 
local aircraftModel = workspace:FindFirstChild(player.Name .. " Aircraft")

local blocklimbs = {}
local blocklimbs2 = {}
local coverblocks = {}
local coverblocks2 = {}
local exposedparts = {}
local diamondstripparts = {} 
local torsopart = nil
local headpart = nil
local torsoparts = {}
local capeparts = {}
local gunparts1 = {}
local gunparts15 = {}
local gunparts2 = {}
local gunparts25 = {}
local eyeparts = {}
local stoneparts = {}
local eyeparts2 = {}
local bulletpart = nil
local hornparts = {}
--local trapparts = {}
--local trapparts2 = {}
local speaker1,speaker2,speaker3 = nil, nil, nil -- equipgun,shoot,crush


for i, v in pairs(myaircraft:GetDescendants()) do
    if v.Name == "BlockStd" and v.Parent.Name == "BlockStd" then
        if v.Color == Color3.fromRGB(170, 80, 0) then
            table.insert(blocklimbs, v)
        elseif v.Color == Color3.fromRGB(170, 79, 0) then
            table.insert(blocklimbs2, v)
        elseif v.Color == Color3.fromRGB(170, 81, 0) then
            torsopart = v
        elseif v.Color == Color3.fromRGB(170, 82, 0) then
            headpart = v
        elseif v.Color == Color3.fromRGB(170, 69, 0) then    
            table.insert(torsoparts, v)
        elseif v.Color == Color3.fromRGB(170, 70, 0) then   
            table.insert(coverblocks, v)
        elseif v.Color == Color3.fromRGB(30, 30, 70) then 
            table.insert(coverblocks2, v)
        elseif v.Color == Color3.fromRGB(80,67,67) then
            table.insert(exposedparts, v)       
        elseif v.Color == Color3.fromRGB(27, 42, 53) then
            table.insert(stoneparts, v)   
        elseif v.Color == Color3.fromRGB(170, 60, 0) then         
        end
    end
end

-- other blocks 
for i, v in pairs(myaircraft:GetDescendants()) do
    if v.Name == "BlockStd" and v.Parent.Name == "HalfPlate" and v.Color == Color3.fromRGB(255,255,255) then
        table.insert(diamondstripparts, v)
        
    elseif v.Name == "BlockStd" and v.Parent.Name == "Plate" then
        table.insert(capeparts, v)
        
    elseif v.Name == "BlockStd" and v.Parent.Name == "HalfPlate" and v.Color == Color3.fromRGB(127,127,127) then
        table.insert(gunparts1, v)
        
    elseif v.Name == "BlockStd" and v.Parent.Name == "HalfPlate" and v.Color == Color3.fromRGB(82,45,0) then
        table.insert(gunparts15, v)
        
    elseif v.Name == "Part" and v.Parent.Name == "Trail"  and v.Color == Color3.fromRGB(127,127,127) then 
        table.insert(gunparts2, v)

    elseif v.Name == "Part" and v.Parent.Name == "Trail"  and v.Color == Color3.fromRGB(0,0,0) then 
        table.insert(gunparts25, v)

    elseif v.Name == "Part" and v.Parent.Name == "Trail"  and v.Color == Color3.fromRGB(255,255,0) then 
        bulletpart = v
        
    elseif v.Name == "Union" and v.Parent.Name == "TinyHalfBall" and v.Color == Color3.fromRGB(170,0,0) then
        table.insert(eyeparts, v)
    elseif v.Name == "BlockStd" and v.Parent.Name == "HoverThruster" and v.Color == Color3.fromRGB(255,0,0) then
        table.insert(eyeparts2, v)
    --elseif v.Name == "BlockStd" and v.Parent.Name == "HoverThruster" and v.Color == Color3.fromRGB(50,40,50) then
    --    table.insert(hornparts, v)
    --elseif v.Name == "BlockStd" and v.Parent.Name == "TinyBall" and v.Color == Color3.fromRGB(170,85,0) then
    --    table.insert(trapparts, v)
    --elseif v.Name == "Seat" and v.Parent.Name == "PilotSeatExtra" then
    --    table.insert(trapparts2, v)
    elseif v.Name == "SpeakerPart" and v.Parent.Name == "Speaker" and v.Parent.Configuration.MusicID.Value == "1498950813" then 
        speaker1 = v
    elseif v.Name == "SpeakerPart" and v.Parent.Name == "Speaker" and v.Parent.Configuration.MusicID.Value == "213603013" then
        speaker2 = v
    elseif v.Name == "SpeakerPart" and v.Parent.Name == "Speaker" and v.Parent.Configuration.MusicID.Value == "765590102" then
        speaker3 = v
    end
end

print("Limb Blocks found:", #blocklimbs)
print("Cover Blocks found:", #coverblocks)
print("Exposed Parts found:", #exposedparts)
print("Diamond Strip Parts found:", #diamondstripparts)
print("Cape Parts found:", #capeparts)
print("Gun Parts 1 found:", #gunparts1)
print("Gun Parts 1.5 found:", #gunparts15)
print("Gun Parts 2 found:", #gunparts2)
print("Gun Parts 2.5 found:", #gunparts25)
print("Eye Parts found:", #eyeparts)
--print("Trap Parts found:", #trapparts)


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

--  gravity: upward force = mass * gravity
bf.Force = Vector3.new(0, part:GetMass() * workspace.Gravity, 0)

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

local function unweld(part)
	game.ReplicatedStorage.Remotes.UnanchorWelds:FireServer(part, "Break")
end


--local ohBoolean1 = true
--local ohNumber2 = 1771661870.6422844
--local ohString3 = "Zero"
--workspace["Ru2ez9z8dh Aircraft"].Speaker.Events["On/Off"]:Fire(ohBoolean1, ohNumber2, ohString3)


local function playsound(part)
	--if part not nil then
		if not part then return end
    task.spawn(function()
        local number = workspace:GetServerTimeNow()
        local string = "Nine"
        part.Parent.Events["On/Off"]:Fire(true, number, string)
        task.wait(0.5)
        part.Parent.Events["On/Off"]:Fire(false, number, string)
    end)
end



-- 1. Offset Configuration

local coverOffsets = {
    CFrame.new(-0.4, 1.25, 0.4),
    CFrame.new(-0.4, 1.25, -0.4),
    CFrame.new(0.4, 1.25, 0.4),
    CFrame.new(0.4, 1.25, -0.4),
    CFrame.new(-0.4, -1.25, 0.4),
    CFrame.new(-0.4, -1.25, -0.4),
    CFrame.new(0.4, -1.25, 0.4),
    CFrame.new(0.4, -1.25, -0.4),
}

local exposeoffset = { 
    CFrame.new(-0.35, 2.65,  0.35),
    CFrame.new(-0.35, 2.65, -0.35),
    CFrame.new(0.35,  2.65,  0.35),
    CFrame.new(0.35,  2.65, -0.35),
}


local diamondOffsets = {
    CFrame.new( -0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(math.rad(90))),
    CFrame.new( 0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(math.rad(90))),
    CFrame.new( -0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(90), math.rad(math.rad(90))),
    CFrame.new( 0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(90), math.rad(math.rad(90))),
    CFrame.new( -0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(180), math.rad(math.rad(90))),
    CFrame.new( 0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(180), math.rad(math.rad(90))),
    CFrame.new( -0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(270), math.rad(math.rad(90))),
    CFrame.new( 0.5, 1.6, 2.3) * CFrame.Angles(math.rad(90), math.rad(270), math.rad(math.rad(90))),
}

local torsoOffset = {

    CFrame.new(2, 0,0.5),
    CFrame.new(0, 0,0.5),
    CFrame.new(-2, 0,0.5),
    CFrame.new(2, 0,-0.5),
    CFrame.new(0, 0,-0.5),
    CFrame.new(-2, 0,-0.5),

    CFrame.new(2, 2,0.5),
    CFrame.new(0, 2,0.5),
    CFrame.new(-2, 2,0.5),
    CFrame.new(2, 2,-0.5),
    CFrame.new(0, 2,-0.5),
    CFrame.new(-2, 2,-0.5),

    CFrame.new(2, -2,0.5),
    CFrame.new(0, -2,0.5),
    CFrame.new(-2, -2,0.5),
    CFrame.new(2, -2,-0.5),
    CFrame.new(0, -2,-0.5),
    CFrame.new(-2, -2,-0.5),

}
local dfltcapeoffset = CFrame.Angles(math.rad(-35), math.rad(0), math.rad(math.rad(0)))
local capeOffset = {
    CFrame.new(-2, 0,-5) * CFrame.Angles(math.rad(-45), math.rad(-30), math.rad(0)),
    CFrame.new(-2, 0,-3) * CFrame.Angles(math.rad(-45), math.rad(-30), math.rad(0)),
    CFrame.new(-1, 0,-5) * CFrame.Angles(math.rad(-45), math.rad(-20), math.rad(0)),--
    CFrame.new(-1, 0,-3) * CFrame.Angles(math.rad(-45), math.rad(-20), math.rad(0)),--
    CFrame.new(1, 0,-3) *  CFrame.Angles(math.rad(-45), math.rad(20),  math.rad(0)),--
    CFrame.new(1, 0,-5) *  CFrame.Angles(math.rad(-45), math.rad(20),  math.rad(0)),--
    CFrame.new(2, 0,-3) *  CFrame.Angles(math.rad(-45), math.rad(30),  math.rad(0)),
    CFrame.new(2, 0,-5) *  CFrame.Angles(math.rad(-45), math.rad(30),  math.rad(0)),
}
local gunOffset1 = {
    CFrame.new(0, 0.2, 0) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(0, -0.2, 0) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(0, 0.2, -0.5) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(0, -0.2, -0.5) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(0, 0, -0.5) * CFrame.Angles(math.rad(90), math.rad(0), 0),--
    CFrame.new(-1, 0.2, 0) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(-1, -0.2, 0) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(-1, 0, 0) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(-1, 0.2, -0.5) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(-1, -0.2, -0.5) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(-1, 0, -0.5) * CFrame.Angles(math.rad(90), math.rad(0), 0),
    CFrame.new(1, 0, -0.6) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-85)),
    CFrame.new(1, 0.18, -0.6) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-85)),
    CFrame.new(1, -0.18, -0.6) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-85)),
}

local gunOffset2 = {
    CFrame.new(-0.7, 0, -1) *     CFrame.Angles(math.rad(90), math.rad(0), math.rad(90)),
    CFrame.new(-1.2, 0, -1) *     CFrame.Angles(math.rad(90), math.rad(180), math.rad(90)),
    CFrame.new(-1.2, 0, 0) *     CFrame.Angles(math.rad(90), math.rad(180), math.rad(90)),

    CFrame.new(-0.7, -0.0, -1.15) *     CFrame.Angles(math.rad(90), math.rad(180), math.rad(90)),

}

local hatoffset = {

 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(0),   math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(45),  math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(90),  math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(135), math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(180), math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(225), math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(270), math.rad(184)),
 CFrame.new(1.8, 1.8, 0) *     CFrame.Angles(math.rad(0), math.rad(315), math.rad(184)),
 CFrame.new(-1.8, 2.5, 0) *     CFrame.Angles(math.rad(0), math.rad(0),   math.rad(250)),
 CFrame.new(-2, 2.5, 0) *     CFrame.Angles(math.rad(25), math.rad(0),   math.rad(250)),
 CFrame.new(-1.7, 2.7, 0) *     CFrame.Angles(math.rad(50), math.rad(-20),   math.rad(250)),
 CFrame.new(-2, 2.7, 0) *     CFrame.Angles(math.rad(80), math.rad(-25),   math.rad(250)),

CFrame.new(-1.8, 2.5, 0) *     CFrame.Angles(math.rad(-30), math.rad(5),   math.rad(250)),

CFrame.new(2, -2.5, 0) *     CFrame.Angles(math.rad(200), math.rad(10),   math.rad(-250)),
CFrame.new(2, -2.5, 0) *     CFrame.Angles(math.rad(160), math.rad(-10),   math.rad(-250)),
CFrame.new(2, -2.5, 0) *     CFrame.Angles(math.rad(120), math.rad(-15),   math.rad(-250)),
CFrame.new(2, -2.5, 0) *     CFrame.Angles(math.rad(100), math.rad(-35),   math.rad(-245)),
CFrame.new(0, -3.5, 0) *     CFrame.Angles(math.rad(0), math.rad(-180),   math.rad(0)),

}




--local GunState = getgenv().GunState

-- Script Source
script=game:GetObjects("rbxassetid://6515226671")[1].Convert
-- Soundtrack
--if not isfile("Mr ByeBye.mp3") then 
--	writefile("Mr ByeBye.mp3",game:HttpGet("https://github.com/gObl00x/Soundtracks/raw/refs/heads/main/Mr%20ByeBye.mp3"))
-- end
-- Definitions
local Player = game.Players.LocalPlayer
if Player then
local Owner = script.Owner
Owner.Value = Owner.Value 
Owner:Destroy()

--//====================================================\\--
--||                       BASIC FUNCTIONS
--\\====================================================//--

-- Initialitation
wait(5/60)
Player = Player -- Muscle Memory:
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = workspace[Player.Name].Dummy
Humanoid = Character.Humanoid
Mouse = Player:GetMouse()
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
local sick = Instance.new("Sound", Character)
IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor
Animation_Speed = 3
Frame_Speed = 0.016666666666666666
local Speed = 25
local SIZE = 3
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", game.Workspace)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
ANIMATOR:Destroy()
local UNANCHOR = true
local HELDGUN, GUNWELD
local HITPLAYERSOUNDS = {
	"263032172",
	"263032182",
	"263032200",
	"263032221",
	"263032252",
	"263033191"
}


function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end
function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end
function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end
local RunService = game:GetService("RunService")

local RunService = game:GetService("RunService")

local TARGET_FPS = 60
local FRAME_TIME = 1 / TARGET_FPS

function Swait(frames)
	frames = frames or 1
	
	for i = 1, frames do
		local start = os.clock()
		repeat
			RunService.Heartbeat:Wait()
		until os.clock() - start >= FRAME_TIME
	end
end
function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id=" .. MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id=" .. TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end
function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end
local weldBetween = function(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end
function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m00 < m11 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp
	if cosTheta >= 1.0E-4 then
		if 1 - cosTheta > 1.0E-4 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	elseif 1 + cosTheta > 1.0E-4 then
		local theta = ACOS(-cosTheta)
		local invSinTheta = 1 / SIN(theta)
		startInterp = SIN((t - 1) * theta) * invSinTheta
		finishInterp = SIN(t * theta) * invSinTheta
	else
		startInterp = t - 1
		finishInterp = t
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function Clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end
function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end
function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end
function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end
local S = IT("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.EmitterSize = 10 + VOLUME * 2
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat
				wait(1)
			until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end
function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end
function WACKYEFFECT(Table)
	local TYPE = Table.EffectType or "Sphere"
	local SIZE = Table.Size or VT(1, 1, 1)
	local ENDSIZE = Table.Size2 or VT(0, 0, 0)
	local TRANSPARENCY = Table.Transparency or 0
	local ENDTRANSPARENCY = Table.Transparency2 or 1
	local CFRAME = Table.CFrame or Torso.CFrame
	local MOVEDIRECTION = Table.MoveToPos or nil
	local ROTATION1 = Table.RotationX or 0
	local ROTATION2 = Table.RotationY or 0
	local ROTATION3 = Table.RotationZ or 0
	local MATERIAL = Table.Material or "Neon"
	local COLOR = Table.Color or C3(1, 1, 1)
	local TIME = Table.Time or 45
	local SOUNDID = Table.SoundID or nil
	local SOUNDPITCH = Table.SoundPitch or nil
	local SOUNDVOLUME = Table.SoundVolume or nil
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh", EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X, SIZE.X, 0.1), VT(0, 0, 0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0, 0, 0))
		end
		if MSH ~= nil then
			local MOVESPEED
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude / TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
			else
				EFFECT.CFrame = CFRAME
			end
			for LOOP = 1, TIME + 1 do
				Swait()
				MSH.Scale = MSH.Scale - GROWTH / TIME
				if TYPE == "Wave" then
					MSH.Offset = VT(0, 0, -MSH.Scale.X / 8)
				end
				EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				else
					EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation
					EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED)
					EFFECT.Orientation = ORI
				end
			end
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat
					Swait()
				until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		elseif PLAYSSOUND == false then
			EFFECT:remove()
		else
			repeat
				Swait()
			until EFFECT:FindFirstChildOfClass("Sound") == nil
			EFFECT:remove()
		end
	end))
end
function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end
Debris = game:GetService("Debris")
function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos, EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end
function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end
Debris = game:GetService("Debris")
function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos, EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end
function Chatter(Text, Timer)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("SpeechBoard") ~= nil then
			Character:FindFirstChild("SpeechBoard"):destroy()
		end
		local naeeym2 = IT("BillboardGui", game.Workspace)
		naeeym2.Size = UD2(0, 100, 0, 40)
		naeeym2.StudsOffset = VT(0, 5, 0)
		naeeym2.Adornee = Character.Head
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel", naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "Legacy"
		tecks2.TextSize = 15
		tecks2.TextStrokeTransparency = 0
		tecks2.TextColor3 = C3(1, 1, 1)
		tecks2.TextStrokeColor3 = C3(0, 0, 0)
		tecks2.Size = UDim2.new(1, 0, 0.5, 0)
		local FINISHED = false
		coroutine.resume(coroutine.create(function()
			for i = 1, string.len(Text) do
				if naeeym2.Parent ~= Character then
					FINISHED = true
				end
				CreateSound(418252437, Head, 7, MRANDOM(8, 12) / 15, false)
				tecks2.Text = string.sub(Text, 1, i)
				Swait(Timer)
			end
			FINISHED = true
		end))
		repeat
			wait()
		until FINISHED == true
		wait(1)
		naeeym2.Name = "FadingDialogue"
		for i = 1, 45 do
			Swait()
			naeeym2.StudsOffset = naeeym2.StudsOffset + VT(0, (2 - 0.044444444444444446 * i) / 45, 0)
			tecks2.TextTransparency = tecks2.TextTransparency + 0.022222222222222223
			tecks2.TextStrokeTransparency = tecks2.TextTransparency
		end
		naeeym2:Destroy()
	end)
	chat()
end
function CreateFlyingDebree(FLOOR, POSITION, AMOUNT, BLOCKSIZE, SWAIT, STRENGTH, DOES360, NAME)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			do
				local DEBREE = CreatePart(3, Effects, "Neon", 0, 0, "Peal", "Debree", BLOCKSIZE, false)
				DEBREE.Name = NAME
				DEBREE.Material = FLOOR.Material
				DEBREE.Color = FLOOR.Color
				DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)))
				if DOES360 == true then
					DEBREE.Velocity = VT(MRANDOM(-STRENGTH, STRENGTH), MRANDOM(-STRENGTH, STRENGTH), MRANDOM(-STRENGTH, STRENGTH))
				else
					DEBREE.Velocity = VT(MRANDOM(-STRENGTH, STRENGTH), STRENGTH, MRANDOM(-STRENGTH, STRENGTH))
				end
				coroutine.resume(coroutine.create(function()
					Swait(15)
					DEBREE.Parent = workspace[Player.Name].Dummy:GetChildren()[10]
					DEBREE.CanCollide = true
					Debris:AddItem(DEBREE, SWAIT)
				end))
			end
		end
	end
end
function SHAKECAM(POSITION, RANGE, INTENSITY, TIME)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					local CAMSHAKER = script.CamShake:Clone()
					CAMSHAKER.Shake.Value = INTENSITY
					CAMSHAKER.Timer.Value = TIME
					CAMSHAKER.Parent = CHILD
					CAMSHAKER.Disabled = false
				end
			end
		end
	end
end
Humanoid.Parent = nil
RootPart.Size = RootPart.Size * SIZE
Torso.Size = Torso.Size * SIZE
RightArm.Size = RightArm.Size * SIZE
RightLeg.Size = RightLeg.Size * SIZE
LeftArm.Size = LeftArm.Size * SIZE
LeftLeg.Size = LeftLeg.Size * SIZE
RootJoint.C0 = ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(0))
RootJoint.C1 = ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(0))
Neck.C0 = NECKC0 * CF(0 * SIZE, 0 * SIZE, 0 + (1 * SIZE - 1)) * ANGLES(RAD(0), RAD(0), RAD(0))
Neck.C1 = CF(0 * SIZE, -0.5 * SIZE, 0 * SIZE) * ANGLES(RAD(-90), RAD(0), RAD(180))
RightShoulder.C1 = CF(0 * SIZE, 0.5 * SIZE, -0.35 * SIZE)
LeftShoulder.C1 = CF(0 * SIZE, 0.5 * SIZE, -0.35 * SIZE)
RightHip.C0 = CF(1 * SIZE, -1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
LeftHip.C0 = CF(-1 * SIZE, -1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
RightHip.C1 = CF(0.5 * SIZE, 1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
LeftHip.C1 = CF(-0.5 * SIZE, 1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
Head.Size = Head.Size * SIZE
RootJoint.Parent = RootPart
Neck.Parent = Torso
RightShoulder.Parent = Torso
LeftShoulder.Parent = Torso
RightHip.Parent = Torso
LeftHip.Parent = Torso

local Trap = Instance.new
local GUNOFFSET = CF(0, 0.8, -1.3)
local BEARTRAP = script.Beartrap
BEARTRAP.Parent = nil
local GRENADE = script.Grenade
GRENADE.Parent = nil
GRENADE.Anchored = false
local FAKEBEARTRAP, FAKEGUN, HELDTRAP
for _, c in pairs(Character:GetChildren()) do
	if script:FindFirstChild(c.Name) then
		local Part = script[c.Name]
		Part.Parent = Character
		Part:SetPrimaryPartCFrame(c.CFrame)
		c.Transparency = 1
		for _, e in pairs(Part:GetChildren()) do
			if e:IsA("BasePart") and e.Name ~= "Base" then
				e.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
				e.Anchored = false
				weldBetween(c, e)
				e.CanCollide = false
				e.Locked = true
				if e.Name == "Beartrap" then
					FAKEBEARTRAP = e
				elseif e.Name == "Gun" then
					FAKEGUN = e
				elseif e.Name == "HeldBeartrap" then
					HELDTRAP = e
				end
			end
		end
	end
end

local TAIL = {}

local SKILLTEXTCOLOR = C3(1, 1, 1)
local SKILLFONT = "Legacy"
local SKILLTEXTSIZE = 3
local ATTACKS = {
	"Mouse - Fury",
	"F - Equip Gun",
	"C - Beartrap",
	"V - Hand Grenade"
}
for i = 1, #ATTACKS do
	local SKILLFRAME = CreateFrame(WEAPONGUI, 1, 2, UD2(0.74, 0, 0.85 - 0.02 * i, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill Frame")
	local SKILLTEXT = CreateLabel(SKILLFRAME, "[" .. ATTACKS[i] .. "]", SKILLTEXTCOLOR, SKILLTEXTSIZE, SKILLFONT, 0, 2, 0, "Skill text")
	SKILLTEXT.TextXAlignment = "Right"
end
Humanoid.Parent = Character
function ApplyDamage(Humanoid, Damage)
	Damage = Damage * DAMAGEMULTIPLIER
	if Humanoid.Health < 2000 then
		if Humanoid.Health - Damage > 0 then
			--Humanoid.Health = Humanoid.Health - Damage
		else
			--Humanoid.Parent:BreakJoints()
		end
	else
		--Humanoid.Parent:BreakJoints()
	end
end
function ApplyAoE(POSITION, RANGE, MINDMG, MAXDMG, FLING, INSTAKILL)
	for index, CHILD in pairs(workspace:GetDescendants()) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if INSTAKILL == true then
						--CHILD:BreakJoints()
					else
						local DMG = MRANDOM(MINDMG, MAXDMG)
						ApplyDamage(HUM, DMG)
					end
					if FLING > 0 then
						for _, c in pairs(CHILD:GetChildren()) do
							if c:IsA("BasePart") then
								local bv = Instance.new("BodyVelocity")
								bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
								bv.velocity = CF(POSITION, TORSO.Position).lookVector * FLING
								bv.Parent = c
								Debris:AddItem(bv, 0.05)
							end
						end
					end
				end
			end
		end
	end
end
function Fury()
	ATTACK = true
	Rooted = false
	if EQUIPPED == false then
		Rooted = true
		Chatter("I'll crush you!", 0)
		for i = 0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0.01 * SIZE, -0.01 * SIZE) * ANGLES(RAD(-5), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, 0.2 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(5), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(-5), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		local TOUCH = RightLeg.Touched:Connect(function(HIT)
			if HIT.Anchored == false and (HIT.Parent:FindFirstChildOfClass("Humanoid") or HIT.Parent.Parent:FindFirstChildOfClass("Humanoid")) then
				--HIT:BreakJoints()
			end
		end)
		for i = 0, 0.1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, -0.4 * SIZE, -0.1 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(-25), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(-25), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -0.7 * SIZE, -0.5 * SIZE) * ANGLES(RAD(25), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1.1 * SIZE, -0.01 * SIZE) * ANGLES(RAD(25), RAD(-75), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		local HITFLOOR, HITPOS = Raycast(RightLeg.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 2 * SIZE, Character)
		if HITFLOOR then
			--for i = 1, 5 do
			--	WACKYEFFECT({
			--		Time = 25,
			--		EffectType = "Wave",
			--		Size = VT(5, 0.5, 5),
			--		Size2 = VT(15 + i * 3, 0, 15 + i * 3),
			--		Transparency = 0.7,
			--		Transparency2 = 1,
			--		CFrame = CF(RightLeg.CFrame * CF(0, -1.05 * SIZE, 0).p) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)),
			--		MoveToPos = nil,
			--		RotationX = 0,
			--		RotationY = 0,
			--		RotationZ = 0,
			--		Material = "Neon",
			--		Color = C3(1, 1, 1),
			--		SoundID = nil,
			--		SoundPitch = nil,
			--		SoundVolume = nil
			--	})
			--end
			--SHAKECAM(HITPOS, 35, 7, 12)
			--ApplyAoE(HITPOS, 25, 35, 45, 45, false)
			--CreateSound(765590102, RightLeg, 6, 1, false)
			playsound(speaker3)
			CreateFlyingDebree(HITFLOOR, CF(HITPOS), 10, VT(2, 2, 2), 5, 75, false,"stoneparts")
		end
		TOUCH:Disconnect()
		for i = 0, 0.2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, -0.4 * SIZE, -0.1 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(-25), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(-25), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -0.7 * SIZE, -0.5 * SIZE) * ANGLES(RAD(25), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1.1 * SIZE, -0.01 * SIZE) * ANGLES(RAD(25), RAD(-75), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	else
		--getgenv().sikis = true
		do
			local GYRO = IT("BodyGyro", game.Workspace)
			GYRO.D = 2
			GYRO.P = 20000
			GYRO.MaxTorque = VT(0, 4000000, 0)
			coroutine.resume(coroutine.create(function()
				repeat
					Swait()
					GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
				until ATTACK == false
				GYRO:Remove()
			end))
			local FIRING = true
			local SHOOTING = false
			local TIMER = 70
			--CreateSound(1498950813, HELDGUN, 6, 1, false)
			playsound(speaker1)
			for i = 0, 0.2, 0.1 / Animation_Speed do
				Swait()
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(35)), 1 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(15 - 5 * COS(SINE / 24)), RAD(-5), RAD(-25)), 1 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(80), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
			end
			local MOUSE = Mouse.Button1Down:connect(function(NEWKEY)
				if SHOOTING == false then
					--GunState.HOLD = true
					--HOLD = true
					--getgenv().sikis = true
					repeat
						SHOOTING = true
						--GunState.SHOOTING = true
						--getgenv().sikis = true
						print("shot")
						--playsound(speaker2)
						local GUNPOS = HELDGUN.CFrame * GUNOFFSET.p
						local HIT, POS, NORMAL = CastProperRay(GUNPOS, Mouse.Hit.p, 1000, Character)
						local DISTANCE = (POS - GUNPOS).Magnitude
						--playsound(speaker2)
						if HIT then
							if HIT.Parent:FindFirstChildOfClass("Humanoid") then
								if HIT.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then
									--HIT.CFrame = HIT.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
									CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], HIT, 10, 1, false)
									ApplyDamage(HIT.Parent:FindFirstChildOfClass("Humanoid"), 99)
									--CreateFlyingDebree(HIT, CF(POS), 7, VT(0.1, 0.1, 0.1), 5, 35, true)
								end
							elseif HIT.Anchored == true then
								--CreateFlyingDebree(HIT, CF(POS), 7, VT(0.2, 0.2, 0.2), 5, 35, true, "bulletparts")
							end
						end
						SHAKECAM(GUNPOS, 8, 5, 3)
						SHAKECAM(POS, 10, 6, 6)
						--WACKYEFFECT({
						--	Time = 6,
						--	EffectType = "Block",
						--	Size = VT(2, 2, 2),
						--	Size2 = VT(4, 4, 4),
						--	Transparency = 0,
						--	Transparency2 = 1,
						--	CFrame = CF(GUNPOS),
						--	MoveToPos = nil,
						--	RotationX = 0,
						--	RotationY = 0,
						--	RotationZ = 0,
						--	Material = "Neon",
						--	Color = C3(1, 1, 0),
						--	SoundID = 213603013,
						--	SoundPitch = 0.9,
						--	SoundVolume = 10
						--})
						--WACKYEFFECT({
						--	Time = 6,
						--	EffectType = "Box",
						--	Size = VT(1.6, 1.6, DISTANCE),
						--	Size2 = VT(0, 0, DISTANCE),
						--	Transparency = 0,
						--	Transparency2 = 1,
						--	CFrame = CF(GUNPOS, POS) * CF(0, 0, -DISTANCE / 2),
						--	MoveToPos = nil,
						--	RotationX = 0,
						--	RotationY = 0,
						--	RotationZ = 0,
						--	Material = "Neon",
						--	Color = C3(1, 1, 0),
						--	SoundID = nil,
						--	SoundPitch = nil,
						--	SoundVolume = nil
						--})
						for i = 0, 0.3, 0.1 / Animation_Speed do
							Swait()
							RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(35)), 1 / Animation_Speed)
							Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(15 - 5 * COS(SINE / 24)), RAD(-5), RAD(-25)), 1 / Animation_Speed)
							RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(100), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
							LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
							RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
							LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
						end
						playsound(speaker2)
						for i = 0, 0.5, 0.1 / Animation_Speed do
							Swait()
							RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(35)), 1 / Animation_Speed)
							Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(15 - 5 * COS(SINE / 24)), RAD(-5), RAD(-25)), 1 / Animation_Speed)
							RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(80), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
							LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
							RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
							LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
						end
					until HOLD == false
					SHOOTING = false
					--getgenv().sikis = false
				end
			end)
			repeat
				Swait()
				if SHOOTING == false then
					TIMER = TIMER - 1
					if TIMER <= 0 then
						FIRING = false
					end
					RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(35)), 1 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(15 - 5 * COS(SINE / 24)), RAD(-5), RAD(-25)), 1 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(80), RAD(0), RAD(30)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-45), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
				end
			until FIRING == false and SHOOTING == false
			MOUSE:Disconnect()
		end
	end
	ATTACK = false
	Rooted = false
end
function EquipGun()
	ATTACK = true
	Rooted = false
	if EQUIPPED == false then
		Chatter("Let's play dirty.", 0)
		getgenv().sikis = true
		print("equipped the gun")
		for i = 0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.4 * SIZE, 0.35 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(15), RAD(0), RAD(-75)) * ANGLES(RAD(0), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0.2 * SIZE) * ANGLES(RAD(-15), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		HELDGUN = FAKEGUN:Clone()
		HELDGUN.Parent = Character
		GUNWELD = CreateWeldOrSnapOrMotor("Weld", RightArm, RightArm, HELDGUN, CF(0.3 * SIZE, -1.5 * SIZE, 0.1 * SIZE) * ANGLES(RAD(-90), RAD(0), RAD(-90)), CF(0, 0, 0))
		FAKEGUN.Transparency = 1
		--CreateSound(1498950813, HELDGUN, 6, 1, false)
		playsound(speaker1)
		for i = 0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.5 * SIZE, 0.45 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(45), RAD(0), RAD(-35)) * ANGLES(RAD(0), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.3 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		EQUIPPED = true
	else
		getgenv().sikis = false
		print("unequipped the gun")
		for i = 0, 0.3, 0.1 / Animation_Speed do
			Swait()
			GUNWELD.C1 = Clerp(GUNWELD.C1, CF(0, 0.5, 0) * ANGLES(RAD(65), RAD(-45), RAD(0)), 1 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(0.7 * SIZE, 0 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.1 * SIZE) * ANGLES(RAD(35), RAD(0), RAD(-75)) * ANGLES(RAD(0), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0.3 * SIZE) * ANGLES(RAD(-25), RAD(15), RAD(-15)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
		FAKEGUN.Transparency = 0
		HELDGUN:remove()
		HELDGUN = nil
		EQUIPPED = false
	end
	ATTACK = false
	Rooted = false
end
function BearTrap()
	ATTACK = true
	Rooted = false
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(-20), RAD(-25), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		until ATTACK == false
	end))
	for i = 0, 0.3, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-0.1 * SIZE, 0.25 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(30), RAD(0), RAD(90)) * ANGLES(RAD(0), RAD(0), RAD(-35)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	local GYRO = IT("BodyGyro", game.Workspace)
	GYRO.D = 2
	GYRO.P = 20000
	GYRO.MaxTorque = VT(0, 4000000, 0)
	GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			--GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
		until ATTACK == false
		GYRO:Remove()
	end))
	FAKEBEARTRAP.Transparency = 1
	HELDTRAP.Transparency = 0
	for i = 0, 0.4, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(40), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	local TRAP = BEARTRAP:Clone()
	TRAP.Parent = Effects
	coroutine.resume(coroutine.create(function()
		TRAP:SetPrimaryPartCFrame(HELDTRAP.CFrame)
		local BASE = TRAP.PrimaryPart
		local OPEN = TRAP.Open
		local CLOSED = TRAP.Closed
		CreateSound(147722227, BASE, 6, 1, false)
		local DISTANCE = (BASE.Position - Mouse.Hit.p).Magnitude
		BASE.Velocity = CF(BASE.Position - VT(0, 5, 0), Mouse.Hit.p).lookVector * (DISTANCE * 2)
		wait(0.7)
		BASE.Velocity = VT(0, 0, 0)
		local ISCLOSED = false
		for i = 1, 15 do
			Swait()
			BASE.CFrame = Clerp(BASE.CFrame, CF(BASE.Position + VT(0, 1, 0)), 0.4)
		end
		TOUCH = OPEN.Touched:Connect(function(HIT)
			if HIT.Anchored == false and ISCLOSED == false and HIT.Parent:FindFirstChildOfClass("Humanoid") then
				TOUCH:Disconnect()
				ISCLOSED = true
				OPEN.Anchored = true
				OPEN.Transparency = 1
				CLOSED.Transparency = 0
				OPEN.CanCollide = false
				CreateSound(HITPLAYERSOUNDS[MRANDOM(1, #HITPLAYERSOUNDS)], HIT, 10, 1, false)
				ApplyDamage(HIT.Parent:FindFirstChildOfClass("Humanoid"), 0)
				--weldBetween(OPEN, HIT)
				CreateSound(54061314, OPEN, 6, 1, false)
			end
		end)
		wait(15)
		TOUCH:Disconnect()
		for i = 1, 45 do
			Swait()
			for _, e in pairs(TRAP:GetChildren()) do
				if e:IsA("BasePart") then
					e.Transparency = e.Transparency + 0.022222222222222223
				end
			end
		end
		TRAP:Remove()
	end))
	HELDTRAP.Transparency = 1
	for i = 0, 0.3, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(5)), 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.2 * SIZE) * ANGLES(RAD(120), RAD(0), RAD(10)) * LEFTSHOULDERC0, 2 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(-5), RAD(-90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	FAKEBEARTRAP.Transparency = 0
	ATTACK = false
	Rooted = false
end
function HandGrenade()
	ATTACK = true
	Rooted = false
	Chatter("How about a little fire?", 0)
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.35 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0.2 * SIZE) * ANGLES(RAD(-20), RAD(-25), RAD(-3)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		until ATTACK == false
	end))
	local GYRO = IT("BodyGyro", game.Workspace)
	GYRO.D = 2
	GYRO.P = 20000
	GYRO.MaxTorque = VT(0, 4000000, 0)
	--GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			--GYRO.CFrame = CF(RootPart.Position, Mouse.Hit.p)
		until ATTACK == false
		GYRO:Remove()
	end))
	for i = 0, 0.4, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(0 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(-5), RAD(0), RAD(15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	local NADE = GRENADE:Clone()
	NADE.Name = "Grenade"
	NADE.Parent = game.Workspace
	NADE.CFrame = LeftArm.CFrame * CF(0, -1.2 * SIZE, 0) * ANGLES(RAD(90), RAD(0), RAD(0))
	NADE.Parent = Effects
	CreateSound(326088041, NADE, 7, 1, false)
	local WELD = weldBetween(LeftArm, NADE)
	for i = 0, 0.7, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(0 - 5 * COS(SINE / 24)), RAD(-5), RAD(-15)), 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(150), RAD(0), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(55), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	coroutine.resume(coroutine.create(function()
		WELD:remove()
		local DISTANCE = (NADE.Position - Mouse.Hit.p).Magnitude
		if DISTANCE > 150 then
			DISTANCE = 150
		end
		NADE.Velocity = CF(NADE.Position - VT(0, 5, 0), Mouse.Hit.p).lookVector * (DISTANCE * 2)
		wait(0.2)
		TOUCH = NADE.Touched:Connect(function()
			TOUCH:Disconnect()
			wait(0.5)
			NADE.Anchored = true
			NADE.Transparency = 0.8
			NADE.CanCollide = false
			local COLORS = {
				C3(0.8862745098039215, 0.6078431372549019, 0.25098039215686274),
				C3(1, 0, 0),
				C3(0.9607843137254902, 0.803921568627451, 0.18823529411764706)
			}
			WACKYEFFECT({
				Time = 66,
				EffectType = "Sphere",
				Size = VT(45, 45, 45),
				Size2 = VT(450, 450, 450),
				Transparency = 0.99,
				Transparency2 = 1,
				CFrame = CF(NADE.Position),
				MoveToPos = nil,
				RotationX = 0,
				RotationY = 0,
				RotationZ = 0,
				Material = "Neon",
				Color = C3(1, 1, 1),
				SoundID = nil,
				SoundPitch = nil,
				SoundVolume = nil
			})
			--for i = 1, 45 do
			--	WACKYEFFECT({
			--		Time = MRANDOM(10, 60),
			--		EffectType = "Sphere",
			--		Size = VT(45, 45, 45) * MRANDOM(5, 12) / 10,
			--		Size2 = VT(65, 65, 65) * MRANDOM(5, 22) / 10,
			--		Transparency = 0,
			--		Transparency2 = 1,
			--		CFrame = CF(NADE.Position) * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 15, 0),
			--		MoveToPos = nil,
			--		RotationX = 0,
			--		RotationY = 0,
			--		RotationZ = 0,
			--		Material = "Neon",
			--		Color = COLORS[MRANDOM(1, #COLORS)],
			--		SoundID = nil,
			--		SoundPitch = nil,
			--		SoundVolume = nil
			--	})
	        -- end

			--ApplyAoE(NADE.Position, 75, 35, 80, 145, false)
			--SHAKECAM(NADE.Position, 160, 12, 25)
			CreateSound(174580476, NADE, 10, 1, false)
			CreateSound(165970126, NADE, 6, 1, false)
			Debris:AddItem(NADE, 10)
		end)
	end))
	for i = 0, 0.3, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(0 - 5 * COS(SINE / 24)), RAD(-5), RAD(15)), 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.2 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(10)) * LEFTSHOULDERC0, 2 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(-5), RAD(-80), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end
function AttackTemplate()
	ATTACK = true
	Rooted = false
	for i = 0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(25 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(15)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE - 0.05 * SIZE * SIN(SINE / 24), 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end
function MouseDown(Mouse)
	if ATTACK == false then
		Fury()
	end
end
function MouseUp(Mouse)
	HOLD = false
end
function KeyDown(Key)
	KEYHOLD = true
	if Key == "f" and ATTACK == false then
		EquipGun()
	end
	if Key == "c" and ATTACK == false then
		BearTrap()
	end
	if Key == "v" and ATTACK == false then
		HandGrenade()
	end
	if Key ~= "x" or ATTACK == false then
	end
end
function KeyUp(Key)
	KEYHOLD = false
end
Mouse.Button1Down:connect(function(NEWKEY)
	MouseDown(NEWKEY)
end)
Mouse.Button1Up:connect(function(NEWKEY)
	MouseUp(NEWKEY)
end)
Mouse.KeyDown:connect(function(NEWKEY)
	KeyDown(NEWKEY)
end)
Mouse.KeyUp:connect(function(NEWKEY)
	KeyUp(NEWKEY)
end)
function unanchor()
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and c ~= RootPart then
			c.Anchored = false
		end
	end
	if UNANCHOR == true then
		RootPart.Anchored = false
	else
		RootPart.Anchored = true
	end
end
Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and Disable_Jump == true then
		Humanoid.Jump = false
	end
end)



if #blocklimbs >= 2 and #coverblocks >= 16 then
    local coverIndex = 1
    for limbIndex = 1, 2 do
        local limbBlock = blocklimbs[limbIndex]
        for offsetIndex = 1, 8 do
            if coverIndex <= #coverblocks then
                weld(coverblocks[coverIndex], limbBlock, coverOffsets[offsetIndex])
                coverIndex += 1
            end
        end
    end
    print("Total cover blocks attached (set 1):", coverIndex - 1)
end

if #blocklimbs2 >= 2 and #coverblocks2 >= 16 then
    local coverIndex = 1
    for limbIndex = 1, 2 do
        local limbBlock = blocklimbs2[limbIndex]
        for offsetIndex = 1, 8 do
            if coverIndex <= #coverblocks2 then
                weld(coverblocks2[coverIndex], limbBlock, coverOffsets[offsetIndex])
                coverIndex += 1
            end
        end
    end
    print("Total cover blocks attached (set 2):", coverIndex - 1)
end

if #blocklimbs >= 2 and #blocklimbs2 >= 2 and #exposedparts >= 16 then
    local exposeIndex = 1

    for limbIndex = 1, 2 do
        local limbBlock = blocklimbs[limbIndex]
        for offsetIndex = 1, 4 do
            weld(exposedparts[exposeIndex], limbBlock, exposeoffset[offsetIndex])
            exposeIndex += 1
        end
    end

    for limbIndex = 1, 2 do
        local limbBlock = blocklimbs2[limbIndex]
        for offsetIndex = 1, 4 do
            weld(exposedparts[exposeIndex], limbBlock, exposeoffset[offsetIndex])
            exposeIndex += 1
        end
    end

    print("Total expose parts attached:", exposeIndex - 1)
end



if #blocklimbs >= 2 and #blocklimbs2 >= 2 and #diamondstripparts >= 32 then
    local diamondIndex = 1

    for limbIndex = 1, 2 do
        local limbBlock = blocklimbs[limbIndex]
        for offsetIndex = 1, 8 do
            weld(diamondstripparts[diamondIndex], limbBlock, diamondOffsets[offsetIndex])
            diamondIndex += 1
        end
    end

    for limbIndex = 1, 2 do
        local limbBlock = blocklimbs2[limbIndex]
        for offsetIndex = 1, 8 do
            weld(diamondstripparts[diamondIndex], limbBlock, diamondOffsets[offsetIndex])
            diamondIndex += 1
        end
    end

    print("Total diamond strip parts attached:", diamondIndex - 1)
end





for i = 1, #torsoOffset do
    weld(torsoparts[i], torsopart, torsoOffset[i])
end

for i = 1, #capeOffset do
    weld(capeparts[i], torsopart, capeOffset[i])
end

for i = 1, #hatoffset do 
    weld(capeparts[i+8], headpart, hatoffset[i])
end

for i = 1, #eyeparts2 do 
    unweld(eyeparts2[i])
end

for i = 1, #hornparts do 
    unweld(hornparts[i])
end


--for i = 1, #trapparts2 do 
--    unweld(trapparts2[i])
--end
--



--local headblock = workspace["Ru2ez9z8dh Aircraft"]["Cylinder 2x2"].Part
--
--weld(headblock,headpart , CFrame.new(0,0,0)* CFrame.Angles(0,0,-90))
weld(myaircraft.HalfCylinder1p52.Part, headpart , CFrame.new(1,0,0)* CFrame.Angles(0,0,math.rad(-90)))
weld(myaircraft.Cylinder1p5.Part, headpart , CFrame.new(-0.5,0,0.2)* CFrame.Angles(math.rad(90),math.rad(0),math.rad(-90)))

weld(eyeparts[1], headpart , CFrame.new(-1.7,-0.5,-0.7) * CFrame.Angles(math.rad(0),math.rad(-5),math.rad(0)))
weld(eyeparts[2], headpart , CFrame.new(-1.7,-0.5,0.7) * CFrame.Angles(math.rad(0),math.rad(5),math.rad(0)))

weld(eyeparts2[1], eyeparts[1] , CFrame.new(-0.3,0,0) * CFrame.Angles(math.rad(0),math.rad(35),math.rad(0)))
weld(eyeparts2[2], eyeparts[2] , CFrame.new(-0.3,0,0) * CFrame.Angles(math.rad(0),math.rad(-35),math.rad(0)))




local gunpart = myaircraft.WingLight.Part
print("Gun Part:", gunpart)
for i = 1, #gunOffset1 do
    weld(gunparts1[i], gunpart, gunOffset1[i])
end

for i = 1, #gunOffset1-12 do
    weld(gunparts15[i], gunpart, gunOffset1[i+12])
end

for i = 1, 3 do
    weld(gunparts2[i], gunpart, gunOffset2[i])
end

weld(gunparts25[1], gunpart, gunOffset2[4])

--for i = 1, 20 do 
--    weld(hornparts[i], headpart, CFrame.new(i/5+5,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)))
--end
--
---- Gun CFrame Attachment
local gunpart = myaircraft.WingLight.Part
local dummy = workspace[player.Name].Dummy

local char = workspace[player.Name].Dummy
if char then
    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 0.9
        end
    end
end

print("Script completed!")




--local visualtrap = workspace["Ru2ez9z8dh Aircraft"].PlateCylinder.Part
--weld(visualtrap, torsopart, CFrame.new(0, 0, -5) * CFrame.Angles(math.rad(-45), math.rad(0), math.rad(0)))
--
weld(speaker1, torsopart, CFrame.new(0, 0, 0))
weld(speaker2, torsopart, CFrame.new(0, 0, 0))
weld(speaker3, torsopart, CFrame.new(0, 0, 0))


--while true do
--    task.wait()
--    local dummyGun = dummy:FindFirstChild("Gun") or dummy:GetChildren()[10].Gun
--    gunpart.CFrame = dummyGun.CFrame * CFrame.new(0,0.2,0.3) * CFrame.Angles(math.rad(0),math.rad(90),math.rad(0))
--end

-- Gun and Stone Parts CFrame Attachment
local gunpart = myaircraft.WingLight.Part -- change later to better path
local dummy = workspace[player.Name].Dummy

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local gunpart = myaircraft.WingLight.Part
local dummy = workspace[player.Name].Dummy


local isShooting = false

-- shoot function
--local function shootBullet()
--	if isShooting then return end
--	isShooting = true
--
--	bulletpart.CFrame = CFrame.new(mouse.Hit.Position)
--	task.wait(0.1) -- tiny wait
--	bulletpart.CFrame = gunpart.CFrame
--
--	isShooting = false
--end

local function shootBullet()
	if isShooting then return end
	isShooting = true

	bulletpart.CFrame = CFrame.new(mouse.Hit.Position)

	-- spin logic
	bulletpart.Anchored = false
	bulletpart.AssemblyAngularVelocity = Vector3.new(0, 5000, 0) 

	task.wait(0.15)

	-- stop spinning
	bulletpart.AssemblyAngularVelocity = Vector3.zero
	bulletpart.CFrame = gunpart.CFrame

	isShooting = false
end

-- click detection
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if sikis then
			shootBullet()
		end
	end
end)


--while true do
--	task.wait()
--
--	local dummyGun = dummy:FindFirstChild("Gun") or dummy:GetChildren()[10].Gun
--	gunpart.CFrame = dummyGun.CFrame * CFrame.new(0, 0.2, 0.3) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
--
--	local debrisParts = {}
--	for i, child in pairs(dummy:GetChildren()[10]:GetChildren()) do
--		if child.Name == "stoneparts" then
--			table.insert(debrisParts, child)
--		end
--	end
--
--	for i, stonePart in pairs(stoneparts) do
--		if debrisParts[i] then
--			stonePart.CFrame = debrisParts[i].CFrame * CFrame.new(0, 0, 0)
--		else
--			stonePart.CFrame = dummy.HumanoidRootPart.CFrame * CFrame.new(0, -20, 0)
--		end
--	end
--
--	-- bullet stays at gun tip when not shooting
--    if not isShooting then
--        bulletpart.CFrame = gunpart.CFrame * CFrame.Angles(0, math.rad(-90), 0)
--	end
--end
--




while true do
	Swait()
	script.Parent = WEAPONGUI
	ANIMATE.Parent = nil
	for _, v in next, Humanoid:GetPlayingAnimationTracks() do
		v:Stop()
	end
	SINE = SINE + CHANGE
	Humanoid.HipHeight = 0.4
	Humanoid.JumpPower = 150
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR = Raycast(RootPart.Position, CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector, 4 * SIZE, Character)
	local WALKSPEEDVALUE = 10 / (Humanoid.WalkSpeed / 16)
	if ANIM == "Walk" and TORSOVELOCITY > 1 then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.15 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5 * SIZE, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5 * SIZE, 0.885 * SIZE - 0.125 * SIZE * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), 0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5 * SIZE, 0.885 * SIZE + 0.125 * SIZE * SIN(SINE / WALKSPEEDVALUE) - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), 0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(35 * COS(SINE / WALKSPEEDVALUE))), 0.6 / Animation_Speed)
	elseif ANIM ~= "Walk" or TORSOVELOCITY < 1 then
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0.2) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5 * SIZE, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5 * SIZE, 1 * SIZE, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5 * SIZE, 1 * SIZE, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE, 0 * SIZE) * ANGLES(RAD(-40), RAD(0), RAD(20)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE, 0 * SIZE) * ANGLES(RAD(-40), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE, -0.3 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE, -0.3 * SIZE) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(20)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 * SIZE) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5 * SIZE, 0.5 * SIZE, 0 * SIZE) * ANGLES(RAD(-10), RAD(0), RAD(25)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5 * SIZE, 0.5 * SIZE, 0 * SIZE) * ANGLES(RAD(-10), RAD(0), RAD(-25)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -0.8 * SIZE, -0.3 * SIZE) * ANGLES(RAD(-25), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, 0 + 0.05 * SIZE * COS(SINE / 24)) * ANGLES(RAD(0), RAD(0), RAD(15)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(10 - 5 * COS(SINE / 24)), RAD(-5), RAD(-5)), 1 / Animation_Speed)
			if EQUIPPED == false then
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1 * SIZE, 0.55 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.75 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(45), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1 * SIZE, 0.25 * SIZE - 0.05 * SIZE * SIN(SINE / 24), -0.5 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			else
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1 * SIZE, 0.5 * SIZE, -0.5 * SIZE) * ANGLES(RAD(45), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1 * SIZE, 0.5 * SIZE, -0.8 * SIZE) * ANGLES(RAD(45), RAD(0), RAD(50)) * CF(0, 0.1 * SIZE, 0) * LEFTSHOULDERC0, 1 / Animation_Speed)
			end
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(65), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE - 0.05 * SIZE * COS(SINE / 24), -0.01 * SIZE) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-4), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0 * SIZE, 0 * SIZE, -0.1 * SIZE) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + (1 * SIZE - 1)) * ANGLES(RAD(5), RAD(0), RAD(0)), 1 / Animation_Speed)
			if EQUIPPED == false then
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1 * SIZE, 0.55 * SIZE + 0.05 * SIZE * COS(SINE / (WALKSPEEDVALUE / 2)), -0.75 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(-90)) * ANGLES(RAD(0), RAD(45), RAD(0)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1 * SIZE, 0.25 * SIZE + 0.05 * SIZE * COS(SINE / (WALKSPEEDVALUE / 2)), -0.5 * SIZE) * ANGLES(RAD(25), RAD(0), RAD(80)) * ANGLES(RAD(0), RAD(45), RAD(0)) * LEFTSHOULDERC0, 1 / Animation_Speed)
			else
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1 * SIZE, 0.5 * SIZE + 0.05 * SIZE * COS(SINE / (WALKSPEEDVALUE / 2)), -0.5 * SIZE) * ANGLES(RAD(45), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1 * SIZE, 0.5 * SIZE + 0.05 * SIZE * COS(SINE / (WALKSPEEDVALUE / 2)), -0.8 * SIZE) * ANGLES(RAD(45), RAD(0), RAD(50)) * CF(0, 0.1 * SIZE, 0) * LEFTSHOULDERC0, 1 / Animation_Speed)
			end
			RightHip.C0 = Clerp(RightHip.C0, CF(1 * SIZE, -1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1 * SIZE, -1 * SIZE, 0 * SIZE) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
		end
	end
	for E = 1, #TAIL do
		TAIL[E].C1 = Clerp(TAIL[E].C1, CF(0, 0, 0) * ANGLES(RAD(-2 * COS(SINE / 48) + 1 * SIN(SINE / 12)), RAD(0), RAD(1 * SIN(SINE / 24))), 1 / Animation_Speed)
	end
	unanchor()
	Humanoid.MaxHealth = 1000
	Humanoid.Health = 1000
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	for _, c in pairs(Character:GetChildren()) do
		if c.ClassName == "Part" and c.Name ~= "Eye" then
			c.Material = "Granite"
			if c:FindFirstChildOfClass("ParticleEmitter") then
				c:FindFirstChildOfClass("ParticleEmitter"):remove()
			end
			c.Color = C3(0.3137254901960784, 0.2627450980392157, 0.2627450980392157)
			if c == Head and c:FindFirstChild("face") then
				c.face:remove()
			end
		elseif c.ClassName == "CharacterMesh" or c.ClassName == "Accessory" or c.Name == "Body Colors" then
			c:remove()
		elseif (c.ClassName == "Shirt" or c.ClassName == "Pants") and c.Name ~= "Cloth" then
			c:remove()
		end
	end

    --part 3
	local dummyGun = dummy:FindFirstChild("Gun") or dummy:GetChildren()[10].Gun
	gunpart.CFrame = dummyGun.CFrame * CFrame.new(0, 0.2, 0.3) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))

	local debrisParts = {}
	for i, child in pairs(dummy:GetChildren()[10]:GetChildren()) do
		if child.Name == "stoneparts" then
			table.insert(debrisParts, child)
		end
	end

	for i, stonePart in pairs(stoneparts) do
		if debrisParts[i] then
			stonePart.CFrame = debrisParts[i].CFrame * CFrame.new(0, 0, 0)
		else
			stonePart.CFrame = dummy.HumanoidRootPart.CFrame * CFrame.new(0, -20, 0)
		end
	end

	-- bullet stays at gun tip when not shooting
    if not isShooting then
        bulletpart.CFrame = gunpart.CFrame * CFrame.Angles(0, math.rad(-90), 0)
	end

	Humanoid.DisplayDistanceType = "None"
	--Humanoid.Name = "NONHUM"
	--if sick.Parent ~= game.Workspace[Player.Name].Dummy then -- dummy
	--	sick = IT("Sound", game.Workspace[Player.Name].Dummy) --dummy
	--end
	--sick.Name = "Music"
	----sick.SoundId = getcustomasset("Mr ByeBye.mp3")
	--sick.Looped = true
	--sick.Pitch = 0.9
	--sick.Volume = 3
	--sick.Playing = true
end

end
print("ran here")
end)
task.wait(1)
task.spawn(function()
print("ran part 2")

print(hatoffset)
print()
for i = 1, 10 do
	Swait()
	print("ran part 2."..i)
end

    end)
