local LifeSensor = GetPart("LifeSensor")
local Gyro = GetPart("Gyro")
local Dispensers = GetPartsFromPort(1,"Dispenser")
local Microphone = GetPart("Microphone")

local PlayerService = require("players")

local Whitelist="ParagonOfSanguine Lodire2O AtsKaanDmn Xxabiyyu_ggxX LuaBloxor HuntersWays101 DemonSecter44 madgarry105 robloxboxertBLOCKED VO1D_STONE Dylanisbeautiful Dankest_Things Sketchyskybread xXnoob_slayer227Xx rupercetamol Meowcat_Hates Minelolololol jhnb_real ItchyZoomWasTaken louisartofwar09 v1nikon springtrapxd911 l5108313 unalej1 michaelosei lolergamer0 orekay2 lodire2o makerbenjammin6 GenericRblxStudioDev dorpg articlize iamachicken1928 burgertaxman 0nehara"



local list=Whitelist:split(" ")

local TargetListShortcut = {}

local MAINTARGET
local Command = "/t"
local refresh = "-r"

print([[-v3
-___ ___  _       ____  __    __  ___ ___        ____  ___  
|   |   || |     /    ||  |__|  ||   |   |      |    |/   \ 
| _   _ || |    |  o  ||  |  |  || _   _ | _____ |  ||     |
|  \_/  || |___ |     ||  |  |  ||  \_/  ||     ||  ||  O  |
|   |   ||     ||  _  ||  `  '  ||   |   ||_____||  ||     |
|   |   ||     ||  |  | \      / |   |   |       |  ||     |
|___|___||_____||__|__|  \_/\_/  |___|___|      |____|\___/ 

---------Manually Launched Anti Warship Missile v10---------
]])

local TimeClock = 60 -- Inverse constant

local function GetPlayers()
	if not LifeSensor then
		return "Error: Cannot retrieve players, LifeSensor is missing."
	end

	local names = {}
	for _, id in LifeSensor:ListPlayers() do
		table.insert(names, PlayerService:GetUsername(id))
	end
	return names
end


local function GetNearPlayerToTarget()
	local Reading = LifeSensor:GetReading()
	local PlayerName
	local PlayerPos
	local distance = 1000000
	for Player, Position in next, Reading do
		if Player ~= nil then
			if table.find(list,Player) ~= nil then
			else
				if (Position-LifeSensor.Position).Magnitude <= distance then
					PlayerName = Player
					PlayerPos = Position
					distance = (Position-LifeSensor.Position).Magnitude
				end
			end
		end
	end
	return PlayerName
end

local function GetPositionAndDistance(Player)
	if LifeSensor:GetReading()[Player] ~= nil then
		local Position = LifeSensor:GetReading()[Player]
		local distance = (Position-LifeSensor.Position).Magnitude
		return Position, distance
	else
		return nil,nil
	end
end

-- Configuration (Adjust these)
local missileSpeed = 1000 -- Speed of the missile in studs/second
local predictionTime = 1/TimeClock-- How far into the future to predict (seconds)

-- Function to predict target position
local function predictTargetPosition(targetPosition, targetVelocity,timeToImpact)
	-- Calculate predicted position
	local predictedPosition = targetPosition + targetVelocity * timeToImpact

	return predictedPosition
end

-- Function to calculate lead (where to aim)
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

local function Calculate(Player)
	local Position1, dis = GetPositionAndDistance(Player)
	if Position1 ~= nil then
		wait(1/TimeClock)
		local p2, _ = GetPositionAndDistance(Player)

		if p2 == nil then
			return
		end

		local Speed = (p2-Position1)*TimeClock

		local p = calculateLead(Gyro.Position,Position1,1000,Speed)


		return p,dis
	else
		return nil, nil
	end
end

local function CheckIfWhiteListed(PlayerName)
	if table.find(list,PlayerName) then
		return " - [Allied]"
	else
		return ""
	end
end

local players = GetPlayers()

print(`PLAYERS IN REGION, PLEASE TYPE "{Command} [number]"" TO MANUALLY SELECT TARGET OR {refresh} to refresh`)

for i, users in players do
	TargetListShortcut[i] = users
	print(`{i}....{users}{CheckIfWhiteListed(users)}`)
end

Microphone.Chatted:Connect(function(plr,Text:string)
	local username = PlayerService:GetUsername(plr)
	if list[table.find(list,username)] then
		local players = GetPlayers()
		print("Yes?")
		Text = Text:lower()

		if Text:lower():sub(0,Command:len()) == Command:lower() then
			local index = 3

			local pass, succes = pcall(function()
				index = tonumber(Text:sub(Command:len() + 1, Text:len()):gsub(" ", ""):gsub("%s+", ""),10)
			end)

			if pass == true then
				print(index)

				local Target = TargetListShortcut[index]
				if Target ~= nil then
					MAINTARGET = Target
					print(`{Target} is now the target`)
				else
					print(`{Target} is not a valid player, check spelling or Capitalizetion`)
				end
			else
				print(`{Text:sub(Command:len() + 1, Text:len())} is not a valid number`)
			end
		elseif Text:lower():sub(0,refresh:len()) == refresh:lower() then
			TargetListShortcut = {}
			print("Refreshed")
			local players = GetPlayers()

			print(`PLAYERS_IN_REGION, PLEASE TYPE "/t [number]"" TO MANUALLY SELECT TARGET`)

			for i, users in players do
				TargetListShortcut[i] = users
				print(`{i}....{users}{CheckIfWhiteListed(users)}`)
			end
		end
	end
end)

while task.wait(1/TimeClock) do
	if MAINTARGET ~= nil then
		local Pos, Dis = Calculate(MAINTARGET)
		if Pos ~= nil then
			Gyro:PointAt(Pos)
			if Dis < 75 then
				print(`Detonated at {Dis} Delay: {(75-Dis)/1000} Target: {MAINTARGET}`)
				for i, d in Dispensers do
					d.Filter = "EnergyBomb"
					d:Dispense()
					d:Dispense()
					d:Dispense()
					print("VOOLY 3")
				end
				TriggerPort(1)
			end
		else
			Gyro.Seek = MAINTARGET
		end
	else
		MAINTARGET = GetNearPlayerToTarget()
		if MAINTARGET ~= nil then
			print(`Target acquired {MAINTARGET}.`)
		end
		Gyro.Seek = "AllExcept "..table.concat(list," ").." TrigMax100 Maxinf"
		Gyro:PointAt()
	end
end
