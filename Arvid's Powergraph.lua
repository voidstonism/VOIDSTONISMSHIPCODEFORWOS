local screenA = assert(GetPartFromPort(1, "Screen"), "at least 1 screen must be attached")
local screenB = GetPartFromPort(2, "Screen")

screenA:ClearElements()
if screenB then
	screenB:ClearElements()
end

local instrument = assert(GetPartFromPort(2, "Instrument"), "no instrument")
local disk = assert(GetPartFromPort(2, "Disk"), "no disk")

--stylua: ignore start

local graphBackground = screenA:CreateElement("ImageLabel", { Image = "rbxassetid://3899340539", ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(120, 120), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromHex("#FFFFFF"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
local barGraphContainer = screenA:CreateElement("ScrollingFrame", { BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png", CanvasSize = UDim2.new(), ScrollBarImageColor3 = Color3.fromHex("#1F1F1F"), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.X, TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png", VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar, Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 36), Size = UDim2.new(1, -12, 1, -42) })

local graphHeader = screenA:CreateElement("Frame", { Active = true, BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Selectable = true, Size = UDim2.new(1, -12, 0, 30), SelectionGroup = true })
local graphTitle = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0, 24) })
screenA:CreateElement("TextLabel", { Text = "Power Graph", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -6, 1, -6) }).Parent = graphTitle

local statsBackground = if screenB
	then screenB:CreateElement("ImageLabel", { Image = "rbxassetid://3899340539", ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(120, 120), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromHex("#FFFFFF"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
	else graphBackground

local sessionDataContainer, allTimeDataContainer
local screenSize = (screenB or screenA):GetDimensions()

if screenSize.X > screenSize.Y then
	sessionDataContainer = screenA:CreateElement("Frame", { Active = true, AnchorPoint = Vector2.new(0, 0), BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Selectable = true, Size = UDim2.new(0.5, -9, 1, -12), SelectionGroup = true })
	allTimeDataContainer = screenA:CreateElement("Frame", { Active = true, AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(1, -6, 0, 6), Selectable = true, Size = UDim2.new(0.5, -9, 1, -12), SelectionGroup = true })
else
	sessionDataContainer = screenA:CreateElement("Frame", { Active = true, AnchorPoint = Vector2.new(0, 0), BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(0, 6, 0, 6), Selectable = true, Size = UDim2.new(1, -12, 0.5, -9), SelectionGroup = true })
	allTimeDataContainer = screenA:CreateElement("Frame", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromHex("#3E3E3E"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.new(0, 6, 1, -6), Selectable = true, Size = UDim2.new(1, -12, 0.5, -9), SelectionGroup = true })
end

local sessionDataTitle = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0, 24) })
screenA:CreateElement("TextLabel", { Text = "Session Data", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -6, 1, -6) }).Parent = sessionDataTitle

local currentPower = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 30), Size = UDim2.new(1, -6, 0, 18) })
local currentPowerText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Current Power:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = currentPower

local highestSession = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 51), Size = UDim2.new(1, -6, 0, 18) })
local highestSessionText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Highest Power:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = highestSession

local lowestSession = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 72), Size = UDim2.new(1, -6, 0, 18) })
local lowestSessionText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Lowest Power:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = lowestSession

local averageSession = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 93), Size = UDim2.new(1, -6, 0, 18) })
local averageSessionText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Average Trend:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = averageSession

local allTimeDataTitle = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 0, 24) })
screenA:CreateElement("TextLabel", { Text = "All Time Data", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -6, 1, -6) }).Parent = allTimeDataTitle

local averageAllTime = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 72), Size = UDim2.new(1, -6, 0, 18) })
local averageAllTimeText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Average Trend:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = averageAllTime

local highestAllTime = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 30), Size = UDim2.new(1, -6, 0, 18) })
local highestAllTimeText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Highest Power:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = highestAllTime

local lowestAllTime = screenA:CreateElement("Frame", { BackgroundColor3 = Color3.fromHex("#1F1F1F"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(3, 51), Size = UDim2.new(1, -6, 0, 18) })
local lowestAllTimeText = screenA:CreateElement("TextLabel", { Text = "N/A", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
screenA:CreateElement("TextLabel", { Text = "Lowest Power:", TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) }).Parent = lowestAllTime

sessionDataContainer.Parent = statsBackground
sessionDataTitle.Parent = sessionDataContainer
currentPower.Parent = sessionDataContainer
currentPowerText.Parent = currentPower
highestSession.Parent = sessionDataContainer
highestSessionText.Parent = highestSession
lowestSession.Parent = sessionDataContainer
lowestSessionText.Parent = lowestSession
averageSession.Parent = sessionDataContainer
averageSessionText.Parent = averageSession

allTimeDataContainer.Parent = statsBackground
allTimeDataTitle.Parent = allTimeDataContainer
averageAllTime.Parent = allTimeDataContainer
averageAllTimeText.Parent = averageAllTime
highestAllTime.Parent = allTimeDataContainer
highestAllTimeText.Parent = highestAllTime
lowestAllTime.Parent = allTimeDataContainer
lowestAllTimeText.Parent = lowestAllTime

graphHeader.Parent = graphBackground
graphTitle.Parent = graphHeader
barGraphContainer.Parent = graphBackground

if not screenB then
	sessionDataContainer.AnchorPoint = Vector2.new(0, 1)
	sessionDataContainer.Position = UDim2.new(0, 6, 1, -6)
	sessionDataContainer.Size = UDim2.new(0.5, -9, 0, 114)

	allTimeDataContainer.AnchorPoint = Vector2.new(1, 1)
	allTimeDataContainer.Position = UDim2.new(1, -6, 1, -6)
	allTimeDataContainer.Size = UDim2.new(0.5, -9, 0, 114)

	barGraphContainer.AnchorPoint = Vector2.new(0.5, 0)
	barGraphContainer.Position = UDim2.new(0.5, 0, 0, 36)
	barGraphContainer.Size = UDim2.new(1, -12, 1, -162)
end

local Components = {
	Bar = function(Power: number, Index: number)
		local mainColour = if Power < 0 then Color3.fromRGB(255, 127, 127) else Color3.fromRGB(127, 255, 127)

		if math.abs(Power) <= 10 then
			local text = screenA:CreateElement("TextLabel", {
				Text = math.abs(math.round(Power)),
				AnchorPoint = Vector2.new(0, 0.5), 
				TextColor3 = if Power == 0 then Color3.fromRGB(64, 192, 255) else mainColour,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 6 + ( Index - 1 ) * 28, 0.5, 0),
				Size = UDim2.fromOffset(25, 15),
				TextSize = 10,
			})

			text.Parent = barGraphContainer
			return text
		end

		local powerBar = screenA:CreateElement("Frame", {
			AnchorPoint = Vector2.new(0, 1), 
			BackgroundColor3 = mainColour,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 6 + ( Index - 1 ) * 28, 0.5, 0),
			Size = UDim2.fromOffset(25, Power / 10)
		})

		if math.abs(Power) <= 500 then
			screenA:CreateElement("TextLabel", {
				Text = math.abs(math.round(Power)),
				TextColor3 = mainColour,
				TextSize = 10,
				AnchorPoint = Vector2.new(0.5, if Power < 0 then 0 else 1),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, if Power < 0 then 1 else 0),
				AutomaticSize = Enum.AutomaticSize.XY,
				TextXAlignment = Enum.TextXAlignment.Center,
			}).Parent = powerBar
		else
			screenA:CreateElement("TextLabel", {
				Text = math.abs(math.round(Power)),
				TextColor3 = if Power < 0 then Color3.fromRGB(200, 0, 0) else Color3.fromRGB(0, 150, 0),
				TextSize = 10,
				AnchorPoint = Vector2.new(0.5, if Power < 0 then 0 else 1),
				BackgroundTransparency = 1,
				Position = if Power < 0 then UDim2.new(0.5, 0, 0, 0) else UDim2.new(0.5, 0, 1, 0),
				Rotation = 90,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextXAlignment = if Power < 0 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Right,
			}).Parent = powerBar
		end

		powerBar.Parent = barGraphContainer
		return powerBar
	end,
}

--stylua: ignore end

local barFrames = {}
local lastPower: number = instrument:GetReading("Power") :: any

local totalLoops = 1
local sessionData = {
	Highest = lastPower,
	Lowest = lastPower,
	HighestChange = -math.huge,
	LowestChange = math.huge,
	Total = 0,
}

instrument.Loop:Connect(function()
	local currentPower: number = instrument:GetReading("Power") :: any
	local powerChange = currentPower - lastPower
	lastPower = currentPower

	while #barFrames >= 100 do
		local firstBar: Instance = table.remove(barFrames) :: any
		firstBar:Destroy()
	end

	for index, barFrame in barFrames do
		barFrame.Position = UDim2.new(0, 6 + index * 28, 0.5, 0)
	end

	local newBar = Components.Bar(powerChange, 1)
	table.insert(barFrames, 1, newBar)

	sessionData.HighestChange = math.max(powerChange, sessionData.HighestChange)
	sessionData.LowestChange = math.min(powerChange, sessionData.LowestChange)

	sessionData.Highest = math.max(currentPower, sessionData.Highest)
	sessionData.Lowest = math.min(currentPower, sessionData.Lowest)
	sessionData.Total += powerChange

	local allTimeData = disk:ReadAll()
	allTimeData.Highest = math.max(currentPower, allTimeData.Highest or 0)
	allTimeData.Lowest = math.min(currentPower, allTimeData.Lowest or math.huge)
	allTimeData.Total = (allTimeData.Total or 0) + powerChange
	allTimeData.TotalLoops = allTimeData.TotalLoops or 1

	currentPowerText.Text = math.round(currentPower)
	highestSessionText.Text = math.round(sessionData.Highest)
	lowestSessionText.Text = math.round(sessionData.Lowest)
	averageSessionText.Text = math.round(sessionData.Total / totalLoops)

	highestAllTimeText.Text = math.round(allTimeData.Highest)
	lowestAllTimeText.Text = math.round(allTimeData.Lowest)
	averageAllTimeText.Text = math.round(allTimeData.Total / allTimeData.TotalLoops)

	barGraphContainer.CanvasSize = UDim2.fromOffset(6 + #barFrames * 28, 0)
	--sessionData.HighestChange + sessionData.HighestChange

	allTimeData.TotalLoops += 1
	totalLoops += 1

	for key, value in allTimeData do
		disk:Write(key, value)
	end
end)
