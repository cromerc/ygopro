function ZodiacBeastStartup(deck)
  print("ZodiacBeast v1.0.1 by neftalimich.")
  deck.Init					= ZodiacBeastInit
  deck.Card					= ZodiacBeastCard
  deck.Chain				= ZodiacBeastChain
  deck.EffectYesNo			= ZodiacBeastEffectYesNo
  deck.YesNo				= ZodiacBeastYesNo
  deck.Position				= ZodiacBeastPosition
  deck.Option				= ZodiacBeastOption
  deck.BattleCommand		= ZodiacBeastBattleCommand
  --[[
  deck.Sum 
  deck.Tribute
  deck.BattleCommand
  deck.AttackTarget
  deck.AttackBoost
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  
  deck.ActivateBlacklist    = ZodiacBeastActivateBlacklist
  deck.SummonBlacklist      = ZodiacBeastSummonBlacklist
  deck.SetBlacklist			= ZodiacBeastSetBlacklist
  deck.Unchainable			= ZodiacBeastUnchainable
  --[[
  deck.RepositionBlacklist
  ]]
  
  deck.PriorityList         = ZodiacBeastPriorityList
  
  -- Debug Mode
  --[[
  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  Duel.RegisterEffect(e3,player_ai)
  --]]
end

ZodiacBeastIdentifier = {73881652} -- add the card(s) identifying your deck here

DECK_ZodiacBeast = NewDeck("ZodiacBeast",ZodiacBeastIdentifier,ZodiacBeastStartup) 

------------------------
--------- LIST ---------
------------------------

ZodiacBeastActivateBlacklist={
-- add cards to never activate/chain here
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
}
ZodiacBeastSummonBlacklist={
-- add monsters to never summon/set here
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
}
ZodiacBeastSetBlacklist={
46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu
}
ZodiacBeastUnchainable={
31755044, -- ZBViper
73881652, -- ZBDirection
98954106, -- ZBJAvarice
59438930, -- GO&SR
83326048, -- DBarrier
}

------------------------
--------- COND ---------
------------------------

function TemplateCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end	
  end
  return true
end

function ZBThroughbladeCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  if (
	    NormalSummonCheck() 
		or HasID(AIHand(),10719350,true) and OPTCheck(10719350)
	  )
	  and (
	    not HasID(AIHand(),c.id,true)
	    or PriorityCheck(AIHand(),PRIO_DISCARD,2,ZBFilter) > 2
	  )
	  and #AIMon() < 5
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return PriorityCheck(AIHand(),PRIO_DISCARD,1) > 0
	else
	  return false
	end
  end
  if loc == PRIO_TOGRAVE then
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return 1
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  if not NormalSummonCheck() then
	    return 2
	  else
	    return 3
	  end
	end
  end
  return true
end

function ZBViperCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_ONFIELD) 
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_OVERLAY) then
	  return 2
	end
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBRabbinaCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_ONFIELD) 
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return 3
	end
	if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 9
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBRamCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_ONFIELD) 
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
	if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return 4
	end
	if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 9
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBMolmoratCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) then
	  return 
	    CardsMatchingFilter(AIDeck(),FilterID,c.id) == 3
	    and CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return CardsMatchingFilter(AIDeck(),FilterID,c.id) == 3
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if HasID(AIDeck(),c.id,true)
	  and #AIMon() < 5
	  then
	    return true
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_OVERLAY) then
	  return 9
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  if loc == PRIO_DISCARD or loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return 3
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBBearmanCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) then
	  local bwMon = SubGroup(AIMon(),FilterRace,RACE_BEASTWARRIOR)
	  if CardsMatchingFilter(bwMon,FilterLevel,4) == 2
	  and not BattlePhaseCheck() 
	  --and Duel.GetCurrentPhase == PHASE_MAIN1
	  and (
	    not NormalSummonCheck()
	    or HasID(UseLists({AIHand(),AIST()}),10719350,true)
	  )
	  then
	    return 10
	  end
	end
  end
  return false
end

function ZBTenkiCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK) 
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return not HasID(UseLists({AIHand(),AIST()}),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBTensuCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  local zbMonHand = SubGroup(AIHand(),ZBMonFilter)
	  return 
	    not HasID(UseLists({AIHand(),AIST()}),c.id,true)
		and CardsMatchingFilter(zbMonHand,FilterLevelMax,4) > 0
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) 
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) 
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
  end
  return true
end

function ZBDranciaCond(loc,c)
  return true
end

function ZBBullhornCond(loc,c)
  return true
end

function ZBTigressCond(loc,c)
  return true
end

function ZBWildbowCond(loc,c)
  return true
end

ZodiacBeastPriorityList={                      
[77150143] = {8,1,8,1,4,1,3,1,1,1,ZBThroughbladeCond},	-- ZBThroughblade
[31755044] = {7,1,7,1,3,1,2,1,1,1,ZBViperCond},			-- ZBViper
[04367330] = {6,1,6,1,2,1,4,1,1,1,ZBRabbinaCond},		-- ZBRabbina
[04145852] = {6,1,6,1,2,1,4,1,1,1,ZBRamCond},			-- ZBRam
[78872731] = {9,1,9,1,5,1,6,1,1,1,ZBMolmoratCond},		-- ZBMolmorat
[67136033] = {1,1,1,1,1,1,9,1,1,1,ZBBearmanCond},		-- ZBBearman

[57103969] = {8,1,1,1,1,1,1,1,1,1,ZBTenkiCond},			-- ZBTenki
[10719350] = {9,1,1,1,1,1,1,1,1,1,ZBTensuCond},			-- ZBTensu
[73881652] = {1,1,1,1,1,1,1,1,1,1,nil},					-- ZBDirection

[48905153] = {1,1,1,1,9,1,9,1,1,1,ZBDranciaCond},		-- ZBDrancia
[85115440] = {1,1,1,1,8,1,8,1,1,1,ZBBullhornCond},		-- ZBBullhorn
[11510448] = {1,1,1,1,7,1,7,1,1,1,ZBTigressCond},		-- ZBTigress
[74393852] = {1,1,1,1,6,1,6,1,1,1,ZBWildbowCond},		-- ZBWildbow
[00581014] = {1,1,1,1,1,1,10,1,1,1,nil},				-- ZBDaigusto
}
--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZodiacBeastInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  
  -- GLOBAL RESET
  GlobalZBSummonId = 0
  GlobalZBTriangle = 0
  GlobalZodiacSign = 0
  
  --for i=1, #Act do
    --local c = Act[i]
	--print("Act",c.id)
  --end
  
  -- ACTIVE 0
  if HasIDNotNegated(Act,43898403,UseTwinTwister) then -- TwinTwisters
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,17626381) then -- Supply Squad
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,73628505) then -- Terraforming
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00675319) -- ZodiacSign
  and not HasID(AIST(),00675319,true)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00581014) then -- ZBDaigusto
    OPTSet(00581014)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,04423206,UseZBInvoker) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,96381979,false,(96381979*16+1),UseZBTigerKing) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ZBMolmorat EFFECT
  for i=1, #Act do
    local c = Act[i]
	if NotNegated(c) and c.description == (78872731*16+1)
	then
	  return {COMMAND_ACTIVATE,i}
	end
  end
  -- Tensu
  if HasIDNotNegated(Act,10719350) then -- Tensu
    OPTSet(10719350)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ACTIVE 1 
  if HasIDNotNegated(Act,48905153,false,(48905153*16+1),UseZBDrancia) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,11510448,false,(11510448*16+1),UseZBTigress) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,85115440,false,(85115440*16+1),UseZBBullhorn) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  if HasIDNotNegated(Act,67136033) then -- ZBBearman
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30741334) then -- ZBGiantrainer
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  if MaxxCheck() then
    -- TERROTOP
    if HasIDNotNegated(SpSum,81275020) then -- STerrotop
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(Sum,81275020) -- STerrotop
    and HasID(UseLists({AIDeck(),AIHand()}),53932291,true)
	and not HasID(AIMon(),81275020,true)
	and CardsMatchingFilter(AIMon(),FilterLevel,3) > 0
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(SpSum,53932291) then -- STaketomborg
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBInvoker
    if HasIDNotNegated(SpSum,04423206) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	
    -- ZB SPECIAL SUMMON
    if HasIDNotNegated(Sum,78872731,SummonZBMolmorat) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    -- ZBWildbow
    if HasIDNotNegated(SpSum,74393852,SummonZBWildbow) then 
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBTigress
    if HasIDNotNegated(SpSum,11510448,SummonZBTigress) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(SpSum,11510448,SummonZBTigress3) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBBullhorn
    if HasIDNotNegated(SpSum,85115440,SummonZBBullhorn) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	-- ZBTigress 2
    if HasIDNotNegated(SpSum,11510448,SummonZBTigress2) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBWildbow2
    if HasIDNotNegated(SpSum,74393852,SummonZBWildbow2) then 
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBDrancia
    if HasIDNotNegated(SpSum,48905153,SummonZBDrancia) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBWildbowFinish
    if HasIDNotNegated(SpSum,74393852) then 
      GlobalZBSummonId = 74393852
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- Utopia Lightning
    if HasIDNotNegated(SpSum,56832966,SummonUtopiaLightningFinish,2) then
      return XYZSummon()
    end
    if HasIDNotNegated(SpSum,84013237,SummonUtopiaLightningFinish,1) then
      return XYZSummon()
    end
    -- ZBGiantrainer
    if HasIDNotNegated(Sum,67136033,SummonZBBearman) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    if HasIDNotNegated(SpSum,30741334,SummonZBGiantrainer) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
    -- ZBTigerKing
    if HasIDNotNegated(SpSum,96381979,SummonZBTigerKing) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
  end
  
  -- ZBDaigusto
  if HasIDNotNegated(SpSum,00581014,SummonZBDaigusto) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  -- Tenki
  if HasIDNotNegated(Act,57103969) then -- Tenki
    OPTSet(57103969)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
   -- ZBTriangle
  if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_HAND,ActiveZBTriangle)
  and MaxxCheck()
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,46060017,nil,nil,LOCATION_SZONE,UseZBTriangle)
  and MaxxCheck()
  then
    GlobalZBTriangle = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- SUMMON 2
  if HasIDNotNegated(Sum,77150143,SummonZBThroughblade) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,04367330) then -- ZBRabbina
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,04145852) then -- ZBRam
    return {COMMAND_SUMMON,CurrentIndex}
  end
  -- SUMMON 3
  if HasIDNotNegated(Sum,77150143) then -- ZBThroughblade
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,31755044) then -- ZBViper
    return {COMMAND_SUMMON,CurrentIndex}
  end
  -- ZBViper
  if HasIDNotNegated(Act,31755044,UseZBViper) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  -- Utopia
  if MaxxCheck() then
    if HasIDNotNegated(SpSum,56832966) then
      return XYZSummon()
    end
    if HasIDNotNegated(SpSum,84013237) then
      return XYZSummon()
    end
  end
  
  if TurnEndCheck() then
	if HasIDNotNegated(SetST,73881652) then
      return {COMMAND_SET_ST ,CurrentIndex}
    end
	if HasIDNotNegated(SetST,98954106) then
      return {COMMAND_SET_ST ,CurrentIndex}
    end
	if HasIDNotNegated(SetST,40605147) then
      return {COMMAND_SET_ST ,CurrentIndex}
    end
	if HasIDNotNegated(SetST,84749824) then
      return {COMMAND_SET_ST ,CurrentIndex}
    end
  end
  
  return nil
end
------------------------
-------- FILTER --------
------------------------
function ZBFilter(c, exceptId)
  if exceptId == nil then exceptId = 0 end
  return 
    FilterSet(c,0xf1)
	and c.id ~= exceptId
end
function ZBMonFilter(c,exceptId)
  if exceptId == nil then exceptId = 0 end
  return 
    FilterSet(c,0xf1)
	and FilterType(c,TYPE_MONSTER)
	and c.id ~= exceptId
end
function ZBXyzFilter(c)
  if c == nil then return false end
  return
    FilterSet(c,0xf1)
	and FilterType(c,TYPE_XYZ)
end
function ZBNonXyzFilter(c, exceptId)
  if exceptId == nil then exceptId = 0 end
  return 
    IsSetCode(c.setcode,0xf1)
	and not FilterType(c,TYPE_XYZ)
end

function ZBBestDetachFilter(c)
  return
    not ZBFilter(c)
	or c.base_attack <= 0
end

function ZBTriangleFilter(c)
  return
    c.id == 57103969 -- ZBTenki
	and FilterLocation(c,LOCATION_SZONE)
	and FilterPosition(c,POS_FACEUP)
	or
	(
	  c.id == 04367330 -- ZBRabbina
	  or c.id == 04145852 -- ZBRam
	  or c.id == 81275020 -- STerrotop
	  or c.id == 53932291 -- STaketomborg
	)
	and FilterLocation(c,LOCATION_MZONE)
end
function ZBDranciaDestroyFilter(c)
  return (
    Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
	and DestroyFilterIgnore(c)
  )
end

------------------------
--------- USE ----------
------------------------
function UseZBViper(c)
  return 
	FilterLocation(c,LOCATION_HAND)
	and BattlePhaseCheck()
  --if #AIMon() == 5 and FilterLocation(c,LOCATION_MZONE)
  --or OppGetStrongestAttack() > AIGetStrongestAttack()
  --then
    --return true
  --end
  --local cards = AIMon()
  --for i=1, cards do
    --local c = cards[i]
	--if c.id == 48905153
	--then
	  --if c.xyz_materials then	
	    --return #c.xyz_materials < 2
	  --else
	    --return true
	  --end
	--end
  --end
  --return false
end
function UseZBTigress(c)
  OPTSet(c.id + 1)
  return true
end
function UseZBBullhorn(c)
  OPTSet(c.id)
  return true
end
function UseZBDrancia(c)
  local xyzmat = c.xyz_materials
  local countMatDetach = CardsMatchingFilter(xyzmat,ZBBestDetachFilter)
  local oppMonFaceUp = SubGroup(OppField(),FilterPosition,POS_FACEUP)
  local prio = SubGroup(oppMonFaceUp,FilterPriorityTarget)
  if countMatDetach > 0
  and DestroyCheck(oppMonFaceUp,false,false,false,ZBDranciaDestroyFilter) > 0
  and #prio > 0
  then
    return true
  end
  return false
end

function ActiveZBTriangle(c)
  if OPTCheck(c.id)
  and not HasIDNotNegated(AIST(),c.id,true)
  then
    return true
  end
  return false
end
function UseZBTriangle(c)
  if CardsMatchingFilter(AIField(),ZBTriangleFilter) > 0
  and OPTCheck(c.id)
  then
    OPTSet(c.id)
    return true
  elseif #AIMon() <= 4
  and OPTCheck(c.id)
  then
    OPTSet(c.id)
    return true
  end
  return false
end

function UseZBInvoker(c)
  OPTSet(c.id)
  return true
end
function UseZBTigerKing(c)
  local oppMonFaceUp = SubGroup(OppMon(),FilterPosition,POS_FACEUP)
  if #oppMonFaceUp > CardsMatchingFilter(oppMonFaceUp,FilterRace,RACE_BEASTWARRIOR)
  then
    OPTSet(c.id)
    return true
  end
  return false
end

function UseZBTTwisters(c)
  if CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) > 0
  and PriorityCheck(AIHand(),PRIO_DISCARD) > 3
  then
    return true
  end
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
function ZodiacBeastEffectYesNo(id,card)
  print("EffectYesNo",id)
  local result = nil
  if id == 81275020 then -- STerrotop
    result = 1
  end
  
  if id == 77150143 then -- ZBThroughblade
    result = 1
  end
  if id == 04367330 then -- ZBRabbina
    result = 1
  end
  if id == 04145852 then -- ZBRam
    result = 1
  end
  if id == 78872731 then -- ZBMolmorat
    result = 1
  end
  
  if id == 96381979 then -- ZBTigerKing
    result = 1
  end
  
  if id == 46060017 then -- ZBTriangle
    GlobalZBTriangle = 2
    result = 1
  end
  
  if result then
    if result == 1 then
      OPTSet(id)
	end
  end
  
  return result
end

function ZodiacBeastYesNo(description_id)
  -- Example implementation: continue attacking, let the ai decide otherwise
  if (description_id/16) > 99999 then
    print("YesNo - id: "..(description_id/16).." - desc: "..description_id)
    if description_id/16 == 00675319 then -- ZodiacSign
	  if GlobalZBTriangle == 0 then
	    GlobalZodiacSign = 1
	    return 1
	  else
	    return 0
	  end
	end
  else
    print("YesNo - desc: "..description_id)
  end
end

function ZodiacBeastOption(options)
  print("Options:")
  for i=1,#options do
    if options[i] == (67136033*16) then
	  return i
	end
  end
  return nil
end

------------------------
-------- SUMMON --------
------------------------
function SummonZBThroughblade(c)
  if CardsMatchingFilter(AIHand(),ZBFilter) > 1
  and PriorityCheck(AIHand(),PRIO_DISCARD) > 1
  then
    OPTSet(c.id)
	return true
  end
  return false
end
function SummonZBMolmorat(c)  
  if HasID(AIDeck(),c.id,true)
  and not HasID(AIMon(),c.id,true)
  and CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  then
    return true
  end
end

function SummonZBWildbow(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) == 0
  then
    GlobalZBSummonId = c.id
    return true
  end
  return false
end
function SummonZBWildbow2(c)
  if GlobalZBAttackSum < AI.GetPlayerLP(2)
  then
    GlobalZBSummonId = c.id
    return true
  end
  return false
end
function SummonZBTigress(c)
  local zbMon = SubGroup(AIGrave(),ZBMonFilter)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and OPTCheck(c.id)
  and CardsMatchingFilter(zbMon,FilterAttackMin,0) > 0
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id)
    return true
  end
  return false
end
function SummonZBTigress2(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and OPTCheck(c.id)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id)
    return true
  end
  return false
end
function SummonZBTigress3(c)
  if OPTCheck(c.id)
  then
    GlobalZBSummonId = c.id
	OPTSet(c.id)
    return true
  end
  return false
end
function SummonZBBullhorn(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  and OPTCheck(c.id)
  then
    GlobalZBSummonId = c.id
    return true
  end
  return false
end
function SummonZBDrancia(c)
  if CardsMatchingFilter(AIMon(),ZBXyzFilter) > 0
  and not HasID(AIMon(),c.id,true)
  then
    GlobalZBSummonId = c.id
    return true
  end
  return false
end

function SummonZBBearman(c)
 local bwMon = SubGroup(AIMon(),FilterRace,RACE_BEASTWARRIOR)
 return 
    CardsMatchingFilter(bwMon,FilterLevel,4) == 2
    and not BattlePhaseCheck()
end

function SummonZBGiantrainer(c)
  return not BattlePhaseCheck()
end

function SummonZBTigerKing(c)
  return 
    OPTCheck(57103969) -- ZBTenki
	and not HasID(UseLists({AIHand(),AIST()}),57103969,true)
	or 
	OPTCheck(10719350) -- ZBTensu
	and not HasID(UseLists({AIHand(),AIST()}),10719350,true)
end
function SummonZBDaigusto(c)
  return
    not HasIDNotNegated(AIMon(),c.id,true)
	and CardsMatchingFilter(AIGrave(),FilterType,TYPE_MONSTER) >= 3
	and (
	  not BattlePhaseCheck() 
	  or CardsMatchingFilter(AIMon(),FilterPosition,POS_FACEUP_DEFENSE) > 0
	  or TotalATK(AIMon(),2,FilterLevel,4) < 1800
	)
end

------------------------
-------- TARGET --------
------------------------
function ZBInvokerTarget(cards,min,max)
  return Add(cards,PRIO_TOFIELD,min)
end

function ZBRabbinaTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND,max)
  end
end
function ZBRamTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"ZBRamTarget")
    return Add(cards,PRIO_TOFIELD,max,ZBNonXyzFilter)
  end
end
function ZBMolmoratTarget(cards,min,max)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOGRAVE,max)
  end
end

function ZBMaterialTarget(cards,min,max)
  --print("ZBMaterialTarget: "..GlobalZBSummonId)
  local result = Add(cards,PRIO_TOGRAVE,max,ZBXyzFilter)
  local xyzmat = cards[1].xyz_materials
  local ZBMon = SubGroup(xyzmat,ZBFilter)
  GlobalZBAttackSum = 0
  for i=1,#ZBMon do
    local c = ZBMon[i]
	--print(c.id.." - attack: "..c.base_attack)
	if c.base_attack > 0 then
      GlobalZBAttackSum = GlobalZBAttackSum + c.base_attack
	end
  end
  return result
end
function ZBAttachTarget(cards,min,max)
  if LocCheck(cards,LOCATION_GRAVE) then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"ZBAttachTarget")
	if OPTCheck(00581014) 
	and HasIDNotNegated(cards,00581014)
	then -- ZBDaigusto
	  return {CurrentIndex}
	end
    return Add(cards,PRIO_TOFIELD,max)
  end
end

function ZBWildbowTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBWildbow - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
end
function ZBTigressTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBTigressTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    --print("ZBTigressTarget - GRAVE to OVERLAY")
    return ZBAttachTarget(cards,min,max)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    --print("ZBTigressTarget - MON")
    return FindID(11510448,cards,true) -- Own
  end
end
function ZBBullhornTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBBullhornTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if LocCheck(cards,LOCATION_DECK) then
    --CountPrioTarget(cards,PRIO_TOHAND,1,nil,nil,nil,"ZBBullhornTarget")
    return Add(cards,PRIO_TOHAND,max)
  end
end
function ZBDranciaTarget(cards,min,max)
  if LocCheck(cards,LOCATION_OVERLAY) then
    --print("ZBDranciaTarget - OVERLAY to GRAVE")
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return BestTargets(cards,max,TARGET_DESTROY,ZBDranciaDestroyFilter,nil,nil,c)
end

GlobalZodiacSign = 0
function ZodiacSignTarget(cards,min,max,c)
  --print("ZodiacSignTarget")
  CountPrioTarget(cards,PRIO_TOGRAVE,1,nil,nil,nil,"ZodiacSignTarget")
  return Add(cards,PRIO_TOGRAVE,max)
end
GlobalZBTriangle = 0
function ZBTriangleTarget(cards,min,max)
  if LocCheck(cards,LOCATION_DECK)
  then
    print("ZBTriangleTarget - DECK to FIELD")
    return Add(cards,PRIO_TOFIELD,max)
  end
  if GlobalZBTriangle == 1 then
    print("ZBTriangleTarget - DESTROY")
	if HasID(cards,57103969,true) -- Tenki
	then
      return FindID(57103969,cards,true)
	elseif HasID(cards,53932291,true) -- STaketomborg
	then
	  return FindID(53932291,cards,true) 
	elseif HasID(cards,81275020,true) -- STerrotop
	then
	  return FindID(81275020,cards,true)
	elseif HasID(cards,78872731,true) -- ZBMolmorat
	then
	  return FindID(78872731,cards,true)
	elseif HasID(cards,04367330,true) -- ZBRabbina
	and CardsMatchingFilter(AIGrave(),ZBFilter,04367330) > 0
	then
	  return FindID(04367330,cards,true)
	elseif HasID(cards,04145852,true) -- ZBRam
	and CardsMatchingFilter(AIGrave(),ZBMonFilter,04145852) > 0
	then
	  return FindID(04145852,cards,true)
	elseif HasID(cards,46060017,true) -- ZBTriangle
	then
	  return FindID(46060017,cards,true)
	else
	  return Add(cards,PRIO_TOGRAVE,ZBNonXyzFilter)
	end
  end
  if GlobalZBTriangle == 2 then
    print("ZBTriangleTarget - to MON")
    return Add(cards,PRIO_TOGRAVE,max)
  end
end
function ZBDirectionTarget(cards,min,max,source)
  if FilterLocation(source,LOCATION_SZONE) then
    if LocCheck(cards,LOCATION_DECK) then
	  --print("ZBDirectionTarget - DECK")
	  return Add(cards,PRIO_TOGRAVE,max)
	end
	if LocCheck(cards,LOCATION_MZONE) then
	  --print("ZBDirectionTarget - MON")
	  local result = {}
	  for i=1, #cards do
	    local c = cards[i]
	    result[i] = c
		result[i].index = i
	  end
	  table.sort(result,function(a,b)return a.attack>b.attack end)
	  return {result[1].index}
	end
  end
  if FilterLocation(source,LOCATION_GRAVE) then
    --print("ZBDirectionTarget - GRAVE to DECK")
    return Add(cards,PRIO_TODECK,max)
  end
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]

GlobalZBSummonId = 0
function ZodiacBeastCard(cards,min,max,id,c)
  -- add OnSelectCard logic here
  if c then 
    --print("Card - CardId: ".. c.id .." - cards: "..#cards.." - min: "..min.." - max: "..max)
  end
  
  if GlobalZodiacSign > 0 then
    local result = ZodiacSignTarget(cards,min,max,id,c) 
	return result 
  end
  
  if id == 77150143 then -- ZBThroughblade
    return Add(cards,PRIO_DISCARD,min)
  end
  if id == 78872731 then -- ZBMolmorat
    return Add(cards,PRIO_TOGRAVE,min)
  end
  
  if id == 31755044 then -- ZBViper
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if id == 04367330 then -- ZBRabbina
    return ZBRabbinaTarget(cards,min,max)
  end
  if id == 04145852 then -- ZBRam
    return ZBRamTarget(cards,min,max)
  end
  if id == 78872731 then -- ZBMolmorat
    return ZBMolmoratTarget(cards,min,max)
  end
  
  if id == 74393852 then -- ZBWildbow
    return ZBWildbowTarget(cards,min,max)
  end
  if id == 11510448 then -- ZBTigress
    return ZBTigressTarget(cards,min,max)
  end
  if id == 85115440 then -- ZBBullhorn
    return ZBBullhornTarget(cards,min,max)
  end
  if id == 48905153 then -- ZBDrancia
    return ZBDranciaTarget(cards,min,max,c)
  end
  
  if id == 04423206 then -- ZBInvoker
    return ZBInvokerTarget(cards,min,max)
  end
  if id == 96381979 then -- ZBTigerKing
    return Add(cards,PRIO_TOHAND,max)
  end
  if id == 00581014 then -- ZBDaigusto
    return Add(cards,PRIO_TODECK,max)
  end
  
  if id == 46060017 then -- ZBTriangle
    return ZBTriangleTarget(cards,min,max,c)
  end
  if id == 73881652 then -- ZBDirection
    return ZBDirectionTarget(cards,min,max,c)
  end
  
  if id == 57103969 then -- ZBTenki
    return Add(cards,PRIO_TOHAND,max)
  end
  
  if id == 98954106 then -- ZBJAvarice
    return Add(cards,PRIO_TODECK,max)
  end
  
  if not c 
  and GlobalZBSummonId ~= 0 then
    local result = ZBMaterialTarget(cards,min,max)
	GlobalZBSummonId = 0
    return result 
  end
  
  return nil
end
------------------------
-------- CHAIN ---------
------------------------
function ChainZBViper(c,aiTurn)
  --print("ChainZBViper")
  if NegateCheckCard(c) 
  or ZBRemovalCheckCard(c)
  or CardsMatchingFilter(OppMon(),ArmadesCheck) > 0 
  then
    return true
  end
  if IsBattlePhase() then
    local aimon,oppmon=GetBattlingMons()
	local cc = nil
	if aimon 
	then 
	  cc = GetCardFromScript(aimon)
	  --print(aimon:GetCode(),oppmon:GetCode())
	  if CardsEqual(c,aimon) 
	  and aiTurn 
	  then
	    return false
	  elseif ZBXyzFilter(cc) and aiTurn
	  then
	    return true
	  elseif WinsBattle(oppmon,aimon) 
	  and (
	    CardsEqual(c,aimon)
	    or ZBXyzFilter(cc)
 	  )
	  then
	    return true
	  
	  end
	end
  end
  return false
end
function ChainZBDranciaOppTurn(c)
  local oppFieldFaceUp = SubGroup(OppField(),FilterPosition,POS_FACEUP)
  if (RemovalCheckCard(c) or NegateCheckCard(c)) 
  and #oppFieldFaceUp > 0
  then
    OPTSet(c.id)
    return true
  end
  local targets = SubGroup(oppFieldFaceUp,ZBDranciaDestroyFilter)
  local prio = SubGroup(targets,FilterPriorityTarget)
  if DestroyCheck(oppFieldFaceUp,false,false,false,ZBDranciaDestroyFilter) > 0
  then
    local xyzmat = c.xyz_materials
	if xyzmat == nil then xyzmat = {} end
	
	if IsBattlePhase() then
	  local aimon,oppmon=GetBattlingMons()
      if WinsBattle(oppmon,aimon) 
      and CardsEqual(c,aimon)
      then
        OPTSet(c.id)
        return true
      end
	end
	if #prio>0 then
	  OPTSet(c.id)
      return true
	end
	if Duel.CheckTiming(TIMING_END_PHASE)
	and CardsMatchingFilter(xyzmat,ZBBestDetachFilter) > 0
    then
	  OPTSet(c.id)
      return true
    end
  end
  return false
end
function ChainZBDranciaAITurn(c)
  local oppFieldFaceUp = SubGroup(OppField(),FilterPosition,POS_FACEUP)
  if (RemovalCheckCard(c) or NegateCheckCard(c)) 
  and #oppFieldFaceUp > 0
  then
    OPTSet(c.id)
    return true
  end
  if DestroyCheck(oppFieldFaceUp,false,false,false,ZBDranciaDestroyFilter) > 0
  then
    local xyzmat = c.xyz_materials
	
	if IsBattlePhase() then
	  local aimon,oppmon=GetBattlingMons()
      if WinsBattle(oppmon,aimon) 
      and CardsEqual(c,aimon)
      then
        OPTSet(c.id)
        return true
      end
	end
    if Duel.GetCurrentPhase() == PHASE_END
    and CardsMatchingFilter(xyzmat,ZBBestDetachFilter) > 0
    then 
	  OPTSet(c.id)
      return true
    end
  end
  return false
end

function ChainZBDirection(c)
  if IsBattlePhase() then
    if CardsMatchingFilter(OppMon(),ArmadesCheck) > 0
	then
	  return true
	end
	local aimon,oppmon=GetBattlingMons()
	if aimon then
	  if ZBXyzFilter(GetCardFromScript(aimon))
	  and WinsBattle(oppmon,aimon)
	  then
	    OPTSet(c.id)
        return true
	  end
	end
  end
  if Duel.GetCurrentPhase() == PHASE_END 
  or ZBRemovalCheckCard(c)
  then
    OPTSet(c.id)
    return true
  end
  return false
end

function ChainZBJAvarice(c,aiTurn)
  if (Duel.GetCurrentPhase() == PHASE_END or aiTurn)
  and CardsMatchingFilter(AIGrave(),ZBMonFilter) >= 5
  and Duel.GetCurrentChain() == 0
  or ZBRemovalCheckCard(c)
  then
    OPTSet(c.id)
    return true
  end
end

function ZBRemovalCheckCard(c)
  return 
    RemovalCheckCard(c,CATEGORY_DESTROY)
    or RemovalCheckCard(c,CATEGORY_REMOVE)
	or RemovalCheckCard(c,CATEGORY_TOGRAVE)
	or RemovalCheckCard(c,CATEGORY_TOHAND)
	or RemovalCheckCard(c,CATEGORY_REMOVE)
end

GlobalRabbinaRam = 0
function ChainZBRabbinaRam(target)
  --print((target.description-1)/16)
  local result = false
  local xyzmat = target.xyz_materials
  --print(#xyzmat)
  if xyzmat then
	local rabbinaMat = false
	local ramMat = false
	if HasID(xyzmat,04367330,true) then rabbinaMat = true end
	if HasID(xyzmat,04145852,true) then ramMat = true end
	--print(rabbinaMat,ramMat)
	if rabbinaMat or ramMat
	then
	  --for i=1,Duel.GetCurrentChain() do
	    local e = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
        local g = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TARGET_CARDS)
		local p = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_PLAYER)
		if p and (p == 1-player_ai) 
		and g
		and e
		then
		  local ce = GetCardFromScript(e:GetHandler())
		  --print("OppCardid",ce.id)
		  g:ForEach(
		    function(c) 
              local c=GetCardFromScript(c)
			  --print("AICardid",c.id,c.description)
              if CardsEqual(c,target)
			  and (
			    FilterType(ce,TYPE_SPELL) and rabbinaMat
				or FilterType(ce,TYPE_TRAP) and ramMat
				or FilterType(ce,TYPE_MONSTER)
			  )
			  then
                --print("WORKS?",GlobalRabbinaRam)
				--if GlobalRabbinaRam == 1 then
				  result = true
				--end
				--GlobalRabbinaRam = GlobalRabbinaRam + 1
              end 
            end
		  ) 
		end
	  --end
	end
  end
  return result
end

function IsOppLastChainEffect()
  local p = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_PLAYER)
  if p and (p == 1-player_ai) then
    return true
  end
  return false
end

function ZodiacBeastChain(cards)
  --for i=1, #cards do
    --local c = cards[i]
	--print("ZBChain",c.id)
  --end
  
  -- add OnSelectChain logic here
  if HasID(cards,4367330,IsOppLastChainEffect) then
    print("CHAIN RABBINA")
	GlobalZBSummonId = 1 -- For DettachTargets
    return {1,CurrentIndex}
  end
  if HasID(cards,4145852,IsOppLastChainEffect) then
    print("CHAIN RAM")
	GlobalZBSummonId = 1 -- For DettachTargets
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,83326048,ChainDimensionalBarrier) then
    return Activate()
  end
  if HasIDNotNegated(cards,40605147,ChainNegation,4) and AI.GetPlayerLP(1)>1500 then -- Solemn Notice
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,84749824,ChainNegation,4) and AI.GetPlayerLP(1)>2000 then -- Solemn Warning
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,73881652,false,nil,LOCATION_GRAVE)  -- ZBDirection
  and Duel.GetCurrentChain() == 0
  and CardsMatchingFilter(AIGrave(),ZBMonFilter) >= 7
  then
    return {1,CurrentIndex}
  end
  
  local aiTurn = Duel.GetTurnPlayer() ~= (1 - player_ai)
  
  if HasIDNotNegated(cards,31755044,ChainZBViper,aiTurn)
  then
    return {1,CurrentIndex}
  end 
  
  -- OppTurn
  if Duel.GetTurnPlayer() == (1 - player_ai)
  then
    if HasIDNotNegated(cards,73881652,false,nil,LOCATION_SZONE,ChainZBDirection) then
      return {1,CurrentIndex}
    end
    if HasIDNotNegated(cards,48905153,ChainZBDranciaOppTurn) 
	then
      return {1,CurrentIndex}
    end
	if HasIDNotNegated(cards,98954106,ChainZBJAvarice,false) then
      return {1,CurrentIndex}
    end
  else
    if HasIDNotNegated(cards,48905153,ChainZBDranciaAITurn) 
	then
      return {1,CurrentIndex}
    end
	if HasIDNotNegated(cards,98954106,ChainZBJAvarice,true) then
      return {1,CurrentIndex}
    end
  end 
  
  return nil
end
------------------------
-------- BATTLE --------
------------------------

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
ZodiacBeastAtt={
48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
}
ZodiacBeastDef={
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
}
function ZodiacBeastPosition(id,available)
  result = nil
  for i=1,#ZodiacBeastAtt do
    if ZodiacBeastAtt[i]==id 
    then 
      result=1
    end
  end
  for i=1,#ZodiacBeastDef do
    if ZodiacBeastDef[i]==id 
    then 
      result=4
    end
  end
  -- add OnSelectPosition logic here
  if id == 85115440 -- ZBBullhorn
  then
    --print("GlobalZBAttackSum: "..GlobalZBAttackSum)
    if GlobalZBAttackSum >= 1200
	and #OppMon() == 0
	or
	GlobalZBAttackSum >= OppGetStrongestAttack()
	and #OppMon() > 0
    or HasID(UseLists({AIHand(),AIMon()}),31755044,true)
    then
      result = 1
    else
      result = 4
    end
  end
  return result
end

function ZodiacBeastBattleCommand(cards, activatable) 
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
  end
  if #mustattack>0 then
    targets = mustattack
  else
    targets = attackable
  end
  
  if HasIDNotNegated(cards,48905153) -- ZBDrancia
  and CanWinBattle(cards[CurrentIndex],targets) 
  then
    return Attack(CurrentIndex)
  end

  return nil
end

--[[LIST
77150143, -- ZBThroughblade
31755044, -- ZBViper
04367330, -- ZBRabbina
04145852, -- ZBRam
78872731, -- ZBMolmorat
67136033, -- ZBBearman
81275020, -- STerrotop
53932291, -- STaketomborg

46060017, -- ZBTriangle
00675319, -- ZodiacSign
57103969, -- ZBTenki
10719350, -- ZBTensu
73881652, -- ZBDirection
98954106, -- ZBJAvarice

48905153, -- ZBDrancia
85115440, -- ZBBullhorn
11510448, -- ZBTigress
74393852, -- ZBWildbow
30741334, -- ZBGiantrainer
96381979, -- ZBTigerKing
00581014, -- ZBDaigusto
04423206, -- ZBInvoker
]]
