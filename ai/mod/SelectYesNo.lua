--- OnSelectYesNo() ---
--
-- Called when AI has to decide something
-- 
-- Parameters:
-- description_id = id of the text dialog that is normally shown to the player
--
-- The descriptions can be found in strings.conf
-- For example, description id 30 = 'Replay, do you want to continue the Battle?'
--
-- Return: 
-- 1 = yes
-- 0 = no
-- -1 = let the ai decide
function GetAttacker()
   return GetCardFromScript(Duel.GetAttacker(),AIMon())
end

function OnSelectYesNo(description_id)
  local result = nil
  local d = DeckCheck()
  if d and d.YesNo then
    result = d.YesNo(description_id)
  end
  if result then 
    if result == true then result = 1 end
    if result == false then result = 0 end
    return result 
  end

	if description_id == 30 then
    local cards = nil
    local attacker = GetAttacker()
    local attack = 0
    if attacker then
      cards = {attacker}
      ApplyATKBoosts(cards)
      attacker = cards[1]
      attack = attacker.attack
    end
    cards=OppMon()
    if #cards == 0 then
      --return 1
    end
    if FilterAffected(attacker,EFFECT_DIRECT_ATTACK) then
      return 1
    end
    ApplyATKBoosts(cards)
    if CanWinBattle(attacker,cards) then 
      GlobalCurrentAttacker = attacker.cardid
      GlobalAIIsAttacking = true
      return 1
    else
      return 0
    end
	end
  if description_id == 1457766049 then  -- Star Seraph Sovereign
    if FieldCheck(4) == 1 then
      return 1
    else
      return 0
    end
  end
  if description_id == 1101042113 then -- Harpie Dancer
    return DancerYesNo()
  end
  if description_id == 1044887489 then -- F0 protect
    GlobalActivatedCardID = 65305468
    return 1
  end
  if description_id == 30100551*16 then -- Minerva
    if DestroyCheck(OppField(),true,true)>0 then
      return 1
    else
      return 0
    end
  end
	return -1
end

