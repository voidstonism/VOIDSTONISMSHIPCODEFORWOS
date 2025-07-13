local Keyboard = GetPart("Keyboard")
local KeyboardIDCHANGER = GetPart("Keyboard")
local speak = GetPart("Speaker")
local modem = GetPart("Modem")
local Screen = assert(GetPart("Screen") or GetPart("TouchScreen"),"Screen appears to be missing.")
local MicroPhone = GetPart("Microphone")
local PlayerService:PlacesService = require("players")

Screen:ClearElements()

num = 0

--Messages sent out are compatible with Arvid's Chat Modem which Uses the `{Name} | {Message}` format, ID M1 is standard.

local Frame = Screen:CreateElement("Frame",{Size = UDim2.fromScale(1,1),AnchorPoint = Vector2.new(0.5,0.5),Position = UDim2.fromScale(0.5,0.5);BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 0,})
local IDLabel:ImageLabel = Screen:CreateElement("ImageLabel",{Size = UDim2.fromScale(0.35,0.14),AnchorPoint = Vector2.new(0,0),Position = UDim2.fromScale(0.025,0.025);BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 0,Image = "rbxassetid://108167164039020";})
local Chats:ScrollingFrame = Screen:CreateElement("ScrollingFrame",{Size = UDim2.fromScale(0.6,0.93),AnchorPoint = Vector2.new(0.5,0.5),Position = UDim2.fromScale(0.69,0.5);BackgroundColor3 = Color3.new(0.204685, 0.204685, 0.204685),BackgroundTransparency = 0,Rotation = 0;CanvasSize = UDim2.fromScale(0.5,1);AutomaticCanvasSize = Enum.AutomaticSize.Y;})
local RefreshButton:TextButton = Screen:CreateElement("TextButton",{Size = UDim2.fromScale(0.1,0.1),AnchorPoint = Vector2.new(0,0),Position = UDim2.fromScale(0.25,0.8);BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 0,Text = "Refresh"})
local ClearButton:TextButton = Screen:CreateElement("TextButton",{Size = UDim2.fromScale(0.1,0.1),AnchorPoint = Vector2.new(0,0),Position = UDim2.fromScale(0.25,0.65);BackgroundColor3 = Color3.new(1, 0, 0),BackgroundTransparency = 0,Text = "Clear",TextColor3 = Color3.new(1, 1, 1)})
local HelpButton:TextButton = Screen:CreateElement("TextButton",{Size = UDim2.fromScale(0.1,0.1),AnchorPoint = Vector2.new(0,0),Position = UDim2.fromScale(0.25,0.5);BackgroundColor3 = Color3.new(0.235294, 1, 0),BackgroundTransparency = 0,Text = "Help",TextColor3 = Color3.new(1, 1, 1)})
local IdLABEL:TextLabel = Screen:CreateElement("TextLabel",{Size = UDim2.fromScale(0.1,0.1),AnchorPoint = Vector2.new(0,0),Position = UDim2.fromScale(0.25,0.35);BackgroundColor3 = Color3.new(0, 0, 0),BackgroundTransparency = 0,Text = modem.NetworkID,TextColor3 = Color3.new(1, 1, 1)})



local frame = Screen:CreateElement("Frame", {BackgroundColor3 = Color3.fromHex("#3F3F3F"), BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.23), Size = UDim2.fromScale(0.17, 0.69) })
local imageLabel = Screen:CreateElement("ImageLabel", { Image = "http://www.roblox.com/asset/?id=4584251621", BackgroundColor3 = Color3.fromHex("#FFFFFF"), BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
local power = Screen:CreateElement("ImageLabel", { Image = "http://www.roblox.com/asset/?id=1145367640", ImageColor3 = Color3.fromHex("#00FF00"), ScaleType = Enum.ScaleType.Slice, SliceScale = -0.05, AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -5, 1, -5), Size = UDim2.fromScale(0.15, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX })
local recieve = Screen:CreateElement("ImageLabel", { Image = "http://www.roblox.com/asset/?id=1145367640", ImageColor3 = Color3.fromHex("#000000"), ScaleType = Enum.ScaleType.Slice, SliceScale = -0.05, AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -35, 1, -5), Size = UDim2.fromScale(0.15, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX })
local status = Screen:CreateElement("ImageLabel", { Image = "http://www.roblox.com/asset/?id=1145367640", ImageColor3 = Color3.fromHex("#000000"), ScaleType = Enum.ScaleType.Slice, SliceScale = -0.05, AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromHex("#FFFFFF"), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -20, 1, -5), Size = UDim2.fromScale(0.15, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX })

imageLabel.Parent = frame
power.Parent = frame
recieve.Parent = frame
status.Parent = frame

local Elements = {}
local Command = "/send"

--speak:Chat(`Hello!, type in the keybaord to chat or type "{Command} [Message]" to chat via microphone`)

function AddTextbox(msg)
	num += 1

	local size = 0.25

	local Args = string.split(msg," | ")

	local Name, Message = Args[1], Args[2]

	if #Args > 2 then
		for i = 3, #Args, 1 do
			Message = Message..Args[i]
		end
	elseif #Args <= 1 then
		Message = msg
		Name = "Unknown Device"
	end

	Elements[num] = Screen:CreateElement("Frame", {Size = UDim2.fromScale(0.85,size),AnchorPoint = Vector2.new(0.5,0.5),Position = UDim2.fromScale(0.5,-size/2);BackgroundColor3 = Color3.new(1, 1, 1),BackgroundTransparency = 0;Rotation = 0;})

	local text = Screen:CreateElement("TextLabel", { Text = Message, TextColor3 = Color3.fromHex("#000000"), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, BackgroundColor3 = Color3.fromHex("#FFFFFF"), BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(1, 0.8), Name = Message })
	local name = Screen:CreateElement("TextLabel", { Text = Name, TextColor3 = Color3.fromHex("#FFFFFF"), TextScaled = true, TextSize = 27, TextWrapped = true, BackgroundColor3 = Color3.fromHex("#2F2F2F"), BorderColor3 = Color3.fromHex("#000000"), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 0.01), Size = UDim2.fromScale(0.48, 0.19) })

	text.Parent = Elements[num]
	name.Parent = Elements[num]

	for _, Element:TextLabel in Elements do
		Element.Position = UDim2.fromScale(0.5,Element.Position.Height.Scale + size)
	end
	Elements[num].Parent = Chats
end

RefreshButton.MouseButton1Click:Connect(function()
	for _, Element:Frame in Elements do
		local TextLB = Element:FindFirstChildWhichIsA("TextLabel")
		TextLB.Text = TextLB.Name
		print(TextLB.Name)
	end
end)

HelpButton.MouseButton1Click:Connect(function()
	Beep(0.5)
	--speak:Chat(`Hello!, type in the keybaord to chat or type "{Command} [Message]" to chat via microphone`)
end)

ClearButton.MouseButton1Click:Connect(function()
	for _, Element:Frame in Elements do
		Element:Destroy()
	end
	Elements = {}
	num = 0
	Beep(0.4)
end)

MicroPhone.Chatted:Connect(function(plr,Text:string)
	if Text:lower():sub(0,Command:len()) == Command then
		local text = `{PlayerService:GetUsername(plr)} | {Text:gsub(`{Command} `,"")}`
		modem:SendMessage(text)
	end
end)


KeyboardIDCHANGER.TextInputted:Connect(function(msg,Player)
	local text = `{Player} | {msg:sub(1,-2)}`

	modem:SendMessage(text)

	Beep()

	status.ImageColor3 = Color3.fromHex("#FF8000")
	wait(0.2)
	status.ImageColor3 = Color3.fromHex("#000000")
end)

modem.MessageSent:Connect(function(msg)
	Beep(0.7)

	--speak:Chat(msg)
	AddTextbox(msg)

	recieve.ImageColor3 = Color3.fromHex("#007BFF")
	wait(0.2)
	recieve.ImageColor3 = Color3.fromHex("#000000")
end)