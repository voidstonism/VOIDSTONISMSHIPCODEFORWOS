local Screen = GetPart("Screen")
local Int = GetPart("Instrument")

local BackGround = Screen:CreateElement('ImageLabel',{
	AnchorPoint = Vector2.new(0.5,0.5);
	Size = UDim2.fromScale(0.9,0.9);
	Position = UDim2.fromScale(0.5,0.5);
	Rotation = 0;
	BackgroundColor3 = Color3.new(0.752941, 1, 0.647059);
	Image = "http://www.roblox.com/asset/?id=2489664746";
})

local HourHand = Screen:CreateElement('Frame',{
	AnchorPoint = Vector2.new(0.5,0.5);
	Size = UDim2.fromScale(0.5,0.5);
	Position = UDim2.fromScale(0.5,0.5);
	Rotation = 0;
	Transparency = 1;
	BorderSizePixel = 0
})

local HourHandSubject = Screen:CreateElement('Frame',{
	AnchorPoint = Vector2.new(0.5,1);
	Size = UDim2.fromScale(0.025,0.43);
	Position = UDim2.fromScale(0.5,0.5);
	Rotation = 0;
	BorderSizePixel = 0;
	BackgroundColor3 = Color3.new(0, 0, 0);
})

HourHandSubject.Parent = HourHand

local MinuteHand = Screen:CreateElement('Frame',{
	AnchorPoint = Vector2.new(0.5,0.5);
	Size = UDim2.fromScale(0.5,0.5);
	Position = UDim2.fromScale(0.5,0.5);
	Rotation = 0;
	Transparency = 1
})

local MinuteHandSubject = Screen:CreateElement('Frame',{
	AnchorPoint = Vector2.new(0.5,1);
	Size = UDim2.fromScale(0.025,0.6);
	Position = UDim2.fromScale(0.5,0.5);
	Rotation = 0;
	BorderSizePixel = 0;
	BackgroundColor3 = Color3.new(0, 0, 0);
})

MinuteHandSubject.Parent = MinuteHand

function InterPolate(Subject,Speed,GoalRotation)
	local StartRotation = Subject.Rotation
	local Increment = (GoalRotation - StartRotation)/Speed
	if Increment < 0 then
		Subject.Rotation = GoalRotation
		return
	end
	
	for i = 1,Speed do
		Subject.Rotation = Subject.Rotation + Increment
		wait(1/Speed)
	end
	return
end

local function INTIATE()
	local Reading = Int:GetReading("Time")
	local Split = string.split(Reading,":")
	local Hour = tonumber(Split[1])
	local Minute = tonumber(Split[2])

	if Hour > 12 then
		Hour = Hour - 12
	end

	local HourDegree = (Hour+(Minute/60))*30
	local MinuteDegree = (Minute*6)
	
	
	MinuteHand.Rotation = MinuteDegree
	HourHand.Rotation= HourDegree
end

INTIATE()

wait()

while task.wait(1) do
	local Reading = Int:GetReading("Time")
	local Split = string.split(Reading,":")
	local Hour = tonumber(Split[1])
	local Minute = tonumber(Split[2])
	
	if Hour > 12 then
		Hour = Hour - 12
	end

	local HourDegree = (Hour+(Minute/60))*30
	local MinuteDegree = (Minute*6)
	
	
	task.spawn(InterPolate,MinuteHand,60,MinuteDegree)
	task.spawn(InterPolate,HourHand,60,HourDegree)
end