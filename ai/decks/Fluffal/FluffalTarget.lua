------------------------
-------- TARGET --------
------------------------
function DogTarget(cards,min,max,c)
  --CountPrioTarget(cards,PRIO_TOHAND,1,nil,nil,nil,"DogTarget")
  return Add(cards,PRIO_TOHAND,max)
end
GlobalPenguin = 0
function PenguinTarget(cards,min,max,c)
  if GlobalPenguin == 1 then
    --CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"PenguinTarget - Field")
    return Add(cards,PRIO_TOFIELD,max)
  end
  if GlobalPenguin == 0 then
    --CountPrioTarget(cards,PRIO_DISCARD,1,nil,nil,nil,"PenguinTarget - Grave")
    return Add(cards,PRIO_DISCARD,min)
  end
end
function OwlTarget(cards,min,max,c)
  local result
  if GlobalOwl == 1 then
    result = FusionSummonTarget(cards,min,max,c,MATERIAL_TOGRAVE)
  else
    result = Add(cards)
  end
  return result
end
function SheepTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_MZONE) then
    local result = {}
    for i=1, #cards do
	  local c = cards[i]
	  result[i] = c
	  result[i].prio = GetPriority(c,PRIO_TOHAND)
	  --print("SheepTarget - id: "..result[i].id.." prio: "..result[i].prio)
	  result[i].index = i
	end
	local compare = function(a,b) return a.prio>b.prio end
	table.sort(result,compare)
    --print("SheepTarget - MZONE to HAND")
    --return Add(cards,PRIO_TOHAND,max)
	return {result[1].index}
  end
  if LocCheck(cards,LOCATION_GRAVE)
  or LocCheck(cards,LOCATION_HAND)
  then
    return Add(cards,PRIO_TOFIELD,max)
  end
end
function OctoTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    if HasID(AIGrave(),72413000,true) -- Wings
	and OPTCheck(72413000)
	and CountFluffal(AIGrave()) <= 2
	and CountEdgeImp(AIGrave()) > 0
	then
	  --CountPrioTarget(cards,PRIO_TOHAND,max,nil,EdgeImpFilter,nil,"OctoTarget")
	  result = Add(cards,PRIO_TOHAND,max,EdgeImpFilter)
	else
	  --CountPrioTarget(cards,PRIO_TOHAND,max,nil,nil,nil,"OctoTarget")
	  result = Add(cards,PRIO_TOHAND,max)
	end
	GlobalOcto = 0
    return result
  end
  if LocCheck(cards,LOCATION_REMOVED) then
    return Add(cards,PRIO_TOGRAVE,max)
  end
end
function CatTarget(cards,min,max,c)
  return Add(cards,PRIO_TOHAND,max)
end
function RabitTarget(cards,min,max,c)
  return Add(cards,PRIO_TOHAND,max)
end
function MouseTarget(cards,min,max,c)
  return Add(cards,PRIO_TOFIELD,max)
end
function WingsTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH,min)
  end
  if LocCheck(cards,LOCATION_SZONE) then
	return Add(cards,PRIO_TOGRAVE,min)
  end
end
-- EdgeImp TARGET
function TomahawkTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_DECK) then
    --print("TomahawkTarget - DECK to GRAVE")
    return Add(cards,PRIO_TOGRAVE,max)
  end
  if LocCheck(cards,LOCATION_HAND) then
    --print("TomahawkTarget - HAND to GRAVE")
    return Add(cards,PRIO_DISCARD,min)
  end
end
function ChainTarget(cards,min,max,c)
  return Add(cards,PRIO_TOHAND,max)
end
GlobalSabres = 0
function SabresTarget(cards,min,max,c)
  if GlobalSabres == 1 then -- SabresMouse
    return Add(cards,PRIO_DISCARD,min,FilterID,06142488) -- Mouse
  end
  if GlobalSabres == 2 then -- SabreFPatchwork
    if CountEdgeImp(AIDeck()) == 0 then
	  return Add(cards,PRIO_DISCARD,min,EdgeImpFilter) -- EdgeImp
	end
	if not HasID(AIDeck(),24094653,true) then
	  return Add(cards,PRIO_DISCARD,min,FilterID,24094653) -- Polymerization
	end
  end
  if (
    CardsMatchingFilter(AIST(),TVendorCheckFilter,true) > 0
    or HasID(AIHand(),70245411,true) -- TVendor
  )
  and PriorityCheck(AIHand(),PRIO_DISCARD) > 3
  then
    return Add(cards,PRIO_TOFIELD,min,FluffalFilter)
  end
  return Add(cards,PRIO_DISCARD)
end
-- Other TARGET
function TGuideTarget(cards,min,max,c)
  return Add(cards,PRIO_TOFIELD,max)
end
function KoSTarget(cards,min,max,c)
  return Add(cards,PRIO_TOHAND,max)
end
function PFusionerTarget(cards,min,max,c)
  local result
  GlobalPolymerization = 1
  result = FusionSummonTarget(cards,min,max,c,MATERIAL_TOGRAVE)
  GlobalPolymerization = 0
  return result
end
-- FluffalS TARGET
GlobalTVendor = 0
function TVendorTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_DECK) then
    --print("TVendorTarget - DECK to HAND")
	GlobalTVendor = 0
	--CountPrioTarget(cards,PRIO_TOHAND,1,nil,nil,nil,"TVendorTarget - HAND")
    return Add(cards,PRIO_TOHAND)
  end
  if GlobalTVendor == 0 then
    --print("TVendorTarget - HAND to GRAVE")
	GlobalTVendor = 1
    return Add(cards,PRIO_DISCARD)
  end
  if GlobalTVendor == 1 then
    --print("TVendorTarget - HAND to FIELD")
	GlobalTVendor = 2
	--CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"TVendorTarget - HAND to FIELD")
    return Add(cards,PRIO_TOFIELD)
  end
  if GlobalTVendor == 2 then
    GlobalTVendor = 0
  end
end

function FPatchworkTarget(cards,min,max,c)
  --CountPrioTarget(cards,PRIO_TOHAND,1,nil,nil,nil,"FPatchworkTarget")
  return Add(cards,PRIO_TOHAND,max)
end
function FRebornTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD,max)
  end
  if LocCheck(cards,LOCATION_REMOVED) then
    return Add(cards,PRIO_TOGRAVE,max)
  end
end

-- FUSION TARGET
GlobalFusionPerform = 0 -- Perform Only
GlobalFusionId = 0 -- Fusion MonsterID

GlobalPolymerization = 0
function PolymerizationTarget(cards,min,max,c)
  if FilterLocation(c,LOCATION_GRAVE) then -- FSubstitute
    return Add(cards,PRIO_TODECK)
  end
  local result
  GlobalPolymerization = 1
  result = FusionSummonTarget(cards,min,max,c,MATERIAL_TOGRAVE)
  GlobalPolymerization = 0
  return result
end
GlobalDFusion = 0
function DFusionTarget(cards,min,max,c)
  local result
  GlobalDFusion = 1
  result = FusionSummonTarget(cards,min,max,c,MATERIAL_TOGRAVE)
  GlobalDFusion = 0
  return result
end
GlobalFFactory = 0
function FFactoryTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  if LocCheck(cards,LOCATION_REMOVED) then
    return Add(cards,PRIO_TOHAND)
  end
  local result
  GlobalFFactory = 1
  result = FusionSummonTarget(cards,min,max,c,MATERIAL_TOGRAVE)
  GlobalFFactory = 0
  return result
end
GlobalFFusion = 0
function FFusionTarget(cards,min,max,c)
  local result
  GlobalFFusion = 1
  result = FusionSummonTarget(cards,min,max,c,PRIO_BANISH)
  GlobalFFusion = 0
  return result
end

-- Spell TARGET
GlobalIFusion = 0
function IFusionTarget(cards,min,max,c)
  GlobalIFusion = 1
  CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"IFusionTarget")
  local result = Add(cards,PRIO_TOFIELD,max)
  OPTSet(cards[1].cardid)
  return result
end
function FBoBTarget(cards,min,max,c)
  return Add(cards,PRIO_TOGRAVE,max)
end
function MSpringTarget(cards,min,max,c)
  return Add(cards,PRIO_DISCARD,min)
end
-- Trap TARGET
function FReserveTarget(cards,min,max,c)
  if LocCheck(cards,LOCATION_EXTRA) then
    --print("FReserveTarget - EXTRA")
    return Add(cards,PRIO_TOHAND)
  end
  if LocCheck(cards,LOCATION_DECK) then
    --print("FReserveTarget - DECK to HAND")
    return Add(cards,PRIO_TOHAND)
  end
end
function JAvariceTarget(cards,min,max,c)
  return Add(cards,PRIO_TOHAND,5,FilterType,TYPE_SPELL+TYPE_TRAP)
end

-- Frightfur TARGET
function FSabreToothTarget(cards,min,max,c)
  return Add(cards,PRIO_TOFIELD,max)
end
function FKrakenTarget(cards,min,max,c)
  return BestTargets(cards,max,TARGET_DESTROY,FKrakenSendFilter)
end
function FLeoTarget(cards,min,max,c)
  return BestTargets(cards,max,TARGET_DESTROY,FTigerDestroyFilter)
end
function FTigerTarget(cards,min,max,c)
  local maxTargets = CardsMatchingFilter(OppField(),FTigerDestroyFilter)
  --print("maxTargets: "..maxTargets)
  if maxTargets > max then
    maxTargets = max
  end
  local result = BestTargets(cards,maxTargets,TARGET_DESTROY,FTigerDestroyFilter)
  return result
end
-- OtherF TARGET
function FStarveTarget(cards,min,max,c)
  return BestTargets(cards,max,TARGET_DESTROY)
end
function FNordenTarget(cards,min,max,c)
  if CardsMatchingFilter(AIGrave(),FluffalNordenFilter) > 0 then
    return Add(cards,PRIO_TOFIELD,max,FluffalNordenFilter)
  else
    return Add(cards,PRIO_TOFIELD,max)
  end
end
-- Other TARGET
function BossMonsterTarget(cards,min,max,c)
  local bossIndex = 1
  if HasIDNotNegated(cards,58481572,true)
  then
	bossIndex = IndexByID(cards,58481572) -- DarkLaw
  elseif HasIDNotNegated(cards,90809975,true)
  then
	bossIndex = IndexByID(cards,90809975) -- Treatoad
  elseif HasIDNotNegated(cards,10443957,true)
  then
    bossIndex = IndexByID(cards,01561110) -- ABC Buster Dragon
  elseif HasIDNotNegated(cards,01561110,true)
  then
    bossIndex = IndexByID(cards,10443957) -- Infinity
  end
  if bossIndex then
    print("InfiniteIndex: "..bossIndex)
    return {bossIndex}
  else
    return BestTargets(cards,max,TARGET_DESTROY)
  end
end

-- FUSION FUNCTIONS
function MaxMaterials(fusionId,min,max)
  local result = 1
  if fusionId == 80889750 -- FSabreTooth
  and GlobalFusionPerform == 3
  then
    result = 2
  else
    result = 1
  end

  if fusionId == 11039171 then -- FWolf
    result = 1
	local expectedDamage = ExpectedDamageMichelet(1,NotFluffalFilter)
	local oppRemainLP = AI.GetPlayerLP(2) - expectedDamage
	if oppRemainLP > 0
	then
	  result = math.ceil(oppRemainLP / (2000 + FrightfurBoost(fusionId)))
	end
  end

  if fusionId == 00464362 then -- FTiger
    if CardsMatchingFilter(OppField(),FTigerAdvantageFilter)
	then
	  return min
	end
    if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	then
	  result = max - 2
	else
	  result = max - 1
	end
	if #AIMon() > 4 then
	  result = result + 1
	end

	if (result + 1) > CardsMatchingFilter(OppField(),FTigerDestroyFilter) then
	  result = CardsMatchingFilter(OppField(),FTigerDestroyFilter) - 1
	end
	if HasID(UseLists({AIHand(),AIMon()}),02729285,true) -- Cat
	or GlobalFFusion == 0
	then
	  if result > 3 then
	    result = 3
	  end
	end
	if CardsMatchingFilter(OppMon(),InfinityMonFilter) > 0 -- InfinityMon
	and CardsMatchingFilter(UseLists({AIHand(),AIMon()}),FluffalFusionProtectFilter) == 0
	then
	  result = 1
	end
	if CardsMatchingFilter(OppField(),FluffalFlootGateFilter) > 0 then
	  result = 1
	end
	if CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) >= 3
	then
	  result = 1
	elseif CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 2
	then
	  if result > 2 then
	    if GlobalFFusion > 0
		then
		  result = 3
		else
	      result = 2
		end
	  end
	elseif CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 1
	then
	  if result > 3 then
	    result = 3
	  end
	end
  end

  if result > max then
    result = max
  end
  if result < min then
    result = min
  end
  print("MaxMaterials - fusionId "..fusionId.." max: "..max.." - Result: "..result)
  return result
end
function FusionSummonTarget(cards,min,max,source,materialDest)
  if LocCheck(cards,LOCATION_EXTRA) then
    local result
	GlobalFusionPerform = 1
	result = Add(cards,PRIO_TOFIELD)
	GlobalFusionId = cards[1].id
	CountPrioTarget(cards,PRIO_TOFIELD,1,nil,nil,nil,"FusionTarget")
	print("FusionTarget: "..GlobalFusionId)
	return result
  end

  if GlobalFusionPerform == 1 then
    GlobalFusionPerform = 2
	--CountPrioTarget(cards,materialDest,1,nil,nil,nil,"FusionTarget1")
	return Add(cards,materialDest)
  end

  if GlobalFusionPerform >= 2 then
    GlobalFusionPerform = GlobalFusionPerform + 1
	--CountPrioTarget(cards,materialDest,MaxMaterials(GlobalFusionId,min,max),nil,nil,nil,"FusionTarget"..(GlobalFusionPerform-1))
	return Add(cards,materialDest,MaxMaterials(GlobalFusionId,min,max))
  end
end

function FluffalCard(cards,min,max,id,c)  -- FLUFFAL CARD
  if c then
    --print("FluffalCard: "..c.id.." - min: "..min.." - max: "..max)
  end
  -- Fluffal TARGET
  if id == 39246582 then -- Dog
    return DogTarget(cards,min,max,c)
  end
  if id == 13241004 then -- Penguin
    return PenguinTarget(cards,min,max,c)
  end
  if id == 65331686 then -- Owl
    return OwlTarget(cards,min,max,c)
  end
  if id == 98280324 then -- Sheep
    return SheepTarget(cards)
  end
  if id == 87246309 then -- Octo
    return OctoTarget(cards,min,max,c)
  end
  if id == 02729285 then -- Cat
    return CatTarget(cards)
  end
  if id == 38124994 then -- Rabit
    return RabitTarget(cards)
  end
  if id == 06142488 then -- Mouse
    return MouseTarget(cards,min,max,c)
  end
  if id == 72413000 then -- Wings
    return WingsTarget(cards)
  end
  -- EdgeImp TARGET
  if id == 97567736 then -- Tomahawk
    return TomahawkTarget(cards)
  end
  if id == 61173621 then -- Chain
    return ChainTarget(cards,min,max,c)
  end
  if id == 30068120 then -- Sabres
    return SabresTarget(cards,min,max,c)
  end
  -- Other TARGET
  if id == 10802915 then -- TGuide
    return TGuideTarget(cards)
  end
  if id == 79109599 then -- KoS
    return KoSTarget(cards)
  end
  if id == 06205579 then -- PFusioner
    return PFusionerTarget(cards)
  end
  -- FluffalS TARGET
  if id == 70245411 then -- TVendor
    return TVendorTarget(cards,min,max,c)
  end
  if id == 34773082 then -- FPatchwork
    return FPatchworkTarget(cards,min,max,c)
  end
  if id == 28039390 then -- FReborn
    return FRebornTarget(cards,min,max,c)
  end
  -- Fusion TARGET
  if id == 24094653 then -- Polymerization
    return PolymerizationTarget(cards,min,max,c)
  end
  if id == 94820406 then -- DFusion
    return DFusionTarget(cards,min,max,c)
  end
  if id == 43698897 then -- FFactory
    return FFactoryTarget(cards,min,max,c)
  end
  if id == 06077601 then -- FFusion
    return FFusionTarget(cards,min,max,c)
  end
  if id == 01845204 then -- IFusion
	return IFusionTarget(cards,min,max,c)
  end
  if id == 17194258 then -- FConscription
	return FReserveTarget(cards,min,max,c)
  end
  -- Spell TARGET
  if id == 35726888 then -- FBoB
    return FBoBTarget(cards,min,max,c)
  end
  if id == 43455065 then -- MSpring
    return MSpringTarget(cards,min,max,c)
  end
  -- Trap TARGET
  if id == 66127916 then -- FReserve
	return FReserveTarget(cards)
  end
  if id == 98954106 then -- JAvarice
	return JAvariceTarget(cards)
  end
  if id == 78474168 then -- BTS
    return BossMonsterTarget(cards,min,max,c)
  end
  -- Frightfur TARGET
  if id == 80889750 then -- FSabreTooth
    return FSabreToothTarget(cards,min,max,c)
  end
  if id == 40636712 then -- FKraken
	return FKrakenTarget(cards,min,max,c)
  end
  if id == 10383554 then -- FLeo
	return FLeoTarget(cards)
  end
  if id == 00464362 then -- FTiger
    return FTigerTarget(cards,min,max,c)
  end
  -- OtherF TARGET
  if id == 41209827 then
    return FStarveTarget(cards,min,max,c)
  end
  if id == 17412721 then
    return FNordenTarget(cards,min,max,c)
  end
  -- OtherX TARGET
  if id == 90809975 then -- Toadally
    return Add(cards,PRIO_TODECK,max,FilterID,90809975)
  end
  if id == 00440556 then -- Bahamut Effect
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalSummonId == 00440556 then -- Bahamut Summon
    return Add(cards,PRIO_TOGRAVE,min,FluffalBahamutMaterialFilter)
  end

  if GlobalKaiju == 1 then
    GlobajKaiju = 0
    return BossMonsterTarget(cards,min,max,c)
  end

  return nil
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