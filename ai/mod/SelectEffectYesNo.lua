--- OnSelectEffectYesNo() ---
--
-- Called when AI has to decide whether to activate a card effect
-- 
-- Parameters:
-- id = card id of the effect
--
-- Return: 
-- 1 = yes
-- 0 = no

function OnSelectEffectYesNo(id,triggeringCard)
  if not player_ai then player_ai = 1 end -- probably puzzle mode, so player goes first
  local result = nil
  if not InfiniteLoopCheck(triggeringCard) then
    return 0
  end
  local d = DeckCheck()
  if d and d.EffectYesNo then
    result = d.EffectYesNo(id,triggeringCard)
  end
  if result then 
    if result == true then result = 1 end
    if result == false then result = 0 end
    return result 
  end
  local YesNoFunctions = {
  FireFistOnSelectEffectYesNo,MermailOnSelectEffectYesNo,
  GadgetOnSelectEffectYesNo,
  HeraldicOnSelectEffectYesNo,SatellarknightOnSelectEffectYesNo,
  ChaosDragonOnSelectEffectYesNo,HATEffectYesNo,QliphortEffectYesNo,
  NobleEffectYesNo,NekrozEffectYesNo,BAEffectYesNo,DarkWorldEffectYesNo,
  BujinOnSelectEffectYesNo,GenericEffectYesNo,ConstellarEffectYesNo,
  BlackwingEffectYesNo,HarpieEffectYesNo,HEROEffectYesNo,
  }
  for i=1,#YesNoFunctions do
    local func = YesNoFunctions[i]
    if result == nil then
      result = func(id,triggeringCard)
    end
  end
  if result then 
    if result == true then 
      result = 1 
    end
    if result == false then result = 0 end
    return result
  end
  if CardIsScripted(id)>0 then
    result = 0
  else
    result = 1
  end
  
  if id == 92661479 or id == 94283662 -- Bounzer, Trance Archfiend
  or id == 52624755 or id == 50091196 -- Peten, Formula
  or id == 80344569 or id == 78156759 -- Grand Mole, Zenmaines
  then 
    result = 1
  end
  
  if id  == 40619825 then -- Axe of Despair
    if Get_Card_Count(AIMon()) >= 2 then 
      GlobalActivatedEffectID = id
      GlobalCardMode = 1 
	  result = 1
      end
   end
   
   if id  == 73580471 then  -- Black Rose Dragon
    if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") or Card_Count_Affected_By(EFFECT_INDESTRUCTABLE_BATTLE,OppMon()) > 0 then  
	  result = 1
      end
   end

	if id == 15028680 then  -- HTS Psyhemuth
    if Get_Card_Att_Def_Pos(OppMon()) >= 2400 then
      return 1
    end
    return 0
  end
  
  -- always activate Dragon Ruler's on banish effects
  if id==53804307 and FilterLocation(triggeringCard,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if id==26400609 and FilterLocation(triggeringCard,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if id==89399912 and FilterLocation(triggeringCard,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if id==90411554 and FilterLocation(triggeringCard,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if result==1 then
    GlobalActivatedEffectID = id
  end
  return result
end

