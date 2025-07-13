-- Imports
screen = GetPartFromPort(1, "TouchScreen")
modem = GetPartFromPort(1, "Modem")

-- Types
type Packet = {from: string, to: string, data: any}

-- Window Management
cancelRatio = 45/((screen:GetDimensions().Y * 0.8 * 0.15))
print(cancelRatio)
topFrameSize = screen:GetDimensions().Y*0.1
random = false
hold = nil
globalHold = false
users = {"tcw131106", "tcw131107"}
players = require("players")
windows = {}
function createWindow(name: string, sizeX: number, sizeY: number, color: Color3, function_data: string)
	
	local isActive = true
	local lockedIn = false
	
	local bottomFrame = screen:CreateElement("Frame", {
		Position = UDim2.fromScale(0.5-sizeX/2, (0.5-sizeY/2) - (topFrameSize/2)/screen:GetDimensions().Y + sizeY + 0.05),
		Size = UDim2.fromScale(sizeX, topFrameSize/(sizeY*screen:GetDimensions().Y) * sizeY),
		BackgroundColor3 = color,
		BackgroundTransparency = 0
	})
	local curve1b = Instance.new("UICorner")
	curve1b.Parent = bottomFrame
	curve1b.CornerRadius = UDim.new(0.45, 0)
	
	local mainFrame = screen:CreateElement("Frame", {
		Position = UDim2.fromScale(0.5-sizeX/2, 0.5-sizeY/2+0.05),
		Size = UDim2.fromScale(sizeX, sizeY),
		BackgroundColor3 = color,
		BorderSizePixel = 0
	})
	
	windows[name] = {frame = mainFrame}
	
	local connectFrame = screen:CreateElement("Frame", {
		Parent = mainFrame,
		Position = UDim2.fromScale(0, 0-topFrameSize/2/screen:GetDimensions().Y/sizeY),
		Size = UDim2.fromScale(1, topFrameSize/2/screen:GetDimensions().Y/sizeY),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	})
	
	
	local topFrame = screen:CreateElement("Frame", {
		Position = UDim2.fromScale(0.5-sizeX/2, (0.5-sizeY/2) - (topFrameSize/2)/screen:GetDimensions().Y),
		Size = UDim2.fromScale(sizeX, topFrameSize/(sizeY*screen:GetDimensions().Y) * sizeY),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0
	})
	
	
	
	local curve1 = Instance.new("UICorner")
	curve1.Parent = topFrame
	curve1.CornerRadius = UDim.new(0.45, 0)
	
	
	
	
	local buttonSize = (topFrameSize)/(screen:GetDimensions().X * sizeX)
	local buttonOffsetX = (0.1 * topFrameSize)/(screen:GetDimensions().X * sizeX)
	local cancelButton = screen:CreateElement("TextButton", {
		Parent = topFrame,
		Position = UDim2.fromScale(buttonOffsetX, 0.1),
		Size = UDim2.fromScale(buttonSize*0.8, 0.8),
		BackgroundColor = BrickColor.new(21),
		Text = "X",
		TextColor = BrickColor.new(26),
		FontFace = Font.new("rbxasset://fonts/families/Kanit.json"),
		TextSize = (screen:GetDimensions().Y * sizeY * 0.15) * cancelRatio,
		TextScaled = true
		

	})
	local curve2 = Instance.new("UICorner")
	curve2.Parent = cancelButton
	curve2.CornerRadius = UDim.new(1, 0)
	local upperText = screen:CreateElement("TextLabel", {
		Parent = topFrame,
		Position = UDim2.fromScale(buttonSize, 0),
		Size = UDim2.fromScale((1 - buttonSize*2), 1),
		Text = name,
		TextColor3 = Color3.fromRGB(26, 26, 26),
		TextScaled = true,
		FontFace = Font.new("rbxasset://fonts/families/Kanit.json"),
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	})
	wait(0.2)
	print(upperText.Text)
	
	task.spawn(function()
		while string.gsub(upperText.Text, "#", "A") ~= upperText.Text do
			upperText:ChangeProperties({
				Text = name
			})
			wait(0.25)
		end
	end)
	
	task.spawn(function()
		while string.gsub(cancelButton.Text, "#", "A") ~= cancelButton.Text do
			cancelButton:ChangeProperties({
				Text = "X"
			})
			wait(0.25)
		end
	end)
	
	
	
	loadstring(function_data)()


	cancelButton.MouseButton1Click:Connect(function()
		isActive = false
		mainFrame:Destroy()
		topFrame:Destroy()
		bottomFrame:Destroy()
	end)
	
	
	
	screen.CursorMoved:Connect(function()
		if hold == true and isActive == true then
			
			
			
			
			local cursors = screen:GetCursors()
			for player, cursor in cursors do
				if true then
					local startX = topFrame.Position.X.Scale * screen:GetDimensions().X
					local endX = startX + topFrame.Size.X.Scale * screen:GetDimensions().X
					local startY = topFrame.Position.Y.Scale * screen:GetDimensions().Y
					local endY = startY + topFrame.Size.Y.Scale * screen:GetDimensions().Y
					print(startX)
					print(cursor.X)
					print(endX)
					print(startY)
					print(cursor.Y)
					print(endY)
					if (startX < cursor.X and cursor.X < endX and startY < cursor.Y and cursor.Y < endY and globalHold == false) or lockedIn == true then
						lockedIn = true
						globalHold = true
						topFrame:ChangeProperties({
							Position = UDim2.fromScale(cursor.X/screen:GetDimensions().X-sizeX/2, cursor.Y/screen:GetDimensions().Y-topFrameSize/2/screen:GetDimensions().Y)
						})
						mainFrame:ChangeProperties({
							Position = UDim2.fromScale(cursor.X/screen:GetDimensions().X-sizeX/2, (cursor.Y+topFrameSize/2)/screen:GetDimensions().Y+0.05-topFrameSize/2/screen:GetDimensions().Y)
						})
						print("Screen X: " .. tostring(screen:GetDimensions().X))
						print("Screen Y: " .. tostring(screen:GetDimensions().Y))
						print("Frame X: " .. tostring(cursor.X))
						print("Frame Y: " .. tostring(cursor.Y+topFrameSize/2))
						bottomFrame:ChangeProperties({
							Position = UDim2.fromScale(cursor.X/screen:GetDimensions().X-sizeX/2, (cursor.Y+sizeY*screen:GetDimensions().Y)/screen:GetDimensions().Y+0.05-topFrameSize/2/screen:GetDimensions().Y)
						})

					end
				end
			end
		end
	end)
	
	screen.CursorReleased:Connect(function()
		hold = false
		lockedIn = false
		globalHold = false
		print("FIRE!!")
		print(hold)
		print(lockedIn)
		print(globalHold)
	end)

end

-- Internet System
function sendPacket(packet: Packet)
	if GetPartFromPort(1, "Port") then
		print("Modem connected..")
		print("Analyzing packet...")
		print("From: " .. packet.from)
		print("To: " .. packet.to)
		print("Data: " .. tostring(packet.data))
		print("Checking user...")
		if packet.from == modem.NetworkID then
			print("User valid")
			print("Sending to " .. packet.to .. "...")
			modem:SendMessage(packet.data, packet.to)
			print("Packet Sent!")
		else
			warn("User invalid, cancelled operation")
		end
	else
		warn("MODEM NOT CONNECTED!")
	end
end

if random == true then
	for i = 1, 10 do
		createWindow("Screen " .. tostring(i),math.random(),math.random(),Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)), {})
	end
else
	createWindow("Welcome",0.4, 0.25, Color3.fromRGB(68, 68, 68), [[
	text = screen:CreateElement("TextLabel", {
		Parent = windows["Welcome"].frame,
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(1, 0.7),
		Text = "hi!",
		TextScaled = true
	
	})	
	
	button = screen:CreateElement("TextButton", {
		Parent = windows["Welcome"].frame,
		Position = UDim2.fromScale(0, 0.7),
		Size = UDim2.fromScale(1, 0.3),
		Text = "pls click me",
		TextScaled = true
	
	})
	
	if button then
		print("button created")
	else
		error("button not created")
	end
	
	button.MouseButton1Click:Connect(function()
		print("clicked!")
		text:ChangeProperties({Text="bye!"})
	end)
	]])
end

hold = false
screen.CursorPressed:Connect(function()
	hold = true
	print("HOLDING!!!")
end)





coroutine.yield()




