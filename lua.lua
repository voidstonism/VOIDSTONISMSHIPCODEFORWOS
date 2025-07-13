local KeyBoard = GetPart("Keyboard")
local ServoMany = GetParts("Servo")
local MotorMany = GetParts("Motor")

RestPosForServos = {}
GearRatio = 1

for i, Servo in ServoMany do
	RestPosForServos["Servo"..i] = Servo.Angle
    Servo.ServoSpeed =  2
end

local KeyBindFunc = {
	[Enum.KeyCode.D] = function()
		for i, Servo in ServoMany do
			Servo:SetAngle(RestPosForServos["Servo"..i]+45)
		end
	end,
	[Enum.KeyCode.A] = function()
		for i, Servo in ServoMany do
			Servo:SetAngle(RestPosForServos["Servo"..i]-45)
		end
	end,
	[Enum.KeyCode.W] = function()
		for i, Motor in MotorMany do
			Motor.Ratio = 1*GearRatio
		end
	end,
	[Enum.KeyCode.S] = function()
		for i, Motor in MotorMany do
			Motor.Ratio = -1*GearRatio
		end
	end,
	[Enum.KeyCode.E] = function()
		if GearRatio >= 10 then return end
		GearRatio += 1
	end,
	[Enum.KeyCode.Q] = function()
		if GearRatio <= 0 then return end
		GearRatio -= 1
	end,
	[Enum.KeyCode.R] = function()
		for i, Motor in MotorMany do
			Motor.Power = -1*Motor.Power
		end
	end,
}

function ReturnServo()
	for i, Servo in ServoMany do
		Servo:SetAngle(RestPosForServos["Servo"..i])
	end
end

function ReturnMotor()
    for i, Motor in MotorMany do
        Motor.Ratio = 0
    end
end

KeyBoard.UserInput:Connect(function(InputObject:InputObject,plyid) -- For Servos
	if InputObject.UserInputState == Enum.UserInputState.Begin then  
        KeyBindFunc[InputObject.KeyCode]()
    elseif InputObject.UserInputState == Enum.UserInputState.End and (InputObject.KeyCode == Enum.KeyCode.A or InputObject.KeyCode == Enum.KeyCode.D) then
        ReturnServo()
	elseif InputObject.UserInputState == Enum.UserInputState.End and (InputObject.KeyCode == Enum.KeyCode.W or InputObject.KeyCode == Enum.KeyCode.S) then
		ReturnMotor()
    end
end)