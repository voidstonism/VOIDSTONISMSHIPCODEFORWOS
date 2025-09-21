local LifeSensor = GetPart("LifeSensor")
local Gyro = GetPart("Gyro")
local Seat = GetPart("VehicleSeat")

Gyro.MaxTorque = 0
Gyro.TriggerWhenSeeked = false
Seat.Enabled = true

local AutoAimBoolean = false

-- Whitelist as a lookup table for fast checking
local Whitelist = {
	["HuntersWays101"] = true, ["Dankest_Things"] = true, ["Stan"] = true,
	["Nadgob1"] = true, ["VO1D_STONE"] = true, ["xXnoob_slayer227Xx"] = true,
	["L5108313"] = true, ["springtrapxd911"] = true, ["ParagonOfSanguine"] = true,
	["DemonSecter44"] = true, ["LuaBloxor"] = true, ["robloxboxertBLOCKED"] = true,
	["Dylanisbeautiful"] = true, ["Sketchyskybread"] = true, ["madgarry105"] = true,
	["XxgamergrannygirlxX"] = true, ["alone_baby"] = true, ["Matthewthegreat7"] = true,
	["redballking1"] = true, ["blueloops9"] = true, ["Lodire2O"] = true,
}

-- Utility: Find closest non-whitelisted player
local function GetNearestTarget()
	local readings = LifeSensor:GetReading()
	local nearestName, nearestPos
	local shortestDistance = math.huge

	for player, pos in next, readings do
		if player and not Whitelist[player] then
			local distance = (pos - LifeSensor.Position).Magnitude
			if distance < shortestDistance then
				nearestName, nearestPos, shortestDistance = player, pos, distance
			end
		end
	end

	return nearestName, nearestPos, shortestDistance
end

-- Predictive calculation
local function PredictTargetPosition()
	local name1, pos1, dist1 = GetNearestTarget()
	if not pos1 then return end

	task.wait() -- One frame delay

	local _, pos2, dist2 = GetNearestTarget()
	if not pos2 then return end

	local velocity = pos2 - pos1
	local predicted = pos2 + velocity * (4.5 + (dist2 / 1000))
	return name1, predicted, dist2
end

-- Main auto-aim loop
local function AutoAim()
	while wait(0.1) do
		local name, predictedPos, distance = PredictTargetPosition()

		if name and AutoAimBoolean then
			Gyro.Seek = ""
			Gyro:PointAt(predictedPos)
		else
			-- Build seek string dynamically from whitelist
			local seekExclusions = {}
			for player in pairs(Whitelist) do
				table.insert(seekExclusions, player)
			end
			Gyro.Seek = "AllExcept " .. table.concat(seekExclusions, " ") .. " TrigMaxMax750000 Max750000"
			Gyro:PointAt()
		end
	end
end

-- Start auto-aim loop in a thread
task.spawn(AutoAim)

-- Toggle logic on Port(1)
GetPort(1).Triggered:Connect(function()
	AutoAimBoolean = not AutoAimBoolean
	Seat.Enabled = not AutoAimBoolean

	if AutoAimBoolean then
		Gyro.MaxTorque = 1e10
		Beep()
	else
		Gyro.MaxTorque = 0
		Beep(0.3)
	end
end)
