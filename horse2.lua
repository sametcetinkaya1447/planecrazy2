-- HORSE SCRIPT CREATED BY SHACKLUSTER CONVERTED BY ME

if game.Workspace:FindFirstChild("horse") then
    print("horse found")
    game.Workspace.horse:Destroy()
end


Breeds = {
	{fur = BrickColor.new("Reddish brown"), mane = BrickColor.new("Really black"), saddle = BrickColor.new("Really black"), reins = BrickColor.new("Really black"), hoof = BrickColor.new("Really black")},
	{fur = BrickColor.new("Institutional white"), mane = BrickColor.new("White"), saddle = BrickColor.new("Really black"), reins = BrickColor.new("Really black"), hoof = BrickColor.new("Really black")},
	{fur = BrickColor.new("Really black"), mane = BrickColor.new("New yeller"), saddle = BrickColor.new("Dark stone grey"), reins = BrickColor.new("Really black"), hoof = BrickColor.new("Really black")},
	{fur = BrickColor.new("Institutional white"), mane = BrickColor.new("Magenta"), saddle = BrickColor.new("Burnt Sienna"), reins = BrickColor.new("Really black"), hoof = BrickColor.new("Really black")}
}

Ply = game.Players.LocalPlayer
Cha = Ply.Character
local Breed = Breeds[math.random(1, #Breeds)]
local ModelName = "horse"
local ModelParent = workspace
local Height = 6.2
local HorseColor = Breed.fur
local EyeColor = BrickColor.new("Really black")
local ManeColor = Breed.mane
local SaddleColor = Breed.saddle
local ReinsColor = Breed.reins
local HoofColor = Breed.hoof
local Speed = 0
local WalkSpeed = 15
local WalkSin = 6
local TrotSpeed = 30
local TrotSin = 4
local MaxSpeed = 120
local SpeedLimit = 120
local startpos = Cha.Head.CFrame * CFrame.new(0, Height + 1.5, 10)

math.randomseed(tick())
math.random()
math.random()
math.random()

aran = function()
	return math.random()
end

ran = function()
	return (math.random() - 0.5) * 2
end

Weld = function(a, b, c, d)
	local w = Instance.new("Weld", a)
	w.Part0 = a
	w.Part1 = b
	if not c then
		w.C0 = CFrame.new()
	else
		w.C0 = c
	end
	if not d then
		w.C1 = CFrame.new()
	else
		w.C1 = d
	end
	return w
end

function clerp(a,b,t) 
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)} 
	local ax, ay, az = a.x, a.y, a.z 
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1-t
	return QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t)) 
end 

function QuaternionFromCFrame(cf) 
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
	local trace = m00 + m11 + m22 
	if trace > 0 then 
		local s = math.sqrt(1 + trace) 
		local recip = 0.5/s 
		return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5 
	else 
		local i = 0 
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then 
			i = 2 
		end 
		if i == 0 then 
			local s = math.sqrt(m00-m11-m22+1) 
			local recip = 0.5/s 
			return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip 
		elseif i == 1 then 
			local s = math.sqrt(m11-m22-m00+1) 
			local recip = 0.5/s 
			return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip 
		elseif i == 2 then 
			local s = math.sqrt(m22-m00-m11+1) 
			local recip = 0.5/s 
			return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip 
		end 
	end 
end

function QuaternionToCFrame(px, py, pz, x, y, z, w) 
	local xs, ys, zs = x + x, y + y, z + z 
	local wx, wy, wz = w*xs, w*ys, w*zs 
	local xx = x*xs 
	local xy = x*ys 
	local xz = x*zs 
	local yy = y*ys 
	local yz = y*zs 
	local zz = z*zs 
	return CFrame.new(px, py, pz,1-(yy+zz), xy - wz, xz + wy,xy + wz, 1-(xx+zz), yz - wx, xz - wy, yz + wx, 1-(xx+yy)) 
end

function QuaternionSlerp(a, b, t) 
	local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] 
	local startInterp, finishInterp; 
	if cosTheta >= 0.0001 then 
		if (1 - cosTheta) > 0.0001 then 
			local theta = math.acos(cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((1-t)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta  
		else 
			startInterp = 1-t 
			finishInterp = t 
		end 
	else 
		if (1+cosTheta) > 0.0001 then 
			local theta = math.acos(-cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((t-1)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta 
		else 
			startInterp = t-1 
			finishInterp = t 
		end 
	end 
	return a[1]*startInterp + b[1]*finishInterp, a[2]*startInterp + b[2]*finishInterp, a[3]*startInterp + b[3]*finishInterp, a[4]*startInterp + b[4]*finishInterp 
end

local Model = Instance.new("Model", ModelParent)
Model.Name = ModelName
local BasePart = Instance.new("Part")
BasePart.Material = "SmoothPlastic"
BasePart.FormFactor = "Custom"
BasePart.Size = Vector3.new()
BasePart.TopSurface = 10
-- MODIFIED: Default all parts to No Collision
BasePart.CanCollide = false 
BasePart:BreakJoints()
BasePart.CFrame = startpos

NP = function()
	local p = BasePart:Clone()
	p.Parent = Model
	return p
end

Sphere = function(parent, scale)
	local sm = Instance.new("SpecialMesh", parent)
	sm.MeshType = "Sphere"
	if not scale then
		sm.Scale = Vector3.new(1, 1, 1)
		return sm
	end
end

BasePart.BrickColor = HorseColor
local Main = NP()
Main.Size = Vector3.new(3.5, 4.5, 8)
Main.CFrame = startpos
MainMesh = Sphere(Main)

local Neck = NP()
Neck.Size = Vector3.new(2, 5, 2.5)
local NeckWeld = Weld(Main, Neck, CFrame.new(0, 0.5, -3.2) * CFrame.Angles(math.rad(-20), 0, 0), CFrame.new(0, -1.5, 0))
local NeckWeld0 = NeckWeld.C0
Sphere(Neck, Vector3.new(1, 1, 1))

local NeckBonus = NP()
NeckBonus.Size = Vector3.new(1.9, 3, 2)
Weld(Neck, NeckBonus, CFrame.new(0, -1.1, 0.5) * CFrame.Angles(-0.5, 0, 0))
Sphere(NeckBonus)

local Head = NP()
Head.Size = Vector3.new(2, 3, 3)
local HeadWeld = Weld(Neck, Head, CFrame.new(0, 2.5, -0.4), CFrame.new(0, 0, 1))
local HeadWeld0 = HeadWeld.C0
local HeadMesh = Instance.new("SpecialMesh", Head)
HeadMesh.Scale = Vector3.new(0.7, 1, 1) * 1.6
HeadMesh.MeshId = "http://www.roblox.com/asset/?id=114690930"

-- Eyes
local EyeR = NP()
EyeR.BrickColor = EyeColor
EyeR.Reflectance = 0.1
EyeR.Size = Vector3.new(0.2, 0.2, 0.2)
Weld(Head, EyeR, CFrame.new(0.631, 0.23, 0.11) * CFrame.Angles(-0.2, 0.1, 0))
Sphere(EyeR, Vector3.new(0.9, 2.1, 2.1))

local EyeL = NP()
EyeL.BrickColor = EyeColor
EyeL.Reflectance = 0.1
EyeL.Size = Vector3.new(0.2, 0.2, 0.2)
Weld(Head, EyeL, CFrame.new(-0.631, 0.23, 0.11) * CFrame.Angles(-0.2, -0.1, 0))
Sphere(EyeL, Vector3.new(0.9, 2.1, 2.1))

-- Tail
local Tail = NP()
Tail.BrickColor = ManeColor
Tail.Transparency = 1
Tail.Size = Vector3.new(0.8, 4.5, 0.8)
local TailWeld = Weld(Main, Tail, CFrame.new(0, 0.88, 3.4) * CFrame.Angles(0, math.rad(10), 0), CFrame.new(0, -2.3, 0) * CFrame.Angles(math.rad(-130), 0, 0))
local TailWeld0 = TailWeld.C0
local TailHairs = {}

for i = 1, 8 do
	local t = NP()
	t.BrickColor = Tail.BrickColor
	t.Size = Vector3.new(0.4 + aran() * 0.2, 5.5 - i * 0.1, 0.4 + aran() * 0.2)
	local tw = Weld(Tail, t, CFrame.new(0, -Tail.Size.Y / 2, 0) * CFrame.Angles(ran() * 0.15, ran() * 0.5, ran() * 0.15) * CFrame.new(ran() * 0.1, 0, ran() * 0.1), CFrame.new(0, -t.Size.Y / 2 + 0.05, 0))
	table.insert(TailHairs, {w = tw, c0 = tw.C0})
end

-- Mane hairs
local BackHairs = {}
for i = 0, 10 do
	if i < 1 or i > 7 then
		local x = i / 10
		local m = NP()
		m.BrickColor = ManeColor
		m.Size = Vector3.new(0.6 + aran() * 0.2 + math.sin(x * 2.7) * 0.5, 0.9 + ran() * 0.1, 0.9 + ran() * 0.1)
		if i < 1 then
			m.Size = m.Size * 0.7
		end
		local tw = Weld(Main, m, CFrame.new(0, 0.9 + math.sin(x * 2.8) * 1.2, 3.4 - x * 6), CFrame.Angles(ran() * 0.1, aran() * 0.1, ran() * 0.2))
		table.insert(BackHairs, {w = tw, c0 = tw.C0})
	end
end

local NeckHairs = {}
for i = 0, 6 do
	local x = i / 6
	local m = NP()
	m.BrickColor = ManeColor
	m.Size = Vector3.new(0.8 + ran() * 0.2, 0.7 + ran() * 0.1, 0.9 + ran() * 0.1)
	local tw = Weld(Neck, m, CFrame.new(0, -1.3 + x * 3.5, 1 + math.sin(0.55 + x * 3.7) * 0.5), CFrame.Angles(ran() * 0.08, aran() * 0.15, ran() * 0.08))
	table.insert(NeckHairs, {w = tw, c0 = tw.C0})
end

local HeadHairs = {}
for i = 0, 6 do
	local x = math.min(1, i / 3)
	local m = NP()
	m.BrickColor = ManeColor
	m.Size = Vector3.new(0.95 + ran() * 0.2, 1, 0.4)
	local tw = Weld(Head, m, CFrame.new(0, -0.8 + x * 1.6, 2.02 - i * 0.23) * CFrame.Angles(-0.2 - i * 0.3, 0, 0), CFrame.Angles(ran() * 0.08, aran() * 0.03, ran() * 0.08))
	table.insert(HeadHairs, {w = tw, c0 = tw.C0})
end

-- Back legs
local LHip = NP()
LHip.Size = Vector3.new(1.5, 3.7, 3.5)
Weld(Main, LHip, CFrame.new(-1, -0.5, 2.2) * CFrame.Angles(0, 0.35, 0))
Sphere(LHip)

local LThigh = NP()
LThigh.Size = Vector3.new(1.6, 4, 2.2)
local BL1 = Weld(LHip, LThigh, CFrame.new(-0.05, 0.3, -0.5) * CFrame.Angles(0, -0.35, 0) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.7, 0))
Sphere(LThigh)

local LBCannon = NP()
LBCannon.Size = Vector3.new(1, 2.8, 1)
local sm = Instance.new("SpecialMesh", LBCannon)
sm.MeshType = "Head"
local BL2 = Weld(LThigh, LBCannon, CFrame.new(0, -LThigh.Size.Y / 2 + 0.4, -0.05) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.3, 0))

local LBKnee = NP()
LBKnee.Size = Vector3.new(1, 1, 1)
local sm = Instance.new("SpecialMesh", LBKnee)
sm.MeshType = "Sphere"
Weld(LBCannon, LBKnee, CFrame.new(0, LBCannon.Size.Y / 2 - 0.1, 0))

local LBHoof = NP()
LBHoof.BrickColor = HoofColor
LBHoof.CanCollide = true 
LBHoof.Size = Vector3.new(1, 0.7, 1)
Instance.new("CylinderMesh", LBHoof)
local BL3 = Weld(LBCannon, LBHoof, CFrame.new(0, -LBCannon.Size.Y / 2, 0) * CFrame.Angles(0, 0, 0), CFrame.new(0, 0.12, 0.2))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.699, 0.5)
Weld(LBHoof, Hoof, CFrame.new(0.4, 0, 0.25))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.699, 0.5)
Weld(LBHoof, Hoof, CFrame.new(-0.4, 0, 0.25))

local RHip = NP()
RHip.Size = Vector3.new(1.5, 3.7, 3.5)
Weld(Main, RHip, CFrame.new(1, -0.5, 2.2) * CFrame.Angles(0, -0.35, 0))
Sphere(RHip)

local RThigh = NP()
RThigh.Size = Vector3.new(1.6, 4, 2.2)
local BR1 = Weld(RHip, RThigh, CFrame.new(0.05, 0.3, -0.4) * CFrame.Angles(0, 0.35, 0) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.7, 0))
Sphere(RThigh)

local RBCannon = NP()
RBCannon.Size = Vector3.new(1, 2.8, 1)
local sm = Instance.new("SpecialMesh", RBCannon)
sm.MeshType = "Head"
local BR2 = Weld(RThigh, RBCannon, CFrame.new(0, -RThigh.Size.Y / 2 + 0.4, -0.05) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.3, 0))

local RBKnee = NP()
RBKnee.Size = Vector3.new(1, 1, 1)
local sm = Instance.new("SpecialMesh", RBKnee)
sm.MeshType = "Sphere"
Weld(RBCannon, RBKnee, CFrame.new(0, RBCannon.Size.Y / 2 - 0.1, 0))

local RBHoof = NP()
RBHoof.BrickColor = HoofColor
RBHoof.CanCollide = true 
RBHoof.Size = Vector3.new(1, 0.7, 1)
Instance.new("CylinderMesh", RBHoof)
local BR3 = Weld(RBCannon, RBHoof, CFrame.new(0, -RBCannon.Size.Y / 2, 0) * CFrame.Angles(0, 0, 0), CFrame.new(0, 0.12, 0.2))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.699, 0.5)
Weld(RBHoof, Hoof, CFrame.new(0.4, 0, 0.25))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.699, 0.5)
Weld(RBHoof, Hoof, CFrame.new(-0.4, 0, 0.25))

-- Front legs
local LShoulder = NP()
LShoulder.Size = Vector3.new(1.5, 2.5, 2)
Weld(Main, LShoulder, CFrame.new(-0.9, -0.5, -2.4) * CFrame.Angles(0, 0.15, 0))
Sphere(LShoulder)

local LForearm = NP()
LForearm.Size = Vector3.new(1.2, 3.5, 1.5)
local FL1 = Weld(LShoulder, LForearm, CFrame.new(-0.1, 0.2, 0.1) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.45, 0))
Sphere(LForearm)

local LFCannon = NP()
LFCannon.Size = Vector3.new(0.8, 2.8, 0.8)
local sm = Instance.new("SpecialMesh", LFCannon)
sm.MeshType = "Head"
local FL2 = Weld(LForearm, LFCannon, CFrame.new(0, -LForearm.Size.Y / 2 + 0.4, -0.05) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.3, 0))

local LFKnee = NP()
LFKnee.Size = Vector3.new(0.8, 0.8, 0.8)
local sm = Instance.new("SpecialMesh", LFKnee)
sm.MeshType = "Sphere"
Weld(LFCannon, LFKnee, CFrame.new(0, LFCannon.Size.Y / 2 - 0.1, 0))

local LFHoof = NP()
LFHoof.BrickColor = HoofColor
LFHoof.CanCollide = true 
LFHoof.Size = Vector3.new(0.8, 0.6, 0.8)
Instance.new("CylinderMesh", LFHoof)
local FL3 = Weld(LFCannon, LFHoof, CFrame.new(0, -LFCannon.Size.Y / 2, 0) * CFrame.Angles(0, 0, 0), CFrame.new(0, 0.12, 0.2))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.599, 0.4)
Weld(LFHoof, Hoof, CFrame.new(0.3, 0, 0.2))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.599, 0.4)
Weld(LFHoof, Hoof, CFrame.new(-0.3, 0, 0.2))

local RShoulder = NP()
RShoulder.Size = Vector3.new(1.5, 2.5, 2)
Weld(Main, RShoulder, CFrame.new(0.9, -0.5, -2.4) * CFrame.Angles(0, -0.15, 0))
Sphere(RShoulder)

local RForearm = NP()
RForearm.Size = Vector3.new(1.2, 3.5, 1.5)
local FR1 = Weld(RShoulder, RForearm, CFrame.new(0.1, 0.2, -0.1) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.45, 0))
Sphere(RForearm)

local RFCannon = NP()
RFCannon.Size = Vector3.new(0.8, 2.8, 0.8)
local sm = Instance.new("SpecialMesh", RFCannon)
sm.MeshType = "Head"
local FR2 = Weld(RForearm, RFCannon, CFrame.new(0, -RForearm.Size.Y / 2 + 0.4, -0.05) * CFrame.Angles(0, 0, 0), CFrame.new(0, 1.3, 0))

local RFKnee = NP()
RFKnee.Size = Vector3.new(0.8, 0.8, 0.8)
local sm = Instance.new("SpecialMesh", RFKnee)
sm.MeshType = "Sphere"
Weld(RFCannon, RFKnee, CFrame.new(0, RFCannon.Size.Y / 2 - 0.1, 0))

local RFHoof = NP()
RFHoof.BrickColor = HoofColor
RFHoof.CanCollide = true 
RFHoof.Size = Vector3.new(0.8, 0.6, 0.8)
Instance.new("CylinderMesh", RFHoof)
local FR3 = Weld(RFCannon, RFHoof, CFrame.new(0, -RFCannon.Size.Y / 2, 0) * CFrame.Angles(0, 0, 0), CFrame.new(0, 0.12, 0.2))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.599, 0.4)
Weld(RFHoof, Hoof, CFrame.new(0.3, 0, 0.2))

local Hoof = NP()
Hoof.BrickColor = HoofColor
Hoof.Size = Vector3.new(0.2, 0.599, 0.4)
Weld(RFHoof, Hoof, CFrame.new(-0.3, 0, 0.2))

-- Seat
Seat = Instance.new("Seat", Model)
Seat.TopSurface = 10
Seat.Size = Vector3.new(3, 1.2, 0.5)
Seat.CanCollide = false
Seat:BreakJoints()
Seat.Transparency = 1
Seat.CFrame = Main.CFrame
SeatWeld = Weld(Main, Seat, CFrame.new(0, 2.5, -0.5), CFrame.new(0, 0, 0))
local SeatWeld0 = SeatWeld.C0

-- Saddle
SaddleMain = NP()
SaddleMain.Size = Vector3.new(2, 1, 3.5)
SaddleMain.BrickColor = SaddleColor
Sphere(SaddleMain)
Weld(Seat, SaddleMain, CFrame.new(0, -0.5, 0.6))

SaddleFront = NP()
SaddleFront.Size = Vector3.new(1.6, 1, 0.3)
SaddleFront.BrickColor = SaddleColor
Sphere(SaddleFront)
Weld(SaddleMain, SaddleFront, CFrame.new(0, 0.4, -1.4) * CFrame.Angles(math.rad(-30), 0, 0))

SaddleBack = NP()
SaddleBack.Size = Vector3.new(1.6, 1, 0.5)
SaddleBack.BrickColor = SaddleColor
Sphere(SaddleBack)
Weld(SaddleMain, SaddleBack, CFrame.new(0, 0.3, 1.4) * CFrame.Angles(math.rad(30), 0, 0))

SaddleFlankR = NP()
SaddleFlankR.Size = Vector3.new(0.3, 1.7, 1.8)
SaddleFlankR.BrickColor = SaddleColor
Sphere(SaddleFlankR)
Weld(SaddleMain, SaddleFlankR, CFrame.new(1.5, -0.8, 0), CFrame.new(0.1, -0.7, 0) * CFrame.Angles(0, 0, math.rad(-30)))

SaddleFlankL = NP()
SaddleFlankL.Size = Vector3.new(0.3, 1.7, 1.8)
SaddleFlankL.BrickColor = SaddleColor
Sphere(SaddleFlankL)
Weld(SaddleMain, SaddleFlankL, CFrame.new(-1.5, -0.8, 0), CFrame.new(-0.1, -0.7, 0) * CFrame.Angles(0, 0, math.rad(30)))


-- Control setup
local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local Throttle = 0
local Steer = 0

local keysPressed = {
	T = false,
	G = false,
	F = false,
	H = false
}

local function UpdateControls()
	if keysPressed.T and not keysPressed.G then
		Throttle = 1
	elseif keysPressed.G and not keysPressed.T then
		Throttle = -1
	else
		Throttle = 0
	end
	
	if keysPressed.F and not keysPressed.H then
		Steer = -1
	elseif keysPressed.H and not keysPressed.F then
		Steer = 1
	else
		Steer = 0
	end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	local key = input.KeyCode.Name
	if keysPressed[key] ~= nil then
		keysPressed[key] = true
		UpdateControls()
	end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
	local key = input.KeyCode.Name
	if keysPressed[key] ~= nil then
		keysPressed[key] = false
		UpdateControls()
	end
end)

-- Speed control keybinds (Z = Walk, X = Trot, V = Gallop)
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.Z then
		SpeedLimit = WalkSpeed
		print("Horse speed: Walk")
	elseif input.KeyCode == Enum.KeyCode.X then
		SpeedLimit = TrotSpeed
		print("Horse speed: Trot")
	elseif input.KeyCode == Enum.KeyCode.V then
		SpeedLimit = MaxSpeed
		print("Horse speed: Gallop")
	end
end)


local Filler = NP()
Filler.Size = Vector3.new(3, 4, 7)
Filler.Transparency = 1
Weld(Main, Filler, CFrame.new(0, -2, 0))

local BallB = NP()
BallB.CanCollide = true 
BallB.Shape = "Ball"
BallB.Size = Vector3.new(3, 3, 3)
BallB.Transparency = 1
local BBW = Weld(Main, BallB, CFrame.new(0, -Height + BallB.Size.Y / 2, 3))
BBW0 = BBW.C0

local BallF = NP()
BallF.CanCollide = true 
BallF.Shape = "Ball"
BallF.Size = Vector3.new(3, 3, 3)
BallF.Transparency = 1
local FBW = Weld(Main, BallF, CFrame.new(0, -Height + BallB.Size.Y / 2, -3))
FBW0 = FBW.C0

local BG = Instance.new("BodyGyro", Main)
BG.cframe = Main.CFrame
local bgcf = BG.cframe
BG.maxTorque = Vector3.new(1, 1, 1) * 4000000

local BF = Instance.new("BodyForce", Main)
BF.force = Vector3.new(0, 10000, 0)

local BV = Instance.new("BodyVelocity", Main)
BV.maxForce = Vector3.new(1, 1, 1) * 4000000
BV.velocity = Vector3.new()

local Legs = {FR1, FR2, FR3, FL1, FL2, FL3, BR1, BR2, BR3, BL1, BL2, BL3}
local Legs0 = {}
for i,v in pairs(Legs) do
	Legs0[i] = v.C0
end


local Player = game.Players.LocalPlayer
local aircraftModel = workspace:FindFirstChild(Player.Name .. " Aircraft")
local ignoreList = {Model}
if aircraftModel then
	table.insert(ignoreList, aircraftModel)
end

RayCast = function(Ray, Ignore)
	local hit, p = workspace:FindPartOnRayWithIgnoreList(Ray, Ignore)
	if not hit then
		return nil, Ray.Origin + Ray.Direction
	end
	if hit.CanCollide then
		return hit, p
	else
		table.insert(Ignore, hit)
		return RayCast(Ray, Ignore)
	end
end

local climbangle = 0
local blinktimer = 0
local connection = nil

connection = game:GetService("RunService").Stepped:connect(function()
	if not Model:IsDescendantOf(workspace) then
		pcall(game.Destroy, Model)
		connection:disconnect()
		return
	end
	
	local th = Throttle
	local st = Steer
	
	local TailSin = math.sin(tick() * (th == 1 and 0.5 + Speed / MaxSpeed * 6 or 2))
	local BreathSin = math.sin(tick() * 2)
	
	TailWeld.C0 = clerp(TailWeld.C0, TailWeld0 * CFrame.Angles(math.rad((th == 1 and 20 + math.min(1, Speed / MaxSpeed) * (-50 + TailSin * 10)) or (th == -1 and 25) or 20), 0, TailSin * 0.3), 0.15)
	
	if math.random(1, 150) == 1 then
		blinktimer = 4
	end
	
	if blinktimer > 0 then
		EyeR.BrickColor = HorseColor
		EyeL.BrickColor = HorseColor
		blinktimer = blinktimer - 1
	else
		EyeR.BrickColor = EyeColor
		EyeL.BrickColor = EyeColor
	end
	
	NeckWeld.C0 = clerp(NeckWeld.C0, CFrame.Angles(0, -st * 0.1, -st * 0.1) * NeckWeld0 * CFrame.Angles(math.rad(BreathSin * 2 + ((th == 1 and -math.min(1, math.max(0, Speed - 10) / (MaxSpeed - 10)) * 45) or (th == -1 and 10) or 0)), 0, 0), 0.15)
	HeadWeld.C0 = clerp(HeadWeld.C0, CFrame.Angles(0, -st * 0.3, -st * 0.1) * HeadWeld0 * CFrame.Angles(math.rad(BreathSin * -4 + ((th == 1 and 10) or (th == -1 and -30) or 0)), 0, 0), 0.15)
	
	MainMesh.Scale = Vector3.new(1, 1 + BreathSin * 0.025, 1)
	SeatWeld.C0 = SeatWeld0 + Vector3.new(0, BreathSin * 0.05, 0)
	
	bgcf = bgcf * CFrame.Angles(0, -st * 0.05, 0)
	BG.cframe = clerp(bgcf, bgcf * CFrame.Angles(0, 0, th == 1 and -st * (0.1 + Speed / MaxSpeed * 0.1) or 0), 0.1) * CFrame.Angles(climbangle, 0, -st * 0.25 * (Speed / MaxSpeed))
	
	Speed = math.max((th == -1 and -WalkSpeed) or (th == 1 and math.min(SpeedLimit, 10)) or 0, math.min(SpeedLimit, Speed + (th == 1 and 0.25 or -3)))
	
	local updown = math.max(0, (th == 1 and TrotSpeed < Speed and math.abs(math.sin((tick() - 0.1) * 3)) or 0) - 0.1)
	local front = Main.CFrame * CFrame.new(0, 0, -3)
	local back = Main.CFrame * CFrame.new(0, 0, 3)
	
	local fHit, fP = RayCast(Ray.new(front.p, front:vectorToWorldSpace(Vector3.new(0, -Height * 6, 0))), {unpack(ignoreList)})
	fP = fP or (front.p + Vector3.new(0, -Height, 0))
	local fDiff = (front.p - fP).magnitude
	if Height * 2 < fDiff then
		fHit = nil
	end
	local fY = math.max(fP.Y, front.Y - Height)
	
	local bHit, bP = RayCast(Ray.new(back.p, back:vectorToWorldSpace(Vector3.new(0, -Height * 6, 0))), {unpack(ignoreList)})
	bP = bP or (back.p + Vector3.new(0, -Height, 0))
	local bDiff = (back.p - bP).magnitude
	if Height * 2 < bDiff then
		bHit = nil
	end
	local bY = math.max(bP.Y, back.Y - Height)
	
	climbangle = climbangle * 0.5
	BV.velocity = (Main.CFrame.lookVector).unit * Speed + Vector3.new(0, -(math.min(fDiff - Height, bDiff - Height) + updown * 0.8) * 3, 0)
	BV.maxForce = Vector3.new(1, 1, 1) * 4000000
	BBW.C0 = BBW0 + Vector3.new(0, updown * 0.8, -1.4)
	FBW.C0 = FBW0 + Vector3.new(0, updown * 0.8, 1.4)
	
	-- Leg animation
	for i = 1, #Legs, 3 do
		local ang = 0
		local ang2 = 0
		local ang3 = 0
		local time = tick()
		
		if i < #Legs / 2 then
			if i % 6 == 1 then
				if th == 1 then
					if Speed <= WalkSpeed then
						ang = math.sin(time * WalkSin) * 0.15 + 0.05
						ang2 = -math.abs(math.cos(time * WalkSin / 2)) * 0.4
					elseif Speed <= TrotSpeed then
						ang = math.sin(time * TrotSin) * 0.5 + 0.4
						ang2 = -math.abs(math.cos(time * TrotSin / 2)) * 1.7
					else
						ang = math.sin(time * 6) * 0.8 + 0.35
						ang2 = -math.abs(math.cos(time * 3)) * 1.8
					end
				elseif th == -1 then
					ang = math.sin(time * 6) * 0.3 + 0.25
					time = time - 0.1
					ang2 = -math.abs(math.sin((time) * 3)) * 1.3 + 0.2
				end
			else
				if th == 1 then
					if Speed <= WalkSpeed then
						time = time + math.pi / WalkSin
						ang = math.sin((time) * WalkSin) * 0.15 + 0.05
						ang2 = -math.abs(math.cos((time) * WalkSin / 2)) * 0.4
					elseif Speed <= TrotSpeed then
						time = time + math.pi / TrotSin
						ang = math.sin((time) * TrotSin) * 0.5 + 0.4
						ang2 = -math.abs(math.cos((time) * TrotSin / 2)) * 1.7
					else
						time = time + 0.15
						ang = math.sin((time) * 6) * 0.8 + 0.35
						ang2 = -math.abs(math.cos((time) * 3)) * 1.8
					end
				elseif th == -1 then
					time = time + math.pi / 2
					ang = math.sin((time) * 6) * 0.3 + 0.25
					time = time - 0.1
					ang2 = -math.abs(math.sin((time) * 3)) * 1.3 + 0.2
				end
			end
		elseif i % 6 == 1 then
			if th == 1 then
				if Speed <= WalkSpeed then
					ang = math.sin((time) * WalkSin) * 0.1 - 0.6
					ang2 = math.abs(math.cos((time) * WalkSin / 2)) * 0.5 + 0.4
				elseif Speed <= TrotSpeed then
					ang = math.sin((time) * TrotSin) * 0.5 - 0.8
					ang2 = math.abs(math.cos((time) * TrotSin / 2)) * 1.4 - 0.1
					ang3 = ang2 - 1
				else
					time = time + math.pi / 2
					ang = math.sin((time) * 6) * 0.5 - 0.8
					ang2 = math.abs(math.cos((time) * 3)) * 1.4 - 0.1
					ang3 = ang2 - 1
				end
			elseif th == -1 then
				ang = math.sin((time) * 6) * 0.2 - 0.6
				time = time - 0.5
				ang2 = math.abs(math.cos((time) * 3)) * 1.4 - 0.1
				ang3 = math.sin((time) * 6) * 0.2
			else
				ang = -0.5
				ang2 = 0.65
				ang3 = -0.15
			end
		else
			if th == 1 then
				if Speed <= WalkSpeed then
					time = time + math.pi / WalkSin
					ang = math.sin((time) * WalkSin) * 0.1 - 0.7
					ang2 = math.abs(math.cos((time) * WalkSin / 2)) * 0.5 + 0.4
				elseif Speed <= TrotSpeed then
					time = time - math.pi / TrotSin
					ang = math.sin((time) * TrotSin) * 0.5 - 0.8
					ang2 = math.abs(math.cos((time) * TrotSin / 2)) * 1.4 - 0.1
					ang3 = ang2 - 1
				else
					time = time + math.pi / 2 - 0.15
					ang = math.sin((time) * 6) * 0.5 - 0.8
					ang2 = math.abs(math.cos((time) * 3)) * 1.4 - 0.1
					ang3 = ang2 - 1
				end
			elseif th == -1 then
				time = time + math.pi / 2
				ang = math.sin((time) * 6) * 0.2 - 0.6
				time = time - 0.5
				ang2 = math.abs(math.cos((time) * 3)) * 1.4 - 0.1
				ang3 = math.sin((time) * 6) * 0.2
			else
				ang = -0.55
				ang2 = 0.65
				ang3 = -0.1
			end
		end
		
		Legs[i].C0 = clerp(Legs[i].C0, Legs0[i] * CFrame.Angles(ang, 0, 0), 0.2)
		Legs[i + 1].C0 = clerp(Legs[i + 1].C0, Legs0[i + 1] * CFrame.Angles(ang2, 0, 0), 0.2)
		Legs[i + 2].C0 = clerp(Legs[i + 2].C0, Legs0[i + 2] * CFrame.Angles(ang3, 0, 0), 0.2)
	end
	
	for i,v in pairs(BackHairs) do
		v.w.C0 = v.c0 * CFrame.Angles(math.sin(BreathSin + i) * 0.05, math.sin(BreathSin + i ^ 2) * 0.05, math.sin(BreathSin + i ^ 3) * 0.05) + Vector3.new(0, BreathSin * 0.05, 0)
	end
end)

-- Destroy command
Player.Chatted:Connect(function(Message)
	if Message:match("g/sr") then
		if workspace:FindFirstChild("horse") then
			workspace.horse:Destroy()
		end
	end
end)

if game.Workspace:FindFirstChild("horse") then
    print("horse found")
    for i, v in pairs(game.Workspace.horse:GetChildren()) do
        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("Seat") then
            v.Transparency = 0.999
        end
    end
end

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Horse spawned!",
    Text = "Use T F G H to control. Type 'g/sr' to remove. Z X V to change speed",
    Duration = 5
})


task.wait(2)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

if Workspace:FindFirstChild("horse") then
    print("horse found")
    for i, v in pairs(Workspace.horse:GetChildren()) do
        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("Seat") then
            v.Transparency = 0.99
        end
    end
end

local player = Players.LocalPlayer
local characterName = player.Character and player.Character.Name or "Ru2ez9z8dh"
local myaircraft = Workspace:FindFirstChild(characterName .. " Aircraft") or Workspace["Ru2ez9z8dh Aircraft"]
local aircraftModel = Workspace:FindFirstChild(player.Name .. " Aircraft")

if not myaircraft then 
    warn("Aircraft not found!")
    return 
end

local toeparts = {}
local feetparts1 = {}
local feetparts2 = {}
local rounderparts = {}
local mouth2part = {}
local tailparts = {}
local eyeparts = {}
local hairparts = {}

local torsopart = nil
local neckpart = nil
local mouth1part = nil
local seat1 = nil
local seat2 = nil

for _, v in pairs(myaircraft:GetDescendants()) do
    if v.Name == "Wheel" and v.Parent.Name == "GearTiny" and v.Color == Color3.fromRGB(17,17,17) then
        table.insert(toeparts, v)
    elseif v.Name == "Part" and v.Parent.Name == "Rod" and v.Color == Color3.fromRGB(105,64,40) then
        table.insert(feetparts1, v)
    elseif v.Name == "Part" and v.Parent.Name == "Rod" and v.Color == Color3.fromRGB(105,60,40) then
        table.insert(feetparts2, v)
    elseif v.Name == "Part" and v.Parent.Name == "Cylinder1p5" and v.Color == Color3.fromRGB(105,60,40) then
        torsopart = v
    elseif v.Name == "Part" and v.Parent.Name == "Cylinder" and v.Color == Color3.fromRGB(105,55,40) then
        neckpart = v
    elseif v.Name == "Part" and v.Parent.Name == "HalfCylinder1p5" and v.Color == Color3.fromRGB(105,60,40) then
        table.insert(rounderparts, v)
    elseif v.Name == "BlockStd" and v.Parent.Name == "Ball" and v.Color == Color3.fromRGB(105, 65, 40) then
        mouth1part = v
    elseif v.Name == "Post" and v.Parent.Name == "Post" and v.Color == Color3.fromRGB(105, 65, 40) then
        table.insert(mouth2part, v)
    elseif v.Name == "Blade" and v.Parent.Name == "GiantPropeller" then
        table.insert(tailparts, v)
    elseif v.Name == "Seat" and v.Parent.Name == "PilotSeat" then
        seat1 = v
    elseif v.Name == "Seat" and v.Parent.Name == "PilotSeatExtra" then
        seat2 = v
    elseif v.Name == "BlockStd" and v.Parent.Name == "HoverThruster" and v.Color == Color3.fromRGB(0, 0, 0) then
        table.insert(eyeparts, v)
    elseif v.Name == "Post" and v.Parent.Name == "Post" and v.Color == Color3.fromRGB(15, 15, 15) then
        table.insert(hairparts, v)
    end
end

local function setupPhysics(part)
    if not part then return end
    
    part.CanCollide = false
    part.Anchored = false

    local bf = part:FindFirstChild("ZeroGravityForce") or Instance.new("BodyForce")
    bf.Name = "ZeroGravityForce"
    bf.Parent = part
    bf.Force = Vector3.new(0, part:GetMass() * Workspace.Gravity, 0)
    
    local bp = part:FindFirstChild("BodyPosition") or Instance.new("BodyPosition")
    bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bp.P = 50000
    bp.D = 800
    bp.Position = part.Position
    bp.Parent = part

    local bg = part:FindFirstChild("BodyGyro") or Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    bg.P = 30000
    bg.D = 500
    bg.CFrame = part.CFrame
    bg.Parent = part
    
    part.AssemblyLinearVelocity = Vector3.zero
end

local function weld(part1, part2, cframe)
    local args = {
        "MotorWeld", aircraftModel:FindFirstChild("MotorBlock"), true, part1, part2, cframe, true 
    }
    if game.ReplicatedStorage:FindFirstChild("BlockRemotes") then
        game.ReplicatedStorage.BlockRemotes.MotorLock:FireServer(unpack(args))
    end
end

local function unweld(part)
    local args = {part, "Break"}
    game.ReplicatedStorage.Remotes.UnanchorWelds:FireServer(unpack(args))
end

for _, part in pairs(myaircraft:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("Part") or part:IsA("WedgePart") or part:IsA("UnionOperation") then
        part.CanCollide = false
        part.Anchored = false
    end
end

for i = 1, 4 do 
    if toeparts[i] and toeparts[i].Parent then
        unweld(toeparts[i].Parent.Part4)
        unweld(toeparts[i].Parent.Part6)
    end
end

for i = 1, #tailparts do 
    unweld(tailparts[i])
end
setupPhysics(tailparts[1])
unweld(seat1)
unweld(seat2)

for i = 1, #eyeparts do 
    unweld(eyeparts[i])
end

task.wait(0.1)

weld(tailparts[1], tailparts[2], CFrame.new(0, 0.5, 0)* CFrame.Angles(math.rad(10), math.rad(5), math.rad(30))) 
weld(tailparts[1], tailparts[3], CFrame.new(0, -0.5, 0)* CFrame.Angles(math.rad(-10), math.rad(0), math.rad(-30))) 

for i = 1, 4 do 
    weld(toeparts[i], feetparts1[i], CFrame.new(-1.5, 0, 0))
end

for i = 1, 11 do 
    weld(rounderparts[i], torsopart, CFrame.new(0, -0.7,0)* CFrame.Angles(0, math.rad(20*i), math.rad(-90)))
end
for i = 12, 23 do 
    weld(rounderparts[i], torsopart, CFrame.new(0, -3.5,0)* CFrame.Angles(0, math.rad(20*i), math.rad(90)))
end

weld(mouth2part[1], mouth1part , CFrame.new(0, 1.2, -0.5)* CFrame.Angles(math.rad(-12.5), 0, 0))
weld(mouth2part[2], mouth1part , CFrame.new(0, 1.2, 0.5)* CFrame.Angles(math.rad(12.5), 0, 0))

weld(seat1, torsopart, CFrame.new(0, -2, 2.5) * CFrame.Angles(0, math.rad(90), 0))
weld(seat2, torsopart, CFrame.new(0, -2, 0) * CFrame.Angles(0, math.rad(90), 0))

weld(eyeparts[1], mouth1part, CFrame.new(-1.25, 0, 0) * CFrame.Angles(0, math.rad(-15), math.rad(25)))
weld(eyeparts[2], mouth1part, CFrame.new(1.25, 0, 0) * CFrame.Angles(0, math.rad(15), math.rad(-25)))

weld(hairparts[1], neckpart, CFrame.new(0, -0.65, 0))
weld(hairparts[2], neckpart, CFrame.new(-0.75, -0.45, 0))
weld(hairparts[3], neckpart, CFrame.new(-1.5, -0.25, 0))
weld(hairparts[4], neckpart, CFrame.new(-2.24, -0.05, 0))

weld(hairparts[5], mouth1part, CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(50), 0, 0))
weld(hairparts[6], mouth1part, CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(70), 0, 0))

setupPhysics(torsopart)
setupPhysics(neckpart)
setupPhysics(mouth1part)
setupPhysics(tailparts[1])

for i = 1, 4 do
    setupPhysics(feetparts1[i])
    setupPhysics(feetparts2[i])
end

local function updateBodyMover(part, targetCFrame)
    if not part then return end
    local bp = part:FindFirstChild("BodyPosition")
    local bg = part:FindFirstChild("BodyGyro")
    
    if bp and bg then
        bp.Position = targetCFrame.Position
        bg.CFrame = targetCFrame
    end
end


-- DEFINE HORSE PARTS ONCE
local horse = Workspace:FindFirstChild("horse")
if not horse then return end

local hChildren = horse:GetChildren()

local hfeet1 = hChildren[50]
local hfeet2 = hChildren[57]
local hfeet3 = hChildren[36]
local hfeet4 = hChildren[43]

local hfeet11 = hChildren[49]
local hfeet12 = hChildren[56]
local hfeet13 = hChildren[35]
local hfeet14 = hChildren[42]

local htors = horse:FindFirstChild("Part")
local hneck = hChildren[2]
local hhead = hChildren[4]
local tailpart = hChildren[12]

if not (hfeet1 and hfeet2 and hfeet3 and hfeet4 and
        hfeet11 and hfeet12 and hfeet13 and hfeet14 and
        htors and hneck and hhead and tailpart) then
    warn("Horse setup failed: some parts are missing.")
    return
end

local offsetFeet = CFrame.Angles(math.rad(-90), math.rad(90), 0)

-- HEARTBEAT LOOP (ONLY CHECKS HORSE + MOTORBLOCK EXISTENCE)
local heartbeatConnection

heartbeatConnection = RunService.Heartbeat:Connect(function()
    -- stop completely if horse is gone
    if not horse or not horse.Parent then
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
        end
        return
    end

    -- stop completely if MotorBlock is gone
    if not aircraftModel or not aircraftModel:FindFirstChild("MotorBlock") then
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
        end
        return
    end

    updateBodyMover(feetparts1[1], hfeet1.CFrame * offsetFeet)
    updateBodyMover(feetparts1[2], hfeet2.CFrame * offsetFeet)
    updateBodyMover(feetparts1[3], hfeet3.CFrame * offsetFeet)
    updateBodyMover(feetparts1[4], hfeet4.CFrame * offsetFeet)

    updateBodyMover(feetparts2[1], hfeet11.CFrame * offsetFeet)
    updateBodyMover(feetparts2[2], hfeet12.CFrame * offsetFeet)
    updateBodyMover(feetparts2[3], hfeet13.CFrame * offsetFeet)
    updateBodyMover(feetparts2[4], hfeet14.CFrame * offsetFeet)

    updateBodyMover(torsopart, htors.CFrame * CFrame.new(0, 0, 1.3) * CFrame.Angles(0, math.rad(90), 0))
    updateBodyMover(neckpart, hneck.CFrame * CFrame.new(0, -0.4, 0) * CFrame.Angles(math.rad(90), math.rad(90), 0))
    updateBodyMover(mouth1part, hhead.CFrame * CFrame.new(0, -0.4, 0.9) * CFrame.Angles(math.rad(80), 0, 0))
    updateBodyMover(tailparts[1], tailpart.CFrame * CFrame.Angles(math.rad(90), 0, math.rad(-90)))
end)
