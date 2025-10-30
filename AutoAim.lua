--[[MBEE_HEADER__DO_NOT_EDIT]]
if game then
	PilotLua = require(game.ReplicatedStorage.PilotLua)
	Beep, FileSystem, GetCPUTime, GetPart, GetPartFromPort, GetParts, GetPartsFromPort, GetPort, GetPorts, JSONDecode, JSONEncode, Microcontroller, Network, RawFileSystem, SandboxID, SandboxRunID, TriggerPort, logError, pilot = PilotLua()
end
-- Version 1755562366
-- Automatically generated header, provides typechecking. Disable "Microcontroller Typechecking" in advanced settings to remove.
--[[MBEE_HEADER__DO_NOT_EDIT]]
local LifeSensor = GetPart("LifeSensor")
local Gyro = GetPart("Gyro")
local Seat = GetPart("VehicleSeat")

Gyro.MaxTorque = 0
Gyro.TriggerWhenSeeked = false
Seat.Enabled = true

local AutoAimBoolean = false

local PlayerService = require("players")

-- Whitelist as a lookup table for fast checking
local WhiteListID = {
	231260961, --ParagonOfSanguine
	671804696, --AtsKaanDmn
	643737262, --Xxabiyyu_ggxX
	1800749867, --LuaBloxor
	2579398539, --HuntersWays101
	2001009508, --DemonSecter44
	163217027, --madgarry105
	629218990, --robloxboxertBLOCKED
	1070628373, --VO1D_STONE ALTERED 1070628373
	116793964, --Dylanisbeautiful
	124562220, --Dankest_Things
	912549715, --Sketchyskybread
	160019711, --xXnoob_slayer227Xx
	424233066, --rupercetamol
	582612019, --Meowcat_Hates
	863898195, --Minelolololol
	1301233084, --jhnb4_real
	183121205, --ItchyZoomWasTaken
	342314704, --louisartofwar09
	337740176, --v1nikon
	575054736, --springtrapxd911
	201125447, --l5108313
	1820385690, --unalej1
	22953003, --michaelosei
	261039947, --lolergamer0
	455957199, --orekay2
	1065929391, --lodire2o
	857491600, --makerbenjammin6
	3372922014, --GenericRblxStudioDev
	190573844, --dorpg
	1949933105, --articlize
	1572474960, --iamachicken1928
	1607576935, --burgertaxman
	74344691, --0nehara
	3088934170, --C3PH3_S
}

--Convert to [Player] = true
local Whitelist = {
}


for _, id in WhiteListID do
	Whitelist[PlayerService:GetUsername(id)] = true
end
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

local function GetOutOfHarmsWay()
	local Rockets = assert(GetParts("Rocket"),"ROCKET NOT DETECTED CANNOT CONTINUE")
	local Anchor = GetPart("Anchor")
	local Switch = GetParts("Switch")
	local Valve = GetParts("Valve")

	local function Speed(Speed:ValueBase)
		Beep()
		for _, R in Rockets do
			R.Propulsion = Speed
		end
	end

	local function MegaSwitch(bool:boolean)
		Beep()
		for _, S in Switch do
			S.SwitchValue = bool
		end	
		for _, V in Valve do
			V.SwitchValue = bool
		end
	end

	local Pos = Vector3.new(math.random(-100000000,100000000),0,math.random(-100000000,100000000))+Vector3.new(Gyro.Position.X,0,Gyro.Position.Z)

	if Anchor and next(Rockets) and next(Valve) and next(Switch) then
		Beep()
		Seat.Enabled = false
		Gyro.MaxTorque = 1e10
		MegaSwitch(true)
		Anchor.Anchored = false
		Gyro:PointAt(Pos)
		Speed(100)
		wait(5)
		MegaSwitch(false)
		Anchor.Anchored = true
		wait(0.5)
		Anchor.Anchored = false
		wait(0.5)
		Anchor.Anchored = true
		Seat.Enabled = true
		Gyro.MaxTorque = 0
	else
		print("Um sir, you are missing parts")
	end
end

-- Checks for the presence of dangerous players

local function GetPlr(IgnoreWhiteList:boolean)
	local Reading = LifeSensor:ListPlayers()

	if IgnoreWhiteList == false then
		for _, ID in Reading do
			local Username = PlayerService:GetUsername(ID)
			if Whitelist[Username] then
				table.remove(Reading, table.find(Reading, ID))
			else
				print(Username)
			end
		end
	end

	return Reading
end

task.wait(1)

if GetNearestTarget() ~= nil then
	print(#GetPlr(false))
	GetOutOfHarmsWay()
else
	print("You are alone.")
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
