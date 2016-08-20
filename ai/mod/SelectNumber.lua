--- OnSelectNumber ---
--
-- Called when AI has to declare a number. 
-- Example card(s): Reasoning
-- 
-- Parameters:
-- choices = table containing the valid choices
--
-- Return: index of the selected choice
function OnSelectNumber(choices)
  local result = nil
  -------------------------------------------
  -- The AI should always try to mill as many
  -- cards as possible with Card Trooper.
  -------------------------------------------
  if GlobalActivatedCardID == 85087012 -- Card Trooper
  then
    GlobalActivatedCardID = nil
    if #AIDeck()>10 then
      return 1
    else
      return 3
    end
  end
  
  if GlobalActivatedCardID == 83531441 -- Dante
  then
    GlobalActivatedCardID = nil
    if #AIDeck()>10 
    and ((OPTCheck(57143342) or OPTCheck(20758643))
    or BattlePhaseCheck())
    then
      return 1
    else
      return 3
    end
  end
  local e,c,id = EffectCheck(1-player_ai)
  if e and id == 58577036 then
    result = ReasoningNumber()
    for i,choice in pairs(choices) do
      if choice == result then
        return i
      end
    end
  end
  local d = DeckCheck()
  if d and d.Number then
    result = d.Number(id,available)
  end
  if result~=nil then return result end
  
  -------------------------------------------
  -- Reset this variable if it gets this far.
  -------------------------------------------
  GlobalActivatedCardID = nil


  -- Example implementation: pick one of the available choices randomly
  return math.random(#choices)
end
