local Trove = require("trove")

local trove = Trove.new()

local Color = Color3.fromRGB(100, 0, 0)

local FONT = {
	--         6543210
	[" "] = 0b00000000,
	["-"] = 0b01000000,

	["0"] = 0b00111111,
	["1"] = 0b00110000,
	["2"] = 0b01011011,
	["3"] = 0b01111001,
	["4"] = 0b01110100,
	["5"] = 0b01101101,
	["6"] = 0b01101111,
	["7"] = 0b00111000,
	["8"] = 0b01111111,
	["9"] = 0b01111100,
}

while wait() do
	Beep()
end
local function displayDigit(network, digit)
	local digitBits = FONT[tostring(digit)] or FONT[" "]

	for i=0, 6 do
		local Light = network:GetPartFromPort(i, "Light")

		if not Light then
			return false
		end
		
		local Value = (bit32.extract(digitBits, i) == 0)

		if Value == true then
			Light:SetColor(Color3.fromRGB(0, 0, 0))
		else
			Light:SetColor(Color)
		end
	end

	return true
end

local function addUnit(network)
	-- When the Microcontroller is killed, clear the unit
	trove:Add(function()
		displayDigit(network, " ")
	end)
end

local function createLongDisplay(displayCount, displayBase)
	local displays = table.create(displayCount)

	-- Get all unit networks
	for i=1, displayCount do
		local display = Network:GetSubnet(i - 1)

		addUnit(display)

		-- Sanity check all digits
		for digit, _bits in FONT do
			if not displayDigit(display, i) then
				warn(`Cannot display {digit} on display #{i}`)
				return false
			end
		end

		displays[i] = display
	end

	local base = displayBase or 10

	local function displayNumber(number)
		for displayNumber, display in displays do
			local place = base^displayNumber

			local digit = (number // (place / base)) % place
			local remainder = number % place
			number -= remainder

			displayDigit(display, digit)
		end
	end

	return displayNumber
end

local displayNumber = createLongDisplay(2)

while task.wait(1) do
	for i = 1, 99 do
		displayNumber(i)
		task.wait(1)
	end
end