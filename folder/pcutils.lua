local genv = getgenv()
local lpname = game.Players.LocalPlayer.Name


-- returns the unspawned plot can be used for managing the plot like painting parts inside plot
genv.getMyPlot = function()
    return workspace:FindFirstChild("PIayerAircraft")
       and workspace.PIayerAircraft:FindFirstChild(lpname)
end

-- returns the spawned plot can be used for controlling spawned parts
genv.getMySpawnedPlot = function()
    return workspace:FindFirstChild(lpname .. " Aircraft")
end


-- burns the parts, destroys it part must be owned by you 
genv.Burn = function(part)
    game:GetService("ReplicatedStorage").Remotes.FireHandler:FireServer(workspace.LavaParts.LavaPart, part)
end


-- welds 2 parts together takes cframe for offset
genv.Weld = function(part1, part2, cframe)
    local args = {"MotorWeld", workspace.PIayerAircraft[lpname]:FindFirstChild("MotorBlock"), true, part1, part2, cframe, true}
    if game.ReplicatedStorage:FindFirstChild("BlockRemotes") then
        game.ReplicatedStorage.BlockRemotes.MotorLock:FireServer(unpack(args))
    end
end

-- unwelds the part from whatever it's welded to 
genv.Unweld = function(part)
    local args = {
    [1] = part,
    [2] = "Break" -- required
    }
    game.ReplicatedStorage.Remotes.UnanchorWelds:FireServer(unpack(args))
end

