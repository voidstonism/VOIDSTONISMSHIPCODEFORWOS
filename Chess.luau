local Screen = GetPart("TouchScreen") or GetPart("TouchScreen") 

local X = { [1] = "A", [2] = "B", [3] = "C", [4] = "D", [5] = "E", [6] = "F", [7] = "G", [8] = "H" }

local Teams = { White = "White", Black = "Black" }

local TeamTurn = "White"

local PieceImages = {
	White = {
		Pawn = "http://www.roblox.com/asset/?id=12705284280",
		Rook = "http://www.roblox.com/asset/?id=12705040502",
		Knight = "http://www.roblox.com/asset/?id=139556054457546",
		Bishop = "http://www.roblox.com/asset/?id=108208024676682",
		Queen = "http://www.roblox.com/asset/?id=12705266883",
		King = "http://www.roblox.com/asset/?id=12705276436"
	},
	Black = {
		Pawn = "http://www.roblox.com/asset/?id=12705282472", -- Replace with black pawn asset ID
		Rook = "http://www.roblox.com/asset/?id=12705043688",
		Knight = "http://www.roblox.com/asset/?id=12593930998",
		Bishop = "http://www.roblox.com/asset/?id=135654556788627",
		Queen = "http://www.roblox.com/asset/?id=12705264073",
		King = "http://www.roblox.com/asset/?id=12705274158"
	}
}


local Pieces = {
	["Pawn"] = {
		Position = "";
		Range = 1;
		CanReverse = false;
		Team = nil;
		Type = "Pawn";
	};
	["Rook"] = {
		Position = "";
		Range = 7;
		CanReverse = true;
		Team = nil;
		Type = "Rook";
	};
	["Knight"] = {
		Position = "";
		Range = 1; -- special movement, not linear
		CanReverse = true;
		Team = nil;
		Type = "Knight";
	};
	["Bishop"] = {
		Position = "";
		Range = 7;
		CanReverse = true;
		Team = nil;
		Type = "Bishop";
	};
	["Queen"] = {
		Position = "";
		Range = 7;
		CanReverse = true;
		Team = nil;
		Type = "Queen";
	};
	["King"] = {
		Position = "";
		Range = 1;
		CanReverse = true;
		Team = nil;
		Type = "King";
	};
}

local PieceLocation = {}
local Tiles = {}
local Alternate = true

local ValidMoveHighlight = Color3.fromRGB(255, 255, 0)
local PrimaryColor = Color3.fromRGB(114, 161, 83)
local SecondaryColor = Color3.fromRGB(255, 244, 196)

local HighlightedTiles = {}

function PositionToCoordinates(pos)
	local x = string.byte(string.sub(pos, 1, 1)) - 64
	local y = tonumber(string.sub(pos, 2, 2))
	return x, y
end

function CoordinatesToPosition(x, y)
	if x < 1 or x > 8 or y < 1 or y > 8 then return nil end
	return X[x] .. y
end

local function IsPathClear(startPos, endPos)
	local sx, sy = PositionToCoordinates(startPos)
	local ex, ey = PositionToCoordinates(endPos)

	local dx = ex - sx
	local dy = ey - sy

	local stepX = (dx == 0) and 0 or (dx > 0 and 1 or -1)
	local stepY = (dy == 0) and 0 or (dy > 0 and 1 or -1)

	local x, y = sx + stepX, sy + stepY

	while x ~= ex or y ~= ey do
		local pos = CoordinatesToPosition(x, y)
		for _, p in pairs(PieceLocation) do
			if p.Position == pos then
				return false
			end
		end
		x = x + stepX
		y = y + stepY
	end

	return true
end

function IsMoveLegal(piece, target)
	local sx, sy = PositionToCoordinates(piece.Position)
	local tx, ty = PositionToCoordinates(target)
	if not tx or not ty then return false end

	local dx = tx - sx
	local dy = ty - sy
	local absDx = math.abs(dx)
	local absDy = math.abs(dy)

	-- Cannot capture own piece
	for _, p in pairs(PieceLocation) do
		if p.Position == target and p.Team == piece.Team then
			return false
		end
	end

	if piece.Type == "Pawn" then
		local dir = piece.Team == "White" and 1 or -1
		
		-- Forward move by 1
		if dx == 0 and dy == dir then
			-- Check tile empty
			for _, p in pairs(PieceLocation) do
				if p.Position == target then return false end
			end
			return true
		end
		
		-- Double move on first move
		if dx == 0 and dy == 2 * dir then
			local startRow = (piece.Team == "White") and 2 or 7
			if sy ~= startRow then return false end
			
			-- Check both tiles empty
			local betweenPos = CoordinatesToPosition(sx, sy + dir)
			for _, p in pairs(PieceLocation) do
				if p.Position == betweenPos or p.Position == target then return false end
			end
			return true
		end
		
		-- Capture diagonally
		if absDx == 1 and dy == dir then
			for _, p in pairs(PieceLocation) do
				if p.Position == target and p.Team ~= piece.Team then
					return true
				end
			end
		end
		
		return false
	end

	if piece.Type == "Knight" then
		return (absDx == 2 and absDy == 1) or (absDx == 1 and absDy == 2)
	end

	if piece.Type == "Bishop" then
		if absDx == absDy and IsPathClear(piece.Position, target) then
			return true
		end
		return false
	end

	if piece.Type == "Rook" then
		if (dx == 0 or dy == 0) and IsPathClear(piece.Position, target) then
			return true
		end
		return false
	end

	if piece.Type == "Queen" then
		if ((absDx == absDy) or (dx == 0 or dy == 0)) and IsPathClear(piece.Position, target) then
			return true
		end
		return false
	end

	if piece.Type == "King" then
		if absDx <= 1 and absDy <= 1 then
			return true
		end
		-- Castling omitted for brevity
		return false
	end

	return false
end

local function FindKing(team)
	for _, p in pairs(PieceLocation) do
		if p.Team == team and p.Type == "King" then
			return p.Position
		end
	end
	return nil
end

local function IsKingInCheck(team)
	local kingPos = FindKing(team)
	if not kingPos then return false end

	for _, p in pairs(PieceLocation) do
		if p.Team ~= team and IsMoveLegal(p, kingPos) then
			return true
		end
	end
	return false
end

local function HasAnyLegalMoves(team)
	for _, p in pairs(PieceLocation) do
		if p.Team == team then
			for x = 1, 8 do
				for y = 1, 8 do
					local target = CoordinatesToPosition(x, y)
					if target and IsMoveLegal(p, target) then
						-- Simulate move
						local originalPos = p.Position
						local capturedIndex = nil
						local capturedPiece = nil
						for i, op in ipairs(PieceLocation) do
							if op.Position == target and op.Team ~= team then
								capturedIndex = i
								capturedPiece = op
								break
							end
						end
						p.Position = target
						if capturedIndex then table.remove(PieceLocation, capturedIndex) end

						local inCheck = IsKingInCheck(team)

						-- Undo move
						p.Position = originalPos
						if capturedIndex then table.insert(PieceLocation, capturedIndex, capturedPiece) end

						if not inCheck then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

local function IsCheckmate(team)
	return IsKingInCheck(team) and not HasAnyLegalMoves(team)
end

local SelectedPiece = nil
local SelectedPieceValidMoves = {}

local function ClearHighlights()
	for _, name in ipairs(HighlightedTiles) do
		local tile = Tiles[name]
		if tile then
			local x = string.sub(name, 1, 1)
			local y = tonumber(string.sub(name, 2, 2))
			local xIndex
			for i, v in ipairs(X) do if v == x then xIndex = i end end
			local isDark = (xIndex + y) % 2 == 0
			tile.BackgroundColor3 = isDark and PrimaryColor or SecondaryColor
		end
	end
	HighlightedTiles = {}
end

local function SelectOrMove(pos)
	if not SelectedPiece then
		for _, piece in pairs(PieceLocation) do
			if piece.Position == pos and piece.Team == TeamTurn then
				SelectedPiece = piece

				-- Find valid moves that don't leave king in check
				local validMoves = {}
				for x = 1, 8 do
					for y = 1, 8 do
						local target = CoordinatesToPosition(x, y)
						if target and IsMoveLegal(piece, target) then
							-- Simulate move
							local originalPos = piece.Position
							local capturedIndex = nil
							local capturedPiece = nil
							for i, op in ipairs(PieceLocation) do
								if op.Position == target and op.Team ~= piece.Team then
									capturedIndex = i
									capturedPiece = op
									break
								end
							end
							piece.Position = target
							if capturedIndex then table.remove(PieceLocation, capturedIndex) end

							local leavesCheck = IsKingInCheck(piece.Team)

							-- Undo move
							piece.Position = originalPos
							if capturedIndex then table.insert(PieceLocation, capturedIndex, capturedPiece) end
                            if not leavesCheck then
							table.insert(validMoves, target)
                            end
						end
					end
				end
			end

			SelectedPieceValidMoves = validMoves

			for _, move in ipairs(validMoves) do
				local tile = Tiles[move]
				if tile then
					tile.BackgroundColor3 = ValidMoveHighlight
					table.insert(HighlightedTiles, move)
				end
			end

			return
		end
	end
else
	local moveAllowed = false
	for _, validMove in ipairs(SelectedPieceValidMoves) do
		if validMove == pos then
			moveAllowed = true
			break
		end
	end

	if moveAllowed then
	-- Remove captured piece if any
	for i = #PieceLocation, 1, -1 do
		local other = PieceLocation[i]
		if other.Position == pos and other.Team ~= SelectedPiece.Team then
			table.remove(PieceLocation, i)
			break
		end
	end

	SelectedPiece.Position = pos
	UpdateLocation()

	local opponentTeam = (TeamTurn == "White") and "Black" or "White"

	if IsCheckmate(opponentTeam) then
		print(TeamTurn .. " wins by checkmate!")
	elseif IsKingInCheck(opponentTeam) then
		print(opponentTeam .. " is in check!")
	end

	TeamTurn = opponentTeam
else
	print("Illegal move")
end


	ClearHighlights()
	SelectedPiece = nil
	SelectedPieceValidMoves = {}
end
end

local function DetermineColor()
local Color = Alternate and SecondaryColor or PrimaryColor
Alternate = not Alternate
return Color
end

function CreateBoard()
for y = 1, 8 do
for x = 1, 8 do
local tileName = X[x] .. y
local Tile = Screen:CreateElement('ImageButton', {
Size = UDim2.fromScale(1/8, 1/8);
Position = UDim2.fromScale((x-1)/8, (y-1)/8);
BackgroundColor3 = DetermineColor();
Name = tileName;
AnchorPoint = Vector2.new(0, 0);
BorderSizePixel = 0;
})
