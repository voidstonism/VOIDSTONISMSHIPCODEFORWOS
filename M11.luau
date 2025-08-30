--[[MBEE_HEADER__DO_NOT_EDIT]]
if game then
	PilotLua = require(game.ReplicatedStorage.PilotLua)
	Beep, FileSystem, GetCPUTime, GetPart, GetPartFromPort, GetParts, GetPartsFromPort, GetPort, GetPorts, JSONDecode, JSONEncode, Microcontroller, Network, RawFileSystem, SandboxID, SandboxRunID, TriggerPort, logError, pilot = PilotLua()
end
-- Version 1755562366
-- Automatically generated header, provides typechecking. Disable "Microcontroller Typechecking" in advanced settings to remove.
--[[MBEE_HEADER__DO_NOT_EDIT]]
local Gyro = GetPart("Gyro")
local Microphone = GetPart("Microphone")
local Rockets = GetParts("Rocket")
local Dispenser = GetPart("Dispenser")
local TouchDetcor = GetParts("TouchSensor")
local LifeSensor = GetPart("LifeSensor")
local Breaker = GetPart("Switch")

local players = require("players")

local Debug = false

local TimeClock = 60

local function dprint(m:string)
	if Debug then
		print(m)
	end
end

Dispenser.Filter = "EnergyBomb Explosive"

local WhiteListTable = {
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

local MAINTARGET = nil

local function GetPlr(IgnoreWhiteList:boolean)
	local Reading = LifeSensor:ListPlayers()

	if IgnoreWhiteList == false then
		for _, ID in Reading do
			if table.find(WhiteListTable,ID) then
				table.remove(Reading, table.find(Reading, ID))
			end
		end
	end

	return Reading
end

local function ConvertIDtabletoString(tableid)
	local Output = {}
	for _, ID in tableid do
		table.insert(Output, players:GetUsername(ID))
	end	
	return Output
end

local function FindClosestPlr()
	local Reading = LifeSensor:GetPlayers()
	local Distance = 3000
	local ClosestTarget = nil

	for IDs, PlrCFrame in Reading do
		local PlrDist = (LifeSensor.Position-PlrCFrame.Position).Magnitude
		if not table.find(WhiteListTable,IDs) and PlrDist < Distance then
			dprint("sir")
			Distance = PlrDist
			ClosestTarget = IDs
		end
	end

	return ClosestTarget
end

local List = LifeSensor:ListPlayers()

local function ListOutPossibleTargets()
	local String = "\nPossible Targets:\n"
	List = LifeSensor:ListPlayers()

	for i, IDS in List do
		if table.find(WhiteListTable,IDS) then
			String = String..`{i} .. {IDS} ({players:GetUsername(IDS)}) ----------- [ALLIED]\n`
		else
			String = String..`{i} .. {IDS} ({players:GetUsername(IDS)})\n`
		end
	end

	warn(String)
end

local function predictTargetPosition(targetPosition, targetVelocity,timeToImpact)
	-- Calculate predicted position
	local predictedPosition = targetPosition + targetVelocity * timeToImpact

	return predictedPosition
end

local function calculateLead(missilePosition, targetPosition, missileSpeed, Playersppeed)

	local targetDirection = (targetPosition - missilePosition).unit
	local distanceToTarget = (targetPosition - missilePosition).magnitude
	local timeToImpact = distanceToTarget / missileSpeed

	--Optional: Check if the target is already in range to avoid issues.
	if timeToImpact <= 0 then
		return targetPosition
	end

	local targetVelocity = Playersppeed

	local predictedTargetPosition = predictTargetPosition(targetPosition, targetVelocity,timeToImpact)
	return predictedTargetPosition
end

local function Calculate()
	local Position1 = LifeSensor:GetPlayers()[MAINTARGET].Position
	if Position1 ~= nil then
		wait(1/TimeClock)
		local p2 = LifeSensor:GetPlayers()[MAINTARGET].Position

		if p2 == nil then
			return
		end

		local Speed = (p2-Position1)*TimeClock

		local p = calculateLead(Gyro.Position,Position1,1000,Speed)


		return p
	else
		return nil, nil
	end
end

function ConnectAllTouch()
	for _, Touch in TouchDetcor do
		Touch.Touched:Connect(function(Object)
			if not Object then return end
			print(tostring(Object))
			if tostring(Object) == "EnergyBomb" or tostring(Object) == "Explosive" then
				Object:Trigger()
			end
		end)
	end
end

function FullSystemShutDown()
	for _, r in Rockets do
		r.Propulsion = 0
	end
	Breaker.SwitchValue = false
	Microcontroller:Shutdown()
	print("FORCED SHUTDOWN COMPLETE")
end

-- Activates

print([[\n
 ____    ____  _____          _  ____      ____  ____    ____       __     __    
|_   \  /   _||_   _|        / \|_  _|    |_  _||_   \  /   _|     /  |   /  |   
  |   \/   |    | |         / _ \ \ \  /\  / /    |   \/   | ______`| |   `| |   
  | |\  /| |    | |   _    / ___ \ \ \/  \/ /     | |\  /| ||______|| |    | |   
 _| |_\/_| |_  _| |__/ | _/ /   \ \_\  /\  /     _| |_\/_| |_      _| |_  _| |_  
|_____||_____||________||____| |____|\/  \/     |_____||_____|    |_____||_____| 
 
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
Commands:
/t (Target) - Set the target to the player of your choice
		e.x: /t 1
-r refreshes player selector
-stopmsl - Stop the missile]])

ListOutPossibleTargets()


Microphone.Chatted:Connect(function(plrid,msg)
	if table.find(WhiteListTable, plrid) then
		msg:gsub("\n","")
		if msg:lower():find("/t") then
			local Target = tonumber(List[tonumber(msg:sub(msg:find("/t")+2))])
			print(`Target Set to {Target} ({players:GetUsername(Target)})`)

			MAINTARGET = Target

		elseif msg:lower() == "-r" then
			ListOutPossibleTargets()
		elseif msg:lower() == "-stopmsl" then
			FullSystemShutDown()
		end
	end
end)

while wait(1/TimeClock) do
	local Error, Msg = pcall(function()
		dprint(MAINTARGET)
		if MAINTARGET == nil then -- if nil, far range is activated
			if next(LifeSensor:GetPlayers()) ~= nil then
				MAINTARGET = FindClosestPlr()
				if MAINTARGET then
					print(`Target aquired: {MAINTARGET} ({players:GetUsername(MAINTARGET)})`)
				end
			else
				MAINTARGET = nil
			end
			Gyro:PointAt()
			Gyro.Seek = `{table.concat(ConvertIDtabletoString(GetPlr(false))," ")}`
			dprint(Gyro.Seek)
		else
			if LifeSensor:GetPlayers()[MAINTARGET] ~= nil then
				local Pos = Calculate()
				local Distance = (LifeSensor.Position-Pos).Magnitude
				Gyro:PointAt(Pos)
				Gyro.Seek = ""
				dprint("LOCKED!")
				if Distance <= 75 then
					ConnectAllTouch()
					for i = 1, 20 do
						Dispenser:Dispense()
					end
					print(`DETONATED @{Distance} TARGET {players:GetUsername(MAINTARGET)}`)
				end
			else
				Gyro:PointAt()
				Gyro.Seek = players:GetUsername(MAINTARGET)
				dprint("LOCKED BUT TOO FAR!")
			end
		end
	end)

	if Error == false then
		warn(Msg)
	end
end
