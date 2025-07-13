local Bins = GetPartsFromPort(1, "Bin")
local Assemblers = GetPartsFromPort(1, "Assembler")

local FactoryPartMats = {
	Bin = {};
	Assembler = {};
}

local ExtractorsNeeded = {}
local AssemblersNeed = {}
local Binsneeded = {}
local UnthrottledTable = {}
local AssemblerList = {}

local BinAndTheirAmount = {}

local Throttle = 1-- 1 per x second

local FactoryConfigModes = {
	AssemblerConfig = {
		Base = {
			"MiningLaser"
		};
		Additional = {};
	};
}

-- Utils
local function CheckBin(bin)
	return bin.Resource
end

local function CheckAssembler(assembler)
	return assembler.Assemble
end

local function GetConfiguredAssemblerCount()
	local count = 0
	for _, assembler in ipairs(Assemblers) do
		if assembler.Assemble and assembler.Assemble ~= "" then
			count += 1
		end
	end
	return count
end


local function ThrottleTable()
	for k, v in pairs(ExtractorsNeeded) do
		ExtractorsNeeded[k] = math.ceil(v * (1 / Throttle))
	end
	for k, v in pairs(AssemblersNeed) do
		AssemblersNeed[k] = math.ceil(v * (1 / Throttle))
	end
end

local function GetAllMaterialsNeededtoAssemble(Material)
	local Recipe = Assemblers[1]:GetRecipe(Material)

	if Recipe then
		for Mats, Amount in pairs(Recipe) do
			if Assemblers[1]:GetRecipe(Mats) then
				AssemblersNeed[Mats] = (AssemblersNeed[Mats] or 0) + Amount
				for i=1,Amount do
					GetAllMaterialsNeededtoAssemble(Mats)
				end
			else
				ExtractorsNeeded[Mats] = (ExtractorsNeeded[Mats] or 0) + Amount
			end
		end
	else
		ExtractorsNeeded[Material] = (ExtractorsNeeded[Material] or 0) + 1
	end
end

local function Fillneed(Material)
	if Assemblers[1]:GetRecipe(Material) then
		AssemblersNeed[Material] = (AssemblersNeed[Material] or 0) + 1
		GetAllMaterialsNeededtoAssemble(Material)
	else
		ExtractorsNeeded[Material] = (ExtractorsNeeded[Material] or 0) + 1
	end
end

local function AssignMaterialIfUnassigned(partTable, configList, matType, assignKey)
	local i = 1
	for _, mat in ipairs(configList) do
		if FactoryPartMats[matType][mat] == nil then
			local part = partTable[i]
			if part then
				print("Assigning", assignKey, "to", mat)
				part[assignKey] = mat
				i += 1
			end
		else
			--warn("Woops!, already assigned .. "..assignKey)
		end
	end
end

local function PopulatePartResourceMap(partList, matType, checkFn)
	for _, part in ipairs(partList) do
		local resource = checkFn(part)
		if resource then
			FactoryPartMats[matType][resource] = part
		end
	end
end

local function CheckAndConfigure(Type, ResourceList)
	if Type == "Bin" then
		PopulatePartResourceMap(Bins, Type, CheckBin)
		AssignMaterialIfUnassigned(Bins, ResourceList, Type, "Resource")
	elseif Type == "Assembler" then
		PopulatePartResourceMap(Assemblers, Type, CheckAssembler)
		AssignMaterialIfUnassigned(Assemblers, ResourceList, Type, "Assemble")
	end
end

local function Setup()
	-- Fill extractors and assembler needs
	for _, Material in ipairs(FactoryConfigModes.AssemblerConfig.Base) do
		Fillneed(Material)
	end

	-- Populate binsneeded (combine both extractor and assembler needs)
	local Seen = {}
	for Resource in pairs(ExtractorsNeeded) do
		if not Seen[Resource] then
			table.insert(Binsneeded, Resource)
			Seen[Resource] = true
		end
	end
	for Resource in pairs(AssemblersNeed) do
		if not Seen[Resource] then
			table.insert(Binsneeded, Resource)
			Seen[Resource] = true
		end
	end

	-- Generate list of assembler tasks
	UnthrottledTable = table.clone(AssemblersNeed)
	
	
	ThrottleTable()
	
	for Resource, Amount in pairs(AssemblersNeed) do
		for _ = 1, Amount do
			table.insert(AssemblerList, Resource)
		end
	end
	
	print(`{#AssemblerList}/{#Assemblers} USED ({math.round((#AssemblerList/#Assemblers)*100)}%)`)

	CheckAndConfigure("Assembler", AssemblerList)
	CheckAndConfigure("Bin", Binsneeded)
end

-- Run setup and final calculations
Setup()


-- Output results
print(`\nFor a production rate of 1 unit per {Throttle} seconds, you would need:`)

for k, v in pairs(ExtractorsNeeded) do
	print(`{k}..{v}`)
end

print("\nAssemblers Needed:")
for k, v in pairs(AssemblersNeed) do
	print(`{k}..{v}`)
end

print("\nBins Needed:")
for _, v in ipairs(Binsneeded) do
	print(v)
end

local function ScanAllBins()
	for _, bin in Bins do
		local resource = CheckBin(bin)
		if resource and resource ~= "VOIDED" and UnthrottledTable[resource] then
			local amount = bin:GetResourceAmount()
			local assignedAssemblers = {}

			for _, assembler in ipairs(Assemblers) do
				if assembler.Assemble == resource then
					table.insert(assignedAssemblers, assembler)
				end
			end

			local needed = AssemblersNeed[resource] or 0
			local assigned = #assignedAssemblers

			if amount > UnthrottledTable[resource] then
				-- Overproduced: unassign all
				for _, assembler in ipairs(assignedAssemblers) do
					assembler.Assemble = ""
					print("nilling .." .. resource)
					print(`{GetConfiguredAssemblerCount()}/{#Assemblers} USED ({math.round((GetConfiguredAssemblerCount()/#Assemblers)*100)}%)`)
				end
				FactoryPartMats.Assembler[resource] = nil
			elseif assigned < needed then
				-- Underproduced: assign missing assemblers
				local toAssign = needed - assigned
				for _, assembler in ipairs(Assemblers) do
					if toAssign <= 0 then break end
					if assembler.Assemble == "" then
						assembler.Assemble = resource
						print("returning .." .. resource)
						print(`{GetConfiguredAssemblerCount()}/{#Assemblers} USED ({math.round((GetConfiguredAssemblerCount()/#Assemblers)*100)}%)`)
						toAssign -= 1
					end
				end
				-- Update factory map only with one (any) assembler
				if not FactoryPartMats.Assembler[resource] then
					for _, assembler in ipairs(Assemblers) do
						if assembler.Assemble == resource then
							FactoryPartMats.Assembler[resource] = assembler
							break
						end
					end
				end
			end
		end
	end
end





while wait(1) do
	ScanAllBins()
end

coroutine.yield()
