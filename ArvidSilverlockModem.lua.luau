local messageData = {}
local nicknames = {}

local keyboard = assert(GetPart("Keyboard"), "no keyboard")
local modem = assert(GetPart("Modem"), "no modem")
local screen = assert(GetPart("Screen"), "no screen")

screen:ClearElements()

local background = screen:CreateElement("ImageLabel", {
	Image = "rbxassetid://8932515443",
	ImageColor3 = Color3.fromHex("#60BEFF"),
	ScaleType = Enum.ScaleType.Tile,
	TileSize = UDim2.fromOffset(120, 120),
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.fromScale(0.5, 0),
	Size = UDim2.fromScale(1, 1),
	BorderSizePixel = 0,
})
local scrollingFrame = screen:CreateElement("ScrollingFrame", {
	BottomImage = "rbxasset://textures/ui/InGameMenu/WhiteSquare.png",
	MidImage = "rbxasset://textures/ui/InGameMenu/WhiteSquare.png",
	ScrollBarThickness = 6,
	TopImage = "rbxasset://textures/ui/InGameMenu/WhiteSquare.png",
	VerticalScrollBarInset = Enum.ScrollBarInset.Always,
	Active = true,
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(3, 3),
	Size = UDim2.new(1, -6, 1, -6),
	BorderSizePixel = 0,
})
local container = screen:CreateElement("Frame", {
	Active = true,
	BackgroundTransparency = 1,
	ClipsDescendants = true,
	Selectable = true,
	Size = UDim2.new(1, -3, 1, 0),
	BorderSizePixel = 0,
	SelectionGroup = true,
})

scrollingFrame.Parent = background
container.Parent = scrollingFrame

local Components = {
	ChatFrame = function(Username: string, Message: string)
		local chatFrame = screen:CreateElement("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromHex("#FFFFFF"),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 16),
		})
		local padding = screen:CreateElement("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Position = UDim2.fromOffset(3, 3),
			Size = UDim2.new(1, -6, 1, -6),
		})

		local username = screen:CreateElement("TextLabel", {
			Text = Username,
			Font = Enum.Font.SourceSansBold,
			TextColor3 = Color3.new(),
			TextSize = 20,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 20),
		})
		local message = screen:CreateElement("TextLabel", {
			Text = Message,
			TextColor3 = Color3.new(),
			TextSize = 8,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 20),
			Size = UDim2.new(1, 0, 0, 8),
		})

		chatFrame.Parent = container
		padding.Parent = chatFrame
		username.Parent = padding
		message.Parent = padding

		return { chatFrame, padding, { message } }
	end,
}

local function DisplayMessage(data: string)
	local username, message = data:match("(%S*) | (.*)")
	if not username or not message then
		username, message = "unknown", data
	end

	message = message:match("^%s*(.-)%s*$")
	if #message == 0 then
		return
	end

	while #messageData > 15 do
		local data: any = table.remove(messageData)
		data.objects[1]:Destroy()
	end

	local lastMessage = messageData[1]

	if lastMessage ~= nil and lastMessage.username == username then
		local totalY = 0
		for _, message in lastMessage.objects[3] do
			totalY += message.AbsoluteSize.Y
		end

		local messageObj = screen:CreateElement("TextLabel", {
			Text = message,
			TextColor3 = Color3.new(),
			TextSize = 8,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 20 + totalY),
			Size = UDim2.new(1, 0, 0, 8),
		})

		messageObj.Parent = lastMessage.objects[2]

		table.insert(lastMessage.message, message)
		table.insert(lastMessage.objects[3], messageObj)
	else
		table.insert(messageData, 1, {
			username = username,
			message = { message },
			objects = Components.ChatFrame(username, message),
		})
	end

	task.wait()

	local totalMessageY = 0
	for i, data in messageData do
		local chatFrame = data.objects[1]
		chatFrame.Position = UDim2.fromOffset(0, totalMessageY + (i - 1) * 3)
		totalMessageY += chatFrame.AbsoluteSize.Y
	end

	scrollingFrame.CanvasSize = UDim2.fromOffset(0, totalMessageY + (#messageData - 1) * 3)
end

keyboard.TextInputted:Connect(function(text: string, username)
	local isCommand = text:match("^:")
	if isCommand then
		local parameters: { string } = (text:match("^%s*(.-)%s*$") :: any):split(" ")
		if #parameters < 0 then
			return
		end

		local command = (table.remove(parameters, 1) :: string):lower()

		if command == ":setcolor" then
			local r: any, g: any, b: any = table.unpack(parameters)
			r, g, b = tonumber(r), tonumber(g), tonumber(b)

			local colour = if parameters[1]:lower() == "default"
				then Color3.fromHex("#60BEFF")
				else Color3.fromRGB(r, g, b)

			background.ImageColor3 = colour
		elseif command == ":setname" then
			nicknames[username] = table.concat(parameters, " ")
		end
	else
		local usernameText = nicknames[username] or username
		local messageText = text:gsub("^\\:", ":")

		local data = usernameText .. " | " .. messageText
		modem:SendMessage(data)
	end
end)

modem.MessageSent:Connect(DisplayMessage)