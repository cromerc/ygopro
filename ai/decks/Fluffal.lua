require("ai.decks.Fluffal.FluffalFilter")
require("ai.decks.Fluffal.FluffalCond")
require("ai.decks.Fluffal.FluffalSummon")
require("ai.decks.Fluffal.FluffalMaterial")
require("ai.decks.Fluffal.FluffalUse")
require("ai.decks.Fluffal.FluffalTarget")
require("ai.decks.Fluffal.FluffalChain")
require("ai.decks.Fluffal.FluffalBattle")

function FluffalStartup(deck)
  print("AI_Fluffal v0.0.2.0.5 by neftalimich.")
  deck.Init					= FluffalInit
  deck.Card					= FluffalCard
  deck.Chain				= FluffalChain
  deck.ChainOrder			= FluffalChainOrder
  deck.EffectYesNo			= FluffalEffectYesNo
  deck.YesNo				= FluffalYesNo
  deck.Position				= FluffalPosition
  deck.BattleCommand		= FluffalBattleCommand
  deck.AttackTarget			= FluffalAttackTarget
  deck.AttackBoost			= FluffalAttackBoost

  --[[
  deck.Option
  deck.Sum
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]

  deck.ActivateBlacklist	= FluffalActivateBlacklist
  deck.SummonBlacklist		= FluffalSummonBlacklist
  deck.SetBlacklist			= FluffalSetBlacklist
  deck.RepositionBlacklist	= FluffalRepositionBlacklist
  deck.Unchainable			= FluffalUnchainable

  deck.PriorityList         = FluffalPriorityList

  -- DEBUG
  --[[
  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
		--Duel.ConfirmCards(1-player_ai,g)
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

FluffalIdentifier = {03841833,72413000}

DECK_FLUFFAL = NewDeck("Fluffal",FluffalIdentifier,FluffalStartup)

FluffalActivateBlacklist={
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
07394770, -- Brilliant Fusion
18895832, -- System Down

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
90809975, -- Toadally Awesome
83531441, -- Dante
}
FluffalSummonBlacklist={
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
}
FluffalSetBlacklist={
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
12580477, -- Raigeki
07394770, -- Brilliant Fusion
18895832, -- System Down

51452091, -- Royal Decree
}
FluffalRepositionBlacklist={
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
81481818, -- Fluffal Patchwork
79109599, -- King of the Swamp
06205579, -- Parasite Fusioner
67441435, -- Glow-Up Bulb
}
FluffalUnchainable={
43455065, -- Magical Spring
66127916, -- Fusion Reserve
98954106, -- Jar of Avarice
}

GlobalFluffalPercent = 0.0
GlobalCanFusionSummon = false
GlobalEffectId = 0
function FluffalInit(cards,to_bp_allowed,to_ep_allowed) -- FLUFFAL INIT
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  -- GLOBAL
  GlobalPenguin = 0
  GlobalOwl = 0
  GlobalSabres = 0
  GlobalTVendor = 0
  GlobalEffectId = 0
  GlobalSummonId = 0
  GlobalFusionId = 0
  GlobalPolymerization = 0
  GlobalDFusion = 0
  GlobalFFusion = 0
  GlobalFluffalMaterial = 0
  GlobalEdgeImpMaterial = 0
  GlobalCanFusionSummon = false

  -- GLOBAL INIT
  --print("--1")
  GlobalFluffalPercent = CountFluffal(AIDeck()) / #AIDeck()
  --print("FluffalPercent: ",(GlobalFluffalPercent * 100).." %")
  if CardsMatchingFilter(Act,FluffalFusionSTFilter2) > 0
  then
    GlobalCanFusionSummon = true
  end
  if HasIDNotNegated(Act,18895832) -- System Down
  and CardsMatchingFilter(UseLists({OppMon(),OppGrave()}),FilterRace,RACE_MACHINE) > 3
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  --print("--2")
  -- FLUFFAL KAIJU
  if CardsMatchingFilter(OppMon(),BossMonFilter) > 0 then
    FluffalSpSumKaiju(cards.spsummonable_cards)
  end
  --print("--3")
  -- FLUFFAL VS VANITY'S EMPTINESS
  if CardsMatchingFilter(OppST(),VanityFilter) > 0 then
    local vanity = FluffalVsVanity(cards,to_bp_allowed,to_ep_allowed)
	if vanity then
	  return {vanity[1],vanity[2]}
    end
	return nil
  end
  --print("--4")
  -- FLUFFAL VS DARKLAW
  GlobalDarkLaw = 0
  if HasID(OppMon(),50720316,true) -- ShadowMist
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) > 0
  then
    if HasIDNotNegated(Act,12580477) -- Raigeki
    then
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	if HasIDNotNegated(Sum,97567736,SummonTomahawk) then
      return {COMMAND_SUMMON,CurrentIndex}
    end
	return nil
  end
  if HasIDNotNegated(OppMon(),58481572,true) -- DarkLaw
  then
    GlobalDarkLaw = 1
	local darklaw = FluffalVsDarkLaw(cards,to_bp_allowed,to_ep_allowed)
	if darklaw then
	  return {darklaw[1],darklaw[2]}
    end
	return nil
  end
  --print("--5")
  -- FLUFFAL VS MACRO
  --if MacroCheck() then -- Is not working
    --local macro = FluffalVsMacro(cards,to_bp_allowed,to_ep_allowed)
	--if macro then
	  --return {macro[1],macro[2]}
    --end
  --end
  --print("--6")
  -- FLUFFAL VS EXTRA DECK BLOCKED
  if CardsMatchingFilter(OppField(),ExtraDeckBlockedFilter) > 0 then
    local extra = FluffalVsExtraBlocked(cards,to_bp_allowed,to_ep_allowed)
	if extra then
	  return {extra[1],extra[2]}
    end
	return nil
  end
  --print("--7")
  -- FLUFFAL PRINCIPAL
  local principal = FluffalPrincipal(cards,to_bp_allowed,to_ep_allowed)
  if principal then
    return {principal[1],principal[2]}
  end
  --print("--8")
  -- FLUFFAL REPOSITION
  if HasIDNotNegated(Rep,80889750,RepFSabreTooth) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Rep,40636712,RepFKraken) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Rep,57477163,RepFSheep) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Rep,83531441,RepDante) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  --print("--9")
  -- TURN END
  if TurnEndCheck() then
    -- ACTIVE END
	if HasIDNotNegated(SpSum,98280324,SpSummonSheepEnd) then
      return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
    end
	if HasIDNotNegated(Act,98280324,UseSheepEnd) then
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
	if HasIDNotNegated(Act,03841833,UseBearPoly) then
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
    -- SET ST END
    if HasID(SetST,66127916) then -- FReserve
	  return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetST,51452091,SetRDecree) then
      return {COMMAND_SET_ST,CurrentIndex}
    end
	-- SET MON END
	if HasIDNotNegated(SetMon,61173621,SetChain) then
      return {COMMAND_SET_MONSTER,CurrentIndex}
    end
	if HasIDNotNegated(SetMon,30068120,SetSabres) then
      return {COMMAND_SET_MONSTER,CurrentIndex}
    end
	if HasIDNotNegated(SetMon,72413000,SetFluffal) then -- Wings
      return {COMMAND_SET_MONSTER,CurrentIndex}
    end
	if HasIDNotNegated(SetMon,98280324,SetFluffal) -- Sheep
	and AI.GetPlayerLP(1) < 6000
	then
      return {COMMAND_SET_MONSTER,CurrentIndex}
    end
  end
  --print("--END")
  return nil
end

--[[
39246582, -- Fluffal Dog
13241004, -- Fluffal Penguin
03841833, -- Fluffal Bear
65331686, -- Fluffal Owl
98280324, -- Fluffal Sheep
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
81481818, -- Fluffal Patchwork
87246309, -- Fluffal Octo
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
------------------------
------- PRINCIPAL ------
------------------------
function FluffalPrincipal(cards,to_bp_allowed,to_ep_allowed)
  --print("PRINCIPAL")
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  -- ACTIVE 0
  print("---7.0")
  if HasIDNotNegated(Act,10383554,UseFLeo) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,05133471,nil,nil,LOCATION_HAND+LOCATION_ONFIELD)
  and UseGalaxyCyclone(1)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,41209827,UseFStarve) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,40636712,UseFKrakenSend) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00440556,UseBahamutFluffal) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,00440556,SpSummonBahamutFluffal) then
    if HasIDNotNegated(Act,13241004,UsePenguin)
    then
      return {COMMAND_ACTIVATE,CurrentIndex}
    end
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,30068120,UseSabresFPatchwork) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,07394770,false,nil,LOCATION_HAND) -- BFusion
  and UseBFusion()
  then
    GlobalEffectId = 07394770
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,07394770,false,nil,LOCATION_SZONE,POS_FACEDOWN) -- BFusion
  and UseBFusion()
  then
    GlobalEffectId = 07394770
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,01845204,UseIFusionAwesome) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30068120,UseSabresMouse) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,06142488,UseMouse) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,34773082,UseFPatchwork) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.1")
  -- ACTIVE EFFECT PRINCIPAL
  if HasIDNotNegated(Act,97567736,false,(97567736*16),UseTomahawkDamage)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,97567736,false,(97567736*16+1),UseTomahawkCopy) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,12580477) and UseRaigeki()
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,43455065,UseMSpring) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,83531441,SpSummonDante)
  and not (
    FSummonFStarve()
	and HasID(UseLists({AIHand(),AIST()}),24094653,true)
  )
  then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,13241004,UsePenguin) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,98280324,UseSheep) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,66127916,UseFReserve) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,24094653,false,nil,LOCATION_GRAVE)
  and UseFSubstituteGrave(Act[CurrentIndex])
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30068120,UseSabresNoEdgeImp) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.2")
  -- NORMAL SUMMON NO DOG
  if HasIDNotNegated(Sum,65331686,SummonOwlNoFusionST) then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  if HasIDNotNegated(Sum,10802915,SummonTGuide)
  and not HasID(Sum,39246582,true)
  then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,87246309,SummonOcto)
  and not HasID(Sum,39246582,true)
  then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  print("---7.3")
  -- ACTIVE TOY VENDOR PRINCIPAL
  if HasIDNotNegated(Act,03841833,UseBearDiscard,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,35726888) and BattlePhaseCheck() then -- FBoB
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_SZONE,POS_FACEUP) -- TVendor
  then
    if UseTVendor(Act[CurrentIndex],true) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_SZONE,POS_FACEDOWN)
  then
    if ActiveTVendor(Act[CurrentIndex],true) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,72413000,UseWings) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_HAND)
  then
    if ActiveTVendor(Act[CurrentIndex],1) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  print("---7.4")
  -- NORMAL SUMMON PRINCIPAL
  if HasID(Act,43898403,UseTwinTwister) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Sum,39246582,SummonDog) then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  if HasIDNotNegated(Sum,13241004,SummonPenguinAwesome)
  then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,65331686,SummonOwl) then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  print("---7.5")
  -- ACTIVE 2
  if HasIDNotNegated(Act,83531441,UseDanteFluffal) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,72413000,UseWingsDisadvantage) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,79109599,UseKoS) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,03841833,UseBearPoly) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.6")
  -- NORMAL SUMMON 2
  if HasIDNotNegated(Sum,10802915,SummonTGuide) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,87246309,SummonOcto) then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  if HasIDNotNegated(Sum,97567736,SummonTomahawk) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,06142488)
  and SummonMouse(2)
  then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  if HasIDNotNegated(Sum,81481818,SummonPatchwork) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,06142488)
  and SummonMouse(1)
  then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  if HasIDNotNegated(Sum,87246309,SummonOctoDiscard) then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  if HasIDNotNegated(Sum,39246582,SummonDogEnd) then
    local CurrentIndexAux = CurrentIndex
    if HasIDNotNegated(Sum,13241004,SummonPenguin)
    then
      return {COMMAND_SUMMON,CurrentIndex}
    end
    return {COMMAND_SUMMON,CurrentIndexAux}
  end
  print("---7.7")
  -- ACTIVE EFFECT SHEEP
  if HasIDNotNegated(UseLists({AIHand(),AIMon()}),98280324,true) -- Sheep
  and #AIMon() <= 3
  and SpSummonSheepEnd()
  and CountFluffal(AIMon()) == 0
  then
    for i=1,#Sum do
	  if not(Sum[i].id == 98280324) and FluffalFilter(Sum[i]) then
	    return {COMMAND_SUMMON,i}
	  end
    end
  end
  print("---7.8")
  -- SPECIAL SUMMON 1
  if HasIDNotNegated(SpSum,98280324,SpSummonSheep) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,67441435,UseBulb) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,33198837,SpSummonNaturiaBeast) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,42110604,SpSummonChanbara) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  print("---7.9")
  -- PREFUSION SUMMON
  if HasIDNotNegated(Act,17194258) and BattlePhaseCheck() then -- FConscription
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.10")
  -- ACTIVE EFFECT TOY VENDOR 2
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_SZONE,POS_FACEUP)
  then
    if UseTVendor(Act[CurrentIndex],false) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_SZONE,POS_FACEDOWN)
  then
    if ActiveTVendor(Act[CurrentIndex],false) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_HAND)
  then
    if ActiveTVendor(Act[CurrentIndex],2) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  print("---7.11")
  -- ACTIVE EFFECT FUSION PRINCIPAL
  if HasIDNotNegated(Act,01845204,UseIFusion) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,65331686,UseOwlFusion) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,43698897,UseFFactory)
  and HasID(AIGrave(),06077601,true) -- FFusion
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,43698897,ActiveFFactory)
  and HasID(AIGrave(),06077601,true) -- FFusion
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,94820406,UseDFusion) then
    if MaterialFSabreTooth() then
	  return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,24094653,false,nil,LOCATION_HAND+LOCATION_SZONE)
  and UseFSubstitute(Act[CurrentIndex])
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,24094653,UsePolymerization) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,94820406,UseDFusion) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.12")
  -- ACTIVE EFFECT POST FUSION
  if HasIDNotNegated(Act,66127916,UseFReserveDisadvantage) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,98954106,UseJAvarice) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.13")
  -- ACTIVE EFFECT SHEEP TOMAHAWK
  if HasIDNotNegated(Act,98280324,UseSheepTomahawk) then
    GlobalSheep = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,98280324,SpSummonSheepTomahawk) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  print("---7.14")
  -- ACTIVE EFFECT FUSION 2
  if HasIDNotNegated(Act,06077601,UseFFusion)
  and AI.GetCurrentPhase() == PHASE_MAIN1
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,43698897,UseFFactory) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,43698897,ActiveFFactory) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  print("---7.15")
  -- ACTIVE END
  if HasID(Act,05133471,nil,nil,LOCATION_GRAVE)
  and UseGalaxyCyclone(2)
  and (
    not FlootGateCheatCheck()
	or CardsMatchingFilter(OppST(),FluffalFlootGateFilter) > 0
  )
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,28039390,UseFReborn)
  and AI.GetCurrentPhase() == PHASE_MAIN1
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  --print("---7.16")
  -- NORMAL SUMMON END
  if HasIDNotNegated(Sum,61173621,SummonChain) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,67441435,SummonBulb) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,30068120,SummonSabres) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  GlobalIFusion = 0
  print("---7 END")
end

------------------------
------ ALTERNATIVE -----
------------------------
function FluffalSpSumKaiju(SpSum)
  for i=1,#SpSum do
    local c = SpSum[i]
	if FilterSet(c,0xD3) then -- Kaiju
	   GlobalKaiju = 1
	   return {COMMAND_SPECIAL_SUMMON,i}
	end
  end
end
function FluffalVsVanity(cards,to_bp_allowed,to_ep_allowed)
  --print("VANITY")
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  -- VANITY ACTIVE 0
  if HasIDNotNegated(Act,12580477) and UseRaigeki()
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,05133471,nil,nil,LOCATION_HAND+LOCATION_ONFIELD)
  and UseGalaxyCyclone(1)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,05133471,nil,nil,LOCATION_GRAVE)
  and UseGalaxyCyclone(2)
  and (
    not FlootGateCheatCheck()
	or CardsMatchingFilter(OppST(),FluffalFlootGateFilter) > 0
  )
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,43898403,UseTwinTwister) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,35726888) then -- FBoB
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,10383554,UseFLeo) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,41209827,UseFStarve) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,40636712,UseFKrakenSend) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- ACTIVE EFFECT VANITY
  if HasIDNotNegated(Act,34773082,UseFPatchwork) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,97567736,false,(97567736*16),UseTomahawkDamage)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,97567736,false,(97567736*16+1),UseTomahawkCopy) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,66127916,UseFReserve) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,17194258) and BattlePhaseCheck() then -- FConscription
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- VANITY ACTIVE TOY VENDOR
  if HasIDNotNegated(Act,03841833,UseBearDiscard,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_SZONE,POS_FACEUP) -- TVendor
  then
    if UseTVendor(Act[CurrentIndex],1) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_SZONE,POS_FACEDOWN)
  then
    if ActiveTVendor(Act[CurrentIndex],false) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  if HasIDNotNegated(Act,72413000,UseWings) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,70245411,nil,nil,LOCATION_HAND)
  then
    if ActiveTVendor(Act[CurrentIndex],false) then
      return {COMMAND_ACTIVATE,CurrentIndex}
	end
  end
  -- VANITY NORMAL SUMMON
  if HasIDNotNegated(Sum,39246582,SummonDog) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,97567736,SummonTomahawk) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  -- VANITY ACTIVE 2
  if HasIDNotNegated(Act,83531441,UseDanteFluffal) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,72413000,UseWingsDisadvantage) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,79109599,UseKoS) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  -- VANITY NORMAL SUMMON 2
  if HasIDNotNegated(Sum,87246309,SummonOcto) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,87246309,SummonOctoDiscard) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,39246582,SummonDogEnd) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  -- VANITY NORMAL SUMMON END
  if HasIDNotNegated(Sum,13241004,SummonEdgeImp) -- Penguin
  then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,61173621,SummonChain) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,30068120,SummonSabres) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  --print("END VANITY")
  return nil
end
function FluffalVsDarkLaw(cards,to_bp_allowed,to_ep_allowed)
  --print("DARKLAW")
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards

  if HasIDNotNegated(Act,12580477) -- Raigeki
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if OppGetStrongestAttack() < AIGetStrongestAttack() then
	if AI.GetCurrentPhase() == PHASE_MAIN1 and to_bp_allowed then
      return {COMMAND_TO_NEXT_PHASE,1}
	end
  end

  if HasID(Act,78474168,nil,nil,LOCATION_GRAVE) -- BreakthroughSkill
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,78474168,nil,nil,LOCATION_ONFIELD) -- BreakthroughSkill
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,24094653,false,nil,LOCATION_HAND+LOCATION_SZONE)
  and UseFSubstitute(Act[CurrentIndex])
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,24094653,UsePolymerization)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,94820406,UseDFusion)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,06077601,UseFFusion)
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,79109599,UseKoS) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  -- FLUFFAL REPOSITION
  if HasIDNotNegated(Rep,40636712,RepFKraken) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Rep,57477163,RepFSheep) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Rep,83531441,RepDante) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end

  return nil
end
function FluffalVsMacro(cards,to_bp_allowed,to_ep_allowed)
  return nil
end
function FluffalVsExtraBlocked(cards,to_bp_allowed,to_ep_allowed)
  return nil
end

-- FluffalM
-- EdgeImp
-- Other
-- FluffalS
-- Spell
-- Trap
-- Frightfur
-- Other Fusion
-- Other XYZ

------------------------
------- FUNCTIONS ------
------------------------

function PrioFluffalMaterial(c,mode)
  local result = 0
  if mode == nil then mode = 1 end
  if mode == 1
  then
    if FilterLocation(c,LOCATION_MZONE)
    and #AIMon() == 5 and GlobalFusionId == 80889750 -- FKraken
    then
	  result = 4
	elseif FilterLocation(c,LOCATION_MZONE)
    and #AIMon() == 2
    then
	  result = 2
    elseif FilterLocation(c,LOCATION_MZONE)
	then
      result = 1
    elseif Get_Card_Count_ID(AIHand(),c.id) > 1
	then
      result = 1
    else -- HAND
      result = 0
    end
	if Negated(c) then
	  result = result + 1
    end
  else
    if FilterLocation(c,LOCATION_MZONE)
    and #AIMon() == 5
    then
	  result = 4
	elseif FilterLocation(c,LOCATION_MZONE)
	and #AIMon() == 4
	then
	  result = 2
    elseif FilterLocation(c,LOCATION_MZONE) then
      result = 0
    else -- GRAVE
      result = 3
    end
  end
  return result
end

function PrioFrightfurMaterial(c,mode)
  local result = 0
  if mode == nil then mode = 1 end
  if mode == 1
  then
    if Negated(c) then
	  result = 10
	end
  else
    result = 0
  end
  return result
end

function FluffalPrioMode(safemode)
  local minPrio = 3 -- PrioDiscard

  if safemode == nil then safemode = true end

  if AI.GetPlayerLP(1) <= 4500
  or OppGetStrongestAttack() >= AI.GetPlayerLP(1)
  then
    minPrio = 2
  end

  if AI.GetPlayerLP(1) <= 2000
  or OppGetStrongestAttack() >= AI.GetPlayerLP(1)
  or ExpectedDamage(1) >= AI.GetPlayerLP(1)
  then
    minPrio = 1
  end

  if #AIMon() <= 1 then
    minPrio = minPrio - 1
  end

  if safemode and minPrio < 1 then
    minPrio = 1
  end

  return minPrio
end

function RoundCustom(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function FluffalSafeSpSummon(mode)
  if GlobalOppMaxxC == Duel.GetTurnCount()
  then
    if AIGetStrongestAttack() > OppGetStrongestAttack() then
	  return false
	end
  end
  return true
end
------------------------
-------- FILTER --------
------------------------

------------------------
--------- COND ---------
------------------------

------------------------
--------- USE ----------
------------------------

------------------------
-------- SUMMON --------
------------------------

------------------------
------- MATERIAL -------
------------------------

------------------------
-------- TARGET --------
------------------------

------------------------
-------- CHAIN ---------
------------------------

------------------------
-------- BATTLE --------
------------------------