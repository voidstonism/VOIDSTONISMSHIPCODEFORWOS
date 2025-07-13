local Instrument=assert(GetPart("Instrument"),`Part "Instrument" appears to be missing, please check connections.`)
local LifeSensor=assert(GetPart("LifeSensor"),`Part "LifeSensor" appears to be missing, please check connections.`)
local Screen=assert(GetPart("Screen") or GetPart("TouchScreen") ,`Screen is not found/Screen is of incorrect type, please use part "Screen"`)

local SecondaryScreen=GetPartFromPort(2,"Screen") or nil
local Sheild = GetPart("EnergyShield") or nil

Screen:ClearElements()

local Radius = 2225
local Diamater = Radius*2
local VersionNum = "v3.8.3E"
local PlayerService:Players = require("players")
local OID = Screen:GetOwnerId()
local Owner = PlayerService:GetUsername(OID)
local CPUTime2 = pilot.getCPUTime()
local CPUTime1 = pilot.getCPUTime()
local UnitVariants = {
	C = "C";
	F = "F";
}
local UnitType = UnitVariants.F

--[[
REMEMBER: INTSTRUMENT UI MUST FACE FORWARD
Writen by VO1D_STONE with player sorting system made by LuaBloxor. PowerGraph by ArvidSilverLocks
Enchanced Greatly by ChatGPT (Efficiency Wise) (15-14 PPT) -> (7-8 PPT)

Variant Naming
E - Efficient
L - Ultra down throttled for power presevation
]]

local LifeSensorCircle3 = Screen:CreateElement('ImageLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,0.5);Size = UDim2.fromScale(1000/Radius, 1000/Radius);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);Image = "http://www.roblox.com/asset/?id=1145367640";ImageColor3 = Color3.new(0.174701, 0.382223, 0.162707);ImageTransparency = 0.8;BorderSizePixel = 0;Rotation = 0}) 
local LifeSensorCircle2 = Screen:CreateElement('ImageLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,0.5);Size = UDim2.fromScale(1500/Radius, 1500/Radius);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);Image = "http://www.roblox.com/asset/?id=1145367640";ImageColor3 = Color3.new(0.174701, 0.382223, 0.162707);ImageTransparency = 0.65;BorderSizePixel = 0;Rotation = 0}) 
local LifeSensorCircle = Screen:CreateElement('ImageLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,0.5);Size = UDim2.fromScale(2000/Radius, 2000/Radius);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);Image = "http://www.roblox.com/asset/?id=1145367640";ImageColor3 = Color3.new(0.174701, 0.382223, 0.162707);ImageTransparency = 0.5;BorderSizePixel = 0;Rotation = 0}) 

local VersionInfo = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.91,0.07);Size = UDim2.fromScale(0.17,0.12);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextSize =11;Text = VersionNum;TextXAlignment = "Right";TextYAlignment = "Top";TextColor3 = Color3.new(1, 1, 1);}) 
local Info = Screen:CreateElement('Frame', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.1,0.07);Size = UDim2.fromScale(0.15,0.1);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0}) 
local PowerInfo = Screen:CreateElement('Frame', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.1,0.93);Size = UDim2.fromScale(0.15,0.1);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0}) 
local PowerInfo2 = Screen:CreateElement('Frame', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.9,0.93);Size = UDim2.fromScale(0.15,0.1);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0}) 
local Power = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "F";TextColor3 = Color3.new(1, 1, 1);}) 
Power.Parent = PowerInfo2
local Powertit = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "Power";TextColor3 = Color3.new(1, 1, 1);}) 
Powertit.Parent = PowerInfo2
local PowerLeft = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "F";TextColor3 = Color3.new(1, 1, 1);}) 
PowerLeft.Parent=PowerInfo2
local PowerLefttit = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "Time Left";TextColor3 = Color3.new(1, 1, 1);}) 
PowerLefttit.Parent = PowerInfo2
local ElevationReading = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);	BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "F";TextColor3 = Color3.new(1, 1, 1);}) 
ElevationReading.Parent = Info
local Y = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "Y";TextColor3 = Color3.new(1, 1, 1);}) 
Y.Parent = Info
local TempDisplay = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);TextStrokeTransparency=0.7;TextStrokeColor3=Color3.new(1, 1, 1);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "N/A";TextColor3 = Color3.new(1, 1, 1);}) 
TempDisplay.Parent = Info
local Distance2000= Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,1);Size = UDim2.fromScale(0.1,0.1);BackgroundTransparency = 1;TextYAlignment = "Top";BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "2000";TextColor3 = Color3.new(1, 1, 1);}) 
local Distance1000= Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,1);Size = UDim2.fromScale(0.1,0.1);	BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;TextYAlignment = "Bottom";Text = "1500";TextColor3 = Color3.new(1, 1, 1);}) 
Distance1000.Parent = LifeSensorCircle2
local Distance500= Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,1);Size = UDim2.fromScale(0.1,0.1);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;TextYAlignment = "Bottom";Text = "1000";TextColor3 = Color3.new(1, 1, 1);}) 
Distance500.Parent = LifeSensorCircle3
local TempUI = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = `°{UnitType}`;	TextColor3 = Color3.new(1, 1, 1);}) 
TempUI.Parent = Info

local HPBarFrame
local HPBAR

if Sheild ~= nil then
	local kk = Color3.new(0.352941, 0.72549, 0.819608)
	HPBarFrame= Screen:CreateElement('Frame',{AnchorPoint = Vector2.new(0.5,0.5),Size = UDim2.fromScale(0.6,0.02),Position = UDim2.fromScale(0.5,0.03),BackgroundColor3=Color3.new(0.282353, 0.282353, 0.282353),BorderColor3 = kk})
	HPBAR = Screen:CreateElement('Frame',{AnchorPoint = Vector2.new(0,0),Size = UDim2.fromScale(0.6,1),Position = UDim2.fromScale(0,0),BackgroundColor3=kk})
	HPBAR.Parent = HPBarFrame
end


local Bearing  = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);TextXAlignment = "Right";TextYAlignment = "Top";Position = UDim2.fromScale(0.925,0.165);Size = UDim2.fromScale(0.1,0.05);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = false;TextSize=10;Text = "BRG: 0";	TextColor3 = Color3.new(1, 1, 1);}) 
local ResetButton = Screen:CreateElement('TextButton', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.95,0.83);Size = UDim2.fromScale(0.05,0.05);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "INFO";TextColor3 = Color3.new(1, 1, 1)}) 
local symbol = Screen:CreateElement('ImageLabel', {ImageColor3=Color3.new(0, 0, 0);AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.95,0.10);Size = UDim2.fromScale(0.05,0.05);BackgroundTransparency = 0;BackgroundColor3 = Color3.fromRGB(199,212,228);BorderSizePixel = 0;Rotation = 0;Image="http://www.roblox.com/asset/?id=4597927207";}) 
local element={}

if SecondaryScreen ~= nil then 
	local Length = 1024
	local Guide = SecondaryScreen:CreateElement("Frame",{
		Position = UDim2.fromScale(0.5,0.5);
		AnchorPoint = Vector2.new(0.5,0);
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.new(1, 0, 0);
		BackgroundTransparency = 0.2;
		Size = UDim2.fromScale(3,Length);
		Rotation = 360;
	})

	local Guide2 = SecondaryScreen:CreateElement("ImageLabel",{
		Position = UDim2.fromScale(0.5,0.5);
		AnchorPoint = Vector2.new(0.5,0);
		BorderSizePixel = 0;
		Image = "http://www.roblox.com/asset/?id=1248849582";
		ImageColor3 = Color3.new(1, 1, 0);
		BackgroundColor3 = Color3.new(1, 0, 0);
		BackgroundTransparency = 1;
		Size = UDim2.fromScale(3,Length);
		Rotation = 360;
	})
end

--Only Game moderators/TestZone mods are here(Discord mods DO NOT COUNT)

local Moderators = {
	["Vecury"] = true;
	["iiMurpyh"] = true;
	["DarkIsaiah"] = true;
	["Dylanisbeautiful"] = true;
	["JplaysStuff"] = true;
	["StrategicEnthusiast"] = true;
	["michaelosei"] = true;
	["Superr_Z"] = true;
}
local DevListed = {
	["addictedroblox1414"] = true;
	["LoneBessPizza"] = true;
	["Hail12Pink"] = true;
	["Weldify"] = true;
	["Hexcede"] = true;
}
local GreenListed={
	["ParagonOfSanguine"] = true;
	["DemonSecter44"] = true;
	["orekay2"] = true;
	["fgjutfsgv"] = true; --eff gee!!
	["LuaBloxor"]= true;
	["HuntersWays101"]= true;
	["Dylanisbeautiful"] = true;
	["LouisArtOfWar09"]= true;
	["blueloops9"] = true;
	["Turtle_Nukes"]= true;
	["Lodire2O"]= true;
	["robloxboxertBLOCKED"]= true;
	["djpablog3"]= true;
	["alone_baby"]= true;
	["madgarry105"]= true;
	["IvanAreEpic"] = true;
}
local RedListed = { --KILL ON SIGHT LIST NO EXCEPTIONS!
	["MrLeoMaster23"] = true; --stupid.
	["xgamerx1234567890_2"]= true; --most annoying of them all
	["florlarer123"]= true;
	["WhictArchal"]= true;
	["RealSkitGamer"]= true;
	["Hunter07936"]= true;
	["x_gamesbr2"]= true;
}
local Stan = {
	["Stan"] = true; -- stan isn't real
}
local UNKOWNENTITIE = {
	[""] = true;
	["1"] = true;
}
local Owners = {
	[Owner] = true;
}
local PlayerCategories = {
	RedListed = { Color = Color3.new(0.841138, 0.255955, 0), Suffix = "[KOS]", List = RedListed },
	GreenListed = { Color = Color3.new(0.0974136, 0.841138, 0), Suffix = "[ALLY]", List = GreenListed },
	DevListed = { Color = Color3.new(0.341512, 0.713542, 0.882399), Suffix = "[DEV]", List = DevListed },
	Moderators = { Color = Color3.new(0.596918, 0.232074, 0.891188), Suffix = "[MOD]", List = Moderators },
	Stan = { Color = Color3.new(0.883925, 0.016556, 0), Suffix = "Stan", List = Stan },
	UNKOWNENTITIE = { Color = Color3.new(0.33518, 0.175006, 0.672023), Suffix = "???", List = UNKOWNENTITIE },
	Owners = { Color = Color3.new(0, 0.536767, 0.883925), Suffix = "", List = Owners },
}

local function createplayer(player: string)
	-- Default settings for the element
	element[player] = Screen:CreateElement('TextLabel', {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0),
		Size = UDim2.fromScale(0.01, 0.01),
		Text = player,
		TextColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.new(0.866712, 0.794995, 0.45391),
		BorderSizePixel = 0,
		TextSize = 7,
		TextScaled = false,
		TextYAlignment = "Top",
		Rotation = 0
	})

	-- Check for each category and apply corresponding styles
	for category, settings in pairs(PlayerCategories) do
		if settings.List[player] then
			element[player].BackgroundColor3 = settings.Color
			element[player].Text = player .. " " .. settings.Suffix
			if category == "Owners" then
				element[player].Size = UDim2.fromScale(0.02, 0.02) -- Special size for Owners
			end
			return
		end
	end
end

local players={}

local function cal()
	local scale = 0.7
	local barGraphContainer = Screen:CreateElement("ScrollingFrame", {
		BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		CanvasSize = UDim2.new(),
		ScrollBarImageColor3 = Color3.fromHex("#1F1F1F"),
		ScrollBarThickness = 6,
		ScrollingDirection = Enum.ScrollingDirection.X,
		TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromHex("#3E3E3E"),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.9, 0.9)
	})
	barGraphContainer.Parent = PowerInfo

	local function createBar(Power, Index)
		local mainColor = Power < 0 and Color3.fromRGB(255, 127, 127) or Color3.fromRGB(127, 255, 127)
		local bar = nil

		if math.abs(Power) <= 10 then
			bar = Screen:CreateElement("TextLabel", {
				Text = math.abs(math.round(Power)),
				AnchorPoint = Vector2.new(0, 0.5),
				TextColor3 = Power == 0 and Color3.fromRGB(64, 192, 255) or mainColor,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 6 + (Index - 1) * 28, 0.5, 0),
				Size = UDim2.fromOffset(2, 15),
				TextSize = 10
			})
		else
			local height = (Power / 2) * 0.15
			bar = Screen:CreateElement("Frame", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = mainColor,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 6 + (Index - 1) * 28, 0.5, 0),
				Size = UDim2.fromOffset(25 * scale, height)
			})

			Screen:CreateElement("TextLabel", {
				Text = math.abs(math.round(Power)),
				TextColor3 = mainColor,
				TextSize = 10,
				AnchorPoint = Vector2.new(0.5, Power < 0 and 0 or 1),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, Power < 0 and 1 or 0),
				AutomaticSize = Enum.AutomaticSize.XY,
				TextXAlignment = Enum.TextXAlignment.Center
			}).Parent = bar
		end
		bar.Parent = barGraphContainer
		return bar
	end

	local barFrames = {}
	local lastPower = Instrument:GetReading("Power")

	Instrument.Loop:Connect(function()
		local currentPower = Instrument:GetReading("Power")
		local powerChange = currentPower - lastPower

		-- Cleanup excess bars
		while #barFrames >= 100 do
			table.remove(barFrames):Destroy()
		end

		-- Update bar positions
		for i, barFrame in ipairs(barFrames) do
			barFrame.Position = UDim2.new(0, 6 + i * 28, 0.5, 0)
		end

		-- Create new bar for power change
		local newBar = createBar(powerChange, 1)
		table.insert(barFrames, 1, newBar)

		-- Update the displayed power values
		lastPower = currentPower
		local powerLeftTime = math.round(((currentPower / math.round(powerChange)) / 60) * 10) / 10

		Power.Text = math.round(currentPower)
		barGraphContainer.CanvasSize = UDim2.fromOffset(6 + #barFrames * 28, 0)

		-- Beep if power change is small
		if math.abs(powerLeftTime) < 5 then
			Beep(1.5)
		end
		-- Update Power Left text
		if powerChange <= 0 then
			PowerLeft.Text = tostring(math.abs(powerLeftTime))
		elseif powerChange > 0 then
			PowerLeft.Text = "Charging"
		end
	end)
end


ResetButton.MouseButton1Click:Connect(function()
	Beep(0.5)
	print(`\nDebug:\nDelayTime: {(CPUTime2 - CPUTime1)/50}\nOwner: {Owner}\nVer{VersionNum}`)
end)

task.spawn(cal)

while task.wait((CPUTime2 - CPUTime1)/50) do
	CPUTime1 = pilot.getCPUTime()
	local currentpos = Instrument:GetReading("Position")
	local currentOrientation = Instrument:GetReading("Orientation")
	local currentTemp = math.round(Instrument:GetReading(`AirTemperature{UnitType}`))

	ElevationReading.Text = math.round(currentpos.Y)
	local theta = (currentOrientation.Y < 0) and (currentOrientation.Y % 360) or currentOrientation.Y
	Bearing.Text = math.round(theta)
	theta = math.rad(theta)

	local playerPositions = LifeSensor:GetReading()

	for player, _ in pairs(players) do
		if not playerPositions[player] then
			players[player] = nil
			element[player]:Destroy()
		end
	end

	for player, playerPosition in pairs(playerPositions) do
		if not players[player] then
			createplayer(player)
			players[player] = true
		end

		local X = (playerPosition.X - currentpos.X) / Diamater
		local Y = (playerPosition.Z - currentpos.Z) / Diamater
		local ad = 0.5
		local Position = UDim2.fromScale(
			(X * math.cos(theta)) - (Y * math.sin(theta)) + ad,
			(X * math.sin(theta)) + (Y * math.cos(theta)) + ad
		)

		-- Update HP and shield bars
		if HPBAR and Sheild then
			HPBAR.Size = UDim2.fromScale(Sheild:GetShieldHealth(), 1)
		end

		TempDisplay.Text = currentTemp

		-- Update symbol rotation
		symbol.Rotation = currentOrientation.Y + 180

		-- Temperature warning and color update
		local ConvertedF = Instrument:GetReading(`AirTemperatureF`)

		if ConvertedF < 35 then
			TempDisplay.TextColor3 = Color3.fromHSV(0.629722, math.max((ConvertedF / 100) + 1.35, 0.8), 1)
		elseif ConvertedF > 120 then
			Beep(math.clamp(ConvertedF / 290, 0, 2))
			TempDisplay.TextColor3 = Color3.new(0.708461, 0.000244144, 0.0933852)
		else
			TempDisplay.TextColor3 = Color3.new(1, 1, 1)
		end

		element[player].Position = Position
		CPUTime2 = pilot.getCPUTime()
	end
end