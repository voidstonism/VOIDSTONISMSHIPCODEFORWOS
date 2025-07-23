local LifeSensor = GetPart("LifeSensor")
local Gyro = GetPart("Gyro")
local Seat = GetPart("VehicleSeat")
local TriggerPort = GetPort(1)

Gyro.MaxTorque = 1e10
Gyro.TriggerWhenSeeked = false
Seat.Enabled = true

local AutoAimBoolean = false

-- Fast lookup
local Whitelist = {
	["HuntersWays101"] = true, ["Dankest_Things"] = true, ["Stan"] = true,
	["Nadgob1"] = true, ["VO1D_STONE"] = true, ["xXnoob_slayer227Xx"] = true,
	["L5108313"] = true, ["springtrapxd911"] = true, ["ParagonOfSanguine"] = true,
	["DemonSecter44"] = true, ["LuaBloxor"] = true, ["robloxboxertBLOCKED"] = true,
	["Dylanisbeautiful"] = true, ["Sketchyskybread"] = true, ["madgarry105"] = true,
	["XxgamergrannygirlxX"] = true, ["alone_baby"] = true, ["Matthewthegreat7"] = true,
	["redballking1"] = true, ["blueloops9"] = true, ["Lodire2O"] = true,
}

-- Build Gyro.Seek string once
local SeekString = "AllExcept " .. table.concat((function()
	local t = {}
	for name in pairs(Whitelist) do
		t[#t+1] = name
	end
	return t
end)(), " ") .. " TrigMaxMax750000 Max750000"

-- Return nearest non-whitelisted player and position
local function GetNearestTarget()
	local readings = LifeSensor:GetReading()
	local nearestName, nearestPos, shortestDistance = nil, nil, math.huge
	local sensorPos = LifeSensor.Position

	for name, pos in pairs(readings) do
		if not Whitelist[name] then
			local dist = (pos - sensorPos).Magnitude
			if dist < shortestDistance then
				nearestName, nearestPos, shortestDistance = name, pos, dist
			end
		end
	end

	return nearestName, nearestPos, shortestDistance
end

-- Predict movement
local function PredictTargetPosition()
	local name1, pos1, _ = GetNearestTarget()
	if not pos1 then return end

	task.wait() -- frame delay
	local _, pos2, dist2 = GetNearestTarget()
	if not pos2 then return end

	local predicted = pos2 + (pos2 - pos1) * (4.5 + dist2 / 1000)
	return name1, predicted, dist2
end

-- Auto-aim loop using Heartbeat for max update rate
task.spawn(function()
	while true do
		wait()

		if not AutoAimBoolean then continue end

		local name, predictedPos = PredictTargetPosition()

		if name then
			Gyro.Seek = ""
			Gyro:PointAt(predictedPos)
		else
			Gyro.Seek = SeekString
			Gyro:PointAt()
		end
	end
end)

-- Port toggle
TriggerPort.Triggered:Connect(function()
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
