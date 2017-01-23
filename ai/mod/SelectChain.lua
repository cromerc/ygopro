--- OnSelectChain --
--
-- Called when AI can chain a card.
-- This function is not completely implemented yet. The parameters will very likely change in the next version.
-- 
-- Parameters:
-- cards = table of cards to chain
-- only_chains_by_player = returns true if all cards in the chain are used by the Player
-- Return: 
-- result
--		1 = yes, chain a card
--		0 = no, don't chain
-- index = index of the chain

GlobalChain = 0
function OnSelectChain(cards,only_chains_by_player,forced)
  if not player_ai then player_ai = 1 end -- probably puzzle mode, so player goes first
  if GlobalBPAllowed == nil and Duel.GetTurnCount()>1 then
    GlobalBPAllowed = true
  end
  if Duel.GetCurrentChain()<=GlobalChain then
    GlobalTargetList = {} -- reset variables for new chain
    GlobalNegatedChainLinks = {}
  end
  GlobalChain=Duel.GetCurrentChain()
  GlobalSummonNegated = nil
  local result = 0
  local index = 1
  local ChainAllowed = 0
  SurrenderCheck()
  DamageSet()
  ResetOncePerTurnGlobals()
  GlobalAIIsAttacking = nil
  --GetNegatePriority()
  
  if GlobalFeatherStorm~=Duel.GetTurnCount()
  and ChainCheck(00007704,1-player_ai) -- Feather Storm
  then
    GlobalFeatherStorm=Duel.GetTurnCount()
  end
  
  if GlobalMaxxC~=Duel.GetTurnCount()
  and ChainCheck(23434538,1-player_ai) -- Maxx "C"
  then
    GlobalMaxxC=Duel.GetTurnCount()
  end
  ---------------------------------------------
  -- Don't activate anything if the AI controls
  -- a face-up Light and Darkness Dragon.
  ---------------------------------------------
  if Get_Card_Count_ID(AIMon(), 47297616, POS_FACEUP) > 0 then
	return 0,0
  end
  
  ---------------------------------------
  -- Don't do anything if if the AI controls
  -- a face-up C106: Giant Hand Red with
  -- a "Number" monster as XYZ material,
  -- that didn't use its effect this turn
  ---------------------------------------
  
  local aimon = AIMon()
  local card = nil
  for i=1,#aimon do
    if aimon[i].id==55888045 then
      card = aimon[i]
    end
  end
  if card and bit32.band(card.position,POS_FACEUP)>0 
  and Duel.GetTurnCount() ~= GlobalC106
  and NotNegated(card)
  then
    local materials = card.xyz_materials
    for i=1,#materials do
      if bit32.band(materials[i].setcode,0x48)>0 then
        return 0,0
      end
    end
  end
  
      -- Lancelot
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if c.id == 66547759 and NotNegated(c)
    and OPTCheck(c.cardid) and c.xyz_material_count>0
    and FilterPosition(c,POS_FACEUP)
    then
      return 0,0
    end
  end
  
  local backup = CopyTable(cards)
  local d = DeckCheck()
  local result,result2 = nil,nil
  result = PriorityChain(cards)
  if result ~= nil then
    if type(result)=="table" then
      if (result[1]~=1 
      or InfiniteLoopCheck(cards[result[2]]))
      and BlacklistCheckChain(result[1],result[2],d,backup)
      then
        return result[1],result[2]
      end
    else
      if (result~=1 
      or InfiniteLoopCheck(cards[result2]))
      and BlacklistCheckChain(result,result2,d,backup)
      then
        return result,result2
      end
    end
  end
  if d and d.Chain then
    result,result2 = d.Chain(cards,only_chains_by_player)
  end
  if result ~= nil then
    if type(result)=="table" then
      if (result[1]~=1 
      or InfiniteLoopCheck(cards[result[2]]))
      then
        return result[1],result[2]
      end
    else
      if (result~=1 
      or InfiniteLoopCheck(cards[result2]))
      then
        return result,result2
      end
    end
  end
  
  backup = CopyTable(cards)
  d = DeckCheck()
  local SelectChainFunctions = {
  FireFistOnChain,HeraldicOnSelectChain,
  GadgetOnSelectChain,BujinOnSelectChain,MermailOnSelectChain,
  SatellarknightOnSelectChain,
  ChaosDragonOnSelectChain,HATChain,QliphortChain,
  NobleChain,NekrozChain,BAChain,DarkWorldChain,
  ConstellarChain,BlackwingChain,HarpieChain,
  HEROChain,GenericChain,
  }
    
  for i=1,#SelectChainFunctions do
    local func = SelectChainFunctions[i]
    result = func(cards,only_chains_by_player)
    if result ~= nil and (d == 0 
    or BlacklistCheckChain(result[1],result[2],d,backup))
    then
      if result[1]~=1 
      or InfiniteLoopCheck(cards[result[2]])
      then
        return result[1],result[2]
      end
    end
  end

  result = 0

 ---------------------------------------------
 -- Cocoon of Evolution on field turn counter
 --------------------------------------------- 
 if Global1PTVariable ~= 1 and Duel.GetTurnPlayer() == player_ai then
  if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 40240595, POS_FACEUP) > 0 and Get_Card_Count_ID(UseLists({AIMon(),AIST()}),68144350,POS_FACEUP) > 0 and AI.GetCurrentPhase() == PHASE_END then -- Cocoon of Evolution, Petit Moth
    GlobalCocoonTurnCount = GlobalCocoonTurnCount +1
    Global1PTVariable = 1
	 else if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 40240595, POS_FACEUP) ==  0 or Get_Card_Count_ID(UseLists({AIMon(),AIST()}),58192742,POS_FACEUP) == 0 then
       GlobalCocoonTurnCount = 0
      end
    end
  end  
  
  -----------------------------------------------------
  -- Check if global chaining conditions are met,
  -- and set ChainAllowed variable to 1 if they are.
  -----------------------------------------------------
  for i=1,#cards do
    local c = cards[i]
    if Get_Card_Count_ID(AIST(),c.id, POS_FACEUP) == 0 or MultiActivationOK(c.id) == 1 then 
      if NotNegated(c) then		
        if UnchainableCheck(c.id) then  -- Checks if any cards from UnchainableTogether list are already in chain.
          if NecrovalleyCheck(c) then
            ChainAllowed = 1
          end
        end
      end
    end
  end
  
  -----------------------------------------------------
  -- Proceed to chain any cards and check other chaining
  -- conditions, only if global restrictions above are met.
  -----------------------------------------------------
  if ChainAllowed == 1 then
  
  -------------------------------------------------
  -- Activate Torrential Tribute if the opponent
  -- controls at least 2 more monsters than the AI.
  -------------------------------------------------
	for i=1,#cards do
      if cards[i].id == 53582587 
      and Get_Card_Count(OppMon()) >= Get_Card_Count(AIMon()) + 2 
      and not Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_SPECIAL_SUMMON) 
      and not Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_NORMAL_SUMMON)
      then
        GlobalActivatedCardID = cards[i].id
        return 1,i
      end
   end
  
  ---------------------------------
  -- Activate Raigeki Break or Phoenix Wing Wind Blast only if
  -- the opponent controls a card.
  ---------------------------------
    for i=1,#cards do
      if cards[i].id == 04178474 then -- Raigeki B
        if Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") or Get_Card_Count(OppST()) > 0 then
          GlobalActivatedCardID = cards[i].id
          GlobalCardMode = 1
		  return 1,i
        end
      end
    end

  ----------------------------------------------------------------
  -- Activate Beckoning Light only if the number of LIGHT monsters
  -- in the AI's graveyard is 5 or more, and also greater than or
  -- equal to the number of cards in the AI's hand (at least 4)
  ----------------------------------------------------------------
    for i=1,#cards do
      if cards[i].id == 16255442 then
        local AIHand = AI.GetAIHand()
        if Get_Card_Count_ATT(AIGrave(),"==",ATTRIBUTE_LIGHT,nil) >= 5 and
           #AIHand >= 4 then
          GlobalActivatedCardID = cards[i].id
          return 1,i
        end
      end
    end
       
  -------------------------------------------------------
  -- Activate Zero Gardna's effect in the Draw Phase.
  -- This will help the AI to use this effect only on the
  -- opponent's turn.
  -------------------------------------------------------
  if AI.GetCurrentPhase() == PHASE_DRAW then
    for i=1,#cards do
      if cards[i].id == 93816465 then
        return 1,i
      end
    end
  end

  ----------------------------------------------
  -- Activate Formula Synchron's "Accel Synchro"
  -- effect if the AI hasn't already attempted
  -- it yet this turn.
  ----------------------------------------------
  for i=1,#cards do
    if cards[i].id == 50091196 and
       Global1PTFormula ~= 1 then
       Global1PTFormula = 1
       GlobalActivatedCardID = cards[i].id
      return 1,i
    end
  end

  ---------------------------------------------
  -- Always try to activate Stardust Dragon's
  -- or SD/AM's "summon from graveyard" effect.
  ---------------------------------------------
  for i=1,#cards do
    if cards[i].id == 44508094 or cards[i].id == 61257789 then
      if cards[i].location == LOCATION_GRAVE then
        return 1,i
      end
    end
  end
  
      
  
  ---------------------------------------------
  -- AI should activate: Waboku, Negate Attack 
  -- only if player has any face up attack position monsters 
  -- with more attack points than AI's stronger attack pos monster
  --------------------------------------------- 
  if Duel.GetTurnPlayer() == 1-player_ai and Global1PTWaboku ~= 1 then
   for i=1,#cards do 
   if cards[i].id == 12607053 or cards[i].id == 14315573 then -- Waboku, Negate Attack
   if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def_Pos(AIMon()) or 
      Get_Card_Count(AIMon()) == 0 and Get_Card_Count_Pos(AIMon(), POS_FACEUP_ATTACK) > 0 then
	  Global1PTWaboku = 1 
	  GlobalActivatedCardID = cards[i].id
     return 1,i
    end
   end
  end
 end
 
 
  ---------------------------------------------
  -- AI should activate: Shadow Spell,
  -- only if player has stronger attack position monster than any of AI's
  -- and player's monster has 2000 attack points or more.
  ---------------------------------------------
   for i=1,#cards do
   if cards[i].id == 29267084 then -- Shadow Spell
    if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") >= 2000 and 
	  (Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack", ">",POS_FACEUP_ATTACK,"attack")) then
       GlobalActivatedCardID = cards[i].id
      return 1,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Return from the Different Dimension,
  -- only if AI can bring out strong tribute monster as result, 
  -- or if player or AI has 0 monsters on the field (just in case)
  ---------------------------------------------
  for i=1,#cards do
   if cards[i].id == 27174286 then -- Return from the Different Dimension
   local AIHand = AIHand()
   local HandHighestATK = 0
   local Result = 0
  if IsBattlePhase() and Duel.GetTurnPlayer() == player_ai
  and Get_Card_Count_Type(AIBanish(),TYPE_MONSTER,">",nil) >= 3 
  and Get_Card_Count(AIMon()) == 0 
  then 
   return 1,i
  end
 if AI.GetCurrentPhase() == PHASE_MAIN1 and Get_Card_Count_Type(AIBanish(),TYPE_MONSTER,">",nil) >= 3 and GlobalIsAIsTurn == 1 and Get_Card_Count(AIMon()) == 0 then	
  for x=1,#AIHand do
    if AIHand[x].attack > HandHighestATK then
       HandHighestATK = AIHand[x].attack       
      if AIHand[x].level >= 5 and
         HandHighestATK >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then
	      return 1,i 
	      end
        end
      end
    end
  end 
end
   
  ---------------------------------------------
  -- AI should activate: Zero Gravity, 
  -- only if Player is about to attack or attacked.
  ---------------------------------------------
  for i=1,#cards do  
   if cards[i].id == 83133491 then  -- Zero Gravity
    if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 83133491, POS_FACEUP) ==  0 
    and AI.GetCurrentPhase() == PHASE_DAMAGE and Duel.GetTurnPlayer() == 1-player_ai
    then
	   GlobalActivatedCardID = cards[i].id
      return 1,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Enemy Controller, if
  -- player's monster is stronger than AI's
  ---------------------------------------------
   for i=1,#cards do    
   if cards[i].id == 98045062 then -- Enemy Controller
	if Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and 
	   Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(OppMon(), "attack", ">", POS_FACEUP_ATTACK, "defense") then
      --return 1,i
     end
   end
 end

  ---------------------------------------------
  -- AI should activate: Amazoness Archers, 
  -- only if AI's monster can become stronger than
  -- any player's monster as result.
  ---------------------------------------------
  for i=1,#cards do  
   if cards[i].id == 67987611 then -- Amazoness Archers
    if (Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") + 500) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
	 GlobalActivatedCardID = cards[i].id
	 return 1,i
     end
   end
 end
  
  ---------------------------------------------
  -- Set global variable to 1 if player activates
  -- "Amazoness Archers" trap card
  ---------------------------------------------
  if Get_Card_Count_ID(OppST(), 67987611, POS_FACEUP) > 0 then
   if IsBattlePhase() then
     Global1PTAArchers = 1
    end
  end
     
  ---------------------------------------------
  -- AI should activate: Spellbinding Circle, Mirror Force,  
  -- only if AI's monsters are weaker than players.
  ---------------------------------------------
  for i=1,#cards do   
   if cards[i].id == 18807108 then-- Spellbinding Circle
    if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") 
    and Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(OppMon(),"attack", ">", POS_FACEUP_ATTACK,"defense")
    and Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") >= 1600 or AI.GetPlayerLP(1) <= 2000 
    then
	   GlobalActivatedCardID = cards[i].id
	    return 1,i
       end
     end
   end
   
  -- always activate Dragon Ruler's on banish effects
  if HasID(cards,53804307,FilterLocation,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if HasID(cards,26400609,FilterLocation,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if HasID(cards,89399912,FilterLocation,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end
  if HasID(cards,90411554,FilterLocation,LOCATION_REMOVED) then
    return 1,CurrentIndex
  end  
  ---------------------------------------------
  -- Mandatory effects the AI could potentially 
  -- skip, if not handled here
  ---------------------------------------------
  for i=1,#cards do 
    if MandatoryCheck(cards[i]) then
      return 1,i
    end
  end  
  
  ----------------------------------------------------------
  -- For now, chain anything else (not already listed above)
  -- that can be chained, except cards with the same ID as
  -- another existing face-up spell/trap card, cards that 
  -- shouldn't be activated in a same chain, and cards that 
  -- shouldn't be activated under certain conditions.
  ----------------------------------------------------------
  
  for i=1,#cards do
    local c = cards[i]
    if (Get_Card_Count_ID(AIST(),c.id, POS_FACEUP) == 0 or MultiActivationOK(c.id) == 1)
    and UnchainableCheck(c.id) 
    and NecrovalleyCheck(c)
    and CardIsScripted(c.id) == 0 
    and NotNegated(c) 
    and InfiniteLoopCheck(c)
    then
      GlobalActivatedCardID = c.id 
      return 1,i
    end
  end
  
  -------------------------------------
  -- Otherwise don't activate anything.
  -------------------------------------
  return 0,0
  end
end
