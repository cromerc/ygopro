------------------------
-------- FILTER --------
------------------------
-- FluffalM FILTER
function FluffalFilter(c)
  return FilterSet(c,0xA9)
end
function NotFluffalFilter(c)
  return not FluffalFilter(c)
end
function PenguinFilter(c)
  if c.id == 39246582 and OPTCheck(39246582) -- Dog
    or c.id == 65331686 and OPTCheck(65331686) -- Owl
    or c.id == 81481818 -- Patchwork
	or c.id == 06142488 -- Mouse
  then
	return true
  elseif c.id == 87246309 -- Octo
  then
    return UseOcto()
  else
    return false
  end
end
function FluffalFusionProtectFilter(c)
  return
    c.id == 02729285 -- Cat
    or c.id == 38124994 -- Rabit
	or c.id == 13241004 -- Penguin
end
-- EdgeImp FILTER
function EdgeImpFilter(c)
  return FilterSet(c,0xC3)
end
-- Other FILTER
function FluffalFusionMonFilter(c)
  return
    EdgeImpFilter(c)
	or
	SubstituteMaterialFilter(c)
end
function SubstituteMaterialFilter(c)
  return
    c.id == 81481818 -- Patchwork
	and FilterLocation(c,LOCATION_MZONE)
	or
	c.id == 79109599 -- KoS
	or
	c.id == 06205579 -- PFusioner
end
-- FluffalS FILTER
function TVendorCheckFilter(c,canUse)
  if canUse then
    return
	  c.id == 70245411
	  and OPTCheck(c.cardid)
  else
    return
	  c.id == 70245411
	  and not OPTCheck(c.cardid)
  end
end
function FrightfurSTFilter(c)
  return
    FilterSet(c,0xAD)
	and FilterType(c,TYPE_SPELL+TYPE_TRAP)
end
-- Spell FILTER
function FusionArchetypeFilter(c)
  return FilterSet(c,0x46)
end
function FluffalFusionSTFilter(c)
  return
    c.id == 24094653 -- Polymerization
	or
	c.id == 94820406 -- DFusion
	or
	c.id == 79109599 -- KoS
	and FilterLocation(c,LOCATION_HAND)
	or
	c.id == 43698897 -- FFactory
	and UseFFactoryAux(true)
	and OPTCheck(43698897)
	or
	c.id == 34773082 -- FPatchwork
	and OPTCheck(34773082)
end
function FluffalFusionSTFilter2(c)
  return
    FluffalFusionSTFilter(c)
    or
	c.id == 06077601 -- FFusion
	and OPTCheck(06077601)
end
-- Trap FILTER
-- Frightfur FILTER
function FrightfurMonFilter(c)
  return
    FilterSet(c,0xAD)
	and FilterType(c,TYPE_MONSTER)
end
function NotFrightfurMonFilter(c)
  return
    not FilterSet(c,0xAD)
	and FilterType(c,TYPE_MONSTER)
end
function FrightfurMonNegatedFilter(c)
  return
	FilterSet(c,0xAD)
	and FilterType(c,TYPE_MONSTER)
	and Negated(c)
end
function FSabreToothFilter(c)
  return
    c.id == 80889750 and NotNegated(c)
end
function FLeoFinishFilter(c,source)
  return
    AI.GetPlayerLP(2) <= c.base_attack -- Origial Attack
	and Targetable(c,TYPE_MONSTER)
	and FluffalDestroyFilter(c)
    and Affected(c,TYPE_MONSTER)
end
function FTigerDestroyFilter(c)
  return (
    Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
	and FluffalDestroyFilter(c)
	and not IgnoreList(c)
  )
end
function FKrakenSendFilter(c)
  return (
    Targetable(c,TYPE_MONSTER)
    and Affected(c,TYPE_MONSTER)
	and FluffalSendFilter(c)
	and not IgnoreList(c)
  )
end
-- Other Fusion FILTER
function FluffalNordenFilter(c)
  return
    FilterAttribute(c,ATTRIBUTE_WATER)
	and FilterLevel(c,4)
end
-- Other XYZ FILTER
function FluffalBahamutMaterialFilter(c)
  return Negated(c)
    or c.id == 17412721
end

-- Other Filter
function FluffalDestroyFilter(c,nontarget,skipblacklist,skipignore)
  return DestroyFilter(c,nontarget,skipblacklist,skipignore)
  and not BypassDestroyFilter(c)
end
function FluffalSendFilter(c,nontarget)
  return not FilterStatus(c,STATUS_LEAVE_CONFIRMED)
  and (nontarget==true or not FilterAffected(c,EFFECT_CANNOT_BE_EFFECT_TARGET))
  and not BypassSendFilter(c)
end

function ByPassDestroyFilter(c)
  return (
    (
	  (
        c.id==62541668 -- Number 77: Seven Sins
        or c.id==99469936 -- Crystalzero Lancer
        or c.id==67173574 -- Number C102
        or c.id==23998625 -- Number 53
        or c.id==01855932 -- Bujintei Kagotsuchi
        or c.id==49678559 -- Number 102
        or c.id==76067258 -- Number 66
        or c.id==23232295 -- BB Lead Joke
        or c.id==48739166 -- Number 101
        or c.id==25853045 -- Black Ray Lancer
        or c.id==25341652 -- Maestroke the Symphony Dijinn
        or c.id==78156759 -- Wind-Up  Zenmaines
        or c.id==10002346 -- Gachi Gachi Gantetsu
        or c.id==65305468 -- Number F0: Utopic Future
        or c.id==15914410 -- Mechquipped Angineer
	  )
	  and c.xyz_material_count>0
	)
    or c.id==94977269 -- El Shaddoll Winda
    or c.id==93302695 -- Kozmol Wickedwitch
  )
  and NotNegated(c)
end
function BypassSendFilter(c)
  return c.id==74586817 -- PSY-Framelord Omega
end
------------------------
-------- COUNT ---------
------------------------
-- General Count
function CountPrioTarget(cards,loc,minPrio,Type,filter,opt,debugMode)
  local result = 0
  if minPrio == nil then
    minPrio = 1
  end
  for i=1, #cards do
    local c = cards[i]
	if debugMode ~= nil then
	  --print(debugMode.." - id: "..c.id)
	end
	c.prio = GetPriority(c,loc)
	if not FilterCheck(c,filter,opt)
    or not (Type == nil or bit32.band(c.type,Type) > 0)	then
      c.prio = -1
    end
	if debugMode ~= nil then
	  print(debugMode.." - Prio: "..c.prio,c.original_id.." - "..GetName(c))
	end
	if c.prio > minPrio then
	  result = result + 1
	end
  end
  if debugMode ~= nil then
	print(debugMode.." - Count: "..result)
  end
  return result
end
-- FluffalM COUNT
function CountFluffal(cards)
  return CardsMatchingFilter(cards,FluffalFilter)
end
-- EdgeImp COUNT
function CountEdgeImp(cards)
  return CardsMatchingFilter(cards,EdgeImpFilter)
end
-- Other COUNT
-- FluffalS COUNT
function CountFPatchworkTarget()
  return
    math.min(CardsMatchingFilter(AIDeck(),FilterID,24094653),CountEdgeImp(AIDeck())) -- Poly/EdgeImp
end
-- Spell COUNT
-- Trap COUNT
-- Frightfur COUNT
function CountFrightfurMon(cards)
  return CardsMatchingFilter(cards,FrightfurMonFilter)
end
-- Other Fusion COUNT
-- Other XYZ COUNT

-- FUSION COUNT
function CountFrighturFusion(prio)
  local result = 0
  if prio == nil then prio = 3 end
  --local fusionExtra = SubGroup(AIExtra(),FilterType,TYPE_FUSION)
  --CountPrioTarget(AIExtra(),PRIO_TOFIELD,3,nil,FilterType,TYPE_FUSION,"CountFrighturFusion")
  result = CountPrioTarget(AIExtra(),PRIO_TOFIELD,1)
  return result
end
function CountFluffalMaterial(cards,loc,safe)
  local result = 0
  local minPrio = FluffalPrioMode(safe)
  if loc == nil then loc = MATERIAL_TOGRAVE end
  --CountPrioTarget(cards,loc,minPrio,TYPE_MONSTER,FluffalFilter,nil,"CountFluffalMaterial: ")
  result = CountPrioTarget(cards,loc,minPrio,TYPE_MONSTER,FluffalFilter)
  return result
end
function CountEdgeImpMaterial(cards,loc,safe)
  local result = 0
  local minPrio = 1
  if loc == nil then loc = MATERIAL_TOGRAVE end
  --CountPrioTarget(cards,loc,1,TYPE_MONSTER,EdgeImpFilter,nil,"CountEdgeImpMaterial: ")
  result = CountPrioTarget(cards,loc,minPrio,TYPE_MONSTER,EdgeImpFilter)
  return result
end

------------------------
-------- CHECK ---------
------------------------
-- Xyz CHECK
function ToadallyPlayCheck()
  return
    HasID(AIExtra(),00440556,true) -- Bahamut
	and OPTCheck(00440556)
    and HasID(AIExtra(),90809975,true) -- Toadally
end
-- Flootgate CHECK
function FlootGateCheatCheck()
  if HasID(OppHand(),05851097,true) -- Vanity
  or HasID(OppHand(),30241314,true) -- MacroCosmos
  or HasID(OppHand(),82732705,true) -- SkillDrain
  then
    return true
  end
  if HasID(OppDeck(),05851097,true) then
    return HasID(OppDeck(),05851097,true) > (#OppDeck() - 5)
  end
  if HasID(OppDeck(),30241314,true) then
    return HasID(OppDeck(),30241314,true) > (#OppDeck() - 5)
  end
  if HasID(OppDeck(),82732705,true) then
    return HasID(OppDeck(),82732705,true) > (#OppDeck() - 5)
  end
  return false
end
function FluffalFlootGateFilter(c)
  return
    (
      c.id==05851097 -- Vanity's Emptiness
	  or c.id==30241314 -- Macro Cosmos
	  or c.id==82732705 -- Skill Drain
	  or c.id==58481572 -- Masked HERO Dark Law
	)
	and FilterPosition(c,POS_FACEUP) and NotNegated(c)
end
-- SpSummon FlootGate
function VanityFilter(c)
  return
    (
      c.id==05851097 -- Vanity's Emptiness
	  or c.id==41855169 -- Jowgen the Spiritualist
	  or c.id==42009836 -- Fossil Dyna Pachycephalo
	) and FilterPosition(c,POS_FACEUP) and NotNegated(c)
end
-- SpExtra FlootGate
function ExtraDeckBlockedFilter(c)
  return
    (
      c.id==84171830 -- Monarch's Field
      or c.id==76218313 -- Dragon Buster
	)
	and FilterPosition(c,POS_FACEUP) and NotNegated(c)
end
-- Spell FlootGate
function SpellBlockedFilter(c)
  return
    (
      c.id == 33198837 -- Naturia Beast
	  or c.id == 58921041 --  Anti-Spell Fragance
	)
	and FilterPosition(c,POS_FACEUP) and NotNegated(c)
end

-- BossMon
function BossMonFilter(c)
  return (
      c.id == 58481572 -- DarkLaw
	  or c.id == 90809975 -- Treatoad
	  or c.id == 01561110 -- BusterDragon
	  or c.id == 10443957 -- Infinity
	  or c.id == 48905153 -- Zodiac Beast Drancia
	) and NotNegated(c)
end
function InfinityMonFilter(c)
  return (
	  c.id == 90809975 -- Treatoad
	  or c.id == 10443957 -- Infinity
	) and NotNegated(c)
end

-- Advantage Filter
function FTigerAdvantageFilter(c)
  return
	BossMonFilter(c)
end
function FSheepAdvantageFilter(c)
  return
	BAFilter(c)
	or FluffalMetalfoesFilter(c)
	or FilterSet(c,0xf1) -- ZodiacBeast
end

function FluffalMetalfoesFilter(c)
  return
    --IsSetCode(c.setcode,0xe1)
	c.id == 28016193 -- Orichalc
	or c.id == 04688231 -- Mythriel
	--or c.id == 77693536 -- Alkahest
end

function MaxxCAdvantageFilter(c)
  return
    MaxxCZBAdvantageFilter(c)
	or (c.id == 58069384 and HasID(OppExtra(),10443957,true)) -- Cyber Dragon Nova

end

function MaxxCZBAdvantageFilter(c)
  return
    c.id == 78872731 -- ZBRat
	or c.id == 74393852 -- ZBWildbow
	or c.id == 11510448 -- ZBTigress
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