local Speakers = GetPartsFromPort(1,"Speaker")

print(#Speakers.." speakers")

--[[
{"1837879082","1841647093","1847413594","1845341094","1847413594","5410081112","7028518546","1847665417","9046476113","9048375035","1847853099"}
local MusicLengths = {"162.037","211.11","208.253","152.604","395.605","193.306","212.217","126.38","169.909"}
]]

local Sounds = {
	["Trance Act A"] = {
		Time = 207;
		ID = 1847413594 ;
	};
	["Venus"] = {
		Time = 204;
		ID = 1843574069;
	};
	["Infectious"] = {
		Time = 300;
		ID = 79451196298919;
	};
	["Nitro-Fun-Easter-Egg"] = {
		Time = 204;
		ID = 7024220835;
	};
	["Pirate Battle"] = {
		Time = 71;
		ID = 1842925663;
	};
	["Synthwar"] = {
		Time = 112;
		ID = 4580911200 ;
	};
	["0to8,1xmxxd - stop posting about baller - original"] = {
		Time = 72;
		ID = 13530438299;
	}; 
	["Jupiter"] = {
		Time = 116;
		ID = 1845221287;
	};
	["Insurgent"] = {
		Time = 133;
		ID = 1842908121;
	};
	["Sunfire"] = {
		Time = 162.037;
		ID = 1837879082;
	};
	["Pulsewave"] = {
		Time = 211.11;
		ID = 1841647093;
	};
	["Nightlights"] = {
		Time = 208.253;
		ID = 1847413594;
	};
	["Voltage Vibe"] = {
		Time = 152.604;
		ID = 1845341094;
	};
	["Overdrive Drift"] = {
		Time = 395.605;
		ID = 5410081112;
	};
	["Metro Pulse"] = {
		Time = 193.306;
		ID = 7028518546;
	};
	["Bassline Boost"] = {
		Time = 212.217;
		ID = 1847665417;
	};
	["Retro Night"] = {
		Time = 126.38;
		ID = 9046476113;
	};
	["Echoes"] = {
		Time = 169.909;
		ID = 9048375035;
	};
	["Warp Drive"] = {
		Time = 184.785; -- Approximated, ID repeats with other tracks
		ID = 1847853099;
	};
}


while task.wait() do
	for i, MUSIC in Sounds do
		local T = MUSIC.Time
		local ID = MUSIC.ID

		local Name = MUSIC
		for _, Speaker in Speakers do

			Speaker.Audio = ID

			--Speaker:Chat(`Now playing {i}`)

		end
		wait()
		
		print(`Now playing {i}`)
		TriggerPort(1)
		wait(T)
	end
end