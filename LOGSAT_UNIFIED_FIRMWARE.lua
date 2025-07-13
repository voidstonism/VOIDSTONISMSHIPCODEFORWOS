--MainFramework by VO1D_STONE, Optimized and Cleaned up by ChatGPT

--Required
local Modem = GetPart("Modem")
local Microphone = GetPart("Microphone")
local Instrument = GetPart("Instrument")

--Optional
local BlackBox = GetPart("BlackBox") 
local LifeSensor = GetPart("LifeSensor")
local Telescope = GetPart("Telescope")

local MaxAge = 10 * 24 * 60 * 60

--ImportantInfo
local PlayerService = require("players")
local coord = Telescope and Telescope:GetCurrentCoordinate()
local RegionName = coord and "(" .. tostring(coord) .. ")"  or (GetPart("Sign") and GetPart("Sign").SignText) or "UNKNOWN"
local WebHook = "https://webhook.lewisakura.moe/api/webhooks/1355610642945544402/aDziyWRgN1lmZVdwNT6AYM8XLnEpApOBD3sna1A-fG7jwPoE2VONqZ0OZ8syd8QobYHW"
local SessionTimeStamp = DateTime.now().UnixTimestamp

local Warplogs, ChatLogs = {}, {}

local DEBUG
-- local DEBUG = true

local EventFilter = {
	["HyperDrive is warping to"] = true,
	["Spawned"] = true,
}

local function DebugPrint(msg)
	if DEBUG then print(msg) end
end

local function PadZero(n)
	return n < 10 and "0" or ""
end

local function FormatTime(seconds)
	local sec = seconds % 60
	local min = math.floor(seconds / 60)
	local hr = math.floor(min / 60)

	return `{PadZero(hr)}{hr}:{PadZero(min)}{min}:{PadZero(sec)}{sec}`
end

local function GetPlayers()
	if not LifeSensor then
		return "Error: Cannot retrieve players, LifeSensor is missing."
	end

	local names = {}
	for _, id in LifeSensor:ListPlayers() do
		table.insert(names, PlayerService:GetUsername(id))
	end
	return table.concat(names, ", ")
end

local function SendMessage(message, header)
	local success, result = pcall(function()
		local elapsed = DateTime.now().UnixTimestamp - SessionTimeStamp

		local embed = {
			username = RegionName,
			embeds = {{
				title = header,
				description = message,
				color = 15844367,
				footer = {
					text = `Session Time: {FormatTime(elapsed)} | Position: {Vector3.new(math.round(Modem.Position.X), math.round(Modem.Position.Y), math.round(Modem.Position.Z))} | Power: {math.round(Instrument:GetReading("Power"))}`
				}
			}},
		}

		Modem:PostAsync(WebHook, JSONEncode(embed))
	end)

	DebugPrint(success)
	return success
end

Microphone.Chatted:Connect(function(userId, message)
	local username = PlayerService:GetUsername(userId)
	table.insert(ChatLogs, `**[{username}]:** {message}`)
end)

local function ProcessBlackBox()
	if BlackBox then
        local logs = BlackBox:GetLogs()
        for _, log in logs do
            if EventFilter[log.Event] and log.TimeAgo < MaxAge then
                table.insert(Warplogs, `Region Activity Detected! {FormatTime(math.round(log.TimeAgo))} hours ago {log.Desc}`)
            end
        end
    
        local message = table.concat(Warplogs, "\n")

        if SendMessage(message, "BlackBox " .. RegionName) then
            print("Success! Region log sent.")
            table.clear(Warplogs)
        else
            print("Failure.")
        end

    else
        SendMessage("Error: Cannot retrieve logs, BlackBox is missing.", RegionName)
	end
end

local function ProcessChatLogs()
	if #ChatLogs == 0 then return end

	local message = table.concat(ChatLogs, "\n")
	if SendMessage(message, "ChatLogs " .. RegionName) then
		print("Success! Chat logs sent.")
		table.clear(ChatLogs)
	else
		print("Failure.")
		print(message)
	end
end


SendMessage(`The Region has started, loaded by: {GetPlayers()}`, RegionName)

wait(3)

ProcessBlackBox()


while task.wait(10) do
	ProcessChatLogs()
end