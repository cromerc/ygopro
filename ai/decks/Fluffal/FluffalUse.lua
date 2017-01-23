------------------------
--------- USE ----------
------------------------
-- Fluffal USE
function UsePenguin(c)
  if CardsMatchingFilter(AIHand(),PenguinFilter) > 0
  then
    GlobalPenguin = 1
	OPTSet(c.cardid)
    return true
  end
  return false
end
function UseBearDiscard(c,mode)
  --CountPrioTarget(AIHand(),PRIO_DISCARD,1,nil,nil,nil,"DISCARD")
  if CardsMatchingFilter(AIST(),TVendorCheckFilter,true) == 0
  or CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) == 0
  then
    if HasID(AIHand(),72413000,true) -- Wings
    or HasID(AIHand(),67441435,true) -- Bulb
    then
	  OPTSet(c.id)
      return true
    elseif PriorityCheck(AIHand(),PRIO_DISCARD) > FluffalPrioMode(mode)
    and (
      #AIHand() > 2
	  or OppGetStrongestAttack() >= AIGetStrongestAttack()
	  or GlobalFluffalPercent >= 0.45
    )
	then
	  OPTSet(c.id)
	  return true
	elseif not NormalSummonCheck()
	and (
	  HasID(AIHand(),39246582,true) and OPTCheck(39246582) -- Dog
	  or
	  HasID(AIHand(),87246309,true) and SummonOcto() -- Octo
	)
	then
	  OPTSet(c.id)
	  return true
	elseif CardsMatchingFilter(AIST(),TVendorCheckFilter,false) > 0 -- TVendor
	and HasID(AIGrave(),72413000,true) -- Wings
	and OPTCheck(72413000)
	then
	  OPTSet(c.id)
	  return true
	end
  end
  return false
end
function UseBearPoly(c)
  if FilterLocation(c,LOCATION_MZONE)
  and not HasID(UseLists({AIHand(),AIST()}),24094653,true) -- Polymerization
  then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseOwlPoly(c)
  if CardsMatchingFilter(OppField(),SpellBlockedFilter) > 0
  or
  HasID(UseLists({AIHand(),AIMon()}),61173621,true) -- Chain
  and OPTCheck(61173621)
  then
    return false
  end
  if CardsMatchingFilter(AIDeck(),FilterID,24094653) > 1 -- Polymerization
  then
    OPTSet(c.id)
    return true
  elseif CardsMatchingFilter(UseLists({AIDeck(),AIHand(),AIST()}),FilterID,34773082) == 0 -- FPatchwork
  then
    OPTSet(c.id)
    return true
  elseif CardsMatchingFilter(AIDeck(),CountFPatchworkTarget) == 0
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function UseOwlFusion(c)
  if AI.GetPlayerLP(1) <= 500 then
    return false
  end
  GlobalOwl = 1
  GlobalFluffalMaterial = CountFluffalMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
  GlobalEdgeImpMaterial = CountEdgeImpMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
  local countF = CountFrighturFusion()
  GlobalOwl = 0
  if countF > 0
  then
    GlobalOwl = 1
    return true
  end
  return false
end
function UseSheep(c)
  if CountEdgeImp(AIGrave()) > 0 then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseSheepEnd(c)
  if CountEdgeImp(UseLists({AIGrave(),AIHand()})) > 0
  then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseSheepTomahawk(c)
  if HasID(AIHand(),97567736,true) -- Tomahawk
  and OPTCheck(97567736 + 1)
  then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function CanUseSheep(includeHand)
  if not HasIDNotNegated(UseLists({AIHand(),AIMon()}),98280324,true)
  or not OPTCheck(98280324)
  then
    return 1
  end
  local edgeImpGrave = 0
  if includeHand then
    edgeImpGrave = CountEdgeImp(UseLists({AIHand(),AIGrave()}))
  else
    edgeImpGrave = CountEdgeImp(AIGrave())
  end

  if CardsMatchingFilter(OppField(),VanityFilter) == 0
  and CountFluffal(UseLists({AIHand(),AIMon()})) > 0
  and edgeImpGrave > 0
  then
    return true
  end
  return false
end
function UseOcto()
  local edgeImpGrave = CountEdgeImp(AIGrave())
  local fluffalGrave = CountFluffal(AIGrave())
  return
    OPTCheck(87246309)
    and (edgeImpGrave + fluffalGrave) > 0
	and (
	  not HasID(UseLists({AIHand(),AIGrave()}),72413000,true) -- Wings
	  or not OPTCheck(72413000)
	  or fluffalGrave > 2
	  or edgeImpGrave > 0
	)
end
function UseMouse(c)
  if OPTCheck(10802915) and OPTCheck(67441435) then
    OPTSet(c.id)
    OPDSet(c.cardid)
	return true
  end
  return false
end
function UseWings(c)
  if PriorityCheck(AIGrave(),PRIO_BANISH) > 1
  and CardsMatchingFilter(AIST(),TVendorCheckFilter,false) > 0
  then
    OPTSet(c.id)
	return true
  else
    return false
  end
end
function UseWingsDisadvantage(c)
  if ExpectedDamage(1) >= AI.GetPlayerLP(1)
  and #AIMon() == 0
  and not NormalSummonCheck()
  then
    OPTSet(c.id)
	return true
  else
    return false
  end
end
-- EdgeImp USE
function UseTomahawkCopy(c)
  OPTCheck(c.id + 1)
  return true
end
function UseTomahawkDamage(c)
  if
  #AIHand() > 5
  or
  HasID(UseLists({AIHand(),AIMon()}),98280324,true) -- Sheep
  and OPTCheck(98280324)
  or
  AI.GetPlayerLP(2) <= 800
  or
  HasID(AIHand(),61173621,true) -- Chain
  and OPTCheck(61173621)
  then
    OPTCheck(c.id)
    return true
  end
  return false
end
function UseSabresNoEdgeImp(c)
  if PriorityCheck(AIHand(),PRIO_DISCARD) > 5
  and CountEdgeImp(UseLists({AIHand(),AIMon()})) == 0
  and #AIHand() > 5
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
  and BattlePhaseCheck()
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function UseSabresMouse(c)
  if HasID(AIHand(),06142488,true) -- Mouse Hand
  and HasID(AIMon(),06142488,true) -- Mouse Field
  and #AIMon() < 4
  then
    GlobalSabres = 1
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseSabresFPatchwork(c)
  if HasID(UseLists({AIHand(),AIST()}),34773082,true) -- FPatchwork
  and OPTCheck(34773082)
  and CountFPatchworkTarget() == 0
  and (
    CountEdgeImp(AIHand()) > 0
	or HasID(AIHand(),24094653,true) -- Polymerization
  )
  then
    GlobalSabres = 2
	OPTSet(c.id)
    return true
  end
  return false
end
-- Other USE
function UseKoS(c)
  if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) <= 1
  and not (
    HasID(AIHand(),65331686,true) -- Owl
	and not NormalSummonCheck()
  )
  and CardsMatchingFilter(UseLists({AIHand(),AIMon()}),FluffalFusionMonFilter) > 1
  and BattlePhaseCheck()
  then
    if
    CardsMatchingFilter(AIDeck(),FilterID,24094653) > 1 -- Polymerization
    or
    CardsMatchingFilter(AIDeck(),CountFPatchworkTarget) == 0
	or
	#OppField() < 2
    then
      return true
	end
  end
  if GlobalIFusion > 0 
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) <= 1
  then
    return true
  end
  return false
end
function UseKoSDiscard(c)
  if CountFPatchworkTarget() == 0
  then
    return true
  end
  return false
end
function UsePFusioner(c)
  GlobalPolymerization = 1

  GlobalFluffalMaterial = CountFluffalMaterial(AIMon(),MATERIAL_TOGRAVE)
  GlobalEdgeImpMaterial = CountEdgeImpMaterial(AIMon(),MATERIAL_TOGRAVE)

  GlobalPolymerization = 0

  return true
end
function UseBulb(c)
  if FieldCheck(4) > 0
  and OPTCheck(06142488) -- Mouse
  and AI.GetCurrentPhase() == PHASE_MAIN1
  and (
	OppGetStrongestAttDef() <= 2100
    or OppGetStrongestAttack() < AIGetStrongestAttack()
  )
  then
    OPDSet(c.id)
	OPTSet(c.id)
    return true
  else
    return false
  end
end
-- FluffalS USE
function ActiveTVendor(c,mode)
  --CountPrioTarget(AIHand(),PRIO_DISCARD,1,nil,nil,nil,"DISCARD")
  if HasID(AIHand(),72413000,true) -- Wings
  then
	return true
  elseif HasID(AIHand(),61173621,true) -- Chain
  and OPTCheck(61173621)
  and OPTCheck(34773082) -- FPatchwork
  then
    return true
  elseif not NormalSummonCheck()
  and (
    HasID(AIHand(),39246582,true) and OPTCheck(39246582) -- Dog
	or
	HasID(AIHand(),87246309,true) and SummonOcto() -- Octo
  )
  and OPTCheck(72413000) and not HasID(AIGrave(),72413000,true) -- Wings
  then
    return false
  elseif HasID(AIHand(),67441435,true) -- Bulb
  then
    return true
  elseif PriorityCheck(AIHand(),PRIO_DISCARD) > FluffalPrioMode(mode)
  and (
    CardsMatchingFilter(AIST(),TVendorCheckFilter,true) == 0
	or FilterLocation(c,LOCATION_SZONE)
  )
  and (
    #AIHand() > 3 and FilterLocation(c,LOCATION_HAND)
	or #AIHand() > 2 and FilterLocation(c,LOCATION_SZONE)
	or GlobalFluffalPercent >= 0.45
	or OppGetStrongestAttack() >= AIGetStrongestAttack()
  )
  and (
    OPTCheck(72413000) -- Wings
	or GlobalFluffalPercent >= 0.40
  )
  and not (
    #AIMon() == 5
	and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) > 0
  )
  then
	return true
  end
  return false
end
function UseTVendor(c,mode)
  --CountPrioTarget(AIHand(),PRIO_DISCARD,1,nil,nil,nil,"DISCARD")
  if HasID(AIHand(),72413000,true) -- Wings
  then
    OPTSet(c.cardid)
	return true
  elseif HasID(AIHand(),61173621,true) -- Chain
  and OPTCheck(61173621)
  and OPTCheck(34773082) -- FPatchwork
  then
	OPTSet(c.cardid)
    return true
  elseif not NormalSummonCheck()
  and (
    HasID(AIHand(),39246582,true) and OPTCheck(39246582) -- Dog
	or
	HasID(AIHand(),87246309,true) and SummonOcto() -- Octo
  )
  and OPTCheck(72413000) and not HasID(AIGrave(),72413000,true) -- Wings
  then
    return false
  elseif HasID(AIHand(),67441435,true) -- Bulb
  then
	OPTSet(c.cardid)
    return true
  elseif PriorityCheck(AIHand(),PRIO_DISCARD) > FluffalPrioMode(mode)
  and (
    #AIHand() > 2
	or GlobalFluffalPercent >= 0.45
	or OppGetStrongestAttack() >= AIGetStrongestAttack()
  )
  and (
    OPTCheck(72413000) -- Wings
	or GlobalFluffalPercent >= 0.40
  )
  and not (
    #AIMon() == 5
	and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) > 0
  )
  then
    OPTSet(c.cardid)
	return true
  else
    return false
  end
  return false
end
function ActiveFFactory(c,safemode)
  return FilterLocation(c,LOCATION_HAND) and UseFFactory(c,safemode)
end
function UseFFactory(c,safemode)
  if UseFFactoryAux(safemode)
  or
  #OppField() <= 2
  and UseFFactoryAux(false)
  and BattlePhaseCheck()
  then
    GlobalFluffalMaterial = CountFluffalMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
    GlobalEdgeImpMaterial = CountEdgeImpMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
    local countF = CountFrighturFusion()
    if countF > 0
    then
	  OPTSet(c.id)
      return true
    end
  end
end
function UseFFactoryAux(safemode)
  if safemode == nil then safemode = true end
  local fusionGrave = CardsMatchingFilter(AIGrave(),FusionArchetypeFilter)
  if HasID(AIGrave(),24094653,true) -- Polymerization
  and safemode
  then
	return fusionGrave > 1
  else
    return fusionGrave > 0
  end
end
function UseFPatchwork(c)
  OPTSet(c.id)
  return true
end
function CanUseFPatchwork()
  return
    HasID(UseLists({AIHand(),AIST()}),34773082,true)
    and OPTSet(34773082)
	and CountFPatchworkTarget() > 0
end
function UseFReborn(c)
  return true
end
-- Spell USE
function UseIFusion(c)
  if AI.GetPlayerLP(1) <= 1000 then
    return false
  end
  if HasID(AIExtra(),80889750,true) -- FSabreTooth
  --and not HasID(AIMon(),57477163,true) -- FSheep
  and (
    CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	or HasID(UseLists({AIHand(),AIST()}),43698897,true) -- FFactory
  )
  and (
    CountFluffalMaterial(UseLists({AIHand(),AIMon()}),MATERIAL_TOGRAVE)
	+ CountEdgeImpMaterial(UseLists({AIHand(),AIMon()}),MATERIAL_TOGRAVE)
  )	> 1
  and #AIMon() <= 3
  then
    OPTSet(c.id)
    return true
  elseif not HasID(AIMon(),80889750,true) -- FSabreTooth
  and HasID(UseLists({AIHand(),AIST()}),06077601,true) -- FFusion
  and CountFrightfurMon(UseLists({AIMon(),AIGrave()})) > 2 -- Frightfurs
  and CountMaterialFTarget(UseLists({AIMon(),AIGrave()}),PRIO_BANISH) > 1
  and #AIMon() <= 3
  then
    OPTSet(c.id)
    return true
  else
    return false
  end
end
function UseIFusionAwesome(c)
  if AI.GetPlayerLP(1) <= 1000 then
    return false
  end
  local waterMon = SubGroup(UseLists({AIGrave(),AIMon()}),FilterAttribute,ATTRIBUTE_WATER)
  local graveMon = SubGroup(AIGrave(),FilterType,TYPE_MONSTER)
  if CardsMatchingFilter(waterMon,FilterLevel,4) > 0
  and HasID(AIExtra(),17412721,true) -- Norden
  and ToadallyPlayCheck()
  and #AIMon() <= 3
  and CardsMatchingFilter(graveMon,FilterLevelMax,4) > 0
  then
    OPTSet(c.id)
    return true
  end
end
function UseBFusion()
  if CardsMatchingFilter(AIHand(),FilterID,13241004) > 1 -- Penguin
  or HasID(AIHand(),39246582,true) -- Dog
  then
    return true
  end
  return false
end
function UseMSpring(c)
  local countOppSTFaceUp = CardsMatchingFilter(OppST(),FilterPosition,POS_FACEUP)
  local countOppSTFaceDown = CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN)

  local countAISTFaceUp = CardsMatchingFilter(AIST(),FilterPosition,POS_FACEUP)

  if countAISTFaceUp < 2
  and (
    (countOppSTFaceUp - countAISTFaceUp) > 1
	and countOppSTFaceDown == 0
    or
	(countOppSTFaceUp - countAISTFaceUp) > 2
  )
  and (
	#OppPendulum() == 2
	or
	(countOppSTFaceUp - countAISTFaceUp) > 2
  )
  and not HasID(OppST(),05851097,true) -- Vanity
  then
    return true
  else
    return false
  end
end
-- FUSION USE
GlobalFluffalMaterial = 0
GlobalEdgeImpMaterial = 0
function UsePolymerization(c)
  if c.original_id == 74335036 then -- FSubstitute
    return false
  end
  GlobalPolymerization = 1
  GlobalFluffalMaterial = CountFluffalMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
  GlobalEdgeImpMaterial = CountEdgeImpMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
  local countF = CountFrighturFusion()
  GlobalPolymerization = 0
  if countF > 0
  then
    return true
  end
  return false
end
function UseFSubstitute(c)
  if c.original_id == 74335036 -- FSubstitute
  and not FilterLocation(c,LOCATION_GRAVE)
  then
    GlobalPolymerization = 1
    GlobalFluffalMaterial = CountFluffalMaterial(AIMon(),MATERIAL_TOGRAVE)
    GlobalEdgeImpMaterial = CountEdgeImpMaterial(AIMon(),MATERIAL_TOGRAVE)
    local countF = CountFrighturFusion()
    GlobalPolymerization = 0
    if countF > 0
    then
      return true
    end
  end
  return false
end
function UseFSubstituteGrave(c)
  if c.original_id == 74335036
  and FilterLocation(c,LOCATION_GRAVE)
  then
    return true
  end
  return false
end
function UseDFusion(c)
  GlobalDFusion = 1

  GlobalFluffalMaterial = CountFluffalMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
  GlobalEdgeImpMaterial = CountEdgeImpMaterial(UseLists({AIMon(),AIHand()}),MATERIAL_TOGRAVE)
  local countF = CountFrighturFusion()

  GlobalDFusion = 0

  if countF > 0
  then
    return true
  end
  return false
end
function UseFFusion(c)
  GlobalFFusion = 1

  GlobalFluffalMaterial = CountFluffalMaterial(UseLists({AIMon(),AIGrave()}),PRIO_BANISH)
  GlobalEdgeImpMaterial = CountEdgeImpMaterial(UseLists({AIMon(),AIGrave()}),PRIO_BANISH)
  local countF = CountFrighturFusion()

  GlobalFFusion = 0

  if countF > 0
  then
    OPTSet(c.id)
    return true
  end
  return false
end

-- Trap USE
function UseFReserve(c)
  return HasID(AIGrave(),24094653,true)
end
function UseFReserveDisadvantage(c)
  return
    AI.GetPlayerLP(1) <= 2000
	or
	AI.GetPlayerLP(1) <= 5000
	and #AIMon() == 0
	and not NormalSummonCheck()
end
function UseJAvarice(c)
  local countFluffal = CountFluffal(AIGrave())
  local countGrave = #AIGrave()
  local countST = CardsMatchingFilter(AIGrave(),FilterType,TYPE_SPELL+TYPE_TRAP)
  if countST > 2
  and (countGrave - countFluffal) >= 5
  then
    return true
  elseif ExpectedDamage(1) >= AI.GetPlayerLP(1) and #AIMon() == 0
  then
    return true
  end
  return false
end

-- Frightfur USE
function UseFSabreTooth(c)
  return true
end
function UseFKrakenSend(c)
  if not BattlePhaseCheck() then
    OPTSet(c.id)
    return true
  end
  local fkrakenCanSend = CardsMatchingFilter(OppMon(),FKrakenSendFilter)
  local frightfurAtk = 2200 + FrightfurBoost(c.id)
  local fkrakenCanAttak = FluffalCanAttack(OppMon(),frightfurAtk)
  local countOppMon = #OppMon()
  local canSummonFSabres = false
  if HasID(AIExtra(),80889750,true) -- FSabreTooth
  and CardsMatchingFilter(AIMon(),FilterID,80889750) <= 2
  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
  and (
	CountEdgeImp(UseLists({AIHand(),AIMon()}))
    + CountFluffalMaterial(UseLists({AIHand(),AIMon()}),MATERIAL_TOGRAVE,true)
  ) >= 2
  then
    canSummonFSabres = true
  end
  if countOppMon > 2
  and fkrakenCanSend > 0
  then
    OPTSet(c.id)
    return true
  elseif canSummonFSabres then
    OPTSet(c.id)
    return true
  elseif CardsMatchingFilter(OppMon(),FilterAffected,EFFECT_INDESTRUCTABLE) > 0
  and fkrakenCanSend > 0
  then
    OPTSet(c.id)
    return true
  elseif OppGetStrongestAttDef() > AIGetStrongestAttack()
  and fkrakenCanSend > 0
  then
    OPTSet(c.id)
    return true
  elseif fkrakenCanAttak <= 2
  then
    return false
  else
	OPTSet(c.id)
    return true
  end
end
function UseFKrakenRepo(c)
  if Negated(c) then
    return false
  end
  if c.attack <= 3500
  then
    return true
  end
  return false
end
function UseFLeo(c)
  OPTSet(c.id)
  return true
end
function UseFTiger(c)
  if CardsMatchingFilter(OppField(),FTigerDestroyFilter) > 0 then
	return true
  end
  return false
end
-- Other Fusion USE
function UseFStarve(c)
  GlobalActivatedCardID = c.id
  OPDSet(c.id)
  return true
end
-- Other XYZ USE
function UseBahamutFluffal(c)
  OPTSet(c.id)
  return true
end
function UseDanteFluffal(c)
  GlobalActivatedCardID = c.id
  OPDSet(c.id)
  return true
end

function FluffalEffectYesNo(id,card) -- FLUFFAL EFFECT YESNO
  if card then
    --print("EffectYesNo - Cardid: "..card.id.." - desc: "..card.description)
  end
  local result = nil

  if id == 39246582 then -- Dog
	result = 1
  end
  if id == 13241004  then -- Penguin
    id = id + 1 -- Material
	result = 1
  end
  if id == 65331686 and UseOwlPoly(card) then -- Owl
	result = 1
  end
  if id == 87246309  then -- Octo
    if (card.description/16) == id then
	  id = id
	else -- Material
	  id = id + 1
	end
	result = 1
  end
  if id == 02729285 then -- Cat
	result = 1
  end
  if id == 38124994 then -- Rabit
	result = 1
  end

  if id == 61173621 then -- Chain
	result = 1
  end

  if id == 10802915 then -- TourGuide
	result = 1
  end
  if id == 06205579 and UsePFusioner(card) then -- PFusioner
    result = 1
  end

  if id == 43698897 then -- FFactory
	result = 1
  end
  if id == 70245411 then -- TVendor
	result = 1
  end

  if id == 91034681 then -- FDaredevil
	result = 1
  end
  if id == 80889750 then -- FSabreTooth
	result = 1
  end
  if id == 40636712 and UseFKrakenRepo(card) then -- FKraken
	result = 1
  end
  if id == 85545073 then -- FBear
    result = 1
  end
  if id == 00464362 then -- FTiger
    return UseFTiger(card)
  end
  if id == 57477163 then -- FSheep
    result = 1
  end

  if id == 41209827 then -- FStarve
    result = 1
  end

  if id == 90809975 then -- Toadally
    local toadallyEffect = card.description - (90809975*16)
    id = 90809975 + toadallyEffect
	if toadallyEffect == 0 then
	elseif toadallyEffect == 1 then
	  result = 0
	elseif toadallyEffect == 2 then
	  result = 1
	elseif toadallyEffect == 3 then
	  result = 0
	elseif toadallyEffect == 4 then
	  result = 0
	end
  end

  if result then
    if result == 1 then
      OPTSet(id)
	end
  end

  return result
end

function FluffalYesNo(desc) -- FLUFFAL YESNO
  if (desc / 16) > 99999 then
    --print("YesNo - id: "..(desc/16).." - desc: "..desc)
  else
    --print("YesNo - desc: "..desc)
  end
  if desc == 93 then -- Choose material?
    if GlobalFusionId == 80889750 then
	  return 1
	end
    return 0
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