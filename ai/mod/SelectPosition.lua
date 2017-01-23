--- OnSelectPosition ---
--
-- Called when AI has to select the monster position.
-- 
-- Parameters (2):
-- id = card id
-- available = available positions
--
-- Return: the position
--[[
From constants.lua
POS_FACEUP_ATTACK		=0x1
POS_FACEDOWN_ATTACK		=0x2
POS_FACEUP_DEFENSE		=0x4
POS_FACEDOWN_DEFENSE	=0x8
--]]
function OnSelectPosition(id, available)
	local result = 0
	local band = bit32.band --assign bit32.band() to a local variable
  result = POS_FACEUP_ATTACK 
  
  -------------------------------------------------------
  -- If a dragon is summoned by the effect of a Hieratic 
  -- monster, always summon it in defense mode, as his 
  -- attack and defense will be 0
  -------------------------------------------------------
  if GlobalActivatedCardID == 27337596 -- Hieratic Dragon King of Atum
  or GlobalActivatedCardID == 07394770 -- Brilliant Fusion
  then
    result = POS_FACEUP_DEFENSE
    GlobalActivatedCardID = nil
    GlobalTributedCardID = nil
    return result
  end
  
  ------------------------------------------------------
  -- Check if AI's monster's attack is lower than of strongest player's monster,
  -- or if any actions can be taken to gain advantage over player.
  -- Then summon or set monster in available position depending on results.
  ------------------------------------------------------
 if band(POS_FACEDOWN_DEFENSE,available) > 0 and Get_Card_Count_Pos(OppMon(), POS_FACEUP) > 0 then
  if AIMonGetAttackById(id) < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP_ATTACK,"attack") and CanChangeOutcomeSS(id) == 0 and AIMonGetAttackById(id) < 2400 then -- Also check if any action can be taken by CanChangeOutcomeSS
    result = POS_FACEDOWN_DEFENSE
    end 
  end
 if band(POS_FACEUP_DEFENSE,available) > 0 and Get_Card_Count_Pos(OppMon(), POS_FACEUP) > 0 then 
  if AIMonGetAttackById(id) < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP_ATTACK,"attack") and CanChangeOutcomeSS(id) == 0 and AIMonGetAttackById(id) < 2400 then -- Also check if any action can be taken by CanChangeOutcomeSS
   result = POS_FACEUP_DEFENSE
   end 
 end
  -------------------------------------------------------
  -- If Treeborn Frog is being special summoned, check if
  -- Creature Swap is in hand, the opponent controls 1
  -- monster, and the AI controls no other monsters.
  --
  -- If so, let the AI be a troll and special summon the
  -- frog in attack position!
  -------------------------------------------------------
  if id == 12538374 then
    if Get_Card_Count_ID(AIHand(),31036355,nil) == 0 or
       Get_Card_Count(OppMon()) ~= 1 or
       Get_Card_Count(AIMon()) ~= 0 then
      result = POS_FACEUP_DEFENSE
    end
  end

  ------------------------------------
  -- Cards to be always summoned in
  -- defense position.
  -- Expanding upon the above example.
  -- More cards to be added later.
  ------------------------------------
  if id == 19665973 or id == 52624755 or   -- Battle Fader, Peten the Dark Clown,
     id == 10002346 or id == 90411554 or   -- Gachi Gachi, Redox
     id == 33420078 or id == 15394084 or   -- Plaguespreader, Nordic Beast Token
     id == 58058134 or id == 10389142 or   -- Slacker Magician, Tomahawk
     id == 46384403 or id == 14677495 then -- Nimble Manta, Tanngnjostr
    
	result = POS_FACEUP_DEFENSE
  end
  
  ------------------------------------
  -- Cards to be always summoned in
  -- attack position.
  -- Expanding upon the above example.
  -- More cards to be added later.
  ------------------------------------
  if id == 64631466 or id == 70908596   -- Relinquished, Constellar Kaust
	or id == 88241506 then -- Maiden with Eyes of Blue
	result = POS_FACEUP_ATTACK
  end
  local positionfunctions={
  FireFistOnSelectPosition,HeraldicOnSelectPosition,GadgetOnSelectPosition,
  BujinOnSelectPosition,MermailOnSelectPosition,
  SatellarknightOnSelectPosition,ChaosDragonOnSelectPosition,HATPosition,
  QliphortPosition,NoblePosition,NekrozPosition,BAPosition,
  DarkWorldPosition,ConstellarPosition,BlackwingPosition,
  GenericPosition,HarpiePosition,HEROPosition,
  }
  for i=1,#positionfunctions do
    local func = positionfunctions[i]
    if func then
      local Position = func(id,available)
      if Position then result=Position end
    end
  end
  local d = DeckCheck()
  if d and d.Position then
    local Position = d.Position(id,available)
    if Position then result=Position end
  end
  if result == nil then result = POS_FACEUP_ATTACK end
  if band(result,available) == 0 then
    if band(POS_FACEUP_ATTACK,available) > 0 then
      result = POS_FACEUP_ATTACK
    elseif band(POS_FACEUP_DEFENSE,available) > 0 then
      result = POS_FACEUP_DEFENSE
    elseif band(POS_FACEDOWN_DEFENSE,available) > 0 then
      result = POS_FACEDOWN_DEFENSE
    else
      result = POS_FACEDOWN_ATTACK
    end
  end
  return result
end
