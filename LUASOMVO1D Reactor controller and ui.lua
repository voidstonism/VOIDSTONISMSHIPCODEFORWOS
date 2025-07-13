local function safecall<x...,y...>(func:(x...)->y...):any  return (function(...)local err={pcall(func,...)} if calldebug then print("safecall ran") end if not table.unpack(err,1,1) then print(table.unpack(err,2,2)) else return table.unpack(err,2) end end) end
local TargetTemp = 950
local Ports = GetPorts(1)
local Screen = assert(GetPart("Screen"),"MISSING SCREEN PLEASE USE A DIFFERENT CODE IF YOU WISH TO NOT HAVE UI")
Screen:ClearElements()

--HUGE THANKS TO LUABLOXOR AND POTENTIALLY LODIRE2O FOR THE BASIC FRAMEWORK! ONLY THE UI IS MADE BY VO1D_STONE
--WARNING: THIS WILL COMSUME ALOT OF POWER, PLEASE OBTAIN A HIGH POWER GENREATOR!

local backgroun = Screen:CreateElement("ImageLabel", { Image = "rbxassetid://3899340539", ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(100, 100), BackgroundColor3 = Color3.fromHex("#FFFFFF"), BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Name = "Backgroun" })
local scrollingFrame:ScrollingFrame = Screen:CreateElement("ScrollingFrame", { BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png", CanvasSize = UDim2.fromScale(0, #Ports), ScrollBarImageColor3 = Color3.fromHex("#5F5F5F"), TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png", Active = true, AutomaticSize = Enum.AutomaticSize.None, AutomaticCanvasSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromHex("#363636"), BackgroundTransparency = 0.45, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.025, 0.05), Size = UDim2.fromScale(0.675, 0.9) })
local infoContainer = Screen:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#363636"), BackgroundTransparency = 0.45, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.725, 0.05), Size = UDim2.fromScale(0.25, 0.9), Name = "Info Container" })
local tEMPLABEL = Screen:CreateElement("TextLabel", { RichText = true, Text = "T:", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 15, TextWrapped = true, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Size = UDim2.fromScale(0.35, 0.125), Name = "TEMPLABEL" })
local tEMPAVERGAE = Screen:CreateElement("TextLabel", { RichText = true, Text = "950", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.35, 0), Size = UDim2.fromScale(0.65, 0.125), Name = "TEMP AVERGAE" })
local rEACTORCOUNT = Screen:CreateElement("TextLabel", { RichText = true, Text = #Ports, TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.35, 0.125), Size = UDim2.fromScale(0.65, 0.125), Name = "REACTORCOUNT" })
local lABEL = Screen:CreateElement("TextLabel", { RichText = true, Text = "R:", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 15, TextWrapped = true, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.125), Size = UDim2.fromScale(0.35, 0.125), Name = "LABEL" })
local _5 = Screen:CreateElement("TextLabel", { RichText = true, Text = "F:", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 15, TextWrapped = true, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.25), Size = UDim2.fromScale(0.35, 0.125), Name = "2" })
local fUEL4 = Screen:CreateElement("TextLabel", { RichText = true, Text = "950", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.35, 0.25), Size = UDim2.fromScale(0.65, 0.125), Name = "FUEL" })

tEMPLABEL.Parent = infoContainer; 
tEMPAVERGAE.Parent = infoContainer; 
rEACTORCOUNT.Parent = infoContainer; 
lABEL.Parent = infoContainer; 
_5.Parent = infoContainer; 
fUEL4.Parent = infoContainer

local function SetRods(Target, Rods, Port, Polysilicon)
	local change = Target - Rods
	if change == 0 then return Target end
	if change > 0 then Polysilicon.PolysiliconMode = 0 for i=1, change do TriggerPort(Port) end end
	if change < 0 then Polysilicon.PolysiliconMode = 1 for i=1, -change do TriggerPort(Port) end end
	return Target
end

local Events = {}
local numb = 1


function GetTempandfuel()
	local Temp = 0 
	local Fuel = 0
	
	for _, portium in Ports do
		local r = GetPartFromPort(portium, "Reactor")
		local cv = 0
		
		Temp += r:GetTemp()
		for _, f in r:GetFuel() do
			cv += f
			task.wait()
		end
		cv /= 4
		Fuel += cv
		task.wait()
	end
	
	Fuel /= #Ports
	Temp /= #Ports
	return Temp, Fuel
end

for ind, Port in Ports do
	local Reactor = GetPartFromPort(Port, "Reactor")
	local Rods = 10
	local Polysilicon = GetPartFromPort(Port, "Polysilicon")
	local Dispenser = GetPartFromPort(Port, "Dispenser")
	Polysilicon.PolysiliconMode = 0
	--if ind % 5 == 0 then task.wait(0.1) end
	for i = 1, 10 do
		TriggerPort(Port)
	end

	local Fuel = Reactor:GetFuel()

	local rod = {}
	local fil
	local Card = Screen:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1D1D1D"), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.025, (((numb/#Ports)-((numb/#Ports)/2.45))-(0.52125/#Ports))), Size = UDim2.fromScale(0.9, 0.6), Name = "REACTORINFOCARD" })
	local TempLabel = Screen:CreateElement("TextLabel", { TextColor3 = Color3.fromHex("#55FF00"), TextScaled = true, TextSize = 86, TextStrokeColor3 = Color3.fromHex("#FFFFFF"), TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#1B2A35"), Size = UDim2.fromScale(1, 0.333), ZIndex = 3, Name = "Temperature" })
	local rEACTOR = Screen:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#FFED23"), BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.015, 0.025), Size = UDim2.fromScale(0.45, 0.95), Name = "REACTOR" })
	local background = Screen:CreateElement("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromHex("#000000"), BorderColor3 = Color3.fromHex("#1B2A35"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.667, 0.833), Name = "Background" })
	local fUEl = Screen:CreateElement("TextLabel", { RichText = true, Text = f, TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.65, 0.175), Size = UDim2.fromScale(0.35, 0.125), Name = "FUEl" })
	local reactorNumber = Screen:CreateElement("TextLabel", { RichText = true, Text = numb, TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.745, 0.05), Size = UDim2.fromScale(0.35, 0.125), Name = "ReactorNumber" })
	local tIT = Screen:CreateElement("TextLabel", { RichText = true, Text = "Fuel", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.275, 0.175), Size = UDim2.fromScale(0.35, 0.125), Name = "TIT" })
	local title = Screen:CreateElement("TextLabel", { RichText = true, Text = "Reactor", TextColor3 = Color3.fromHex("#FFFFFF"), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.375, 0.05), Size = UDim2.fromScale(0.35, 0.125), Name = "Title" })

	for i, fuel in Fuel do
		fil = Screen:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#5F5F5F"), BorderColor3 = Color3.fromHex("#1B2A35"), BorderSizePixel = 0, Position = UDim2.fromScale(0.041+(i*0.167), 0.333), Size = UDim2.fromScale(0.0833, 0.5), ZIndex = 3, Name = "Rod1" })
		rod[i] = Screen:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#00FF00"), BorderColor3 = Color3.fromHex("#1B2A35"), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, -(fuel/1)), ZIndex = 3, Name = "FUEL" })
		rod[i].Parent = fil
		fil.Parent = rEACTOR
	end

	Card.Parent = scrollingFrame; 	rEACTOR.Parent = Card; 		background.Parent = rEACTOR; 			TempLabel.Parent = background; 	   	fUEl.Parent = Card; 	tIT.Parent = Card; 	reactorNumber.Parent = Card; 	title.Parent = Card; 
	numb += 1

	Events[ind] = safecall(function()

		local Fuels = Reactor:GetFuel()
		local RodsInserted = 0
		local NeedsFuel = false
		local f = 0

		for i, Fuel in Fuels do
			rod[i].Size = UDim2.fromScale(1,-(Fuel/1))
			if Fuel == -1 then
				Polysilicon.PolysiliconMode = 2
				TriggerPort(Port)
			end
			if Fuel <= 0 then
				NeedsFuel = true
			else
				RodsInserted += 1
			end
			f += Fuel
		end
		f/= 4
		fUEl.Text = math.round(f*1000)/1000
		TempLabel.Text = math.round(Reactor:GetTemp())
		if RodsInserted < 4 then
			Dispenser:Dispense()
			RodsInserted += 1
		end
		if RodsInserted <= 0 then return end
		local Diff = TargetTemp - Reactor:GetTemp()
		local NewRods = math.ceil(math.clamp(10 - (Diff * 3 + 20) / math.max(RodsInserted, 1), 0, 10))
		Rods = SetRods(NewRods, Rods, Port, Polysilicon)
		Polysilicon.PolysiliconMode = 2
		-- ((10-Rods)*RodsInserted-20)/3
	end)
end

rEACTORCOUNT.Text = #Ports

GetPartFromPort(Ports[1], "Reactor").Loop:Connect(function()
	
	local T,F = GetTempandfuel()
	fUEL4.Text = math.round(F*100)/100
	tEMPAVERGAE.Text = math.round(T)
	
	for ind, Port in Ports do
		Events[ind]()
	end
end)