local function worldToScreenPoint(pos, cf, fov, dims, near)
	local objectPos = cf:Inverse() * pos
	local focalLength = dims.Y/2 / math.tan(math.rad(fov/2))
	return if objectPos.Z < near then
		{-objectPos.X/objectPos.Z*focalLength, -objectPos.Y/objectPos.Z*focalLength}
	else nil
end
local function PointToGui(pos: Vector2)
    return pos.Y * -50, pos.X * 50
end
local function _ProjectToPlane(src: Vector3, dest: Vector3)
    local direction = dest-src
    local rayToPlane = src + direction * (-src.Y / direction.Y)
    return Vector3.new(rayToPlane.X, rayToPlane.Z, src.Y)
end
local function ProjectPoint(src: Vector3, dest: Vector3)
    local direction = dest-src
    local rayToPlane = src + direction * (-src.Y / direction.Y)
    return Vector3.new(rayToPlane.Z * -50, rayToPlane.X * 50, src.Y)
    -- return Vector3.new(planePos.Y * -50, planePos.X * 50, planePos.Z)
end
local Screen = GetPart("TouchScreen") or GetPart("Screen")
local Parts = GetParts()
local OwnedParts = {}
for _, part in Parts do
    OwnedParts[part] = true
end
local TargettedPlayer: number = Microcontroller.PartLocked
local LifeSensor = GetPart("LifeSensor")
Screen.CursorPressed:Connect(function(cursor)
    TargettedPlayer = cursor.UserId
end)
local function CreateFrame(screen)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(10, 10)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundTransparency = 0
    Frame.BackgroundColor3 = Color3.new(1,1,1)
    Frame.BorderSizePixel = 0
    Frame.Parent = screen:GetCanvas()
    print("created frame")
    return Frame
end
local CubePoints = {
    Vector3.new(-1, -1, -1);
    Vector3.new(-1, -1, 1);
    Vector3.new(-1, 1, -1);
    Vector3.new(-1, 1, 1);
    Vector3.new(1, -1, -1);
    Vector3.new(1, -1, 1);
    Vector3.new(1, 1, -1);
    Vector3.new(1, 1, 1);
}
local Connections = {
    {1, 2};
    {1, 3};
    {1, 5};
    {2, 4};
    {2, 6};
    {3, 4};
    {3, 7};
    {4, 8};
    {5, 6};
    {5, 7};
    {6, 8};
    {7, 8};
}
local Lines = {
    Lines = {};
    Points = {}
}
function Lines:PositionLine(Frame: GuiObject, x1, y1, x2, y2)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Size = UDim2.fromOffset(math.sqrt((x1-x2)^2 + (y1-y2)^2), 1)
    Frame.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(0.5*(x1 + x2), 0.5*(y1 + y2))
    Frame.Rotation = math.deg(math.atan2(y2 - y1, x2 - x1))
end
function Lines:PositionPoint(Frame: GuiObject, x1, y1, dist, rot)
    local dims = 5 / dist
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Size = UDim2.fromOffset(dims, dims)
    Frame.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(x1, y1)
    Frame.Rotation = rot
end
function Lines:ProjectLine(line: any, point1: Vector3, point2: Vector3)
    local Frame = line[1]
    Frame.BackgroundTransparency = if point1.Z >0 and point2.Z >0 then 1 else 0.3
    if Frame.BackgroundTransparency ~= 1 then
        line[2] = point1.X
        line[3] = point1.Y
        line[4] = point2.X
        line[5] = point2.Y
    end
end
function Lines:ProjectPoint(point: any, point1: Vector3, dist)
    local Frame = point[1]
    Frame.BackgroundTransparency = if point1.Z >0 then 1 else 0.3
    if Frame.BackgroundTransparency ~= 1 then
        point[2] = point1.X
        point[3] = point1.Y
        point[4] = dist
    end
end
function Lines:AddLine(name, screen)
    local frame = CreateFrame(screen)
    local line = {frame, 0, 0, 1, 1}
    self.Lines[name] = line
    return line
end
function Lines:AddPoint(name, screen)
    local frame = CreateFrame(screen)
    local point = {frame, 0, 0, 2, 0}
    self.Points[name] = point
    return point
end
function Lines:Update()
    for _, point in self.Points do
        self:PositionPoint(table.unpack(point))
    end
    for _, line in self.Lines do
        self:PositionLine(table.unpack(line))
    end
end
--[=[
local Viewer = {
    Parts = {};
}
function Viewer:AddPart(part)
    if Viewer.Parts[part] then
        return
    end
    local frames = Viewer.Parts[part]
    if frames then
        return frames
    else
        frames = {}
    end
    for ind, point in Connections do
        frames[ind] = CreateFrame(nil)
    end
    Viewer.Parts[part] = frames
    part.Destroying:Connect(function()
        for _, line in frames do
            for _, frame in line do
                frame:Destroy()
            end
        end
        Viewer.Parts[part] = nil
    end)
    return frames
end
--]=]
local PlayerModule = {
    Players = {}
}
function PlayerModule:Update(LifeSensor, add, remove, update, ...)
    local players = self.Players
    local reading = {}
    for _, obj in GetParts("Diamond") do
        local pos = obj.Position
        reading[obj] = pos --pos.Unit * math.log(pos.Magnitude) * 3e4
    end
    for player, pos in reading do
        if not players[player] then
            add(player, ...)
            players[player] = pos
        end
        update(player, pos, ...)
    end
    for player, pos in players do
        if not reading[player] then
            remove(player, ...)
            players[player] = nil
        end
    end
end
--[=[
for _, part in GetParts() do
    Viewer:AddPart(part)
end
task.spawn(function()
    while true do
        for _, part in GetPart("Scanner"):GetPartsInRange() do
            if OwnedParts[part] or not part:HasPermission("Configure") then continue end
            Viewer:AddPart(part)
        end
        task.wait(10)
    end
end)
--]=]
local screenRadius = 4
local function toRadarSpace(vec)
    return (vec/1e6+Vector3.new(0.5,-1))*screenRadius
end
local function updatePlayer(player, pos, shipCF, objectDest)
    local relativePos = shipCF:Inverse() * pos
    local radarPos = toRadarSpace(relativePos)
    local l1 = ProjectPoint(toRadarSpace(relativePos * Vector3.new(0, 1, 1)), objectDest)
    local l2 = ProjectPoint(radarPos, objectDest)
    Lines:ProjectLine(Lines.Lines[player], l1 ,l2)
    Lines:ProjectPoint(Lines.Points[player], l2, radarPos.Magnitude / screenRadius)
end
local function radarCircle(objectDest)
    local points = {}
    for i = 0, 63 do
        local angle = i/64 * 2*math.pi
        points[i] = ProjectPoint(toRadarSpace(Vector3.new(0, math.cos(angle) * 1e6, math.sin(angle) * 1e6)), objectDest)
    end
    for i = 0, 63 do
        Lines:ProjectLine(Lines.Lines[i], points[i], points[(i + 1)%64])
    end
end
local function addPlayer(player)
    local line = Lines:AddLine(player, Screen)
    line[1].BackgroundColor3 = Color3.new(0, 1, 1)
    local point = Lines:AddPoint(player, Screen)
    if player ~= "LuaBloxor" then
        point[1].BackgroundColor3 = Color3.new(1, 0, 0)
    end
end
local function removePlayer(player)
    local line = Lines.Lines[player]
    line[1]:Destroy()
    Lines.Lines[player] = nil
    local point = Lines.Points[player]
    point[1]:Destroy()
    Lines.Points[player] = nil
end
for i = 0, 63 do
    local line = Lines:AddLine(i, Screen)
    line[1].BackgroundColor3 = Color3.new(1, 0.6 ,0)
end
while true do
    local CPUTime1 = pilot.getCPUTime()
    local surfaceCF = Screen.CFrame * CFrame.new(0, Screen.Size.Y * 0.5, 0)
    local cameraPos: CFrame = LifeSensor:GetPlayers()[TargettedPlayer] * CFrame.new(0, 0, 0.5)
    local objectDest = surfaceCF:Inverse() * cameraPos.Position
    PlayerModule:Update(LifeSensor, addPlayer, removePlayer, updatePlayer, surfaceCF.Rotation + LifeSensor.Position, objectDest)
    radarCircle(objectDest)
    --[=[
        for part, frames in Viewer.Parts do
            local screenPoints = {}
            for ind, point in CubePoints do
                local objectSrc = surfaceCF:Inverse() * part.CFrame * (point*part.Size/2)
                screenPoints[ind] = ProjectPoint(objectSrc, objectDest)
            end
            for ind, points in Connections do
                Lines:ProjectLine(frames[ind][i], screenPoints[points[1]], screenPoints[points[2]])
            end
        end
    --]=]
    Lines:Update()
    local CPUTime2 = pilot.getCPUTime()
    task.wait((CPUTime2 - CPUTime1)/50)
end