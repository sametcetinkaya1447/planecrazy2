local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Speed variables
local HORSE_SPEED = 2.5
local HORSE_MAX_SPEED = 15
local HORSE_MIN_SPEED = 1.0
local HORSE_SPEED_INCREMENT = 0.5


local function spawnHorse()
    local assetId = 78120759241594
    
    local success, model = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    
    if not success or not model then
        warn("Failed to load horse model:", model)
        return nil
    end
    
    model.Parent = workspace
    return model
end

-- Delete if horse already exists
if workspace:FindFirstChild("Horse") then
    workspace.Horse:Destroy()
end

-- Create a function to set up the horse
local function setupHorse()
    local horse = spawnHorse()
    if not horse then return end
    
    -- Position the horse near the player
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        if not horse.PrimaryPart then
            horse.PrimaryPart = horse:FindFirstChild("HumanoidRootPart") or horse:FindFirstChildWhichIsA("BasePart")
        end
        
        if horse.PrimaryPart then
            horse:SetPrimaryPartCFrame(
                player.Character.HumanoidRootPart.CFrame + Vector3.new(5, 0, 5)
            )
        end
    end
    
    -- Make every part inside horse transparent
    for _, part in pairs(horse:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("UnionOperation") then
            part.Transparency = 0.9
        end
    end 

    -- Make sure we have animations folder
    if not horse:FindFirstChild("Animations") then
        local animationsFolder = Instance.new("Folder")
        animationsFolder.Name = "Animations"
        animationsFolder.Parent = horse
        
        local defaultAnimations = {
            Idle = "rbxassetid://5261729120",
            Walk = "rbxassetid://5261732364",
            Jump = "rbxassetid://5261734997",
            Fall = "rbxassetid://5261737019",
            Dead = "rbxassetid://5261739457",
            Ride = "rbxassetid://5261743476"
        }
        
        for name, id in pairs(defaultAnimations) do
            local anim = Instance.new("Animation")
            anim.Name = name
            anim.AnimationId = id
            anim.Parent = animationsFolder
        end
    end
    
    -- Make sure we have a humanoid
    if not horse:FindFirstChild("Humanoid") then
        local humanoid = Instance.new("Humanoid")
        humanoid.Parent = horse
    end
    
    -- Configure the humanoid for speed
    local humanoid = horse:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16 * HORSE_SPEED
    end
    
    -- Create a VehicleSeat
    if not horse:FindFirstChild("Seat") then
        local seat = Instance.new("VehicleSeat")
        seat.Name = "Seat"
        seat.Size = Vector3.new(2, 0.5, 2)
        seat.Transparency = 1
        seat.CanCollide = false
        
        if horse:FindFirstChild("HumanoidRootPart") then
            seat.Position = horse.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
            seat.Parent = horse
            
            local weld = Instance.new("Weld")
            weld.Part0 = horse.HumanoidRootPart
            weld.Part1 = seat
            weld.C0 = CFrame.new(0, 2, 0)
            weld.Parent = seat
        else
            seat.Parent = horse
        end
    end
    
    return horse
end

-- Animation system
local function setupAnimations(horse)
    local horseHumanoid = horse:WaitForChild("Humanoid")
    local animations = {}
    
    for _, animation in pairs(horse:WaitForChild("Animations"):GetChildren()) do
        animations[animation.Name] = horseHumanoid:LoadAnimation(animation)
    end
    
    local state = "None"
    
    local function isGrounded()
        local ray = Ray.new(horse.HumanoidRootPart.Position + Vector3.new(0, -4.3, 0), Vector3.new(0, -1, 0))
        local hit, position = workspace:FindPartOnRay(ray, horse)
        return hit and hit.CanCollide
    end
    
    local function stopAll()
        for _, animation in pairs(animations) do
            animation:Stop()
        end
    end
    
    local function changeState(newState)
        if state ~= newState then
            stopAll()
            state = newState
            if animations[state] then
                animations[state]:Play()
            end
        end
    end
    
    local animationConnection
    animationConnection = RunService.Stepped:Connect(function()
        if not horse or not horse:FindFirstChild("HumanoidRootPart") or not horse:FindFirstChild("Humanoid") then
            if animationConnection then animationConnection:Disconnect() end
            return
        end
        
        if horseHumanoid.Health > 0 then
            if isGrounded() then
                local speed = Vector3.new(horse.HumanoidRootPart.Velocity.X, 0, horse.HumanoidRootPart.Velocity.Z).magnitude
                if speed > 1 then
                    if animations["Walk"] then
                        animations["Walk"]:AdjustSpeed(HORSE_SPEED * 0.8)
                    end
                    changeState("Walk")
                else
                    changeState("Idle")
                end
            else
                local ySpeed = horse.HumanoidRootPart.Velocity.Y
                if ySpeed > 0 then
                    changeState("Jump")
                else
                    changeState("Fall")
                end
            end
        else
            changeState("Dead")
        end
    end)
    
    return {
        stopAll = stopAll,
        changeState = changeState,
        disconnect = function() 
            if animationConnection then
                animationConnection:Disconnect()
            end
        end
    }
end

-- Controls system
local function setupControls(horse)
    local movement = Vector3.new(0, 0, 0)
    local riding = false
    local rideAnimation = nil
    local controlling = false
    
    local function createControlCharacter()
        if not player.Character then return nil end
        
        local controlChar = Instance.new("Model")
        controlChar.Name = "HorseController"
        
        local humanoid = Instance.new("Humanoid")
        humanoid.Parent = controlChar
        
        local hrp = Instance.new("Part")
        hrp.Name = "HumanoidRootPart"
        hrp.Size = Vector3.new(2, 2, 1)
        hrp.Transparency = 1
        hrp.CanCollide = false
        hrp.Parent = controlChar
        
        controlChar.PrimaryPart = hrp
        controlChar.Parent = workspace
        
        return controlChar
    end
    
    local function setupSeatOverride()
        local seat = horse:WaitForChild("Seat")
        
        local function sitOnHorse()
            if not player.Character or not player.Character:FindFirstChild("Humanoid") then return false end
            
            local controlChar = workspace:FindFirstChild("HorseController") or createControlCharacter()
            if not controlChar then return false end
            
            controlChar.HumanoidRootPart.CFrame = horse.Seat.CFrame
            
            seat.Disabled = false
            riding = true
            controlling = true
            
            horse.Humanoid.WalkSpeed = 16 * HORSE_SPEED
            createSpeedGUI()
            
            return true
        end
        
        local function dismount()
            riding = false
            controlling = false
            movement = Vector3.new(0, 0, 0)
            
            local controlChar = workspace:FindFirstChild("HorseController")
            if controlChar then
                controlChar:Destroy()
            end
            
            local speedGui = player.PlayerGui:FindFirstChild("HorseSpeedGUI")
            if speedGui then
                speedGui:Destroy()
            end
            
            return false
        end
        
        return sitOnHorse, dismount
    end
    
    local function createSpeedGUI()
        local existingGui = player.PlayerGui:FindFirstChild("HorseSpeedGUI")
        if existingGui then
            existingGui:Destroy()
        end
        
        local speedGui = Instance.new("ScreenGui")
        speedGui.Name = "HorseSpeedGUI"
        speedGui.Parent = player.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 50)
        frame.Position = UDim2.new(0.5, -100, 0.9, -50)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 0.5
        frame.Parent = speedGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
        
        local speedLabel = Instance.new("TextLabel")
        speedLabel.Name = "SpeedLabel"
        speedLabel.Size = UDim2.new(1, 0, 0.6, 0)
        speedLabel.Position = UDim2.new(0, 0, 0, 0)
        speedLabel.BackgroundTransparency = 1
        speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedLabel.Text = "Speed: " .. HORSE_SPEED .. "x"
        speedLabel.Font = Enum.Font.GothamBold
        speedLabel.TextSize = 16
        speedLabel.Parent = frame
        
        local controlsLabel = Instance.new("TextLabel")
        controlsLabel.Size = UDim2.new(1, 0, 0.4, 0)
        controlsLabel.Position = UDim2.new(0, 0, 0.6, 0)
        controlsLabel.BackgroundTransparency = 1
        controlsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        controlsLabel.Text = "Q: Slower | R: Faster"
        controlsLabel.Font = Enum.Font.Gotham
        controlsLabel.TextSize = 12
        controlsLabel.Parent = frame
    end
    
    local function updateSpeedDisplay()
        local speedGui = player.PlayerGui:FindFirstChild("HorseSpeedGUI")
        if speedGui then
            local speedLabel = speedGui:FindFirstChild("Frame"):FindFirstChild("SpeedLabel")
            if speedLabel then
                speedLabel.Text = "Speed: " .. HORSE_SPEED .. "x"
            end
        end
    end
    
    local sitOnHorse, dismount = setupSeatOverride()
    
    local inputBeganConnection = UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
        if gameProcessedEvent then return end
        
        if inputObject.KeyCode == Enum.KeyCode.F then
            if not riding then
                if player.Character and horse then
                    local distance = (player.Character.HumanoidRootPart.Position - horse.HumanoidRootPart.Position).Magnitude
                    if distance < 10 then
                        sitOnHorse()
                    end
                end
            else
                dismount()
            end
            return
        end
        
        if riding and controlling then
            if inputObject.KeyCode == Enum.KeyCode.R then
                HORSE_SPEED = math.min(HORSE_SPEED + HORSE_SPEED_INCREMENT, HORSE_MAX_SPEED)
                horse.Humanoid.WalkSpeed = 16 * HORSE_SPEED
                updateSpeedDisplay()
            elseif inputObject.KeyCode == Enum.KeyCode.Q then
                HORSE_SPEED = math.max(HORSE_SPEED - HORSE_SPEED_INCREMENT, HORSE_MIN_SPEED)
                horse.Humanoid.WalkSpeed = 16 * HORSE_SPEED
                updateSpeedDisplay()
            end
        end
        
        if not riding or not controlling then return end

        if inputObject.KeyCode == Enum.KeyCode.W or inputObject.KeyCode == Enum.KeyCode.Up then
            movement = Vector3.new(movement.X, movement.Y, -1)
        elseif inputObject.KeyCode == Enum.KeyCode.S or inputObject.KeyCode == Enum.KeyCode.Down then
            movement = Vector3.new(movement.X, movement.Y, 1)
        elseif inputObject.KeyCode == Enum.KeyCode.A or inputObject.KeyCode == Enum.KeyCode.Left then
            movement = Vector3.new(-1, movement.Y, movement.Z)
        elseif inputObject.KeyCode == Enum.KeyCode.D or inputObject.KeyCode == Enum.KeyCode.Right then
            movement = Vector3.new(1, movement.Y, movement.Z)
        elseif inputObject.KeyCode == Enum.KeyCode.LeftShift then
            horse.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    
    local inputEndedConnection = UserInputService.InputEnded:Connect(function(inputObject, gameProcessedEvent)
        if gameProcessedEvent or not riding or not controlling then return end
        
        if inputObject.KeyCode == Enum.KeyCode.W or inputObject.KeyCode == Enum.KeyCode.Up then
            if movement.Z < 0 then
                movement = Vector3.new(movement.X, movement.Y, 0)
            end
        elseif inputObject.KeyCode == Enum.KeyCode.S or inputObject.KeyCode == Enum.KeyCode.Down then
            if movement.Z > 0 then
                movement = Vector3.new(movement.X, movement.Y, 0)
            end
        elseif inputObject.KeyCode == Enum.KeyCode.A or inputObject.KeyCode == Enum.KeyCode.Left then
            if movement.X < 0 then
                movement = Vector3.new(0, movement.Y, movement.Z)
            end
        elseif inputObject.KeyCode == Enum.KeyCode.D or inputObject.KeyCode == Enum.KeyCode.Right then
            if movement.X > 0 then
                movement = Vector3.new(0, movement.Y, movement.Z)
            end
        end
    end)
    
    local movementConnection = nil
    
    local function startMovementLoop()
        if movementConnection then movementConnection:Disconnect() end
        
        movementConnection = RunService.RenderStepped:Connect(function()
            if not horse or not horse:FindFirstChild("Humanoid") then
                movementConnection:Disconnect()
                return
            end
            
            if riding and controlling then
                local scaledMovement = movement * HORSE_SPEED
                horse.Humanoid:Move(scaledMovement, true)
            end
        end)
    end
    
    startMovementLoop()
    
    return {
        startRiding = sitOnHorse,
        stopRiding = dismount,
        disconnect = function()
            if inputBeganConnection then inputBeganConnection:Disconnect() end
            if inputEndedConnection then inputEndedConnection:Disconnect() end
            if movementConnection then movementConnection:Disconnect() end
            if riding then dismount() end
        end
    }
end

-- Alignment function for aircraft parts
local function alignParts(source, target, rotationOffset, positionOffset)
    rotationOffset = rotationOffset or CFrame.new()
    positionOffset = positionOffset or Vector3.new(0, 0, 0)

    for _, child in pairs(source:GetChildren()) do
        if child:IsA("AlignPosition") or child:IsA("AlignOrientation") or child:IsA("Attachment") then
            child:Destroy()
        end
    end

    local sourceAttachment = Instance.new("Attachment", source)
    local targetAttachment = Instance.new("Attachment", target)

    local finalOffset = CFrame.new(positionOffset) * rotationOffset
    targetAttachment.CFrame = finalOffset

    local alignPos = Instance.new("AlignPosition", source)
    alignPos.Attachment0 = sourceAttachment
    alignPos.Attachment1 = targetAttachment
    alignPos.RigidityEnabled = true
    alignPos.Responsiveness = 200
    alignPos.MaxForce = math.huge
    alignPos.ApplyAtCenterOfMass = true

    if not source:IsA("Seat") and not source:IsA("VehicleSeat") then
        local alignOri = Instance.new("AlignOrientation", source)
        alignOri.Attachment0 = sourceAttachment
        alignOri.Attachment1 = targetAttachment
        alignOri.RigidityEnabled = true
        alignOri.Responsiveness = 200
        alignOri.MaxTorque = math.huge
    end
end

local function burn(part)
    ReplicatedStorage.Remotes.FireHandler:FireServer(workspace.LavaParts.LavaPart, part)
end

local function weld(aircraftModel, part1, part2, cframe)
    local args = {
        [1] = "MotorWeld",
        [2] = aircraftModel.MotorBlock, 
        [3] = true,
        [4] = part1,
        [5] = part2,
        [6] = cframe,
        [7] = true 
    }
    ReplicatedStorage.BlockRemotes.MotorLock:FireServer(unpack(args))
end

-- Setup aircraft alignment to horse
local function setupAircraftAlignment(horse)
    local aircraftModel = workspace:FindFirstChild(player.Name .. " Aircraft")
    if not aircraftModel then
        warn("Aircraft model not found!")
        return
    end
    
    local aircraft = aircraftModel
    local legTargets = {"Left Leg", "Right Leg", "Left Arm", "Right Arm"}
    local torso = nil
    local legs = {}
    local neck, head, hair, hair1 = nil, nil, nil, nil
    local eye1, eye2 = nil, nil
    
    for _, part in ipairs(aircraft:GetDescendants()) do
        if part.Name == "Post" and part:IsA("Part") and part.Color == Color3.fromRGB(124,92,69) then
            part.CanCollide = false
            table.insert(legs, part)
        elseif part.Name == "Part" and part.Parent.Name == "Cylinder" and part.Color == Color3.fromRGB(31,31,31) then 
            torso = part
        elseif part.Name == "Post" and part:IsA("Part") and part.Color == Color3.fromRGB(124,92,71) then
            neck = part
        elseif part.Name == "Post" and part:IsA("Part") and part.Color == Color3.fromRGB(124,92,70) then
            head = part
        elseif part.Name == "Part" and part.Color == Color3.fromRGB(0,0,0) then
            hair = part
        elseif part.Name == "Part" and part.Color == Color3.fromRGB(0,0,1) then
            hair1 = part
        elseif part.Name == "BlockStd" and part.Color == Color3.fromRGB(0,0,1) then
            eye1 = part
        elseif part.Name == "BlockStd" and part.Color == Color3.fromRGB(0,0,2) then
            eye2 = part
        end
    end
    
    for i,v in pairs(aircraft:GetDescendants()) do 
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.CanCollide = false
        end
    end
    
    local seat = aircraft.PilotSeat.Seat
    local rotateRight = CFrame.Angles(math.rad(-90), math.rad(90), math.rad(90))
    local defaultrotation = CFrame.Angles(0, 0, 0)
    local torsorot = CFrame.Angles(math.rad(90), 0, math.rad(90))
    local backOffset = Vector3.new(0, 0, 0)
    local downoffset = Vector3.new(0, 0, 0)
    
    for i,v in pairs(seat.Parent:GetDescendants()) do 
        if v.Name ~= "Seat" then
            burn(v)
        end
    end
    
    local seat2 = aircraft.PilotSeatExtra.Seat
    for i,v in pairs(seat2.Parent:GetDescendants()) do 
        if v.Name ~= "Seat" then
            burn(v)
        end
    end
    
    -- Align legs
    if #legs >= 4 then
        alignParts(legs[1], horse[legTargets[1]], rotateRight, downoffset)
        alignParts(legs[2], horse[legTargets[2]], rotateRight, downoffset)
        alignParts(legs[3], horse[legTargets[3]], rotateRight, downoffset)
        alignParts(legs[4], horse[legTargets[4]], rotateRight, downoffset)
    end
    
    -- Align body parts
    if torso then alignParts(torso, horse.Body, torsorot, backOffset) end
    if neck then alignParts(neck, horse.Torso, defaultrotation) end
    if head then alignParts(head, horse.Head, defaultrotation) end
    if hair then 
        alignParts(hair, horse.Tail, CFrame.Angles(math.rad(60), 0, math.rad(90)), Vector3.new(0, 0, 0.9))
    end
    
    -- Weld eyes and hair
    if eye1 and head then
        weld(aircraftModel, eye1, head, CFrame.new(-0.4,-0.7,0) * CFrame.Angles(math.rad(-90), 0, math.rad(-90)))
    end
    if eye2 and head then
        weld(aircraftModel, eye2, head, CFrame.new(0.4,-0.7,0) * CFrame.Angles(math.rad(90), 0, math.rad(90)))
    end
    if hair1 and head then
        weld(aircraftModel, hair1, head, CFrame.new(1.3,0,0.5) * CFrame.Angles(math.rad(90), 0, math.rad(90)))
    end
    
    -- Position and weld seats
    seat.CFrame = horse.Body.CFrame * CFrame.new(0, 1.1, 0.6)
    seat.Anchored = false
    
    local weld1 = Instance.new("WeldConstraint")
    weld1.Part0 = seat
    weld1.Part1 = horse.Body
    weld1.Parent = seat
    
    seat2.CFrame = horse.Body.CFrame * CFrame.new(0, 1.1, -1)
    seat2.Anchored = false
    
    local weld2 = Instance.new("WeldConstraint")
    weld2.Part0 = seat2
    weld2.Part1 = horse.Body
    weld2.Parent = seat2
    
    -- Make tail transparent
    if horse:FindFirstChild("Tail") then
        horse.Tail.Transparency = 1
    end
end

-- Main function to set up the entire system
local function setupHorseSystem()
    local horse = setupHorse()
    if not horse then
        warn("Failed to set up horse")
        return
    end
    
    local animationSystem = setupAnimations(horse)
    local controlSystem = setupControls(horse)
    
    -- Wait a moment for horse to fully load, then setup aircraft alignment
    task.wait(0.5)
    setupAircraftAlignment(horse)
    
    -- Create GUI notification
    local messageGui = Instance.new("ScreenGui")
    messageGui.Name = "HorseMessage"
    messageGui.Parent = player.PlayerGui
    
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(0, 300, 0, 50)
    message.Position = UDim2.new(0.5, -150, 0.1, 0)
    message.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    message.BackgroundTransparency = 0.5
    message.TextColor3 = Color3.fromRGB(255, 255, 255)
    message.Text = "Horse spawned! Press F when near the horse to ride it.\nUse Q/R to adjust speed when riding."
    message.Font = Enum.Font.GothamBold
    message.TextSize = 14
    message.Parent = messageGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = message
    
    task.delay(5, function()
        messageGui:Destroy()
    end)
    
    -- Clean up function
    local function cleanup()
        if animationSystem then animationSystem.disconnect() end
        if controlSystem then controlSystem.disconnect() end
        if horse and horse.Parent then horse:Destroy() end
        
        local controlChar = workspace:FindFirstChild("HorseController")
        if controlChar then controlChar:Destroy() end
        
        local speedGui = player.PlayerGui:FindFirstChild("HorseSpeedGUI")
        if speedGui then speedGui:Destroy() end
    end
    
    return {
        horse = horse,
        cleanup = cleanup
    }
end

-- Execute the system
local horseSystem = setupHorseSystem()
