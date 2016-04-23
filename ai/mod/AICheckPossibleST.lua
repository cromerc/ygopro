-----------------------------------------
-- AICheckPossibleST.lua
--
-- A set of functions to check for possible spell or trap card activation or special summoning in specified situations,
-- and returning possible outcome of doing so. 
-----------------------------------------

function CanChangeOutcome(cards,SummonableCards, ActivatableCards)
local Result = 0
local AIMons = AI.GetAIMonsterZones()
local AIExtra = AI.GetAIExtraDeck()
  
  -------------------------------------------------------
  -- Check if any XYZ or SYNCHRO monsters can be summoned.
  -------------------------------------------------------   
 for i=1,#SummonableCards do  
   if isMonLevelEqualToRank(SummonableCards[i].level,SummonableCards[i].id) ~= 0 and SummonableCards[i].location == LOCATION_HAND and 
   (AIMonCountLowerLevelAndAttack(SummonableCards[i].level,SummonableCards[i].attack) + GlobalAdditionalTributeCount) >= 
   AIMonGetTributeCountByLevel(SummonableCards[i].level) then 
     for x=1,#AIExtra do  
	 if AIExtra[x] ~= false then
	 if (AIMonOnFieldMatCount(AIExtra[x].rank) + 1) >= GetXYZRequiredMatCount() then 
	  Result = 1
	 end
    end
   end 
  end 
 end
 
 ---------------------------------------------------------------
 -- Check if player controls only 1 monster, and if it can be destroyed
 ---------------------------------------------------------------
 if Get_Card_Count_Pos(OppMon(), POS_FACEUP_ATTACK) == 1 and Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") then
   Result = 1
  end
 
 if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 72302403, POS_FACEUP) > 0 or Get_Card_Count_ID(AIMon(), 58775978, nil) > 0 then -- Swords of Revealing Light, Nightmare's Steelcage
    Result = 1
   end
 
 if Get_Card_Count_ID(AIMon(), 70908596, nil) > 0 then -- Constellar Kaust
    Result = 1
  end
 
 if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 40619825, nil) > 0 then -- Axe of Despair
  for i=1,#SummonableCards do  
   if (SummonableCards[i].attack +1000) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
      Result = 1
	  end
    end
  end
  
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 83746708, nil) > 0 then -- Mage Power    
  for i=1,#SummonableCards do  
   if (SummonableCards[i].attack + 500 * (Get_Card_Count(AI.GetAISpellTrapZones()) +1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
      Result = 1
	  end
    end
  end
  
  for i=1,#SummonableCards do  
   if SummonableCards[i].id == 70908596 then -- Constellar Kaust
      Result = 1
	  end
   end
 
 if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 55713623, nil) > 0 then -- Shrink
  for i=1,#SummonableCards do  
   if SummonableCards[i].attack > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") / 2 then 
      Result = 1
	  end
    end
  end
  
 if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 67227834, nil) > 0 then -- Magic Formula
  for i=1,#SummonableCards do   
   if SummonableCards[i].id == 46986414 or SummonableCards[i].id == 38033121 then -- Dark Magician, Dark Magician Girl
     if (SummonableCards[i].attack +700) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
        Result = 1
	    end
      end
    end
  end 
 
 if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 22046459, nil) > 0 then -- Megamorph
  for i=1,#SummonableCards do  
   if AI.GetPlayerLP(1) < AI.GetPlayerLP(2) and SummonableCards[i].attack >= 1500 then 
    if SummonableCards[i].attack * 2  > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
        Result = 1
	    end
      end
    end
  end 
  
 if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 98045062, nil) > 0 then -- Enemy Controller
  for i=1,#SummonableCards do  
   if SummonableCards[i].attack > Get_Card_Att_Def(OppMon(), "attack", ">", POS_FACEUP_ATTACK, "defense") then 
      Result = 1
	  end
    end
  end

 if Get_Card_Count_ID(AIGrave(), 34230233, nil) > 0 then  -- Grapha, Dragon Lord of Dark World
  for i=1,#SummonableCards do  
   if IsDiscardEffDWMonster(SummonableCards[i].id) == 1 then 
      Result = 1
	  end
    end
  end
  
 if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 33017655, nil) > 0 then -- The Gates of Dark World
  for i=1,#SummonableCards do  
   if SummonableCards[i].race == RACE_FIEND then 
    if (SummonableCards[i].attack +300) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then
	    Result = 1
	    end
      end
    end
  end 
  
  for i=1,#SummonableCards do  
   if SummonableCards[i].id == 10000020 then -- Slifer the Sky Dragon
    if (SummonableCards[i].attack + 1000 * (Get_Card_Count(AIHand()) -1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	  Result = 1
	  end
    end
  end
  
  for i=1,#SummonableCards do  
   if SummonableCards[i].id == 98777036 then -- Tragoedia
    if (SummonableCards[i].attack + 600 * (Get_Card_Count(AIHand()) -1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	  Result = 1
	  end
    end
  end
  
  for i=1,#SummonableCards do  
   if SummonableCards[i].id == 10000010 then -- The Winged Dragon of Ra	
    if (SummonableCards[i].attack + AI.GetPlayerLP(1) - 100) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	  Result = 1
	  end
    end
  end
    
	return Result
  end
  
  --------------------------------------------------
  -- Copy of above function, to be used in SelectPosition, 
  -- when AI has to special summon monsters.
  --------------------------------------------------
  function CanChangeOutcomeSS(CardID)
  local Result = 0
 
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 22046459, nil) > 0 then -- Megamorph
   if AI.GetPlayerLP(1) < AI.GetPlayerLP(2) and AIMonGetAttackById(CardID) >= 1500 then 
    if AIMonGetAttackById(CardID) * 2  > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
      Result = 1
	  end
    end
  end
  
 ---------------------------------------------------------------
 -- Check if player controls only 1 monster, and if it can be destroyed
 ---------------------------------------------------------------
 if Get_Card_Count_Pos(OppMon(), POS_FACEUP_ATTACK) > 0 and Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") then
   Result = 1
  end
  
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 67227834, nil) > 0 then -- Magic Formula
   if CardID == 46986414 or CardID == 38033121 then -- Dark Magician, Dark Magician Girl
     if (AIMonGetAttackById(CardID) +700) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
      Result = 1
	  end
    end
  end   
  
  if Get_Card_Count_ID(AIMon(), 70908596, POS_FACEUP) > 0 then -- Constellar Kaust
    Result = 1
  end
    
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 40619825, nil) > 0 then -- Axe of Despair
   if (AIMonGetAttackById(CardID) +1000) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
     Result = 1
	 end
  end 
  
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 83746708, nil) > 0 then -- Mage Power
   if (AIMonGetAttackById(CardID) + 500 * (Get_Card_Count(AI.GetAISpellTrapZones()) +1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
     Result = 1
	 end
  end 
  
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 55713623, nil) > 0 then -- Shrink 
   if AIMonGetAttackById(CardID) > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") / 2 then 
     Result = 1
	 end
  end 
 
  if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 33017655, nil) > 0 then -- The Gates of Dark World
   if AIMonGetRaceById(CardID) == RACE_FIEND then 
	if (AIMonGetAttackById(CardID) +300) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then
	  Result = 1
	  end
    end
  end
 
  if Get_Card_Count_ID(AIGrave(), 34230233, nil) > 0 then -- Grapha, Dragon Lord of Dark World 
   if IsDiscardEffDWMonster(CardID) == 1 then 
    Result = 1
    end
  end 
     
  if CardID == 10000020 then -- Slifer the Sky Dragon
    if (AIMonGetAttackById(CardID) + 1000 * (Get_Card_Count(AIHand()) -1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	Result = 1
    end
  end 
  
  if CardID == 98777036 then -- Tragoedia
    if (AIMonGetAttackById(CardID) + 600 * (Get_Card_Count(AIHand()) -1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	Result = 1
    end
  end 
    
  if CardID == 70908596 then -- Constellar Kaust
	Result = 1
  end
  
  if CardID == 10000010 then -- The Winged Dragon of Ra	
    if (AIMonGetAttackById(CardID) + AI.GetPlayerLP(1) - 100) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	Result = 1
    end
  end 
  
  if CardID == 12014404 then -- Gagaga Gunman	
	if (AIMonGetAttackById(CardID) + 1500) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	Result = 1
    end
  end 
  
  if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 72302403, POS_FACEUP) > 0 or Get_Card_Count_ID(AIMon(), 58775978, POS_FACEUP) > 0 then -- Swords of Revealing Light, Nightmare's Steelcage
    Result = 1
   end
  
  return Result
 end
 
  --------------------------------------------------
  -- Checks if AI should change position of monster to allow XYZ summon
  -- used only in position changing function.
  --------------------------------------------------
  function ChangePosToXYZSummon(cards, SummonableCards, RepositionableCards)
  local Result = 0
  local AIMons = AI.GetAIMonsterZones()
  local AIExtra = AI.GetAIExtraDeck() 
  
  for i=1,#SummonableCards do  
  if SummonableCards[i] ~= false then
   if isMonLevelEqualToRank(SummonableCards[i].level,SummonableCards[i].id) == 1 and SummonableCards[i].location == LOCATION_HAND and 
   (AIMonCountLowerLevelAndAttack(SummonableCards[i].level,SummonableCards[i].attack) + GlobalAdditionalTributeCount) >= 
   AIMonGetTributeCountByLevel(SummonableCards[i].level) then 
     for x=1,#AIExtra do  
	 if AIExtra[x] ~= false then
	  if (AIMonOnFieldMatCount(AIExtra[x].rank) + 1) >= GetXYZRequiredMatCount() or AIMonOnFieldMatCurrentCount() >= GetXYZRequiredMatCount() then 
	    Result = 1
	   end
      end
     end 
    end
   end 
  end 
   for x=1,#AIExtra do  
	 if AIExtra[x] ~= false then
	  if AIMonOnFieldMatCount(AIExtra[x].rank) >= GetXYZRequiredMatCount() or AIMonOnFieldMatCurrentCount() >= GetXYZRequiredMatCount() then 
	 Result = 1
     end
   end 
  end
   return Result
 end
 
 