local Instrument=GetPartFromPort(3,"Instrument")
local LifeSensor=GetPartFromPort(2,"LifeSensor")
local Screen=GetPartFromPort(1,"Screen")
Screen:ClearElements()
local Radius = 2225
local Diamater = Radius*2
local VersionNum = "v2.1.3"
--Weaponized Microcontrollers Progamming and Development Program (WMPDP)
--REMEMBER: INTSTRUMENT UI MUST FACE FORWARD
local LifeSensorCircle3 = Screen:CreateElement('ImageLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,0.5);Size = UDim2.fromScale(1000/Radius, 1000/Radius);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);Image = "http://www.roblox.com/asset/?id=1145367640";ImageColor3 = Color3.new(0.174701, 0.382223, 0.162707);ImageTransparency = 0.8;BorderSizePixel = 0;Rotation = 0}) 
local LifeSensorCircle2 = Screen:CreateElement('ImageLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,0.5);Size = UDim2.fromScale(1500/Radius, 1500/Radius);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);Image = "http://www.roblox.com/asset/?id=1145367640";ImageColor3 = Color3.new(0.174701, 0.382223, 0.162707);ImageTransparency = 0.65;BorderSizePixel = 0;Rotation = 0}) 
local LifeSensorCircle = Screen:CreateElement('ImageLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,0.5);Size = UDim2.fromScale(2000/Radius, 2000/Radius);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);Image = "http://www.roblox.com/asset/?id=1145367640";ImageColor3 = Color3.new(0.174701, 0.382223, 0.162707);ImageTransparency = 0.5;BorderSizePixel = 0;Rotation = 0}) 
--Writen by VO1D_STONE with player sorting system made by LuaBloxor. PowerGraph by ArvidSilverLocks
local VersionInfo = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.91,0.07);Size = UDim2.fromScale(0.17,0.12);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextSize =11;Text = VersionNum;TextXAlignment = "Right";TextYAlignment = "Top";TextColor3 = Color3.new(1, 1, 1);}) 
local Info = Screen:CreateElement('Frame', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.1,0.07);Size = UDim2.fromScale(0.15,0.1);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0}) 

local PowerInfo = Screen:CreateElement('Frame', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.1,0.93);Size = UDim2.fromScale(0.15,0.1);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0}) 
local PowerInfo2 = Screen:CreateElement('Frame', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.9,0.93);Size = UDim2.fromScale(0.15,0.1);BackgroundTransparency = 0.5;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0}) 
local Power = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = math.round(Instrument:GetReading(4));TextColor3 = Color3.new(1, 1, 1);}) 
PowerInfo2:AddChild(Power)
local Powertit = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "Power";TextColor3 = Color3.new(1, 1, 1);}) 
PowerInfo2:AddChild(Powertit)
local PowerLeft = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = math.round(Instrument:GetReading(4));TextColor3 = Color3.new(1, 1, 1);}) 
PowerInfo2:AddChild(PowerLeft)
local PowerLefttit = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "Time Left";TextColor3 = Color3.new(1, 1, 1);}) 
PowerInfo2:AddChild(PowerLefttit)
local ElevationReading = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);	BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = Instrument:GetReading(6).Y;TextColor3 = Color3.new(1, 1, 1);}) 
Info:AddChild(ElevationReading)
local Y = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.25);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "Y";TextColor3 = Color3.new(1, 1, 1);}) 
Info:AddChild(Y)
local TempDisplay = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.75,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);TextStrokeTransparency=0.7;TextStrokeColor3=Color3.new(1, 1, 1);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = math.round(Instrument:GetReading(8).Y);TextColor3 = Color3.new(1, 1, 1);}) 
Info:AddChild(TempDisplay)
local Distance2000= Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,1);Size = UDim2.fromScale(0.1,0.1);BackgroundTransparency = 1;TextYAlignment = "Bottom";BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "2000";TextColor3 = Color3.new(1, 1, 1);}) 
LifeSensorCircle:AddChild(Distance2000)
local Distance1000= Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,1);Size = UDim2.fromScale(0.1,0.1);	BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;TextYAlignment = "Bottom";Text = "1500";TextColor3 = Color3.new(1, 1, 1);}) 
LifeSensorCircle2:AddChild(Distance1000)
local Distance500= Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.5,1);Size = UDim2.fromScale(0.1,0.1);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;TextYAlignment = "Bottom";Text = "1000";TextColor3 = Color3.new(1, 1, 1);}) 
LifeSensorCircle3:AddChild(Distance500)
local TempUI = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.25,0.75);Size = UDim2.fromScale(0.45,0.45);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = true;Text = "ºF";	TextColor3 = Color3.new(1, 1, 1);}) 
Info:AddChild(TempUI)
local Bearing  = Screen:CreateElement('TextLabel', {AnchorPoint = Vector2.new(0.5,0.5);TextXAlignment = "Right";TextYAlignment = "Top";Position = UDim2.fromScale(0.925,0.165);Size = UDim2.fromScale(0.1,0.05);BackgroundTransparency = 1;BackgroundColor3 = Color3.new(0.174701, 0.382223, 0.162707);BorderSizePixel = 0;Rotation = 0;TextScaled = false;TextSize=10;Text = "BRG: 0";	TextColor3 = Color3.new(1, 1, 1);}) 
local symbol = Screen:CreateElement('ImageLabel', {ImageColor3=Color3.new(0, 0, 0);AnchorPoint = Vector2.new(0.5,0.5);Position = UDim2.fromScale(0.95,0.10);Size = UDim2.fromScale(0.05,0.05);BackgroundTransparency = 0;BackgroundColor3 = Color3.fromRGB(199,212,228);BorderSizePixel = 0;Rotation = 0;Image="http://www.roblox.com/asset/?id=4597927207";}) 
local element={}
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
	["Nataluliee"] = true;
}
local DevListed = {
	["addictedroblox1414"] = true;
	["LoneBessPizza"] = true;
	["Hail12Pink"] = true;
	["Weldify"] = true;
	["evlynst1"] = true;
}
local GreenListed={
	["KindDavid24"] = true;
	["DemonSecter44"] = true;
	["raikt3"] = true;
	["fgjutfsgv"] = true; --eff gee!!
	["LuaBloxor"]= true;
	["HuntersWays101"]= true;
	["Dylanisbeautiful"] = true;
	["LouisArtOfWar09"]= true;
	["Turtle_Nukes"]= true;
	["Lodire2O"]= true;
	["robloxboxertBLOCKED"]= true;
	["madgarry105"]= true;
}
local RedListed = { --KILL ON SIGHT LIST NO EXCEPTIONS!
	["MrLeoMaster23"] = true; --stupid.
	["IvanAreEpic"] = true; --kinda chill but still somewhat annoying
	["xgamerx1234567890_2"]= true; --most annoying of them all
	["florlarer123"]= true;
	["WhictArchal"]= true;
	["djpablog3"]= true;
	["alone_baby"]= true;
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
	["VO1D_STONE"] = true;
	["Bingo146"] = true;
}
local function createplayer(player:string)
	element[player] =  Screen:CreateElement('TextLabel', {
		AnchorPoint = Vector2.new(0.5,0.5);
		Position = UDim2.new(0,0);
		Size = UDim2.fromScale(0.01, 0.01);
		Text = player;
		TextColor3 = Color3.new(1, 1, 1);
		BackgroundTransparency = 0;
		BackgroundColor3 = Color3.new(0.866712, 0.794995, 0.45391);
		BorderSizePixel = 0;
		TextSize = 7;
		TextScaled = false;
		TextYAlignment = "Top";
		Rotation = 0
	}) 
end
local players={}
local function cal()
	local scale = 0.7
	local barGraphContainer = Screen:CreateElement("ScrollingFrame", { BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png", CanvasSize = UDim2.new(), ScrollBarImageColor3 = Color3.fromHex("#1F1F1F"), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.X, TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png", VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar, Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5,0.5), Size = UDim2.fromScale(0.9,0.9) })
	PowerInfo:AddChild(barGraphContainer)
	local Components = {
		Bar = function(Power: number, Index: number)
			local mainColour = if Power < 0 then Color3.fromRGB(255, 127, 127) else Color3.fromRGB(127, 255, 127)

			if math.abs(Power) <= 10 then
				local text = Screen:CreateElement("TextLabel", {
					Text = math.abs(math.round(Power)),
					AnchorPoint = Vector2.new(0, 0.5),
					TextColor3 = if Power == 0 then Color3.fromRGB(64, 192, 255) else mainColour,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 6 + ( Index - 1 ) * 28, 0.5, 0),
					Size = UDim2.fromOffset(2, 15),
					TextSize = 10,
				})

				barGraphContainer:AddChild(text)
				return text
			end

			local powerBar = Screen:CreateElement("Frame", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = mainColour,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 6 + ( Index - 1 ) * 28, 0.5, 0),
				Size = UDim2.fromOffset(25*scale, (Power / 2)*0.15)
			})

			if math.abs(Power) <= 500 then
				powerBar:AddChild(Screen:CreateElement("TextLabel", {
					Text = math.abs(math.round(Power)),
					TextColor3 = mainColour,
					TextSize = 10,
					AnchorPoint = Vector2.new(0.5, if Power < 0 then 0 else 1),
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, if Power < 0 then 1 else 0),
					AutomaticSize = Enum.AutomaticSize.XY,
					TextXAlignment = Enum.TextXAlignment.Center,
				}))
			else
				powerBar:AddChild(Screen:CreateElement("TextLabel", {
					Text = math.abs(math.round(Power)),
					TextColor3 = if Power < 0 then Color3.fromRGB(200, 0, 0) else Color3.fromRGB(0, 150, 0),
					TextSize = 10,
					AnchorPoint = Vector2.new(0.5, if Power < 0 then 0 else 1),
					BackgroundTransparency = 1,
					Position = if Power < 0 then UDim2.new(0.5, 0, 0, 0) else UDim2.new(0.5, 0, 1, 0),
					Rotation = 90,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextXAlignment = if Power < 0 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Right,
				}))
			end

			barGraphContainer:AddChild(powerBar)
			return powerBar
		end,
	}
	local barFrames = { }
	local lastPower = Instrument:GetReading(4)
	local totalLoops = 1
	while true do
		task.wait(1)
		local currentPower = Instrument:GetReading(4)
		local powerChange = currentPower - lastPower
		lastPower = currentPower
		while #barFrames >= 100 do
			table.remove(barFrames):Destroy()
		end
		for i, barFrame in barFrames do
			barFrame.Position = UDim2.new(0, 6 + i * 28, 0.5, 0)
		end
		local WritenbyVO1D_STONEwithplayersortingsystemmadebyLuaBloxorPowerGraphbyArvidSilverLocks = Components.Bar(powerChange, 1)
		table.insert(barFrames, 1, WritenbyVO1D_STONEwithplayersortingsystemmadebyLuaBloxorPowerGraphbyArvidSilverLocks)
		barGraphContainer.CanvasSize = UDim2.fromOffset(6 + #barFrames * 28, 0)
		totalLoops += 1
		local Time = math.round(((currentPower/powerChange)/60)*10)/10
		if powerChange <= 0 then
			PowerLeft.Text = math.abs(Time)
		elseif powerChange > 0 then
			PowerLeft.Text = "Charging"
		end
	end
end
--FUCK YOU
local Coro = coroutine.create(cal)
coroutine.resume(Coro)
local timee = 0
while true do
	ElevationReading.Text = math.round(Instrument:GetReading(6).Y)
	Power.Text = math.round(Instrument:GetReading(4))
	task.wait(timee)
	local playerPositions=LifeSensor:GetReading()
	--if PlrCount.Text ~= plyrcount then
	for player in players do
		if playerPositions[player]==nil then 
			players[player]=nil 
			element[player]:Destroy() 
		end
	end
	for player,playerPosition in playerPositions do
		if players[player]==nil then 
			createplayer(player) 
			players[player]=true 
		end
		local currentpos = Instrument:GetReading(6)
		local ad = 0.5
		local orn = Instrument:GetReading(8)
		local theta
		if orn.Y < 0 then
			theta = orn.Y % 360
		else
			theta = orn.Y
		end 
		symbol.Rotation = theta+180
		if Bearing.Text ~= math.round(theta) then
			Bearing.Text = math.round(theta)
		end
		local Templ = math.round(Instrument:GetReading(2))
		TempDisplay.Text = Templ
		if Templ < 35 then
			local Coldcolor = Color3.fromHSV(0.629722,math.max((Templ/100)+1.35,0.8), 1)
			if TempDisplay.TextColor3 ~= Coldcolor then
				TempDisplay.TextColor3 = Coldcolor
			end
		elseif Templ > 120 then
			if Templ > 240 then
				Beep(math.clamp(Templ/290,0,2))
			end
			if TempDisplay.TextColor3 ~= Color3.new(0.708461, 0.000244144, 0.0933852) then
				TempDisplay.TextColor3 = Color3.new(0.708461, 0.000244144, 0.0933852)
			end
		else
			if TempDisplay.TextColor3 ~= Color3.new(1, 1, 1) then
				TempDisplay.TextColor3 = Color3.new(1, 1, 1)
			end
		end
		theta = math.rad(theta)
		local X = ((playerPosition.X-currentpos.X)/Diamater)
		local Y = ((playerPosition.Z-currentpos.Z)/Diamater)
		local x1 = (X*math.cos(theta)) - (Y*math.sin(theta)) 
		local y1 = (X*math.sin(theta)) + (Y*math.cos(theta))
		if RedListed[player] == true then
			if element[player].Text ~= player.." [KOS]" then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.841138, 0.255955, 0),
					Text =  player.." [KOS]"
				})
			end
		elseif GreenListed[player] == true then
			if element[player].Text ~= player.." [ALLY]" then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.0974136, 0.841138, 0);
					Text = player.." [ALLY]"
				})
			end
		elseif DevListed[player] == true then
			if element[player].Text ~= player.." [DEV]" then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.341512, 0.713542, 0.882399);
					Text = player.." [DEV]"
				})
			end
		elseif Moderators[player] == true then
			if element[player].Text ~= player.." [MOD]" then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.596918, 0.232074, 0.891188);
					Text = player.." [MOD]"
				})
			end
		elseif Stan[player] == true then
			if element[player].Text ~= player then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.883925, 0.016556, 0);
					Text = player
				})
			end
		elseif UNKOWNENTITIE[player] == true then
			if element[player].Text ~= "UNKOWN ENTITY [???]" then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.33518, 0.175006, 0.672023);
					Text = "UNKOWN ENTITY [???]"
				})
			end
		elseif Owners[player] == true then
			if element[player].Text ~= player or element[player].BackgroundColor3 ~= Color3.new(0, 0.536767, 0.883925)  then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0, 0.536767, 0.883925);
					Text = player;
					Size = UDim2.fromScale(0.02, 0.02);
				})
			end
		else	
			if element[player].BackgroundColor3 ~= Color3.new(0.866712, 0.794995, 0.45391) then
				element[player]:ChangeProperties({BackgroundColor3 = Color3.new(0.866712, 0.794995, 0.45391)})
			end
		end
		element[player]:ChangeProperties({Position=UDim2.fromScale(x1+ad,y1+ad)})
	end
end