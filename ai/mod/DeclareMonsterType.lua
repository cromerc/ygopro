--- OnDeclareMonsterType ---
--
-- Called when AI has to declare a monster type. 
-- Example card(s): DNA Surgery, Rivalry of Warlords
-- 
--[[
Check out the Races section in constants.lua

RACE_WARRIOR		=0x1		--
RACE_SPELLCASTER	=0x2		--
RACE_FAIRY              =0x4            --
RACE_FIEND              =0x8            --
RACE_ZOMBIE             =0x10           --
RACE_MACHINE		=0x20		--
RACE_AQUA               =0x40           --
RACE_PYRO               =0x80           --
RACE_ROCK               =0x100          --
RACE_WINDBEAST		=0x200		--
RACE_PLANT              =0x400          --
RACE_INSECT             =0x800          --
RACE_THUNDER		=0x1000		--
RACE_DRAGON             =0x2000         --
RACE_BEAST              =0x4000         --
RACE_BEASTWARRIOR	=0x8000		--
RACE_DINOSAUR		=0x10000	--
RACE_FISH               =0x20000        --
RACE_SEASERPENT		=0x40000	--
RACE_REPTILE		=0x80000	--
RACE_PSYCHO             =0x100000       --
RACE_DEVINE             =0x200000       --
RACE_CREATORGOD		=0x400000	--
--]]
--
-- Parameters (2):
-- count = number of types to return
-- choices = table of valid types
--
-- Return: a number containing the selected types
function OnDeclareMonsterType(count, choices)
  local result = nil
  local d = DeckCheck()
  if d and d.MonsterType then
    result = d.MonsterType(count,choices)
  end
  if result~=nil then return result end
	result = 0
	local returnCount = 0
	
	-- Example implementation: Just return the first valid type(s) you come across
	while returnCount < count do
		result = result + choices[returnCount+1] --add type
		returnCount = returnCount + 1
	end
	
	return result
	
	--[[
	--You can return a specific type like this:
	return RACE_WARRIOR --returns the warrior type
	
	--If more types are required then return the sum:
	return RACE_SPELLCASTER+RACE_BEAST --returns spellcaster and beast
	--]]
end
