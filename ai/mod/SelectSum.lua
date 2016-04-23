--- OnSelectSum ---
--
-- Called when AI has to select a "sum". The sum can be the levels most of the time, but also something else. (This function is still in beta)
-- Note: if incorrect sum is returned the game will try to adjust
--
-- Example card(s): Machina Fortress, synchro summons
-- 
-- Parameters:
-- cards = table of cards to select
-- sum = the expected sum to return
--
-- Return: 
-- result = table containing target indices
function OnSelectSum(cards,sum,triggeringCard)
  local result = nil
  local d=DeckCheck()
  if d and d.Sum then
    result = d.Sum(cards,sum,triggeringCard)
  end
  if result~=nil then return result end
  if DeckCheck(DECK_GADGET) then result = GadgetSum(cards,sum,triggeringCard) end
  if result then return result end
  if DeckCheck(DECK_NEKROZ) then result = NekrozSum(cards,sum,triggeringCard) end
  if result then return result end
  
  result = {}
  local num_levels = 0
	for i=1,#cards do
		num_levels = num_levels + cards[i].level
		result[i]=i
		if(num_levels >= sum) then
			--end the loop
			break
		end
	end
	return result
end