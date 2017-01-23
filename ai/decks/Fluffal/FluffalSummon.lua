------------------------
-------- SUMMON --------
------------------------
-- Fluffal SUMMON
function SummonDog()
  return
    OPTCheck(39246582)
	and CountFluffal(AIDeck()) > 0
	and #AIDeck() > 17
end
function SummonDogEnd()
  return
    OPTCheck(39246582)
	and CountFluffal(AIDeck()) > 0
end
function SummonPenguin()
  if CardsMatchingFilter(AIHand(),PenguinFilter) > 0
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 0
  then
    return true
  end
  return false
end
function SummonPenguinAwesome(c)
  local waterMon = SubGroup(AIMon(),FilterAttribute,ATTRIBUTE_WATER)
  if (
    HasID(UseLists({AIHand(),AIST()}),01845204,true) -- IFusion
	and OPTCheck(01845204)
	and HasID(AIExtra(),17412721,true) -- Norden
	or
	CardsMatchingFilter(waterMon,FilterLevel,4) > 0
  )
  and ToadallyPlayCheck()
  and #AIMon() <= 3
  then
    return true
  elseif CardsMatchingFilter(AIHand(),FilterID,c.id) >= 2
  and HasIDNotNegated(AIMon(),03113836,true) -- GK Seraphinite
  then
    return true
  end
  return false
end
function SummonOwl(c)
  return
    OPTCheck(65331686) -- Own
	and CardsMatchingFilter(OppField(),ExtraDeckBlockedFilter) == 0
	and (
	 CardsMatchingFilter(UseLists({AIHand(),AIMon()}),FluffalFusionMonFilter)
	 +
	 CardsMatchingFilter(AIMon(),FrightfurMonFilter)
	) > 0
end
function SummonOwlNoFusionST(c)
  return
    OPTCheck(65331686) -- Own
	and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) == 0
	and UseOwlPoly(c)
	and not OPTCheck(72413000) -- Wings
	and CardsMatchingFilter(OppField(),ExtraDeckBlockedFilter) == 0
end
function SpSummonSheep()
  if OPTCheck(98280324)
  and not HasID(AIMon(),98280324,true)
  and CountEdgeImp(AIGrave()) > 0
  then
    return true
  else
    return false
  end
end
function SpSummonSheepTomahawk()
  if OPTCheck(98280324)
  and not HasID(AIMon(),98280324,true)
  and HasID(AIHand(),97567736,true) -- Tomahawk
  then
    return true
  else
    return false
  end
end
function SpSummonSheepEnd()
  if OPTCheck(98280324)
  and not HasID(AIMon(),98280324,true)
  and CountEdgeImp(UseLists({AIGrave(),AIHand()})) > 0
  then
    return true
  else
    return false
  end
end
function SummonOcto()
  if UseOcto() then
    if CardsMatchingFilter(AIBanish(),FilterType,TYPE_MONSTER) > 0
	and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	then
	  return true
	elseif CanUseSheep(true)
	then
	  return true
	end
  end
  return false
end
function SummonOctoDiscard()
  if UseOcto()
  and (
    HasID(AIHand(),70245411,true) -- TVendor
	or
	CardsMatchingFilter(AIST(),TVendorCheckFilter,true) > 0
	or
	HasID(AIGrave(),03841833,true) -- Bear
	and OPTCheck(03841833)
	and HasID(AIDeck(),70245411,true)
  )
  then
    return true
  end
  return false
end
function SummonMouse(mode)
  if mode == nil then
    mode = 2
  end
  if OPTCheck(06142488)
  and Get_Card_Count_ID(AIDeck(),06142488) == mode
  and #AIMon() < 3
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) > 0
  and (
    CountEdgeImp(UseLists({AIHand(),AIMon()}))
	or CardsMatchingFilter(UseLists({AIHand(),AIMon()}),SubstituteMaterialFilter) > 0
  )
  and BattlePhaseCheck()
  then
    return true
  else
    return false
  end
end
function SummonPatchwork()
  if CountEdgeImp(UseLists({AIMon(),AIHand()})) == 0
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) > 0
  and not HasID(UseLists({AIHand(),AIST()}),01845204,true) -- IFusion
  then
    return true
  else
    return false
  end
end
-- EdgeImp SUMMON
function SummonTomahawk(c)
  return OPTCheck(97567736+1)
end
function SummonChain(c)
  return SummonEdgeImp(c)
end
function SummonSabres(c)
  return SummonEdgeImp(c)
end
function SummonEdgeImp(c)
  return
    BattlePhaseCheck()
	and (
	  OppGetStrongestAttDef() < c.attack
	  or
	  OppGetStrongestAttDef() < AIGetStrongestAttack()
	  and (
	    CanWinBattle(c,OppMon())
		or CardsMatchingFilter(AIMon(),FrightfurMonFilter) >= #OppMon()
	  )
	)
end
-- Other SUMMON
function SummonTGuide()
  if HasID(AIDeck(),30068120,true) -- Sabres
  and OPTCheck(06142488) -- Mouse
  and #AIMon() <= 3
  then
    if HasID(AIExtra(),83531441,true) -- Dante
	and (
	  CardsMatchingFilter(OppMon(),FilterAttackMax,2400) > 0
	  or #OppMon() == 0
	)
    then
      return true
	elseif HasID(AIExtra(),41209827,true) -- FStarve
	and CardsMatchingFilter(OppMon(),FilterSummon,SUMMON_TYPE_SPECIAL) > 0
	and CardsMatchingFilter(OppMon(),FilterLevelMin,5) > 0
	and HasID(UseLists({AIHand(),AIST()}),24094653,true) -- Polymerization
    then
	  return true
	else
	  return false
	end
  else
    return false
  end
end
function SummonBulb()
  if FieldCheck(4) > 0
  and OPTCheck(06142488) -- Mouse
  and OppGetStrongestAttDef() <= 2100
  and AI.GetCurrentPhase() == PHASE_MAIN1
  then
    return true
  end
  return false
end
-- Frightfur SUMMON
function FSummonFDaredevil(c)
  return SpSummonFDaredevil(c)
end
function SpSummonFDaredevil(c)
  local frightfurAtk = c.attack + FrightfurBoost(c.id)
  local canAttack = FluffalCanAttack(OppMon(),frightfurAtk)
  local frightfurGrave = CountFrightfurMon(UseLists({AIGrave(),AIMon()}))
  
  if (frightfurGrave + 1) * 500 >= AI.GetPlayerLP(2) 
  or 
  OppGetStrongestAttDef() >= AIGetStrongestAttack()
  and frightfurAtk > OppGetStrongestAttDef()
  and OppGetStrongestAttDef() > 3000
  and Duel.GetTurnCount() > 1
  then
    return true
  end
  return false
end

function FSummonFSabreTooth(c)
  if not HasIDNotNegated(AIMon(),80889750,true) -- FSabreTooth
  then
    return true
  elseif CardsMatchingFilter(AIMon(),FilterID,80889750) < 2
  and #AIMon() <= 4
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) <= 2
  and BattlePhaseCheck()
  and (
	HasID(AIMon(),40636712,true) -- FKraken
	or HasID(AIMon(),00464362,true) -- FTiger
  )
  then
    return true
  else
    if CardsMatchingFilter(AIMon(),FilterID,80889750) == 2
	or not BattlePhaseCheck()
	or #AIMon() <= 4
	then
	  return 1
	end
	return false
  end
end
function SpSummonFSabreTooth(c)
  if not HasIDNotNegated(AIMon(),80889750,true) -- FSabreTooth
  then
    return 1
  end
  return false
end

function FSummonFKraken(c)
  return SpSummonFKraken(c)
end
function SpSummonFKraken(c)
  local frightfurAtk = 2200 + FrightfurBoost(40636712)
  local canAttack = FluffalCanAttack(OppMon(),frightfurAtk)
  if not HasIDNotNegated(AIMon(),40636712,true) -- FKraken
  then
    if CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_INDESTRUCTABLE) > 0
	and CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_IMMUNE_EFFECT) < #OppMon()
    or
	CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) < 2
	and (
	  #OppMon() == 0
	  or
	  #OppMon() == 1
	  and CountFluffal(UseLists({AIHand(),AIMon()})) + CountEdgeImp(UseLists({AIHand(),AIMon()})) >= 2
	  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	  and CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_IMMUNE_EFFECT) < #OppMon()
	  or
	  #OppMon() == 2
	  and canAttack > 0
	  or
	  #OppMon() > 2
	  and canAttack >= 2
	)
	then
	  return true
	else
	  return false
	end
  else
	if not BattlePhaseCheck() then
	  return 1
	end
	return false
  end
end

function FLeoFinish()
  return CardsMatchingFilter(OppMon(),FLeoFinishFilter,c) > 0
end
function FSummonFLeo(c)
  return SpSummonFLeo(c)
end
function SpSummonFLeo(c)
  return
	not HasIDNotNegated(AIMon(),10383554,true) -- FLeo
	and OPTCheck(10383554)
	and FLeoFinish()
end

function FSummonFBear(c)
  return SpSummonFBear(c)
end
function SpSummonFBear(c)
  if not BattlePhaseCheck() then
	return 1
  end
  local frightfurAtk = 2200 + FrightfurBoost(85545073)
  c.attack = frightfurAtk
  local canAttack = FluffalCanAttack(OppMon(),frightfurAtk)
  if not HasIDNotNegated(AIMon(),85545073,true) -- FBear
  then
    return
	  #OppMon() > 0
	  and canAttack > 0
	  and CanWinBattle(c,OppMon(),true)
  end
  return false
end

function FWolfFinish()
  --print("FWolfFinish")
  local cards = UseLists({AIHand(),AIMon()})
  if GlobalFFusion == 1 then cards = UseLists({AIGrave(),AIMon()}) end
  local fluffalMon = CountFluffal(cards)
  local frightfurMon = CountFrightfurMon(AIMon())
  local expecteDamage = ExpectedDamageMichelet(1,NotFluffalFilter)
  local fBoost = FrightfurBoost(11039171)
  local frightfurAtk = 2000 + fBoost
  --print("FWolf - Attack",frightfurAtk)
  --print("expecteDamage: "..expecteDamage)
  expecteDamage = expecteDamage + (fBoost * (frightfurMon + 1))
  --print("DummyExpecteDamage: "..expecteDamage)
  local materialNeeded = math.ceil((AI.GetPlayerLP(2) - expecteDamage) / frightfurAtk)
  --print("MaterialNeeded: "..materialNeeded)
  --print((fluffalMon + 1),fluffalMon,(fluffalMon + 1) >= materialNeeded)
  return
    #OppMon() == 0
	or
	HasIDNotNegated(AIMon(),80889750,true)
	and HasIDNotNegated(AIMon(),00464362,true)
	and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) < 3
	or
	#OppMon() <= 1
	and HasIDNotNegated(AIMon(),00464362,true)
	and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 0
	and OppGetStrongestAttDef() < 3000
	or
	#OppField() == 0
	and CountFluffal > 1
	or
	HasIDNotNegated(AIMon(),00464362,true)
	and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 0
	and (
	  AIGetStrongestAttack() > OppGetStrongestAttDef()
	  or frightfurAtk > OppGetStrongestAttDef()
	)
	and expecteDamage < AI.GetPlayerLP(2)
	and
	  (fluffalMon + 1) >= materialNeeded
end
function FSummonFWolf(c)
  if not BattlePhaseCheck() then
	return 0
  end
  if not HasIDNotNegated(AIMon(),11039171,true) -- FWolf
  then
    return
      FWolfFinish()
	  and CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_INDESTRUCTABLE_BATTLE) == 0
  end
  return false
end
function SpSummonFWolf(c)
  return false
end

function FSummonFTiger(c)
  if not HasIDNotNegated(AIMon(),00464362,true) -- FTiger
  and BattlePhaseCheck()
  then
	if CardsMatchingFilter(OppField(),FTigerAdvantageFilter) > 0
	then
	  return 11
	end
	if GlobalFFusion > 0 
	and CardsMatchingFilter(OppField(),FTigerDestroyFilter) > 3
	then
	  return 10
	end
	if OppGetStrongestAttDef() >= AIGetStrongestAttack()
	and OppGetStrongestAttDef() > 3000
	and CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_IMMUNE_EFFECT) > 0
	then
	  if HasID(AIMon(),80889750,true) -- FSabreTooth
	  then
	    return 10
	  elseif CardsMatchingFilter(OppField(),FTigerDestroyFilter) > 0
	  then
	    return 9
	  else
	    return 8
	  end
	end
    return
	  CardsMatchingFilter(OppField(),FTigerDestroyFilter) > 1
	  or
	  CardsMatchingFilter(OppField(),FTigerDestroyFilter) == 1
	  and OppGetStrongestAttDef() >= AIGetStrongestAttack()
	  and HasID(AIMon(),80889750,true) -- FSabreTooth
  else
    if not BattlePhaseCheck() then
	  return 1
	end
  end
  return false
end
function SpSummonFTiger(c)
  return
    not HasID(AIMon(),00464362,true) -- FTiger
    and OppGetStrongestAttDef() >= AIGetStrongestAttack()
	and HasID(AIMon(),80889750,true) -- FSabreTooth
	and BattlePhaseCheck()
end

function FSummonFSheep(c)
  if not HasIDNotNegated(AIMon(),57477163,true) -- FSheep
  then
    if Duel.GetTurnCount() == 1
	and not OPTCheck(61173621) -- Chain
	then
	  return 1
	end
	return SpSummonFSheep(c)
  end
  return false
end
function SpSummonFSheep(c)
  local frightfurAtk = 2000 + FrightfurBoost(57477163)
  if not HasIDNotNegated(AIMon(),57477163,true) -- FSheep
  then
    if CardsMatchingFilter(OppField(),FSheepAdvantageFilter) > 0 then
	  if CardsMatchingFilter(OppMon(),FilterPosition,POS_ATTACK) > 0
	  or CardsMatchingFilter(OppMon(),FilterDefenseMax,frightfurAtk-1) > 0
	  then
	    return 9
	  else
	    return 5
	  end
    end
    return true
  else
    if not BattlePhaseCheck() then
	  return 1
	end
  end
  return false
end
-- OtherF SUMMON
function FSummonFStarve(c)
  return
	CardsMatchingFilter(OppMon(),FilterSummon,SUMMON_TYPE_SPECIAL) > 0
	and (
      SpSummonFStarve()
	  or
	  AI.GetPlayerLP(2) <= 2800
	  and CardsMatchingFilter(OppMon(),FilterPosition,POS_FACEUP_ATTACK) > 0
    )
end
function SpSummonFStarve(c)
  if not HasIDNotNegated(AIMon(),41209827,true) -- FStarve
  then
    return CardsMatchingFilter(OppMon(),FilterLevelMin,5) > 0
  end
  return false
end

-- OtherS SUMMON
function SpSummonNaturiaBeast(c)
  return
    OppGetStrongestAttack() <= 2200
end
function SpSummonChanbara(c)
  return
    AI.GetCurrentPhase() == PHASE_MAIN1
	and GlobalBPAllowed
	and (
	  OppGetStrongestAttack() < AIGetStrongestAttack()
	  or CardsMatchingFilter(OppMon(),FilterAttackMax,2200) > 0
	  or #OppMon() == 0
	)
end
-- OtherX SUMMON
function SpSummonBahamutFluffal(c)
  if HasID(AIExtra(),90809975,true) then -- Toadally
    GlobalSummonId = 00440556
    return true
  end
  return false
end

------------------------
--------- SET ----------
------------------------
function SetChain(c)
  return not HasID(AIMon(),c.id,true)
end
function SetSabres(c)
  return SetFluffal(c)
end
function SetFluffal(c)
  if CardsMatchingFilter(AIMon(),FluffalFusionMonFilter) > 0
  or #AIMon() > 0
  then
    return false
  end
  return true
end
-- Trap SET
-- Trap Set
function SetFReserve(c)
  return true
end
function SetRDecree(c)
  return not HasID(AIST(),c.id,true)
end
------------------------
------ REPOSITION ------
------------------------
function RepFSabreTooth(c)
  if FilterPosition(c,POS_DEFENSE)
  and CardsMatchingFilter(OppMon(),FilterAttackMax,c.attack) > 0
  then
    return true
  elseif FilterPosition(c,POS_ATTACK)
  and AI.GetCurrentPhase() == PHASE_MAIN2
  and CardsMatchingFilter(OppMon(),FilterAttackMin,c.attack+1) > 0
  then
    return true
  else
    return false
  end
end
function RepFKraken(c)
  if FilterPosition(c,POS_DEFENSE)
  and AI.GetCurrentPhase() == PHASE_MAIN1
  then
    if c.attack >= c.defense then
	  return true
	end
	if OPTCheck(c.id)
	and OppGetStrongestAttack() < AIGetStrongestAttack()
	then
	  return true
	elseif not OPTCheck(c.id)
	and OppGetStrongestAttack() < c.attack
	then
	  return true
	elseif not OPTCheck(c.id)
	and OppGetStrongestAttack() < AIGetStrongestAttack()
	and OppGetStrongestAttack() >= c.attack
	and #OppMon() > 1
	then
	  return true
	end
  end
  if AI.GetCurrentPhase() == PHASE_MAIN2 then
    return GenericReposition(c)
  end
  return false
end
function RepFSheep(c)
  if FilterPosition(c,POS_DEFENSE)
  then
    return true
  else
    return false
  end
end

function RepDante(c)
  if FilterPosition(c,POS_DEFENSE)
  and BattlePhaseCheck()
  and (
    #OppMon() == 0
	or OppGetStrongestAttDef() <= c.attack
  )
  and NotNegated(c)
  or
  FilterPosition(c,POS_FACEUP_ATTACK)
  and (
    Negated(c)
    or TurnEndCheck()
    or OppGetStrongestAttDef()>=1000
    and OppHasStrongestMonster()
  )
  then
    return true
  elseif FilterPosition(c,POS_FACEDOWN_DEFENSE)
  and c.xyz_material_count > 0
  then
    return true
  else
    return false
  end
end


function GenericReposition(c)
  if FilterPosition(c,POS_ATTACK) then
    if c.defense > c.attack
	then
      return true
    else
	  return false
	end
  end
  if FilterPosition(c,POS_DEFENSE) then
    if c.attack >= c.defense then
      return true
    else
	  return false
	end
  end
  return false
end

--[[
39246582, -- Fluffal Dog
13241004, -- Fluffal Penguin
03841833, -- Fluffal Bear
65331686, -- Fluffal Owl
98280324, -- Fluffal Sheep
87246309, -- Fluffal Octo
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
81481818, -- Fluffal Patchwork
97567736, -- Edge Imp Tomahawk
61173621, -- Edge Imp Chain
30068120, -- Edge Imp Sabres
10802915, -- Tour Guide from the Underworld
79109599, -- King of the Swamp
06205579, -- Parasite Fusioner
67441435, -- Glow-Up Bulb

70245411, -- Toy Vendor
06077601, -- Frightfur Fusion
43698897, -- Frightfur Factory
34773082, -- Frightfur Patchwork
28039390, -- Frightfur Reborn
01845204, -- Instant Fusion
24094653, -- Polymerization
94820406, -- Dark Fusion
05133471, -- Galaxy Cyclone
35726888, -- Foolish Burial of Belongings
43455065, -- Magical Spring
43898403, -- Twin Twister
12580477, -- Raigeki

66127916, -- Fusion Reserve
98954106, -- Jar of Avarice
51452091, -- Royal Decree

91034681, -- Frightfur Daredevil
80889750, -- Frightfur Sabre-Tooth
40636712, -- Frightfur Kraken
10383554, -- Frightfur Leo
85545073, -- Frightfur Bear
11039171, -- Frightfur Wolf
00464362, -- Frightfur Tiger
57477163, -- Frightfur Sheep
41209827, -- Starve Venom Fusion Dragon
42110604, -- Hi-Speedroid Chanbara
83531441, -- Dante
]]