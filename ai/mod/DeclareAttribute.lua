--- OnDeclareAttribute ---
--
-- Called when AI has to declare an attribute. 
-- Example card(s): DNA Transplant, Gozen Match, Earthshaker
-- 
--[[
Check out the Attributes section in constants.lua

ATTRIBUTE_EARTH		=0x01
ATTRIBUTE_WATER		=0x02
ATTRIBUTE_FIRE		=0x04
ATTRIBUTE_WIND		=0x08
ATTRIBUTE_LIGHT		=0x10
ATTRIBUTE_DARK		=0x20
ATTRIBUTE_DEVINE	=0x40
--]]
--
-- Parameters (2):
-- count = number of attributes to return
-- choices = table of valid attributes
--
-- Return: a number containing the selected attributes
function OnDeclareAttribute(count, choices)
  local result = nil
  local d = DeckCheck()
  if d and d.Attribute then
    result = d.Attribute(count,choices)
  end
  if result~=nil then return result end
  result = 0
	local returnCount = 0
	
	-- Example implementation: Just return the first valid attribute(s) you come across
	while returnCount < count do
		result = result + choices[returnCount+1] --add attribute
		returnCount = returnCount + 1
	end
	
	return result
	
	--[[
	--You can return a specific attribute like this:
	return ATTRIBUTE_LIGHT --returns the light attribute
	
	--If more attributes are required then return the sum:
	return ATTRIBUTE_WATER+ATTRIBUTE_FIRE --returns water and fire
	--]]
end
