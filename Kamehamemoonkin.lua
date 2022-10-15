----------------------------
----------------------------
--     Kamehamemoonkin    --
-- (c)2022 Kulturnilpferd -- 
----------------------------

local function contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end

local WrathIDs = {5176, 5177, 5178, 5179, 5180, 6780, 8905, 9912, 26984, 65862, 48459, 48461}
local soundPlayed = false;
local KamehamemoonkinFrame = CreateFrame("Frame");
KamehamemoonkinFrame:RegisterEvent("UNIT_SPELLCAST_START");
KamehamemoonkinFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
KamehamemoonkinFrame:RegisterEvent("UNIT_SPELLCAST_FAILED");
KamehamemoonkinFrame:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET");
KamehamemoonkinFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
KamehamemoonkinFrame:RegisterEvent("UNIT_SPELLCAST_STOP");
KamehamemoonkinFrame:SetScript("OnEvent",
    function(self, event, arg1, arg2, arg3, arg4, arg5)
		local cast = UnitCastingInfo("player")
        if (event == "UNIT_SPELLCAST_START") then
			--print(arg1, arg2, arg3, arg4, arg5)
			if contains(WrathIDs,arg3) and soundPlayed == false then
				PlayMusic("Interface\\AddOns\\Kamehamemoonkin\\kamehameha.mp3");
				soundPlayed = true;
			end
        end
		if (event == "UNIT_SPELLCAST_INTERRUPTED" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_FAILED_QUIET" or event == "UNIT_SPELLCAST_STOP") then
			--print(arg1, arg2, arg3, arg4, arg5)
			if contains(WrathIDs,arg3) and cast then
				--C_Timer.NewTicker(0.2,function() StopMusic() end, 1)
				StopMusic()
				soundPlayed = false;
				--print("arbot")
			end
		end
		if (event == "UNIT_SPELLCAST_SUCCEEDED") then
			if contains(WrathIDs,arg3) then
				StopMusic()
				soundPlayed = false;
			end	
		end	
    end
);