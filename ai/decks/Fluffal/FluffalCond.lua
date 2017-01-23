------------------------
--------- COND ---------
------------------------
-- Fluffal COND
function DogCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if not OPTCheck(c.id) and Duel.GetTurnCount() > 1
	or
	Get_Card_Count_ID(AIHand(),c.id) > 1
	and GlobalFusionId ~= 80889750 -- FSabreTooth
	then
      return 5 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if HasID(AIHand(),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  return not NormalSummonCheck() and SummonDog()
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    if SummonDog() and not NormalSummonCheck()
		then
		  return true
		else
		  return 7
		end
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  if not OPTCheck(c.id) then
	    return 1
	  end
	  if NormalSummonCheck() then
	    return 11
	  end
	  return
	    OPTCheck(c.id)
		and SummonDog()
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return false
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 4
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if Get_Card_Count_ID(AIHand(),c.id) > 1 then
	    return 5
	  else
	    return not OPTCheck(c.id)
      end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
GlobalPenguinAux = 0
function PenguinCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if OPTCheck(c.id + 1)
	then
	  if Get_Card_Count_ID(UseLists({AIHand(),AIMon()}),c.id) == 2 then
	    if GlobalPenguinAux == 0 then
		  GlobalPenguinAux = c.cardid
		end
	    if GlobalPenguinAux == c.cardid then
		  return 1
		else
		  return 10 + PrioFluffalMaterial(c,1)
		end
	  else
	    GlobalPenguinAux = 0
	  end
	  return 10 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if HasID(UseLists({AIHand(),AIMon()}),c.id,true)
	or not OPTCheck(c.id + 1)
	then
	  return 1
	end
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  -- Toadally
	  if ToadallyPlayCheck() then
	    if HasID(AIHand(),01845204,true) -- IFusion
		then
		  return 9
		end
		local waterMon = SubGroup(AIMon(),FilterAttribute,ATTRIBUTE_WATER)
		if CardsMatchingFilter(waterMon,FilterLevel,4) > 0
		and not NormalSummonCheck()
		then
		  return 10
		end
	  end
	  if CardsMatchingFilter(AIHand(),PenguinFilter) > 0
	  and not NormalSummonCheck()
	  and OPTCheck(c.id + 1)
	  then
	    return 7
	  end
	  return
		OPTCheck(c.id + 1)
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    if GlobalCanFusionSummon == false then
		  return 10
		end
	    if SummonPenguin() and not NormalSummonCheck()
		then
		  return true
		else
		  return 8
		end
	  end
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
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id + 1) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id + 1) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 5
	  else
	    return 2
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if Get_Card_Count_ID(AIHand(),c.id) > 1 then
	    return 4
	  else
	    return not OPTCheck(c.id + 1)
      end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function BearCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if not HasID(AIDeck(),70245411,true) then
	  return 7 + PrioFluffalMaterial(c,1)
    elseif not OPTCheck(c.id) and Duel.GetTurnCount() > 1
	or
	Get_Card_Count_ID(AIHand(),c.id) > 1
	and GlobalFusionId ~= 80889750 -- FSabreTooth
	then
      return 6 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	then
	  if HasID(AIHand(),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  local fluffalsGrave = CountFluffal(AIGrave())
	  if HasID(AIDeck(),70245411,true) -- TVendor
	  and not HasID(AIHand(),70245411,true)
	  and OPTCheck(72413000) -- Wings
	  and (
	    not HasID(AIST(),70245411,true) -- TVendor
	    or
	    HasID(AIGrave(),72413000,true) -- Wings
	    and fluffalsGrave < 2
      )
	  and (
	    PriorityCheck(AIHand(),PRIO_DISCARD) > FluffalPrioMode(1)
	    or
	    HasID(AIGrave(),72413000,true) -- Wings
	    and fluffalsGrave < 2
	  )
      then
        return true
      else
        return false
      end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    if OPTCheck(c.id)
		then
		  return true
		else
		  return 6
		end
	  end
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIHand(),c.id,true) then
	    if OPTCheck(c.id)
		then
		  return true
		else
		  return 6
		end
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id)
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return
	    OPTCheck(c.id)
	    and HasID(AIGrave(),24094653,true) -- Polymerization
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  if not HasID(AIDeck(),70245411,true) -- TVendor
	  then
	    return 10
	  end
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 6
	  else
	    return 3
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if Get_Card_Count_ID(AIHand(),c.id) > 1
	  or not HasID(AIDeck(),70245411,true) -- TVendor
	  then
	    return 6
	  else
	    return not OPTCheck(c.id)
      end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function OwlCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if not OPTCheck(c.id) or GlobalOwl == 1
	or Get_Card_Count_ID(AIHand(),c.id) > 1
	then
      return 3 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if HasID(AIHand(),c.id,true)
	or not OPTCheck(c.id)
	then
	  return 1
	end
    if FilterLocation(c,LOCATION_DECK)
	then
	  if not NormalSummonCheck()
	  then
	    if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) == 0
		or CanUseFPatchwork()
	    then
	      return true
		else
		  return false
	    end
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) 
	  then
	    if not OPTCheck(c.id) then
		  return 9
		elseif not NormalSummonCheck() 
		then
		  return true
		else
		  return false
		end
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return 6
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  if not OPTCheck(c.id) then
	    return 1
	  end
	  if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter2) == 0
	  then
	    return 9
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 7
	  else
	    return 4
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function SheepCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if not OPTCheck(c.id) or Get_Card_Count_ID(AIHand(),c.id) > 1
	then
      return 3 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if HasID(UseLists({AIHand(),AIMon()}),c.id,true)
	or not OPTCheck(c.id)
	then
	  return 1
	end
    local edgeImpHand = CountEdgeImp(AIHand())
	local edgeImpMon = CountEdgeImp(AIMon())
	local edgeImpGrave = CountEdgeImp(AIGrave())
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if not BattlePhaseCheck() and (edgeImpHand + edgeImpGrave) > 0
	  then
	    return 8
	  end
	  if edgeImpGrave > 0
	  and not (
	    HasID(UseLists({AIHand(),AIST()}),34773082,true) -- FPatchwork
		and CountFPatchworkTarget() > 0
		and OPTCheck(34773082)
	  )
	  then
	    if CardsMatchingFilter(UseLists({AIHand(),AIMon()}),FluffalFusionMonFilter) == 0
	    and CountFluffal(AIMon()) > 0
	    and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter)
	    then
	      return 8
	    end
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return OPTCheck(c.id)
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 6
	  else
	    return 3
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
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
GlobalOctoAux = 0
function OctoCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if OPTCheck(c.id + 1)
	and CardsMatchingFilter(AIBanish(),FilterType,TYPE_MONSTER) >= 1
	then
	  if Get_Card_Count_ID(UseLists({AIHand(),AIMon()}),c.id) == 2 then
	    if GlobalOctoAux == 0 then
		  GlobalOctoAux = c.cardid
		end
	    if GlobalOctoAux == c.cardid then
		  return 1
		else
		  return 8 + PrioFluffalMaterial(c,1)
		end
	  else
	    GlobalOctoAux = 0
	  end
	  return 8 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if HasID(UseLists({AIHand(),AIMon()}),c.id,true)
	or not OPTCheck(c.id + 1)
	then
	  return 1
	end
    if FilterLocation(c,LOCATION_DECK)
	then
	  if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	  and CardsMatchingFilter(AIBanish(),FilterType,TYPE_MONSTER) > 0
	  then
	    return true
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    return 6
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if OPTCheck(c.id + 1) then
	    return 11
	  else
	    return 8
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if not OPTCheck(c.id) then
	  return 1
	end
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	  and not (
	    HasID(AIGrave(),72413000,true) -- Wings
	    and OPTCheck(72413000)
	    and CountFluffal(AIGrave()) <= 2
	  )
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 3
	  else
	    return 2
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return not HasID(AIBanish(),c.id,true)
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function CatCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if OPTCheck(c.id)
	and (
      GlobalPolymerization == 1
	  or HasID(AIGrave(),24094653,true) --Polymerization
	)
	then
      return 12 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(AIHand(),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  local polyCount = CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,24094653)
	  if polyCount > 1 
	  and not HasID(UseLists({AIHand(),AIMon()}),13241004,true) -- Penguin
	  then
	    return 5
	  elseif polyCount > 0
	  then
	    return true
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    return 3
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return 9
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return
	    OPTCheck(c.id)
	    and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 9
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function RabitCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if OPTCheck(c.id)
	and (
	  HasID(UseLists({AIHand(),AIMon(),AIGrave()}),02729285,true) -- Cat
	  or HasID(AIGrave(),87246309,true) -- Octo
	)
	then
      return 9 + PrioFluffalMaterial(c,1)
	else
	  return 1 + PrioFluffalMaterial(c,1)
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(AIHand(),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	  then
	    return true
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    return 4
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return 10
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return
	    OPTCheck(c.id)
	    and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.id + 1) or Get_Card_Count_ID(AIHand(),c.id) > 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 11
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id) or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function MouseCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if FilterPosition(c,POS_FACEUP_ATTACK)
	and FilterLocation(c,LOCATION_ONFIELD)
	then
      return 8 + PrioFluffalMaterial(c,1)
	elseif FilterLocation(c,LOCATION_ONFIELD)
	and not OPTCheck(c.cardid)
	then
	  return 7
	elseif not HasID(AIDeck(),c.id,true)
	then
      return 6 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(AIHand(),c.id,true)
	  then
	    return 1
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if FilterPosition(c,POS_FACEUP_ATTACK) then
	    return 6
	  else
	    return 1
      end
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return false
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if Get_Card_Count_ID(AIDeck(),c.id) > 0
	  and OPTCheck(10802915) -- TourGuide
	  and OPTCheck(67441435) -- Bulb
	  and not (HasID(AIGrave(),67441435,true) and OPDCheck(67441435)) -- Bulb
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	then
	  return
	    not OPTCheck(c.id)
	    or Get_Card_Count_ID(AIHand(),c.id) > 1
	    or Get_Card_Count_ID(AIDeck(),c.id) == 0
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.cardid)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 4
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if Get_Card_Count_ID(AIDeck(),c.id) == 1 then
	    return 3
	  end
      return
	    Get_Card_Count_ID(AIDeck(),c.id) == 0
        or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterPosition(c,POS_FACEUP_ATTACK) then
	  return 10
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function WingsCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if OPTCheck(c.id)
	and HasID(AIST(),70245411,true) -- Toy Vendor
	then
	  return 9
	else
      return 6
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(UseLists({AIHand(),AIGrave(),AIMon()}),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  if HasID(AIHand(),70245411,true) -- TVendor HAND
	  or
	  HasID(AIHand(),03841833,true) -- Bear
	  and OPTCheck(03841833)
	  and HasID(AIDeck(),70245411,true) -- TVendor
	  or
	  CardsMatchingFilter(AIST(),TVendorCheckFilter,true) > 0 -- TVendor
	  or
	  HasIDNotNegated(AIST(),70245411,true) -- TVendor
	  and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FluffalFusionSTFilter) > 0
	  and CardsMatchingFilter(UseLists({AIHand(),AIMon()}),FluffalFusionMonFilter) > 0
	  then
	    return true
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true) then
	    return 5
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return 2
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return 2
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 10
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return Get_Card_Count_ID(UseLists({AIGrave(),AIBanish()}),70245411) == 3 -- TVendor
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function PatchworkCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if GlobalFusionPerform == 2
	and GlobalFusionId ~= 40636712 -- FKraken
	then
	  return 11
	end
    return 3 + PrioFluffalMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(AIHand(),c.id,true)
	  then
	    return 1
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return 2
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return CountEdgeImp(UseLists({AIHand(),AIMon()})) == 0
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return Get_Card_Count_ID(AIHand(),c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return Get_Card_Count_ID(AIHand(),c.id) > 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 3
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
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
-- EdgeImp COND
function TomahawkCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if GlobalFusionPerform == 2
	then
	  return 10 + PrioFluffalMaterial(c,1)
	elseif GlobalFusionPerform > 2 then
	  return 5 + PrioFluffalMaterial(c,1)
	end
	return 5 + PrioFluffalMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(AIHand(),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  return OPTCheck(c.id + 1) and not HasID(AIHand(),c.id,true)
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return OPTCheck(c.id + 1) and not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return OPTCheck(c.id + 1) and HasID(AIDeck(),30068120,true) -- Sabres
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 3
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function ChainCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if GlobalFusionId == 57477163 and OPTCheck(c.id) then -- FSheep
	  return 10
	end
    if GlobalFusionPerform == 2 or GlobalFusionId == 40636712 -- FKraken
	then
	  if OPTCheck(c.id) then
	    return 6 + PrioFluffalMaterial(c,1)
	  else
	    return 1
	  end
	elseif GlobalFusionPerform > 2 then
	  return 5 + PrioFluffalMaterial(c,1)
	end
	if OPTCheck(c.id) then
	  return 6 + PrioFluffalMaterial(c,1)
	else
	  return 1
	end
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(AIHand(),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return false
	  end
	  return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  if not HasID(AIHand(),c.id,true)
	  and OPTCheck(c.id)
	  then
		return 5
	  else
	    return 2
	  end
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if OPTCheck(c.id)
	  and CardsMatchingFilter(AIDeck(),FrightfurSTFilter) > 0
	  and not HasID(UseLists({AIHand(),AIMon()}),c.id,true)
	  then
	    return 10
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return not OPTCheck(c.id)
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 5
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if OPTCheck(c.id) and CountFPatchworkTarget() > 0
	  and OPTCheck(34773082) -- FPatchwork
	  then
	    return 11
	  end
	  return
	    OPTCheck(c.id)
		or Get_Card_Count_ID(AIHand(),c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function SabresCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if GlobalFusionPerform == 2 or GlobalFusionId == 40636712 -- FKraken
	then
	  return 5 + PrioFluffalMaterial(c,1)
	elseif GlobalFusionPerform > 2
	then
	  return 1 + PrioFluffalMaterial(c,1)
	end
	return 5 + PrioFluffalMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if HasID(UseLists({AIHand(),AIMon()}),c.id,true)
	then
	  return false
	end
    if FilterLocation(c,LOCATION_DECK)
	then
	  if CountEdgeImp(UseLists({AIHand(),AIMon()})) == 0
	  and not CanUseSheep(false)
	  and not (
	    HasID(UseLists({AIHand(),AIST()}),34773082,true) -- FPatchwork
		and CountFPatchworkTarget() > 0
		and OPTCheck(34773082)
	  )
	  then
	    return true
	  else
	    return false
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if CountEdgeImp(UseLists({AIHand(),AIMon()})) == 0
	  and not CanUseSheep(false)
	  then
	    return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND) then
	  return
	    not HasID(UseLists({AIHand(),AIMon()}),98280324,true) -- Sheep
	    or not OPTCheck(98280324)
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  if not HasID(UseLists({AIHand(),AIMon()}),c.id,true) then
		return 6
	  else
	    return 3
	  end
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 8
	  else
	    return 2
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if CardsMatchingFilter(UseLists({AIHand(),AIMon()}),FilterID,c.id) > 1
	  or CountEdgeImp(UseLists({AIHand(),AIMon()}))
	  or CanUseSheep()
	  then
	    return true
	  elseif CardsMatchingFilter(UseLists({AIHand(),AIST()}),FrightfurSTFilter)
	  then
	    return 2
      else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
-- OtherM COND
function TGuideCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 10 + PrioFluffalMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOFIELD then
    return false
  end
  if not OPTCheck(c.id)
  or not HasID(AIDeck(),30068120,true) -- Sabres
  or not HasID(AIExtra(),83531441,true) -- Dante
  then
    return true
  else
    return false
  end
end
function KoSCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if GlobalFusionId == 57477163 then -- FSheep
	  return 2 + PrioFluffalMaterial(c,1)
	end
    return 10 + PrioFluffalMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return not HasID(AIHand(),c.id,true)
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return CardsMatchingFilter(UseLists({AIHand(),AIST()}),FrightfurSTFilter) > 0
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 9
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if GlobalCanFusionSummon == false
	  and HasID(UseLists({AIHand(),AIST()}),06077601,true) -- FFusion
	  then
	    return 10
	  end
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  if GlobalFusionId == 57477163 then -- FSheep
	    return 2 + PrioFluffalMaterial(c,2)
	  end
      return 10 + PrioFluffalMaterial(c,2)
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function PFusionerCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if GlobalFusionId == 57477163 then -- FSheep
	  return 2 + PrioFluffalMaterial(c,1)
	end
    return 10 + PrioFluffalMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return not HasID(AIHand(),c.id,true)
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if #AIMon() > 0
	  then
        return true
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return not OPTCheck(c.id)
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 9
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return not OPTCheck(c.id)
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  if GlobalFusionId == 57477163 then -- FSheep
	    return 2 + PrioFluffalMaterial(c,2)
	  end
      return 10 + PrioFluffalMaterial(c,2)
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
-- FluffalS COND
function TVendorCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return PriorityCheck(AIGrave(),PRIO_BANISH) > 1
	end
  end
  if loc == PRIO_TOFIELD then
    return true
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  if AI.GetPlayerLP(1) <= 2000 then
	    return 4
	  end
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return 8
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.cardid)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return
	    CardsMatchingFilter(AIHand(),FilterID,c.id) > 1
	    or
	    #AIHand() < 3
	    and not (
	      HasID(AIGrave(),72413000,true) -- Wings
	      and OPTCheck(72413000)
	    )
		or #OppField() < 3
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  return
	    Duel.GetTurnCount() >= 2
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  if CardsMatchingFilter(UseLists({AIHand(),AIST(),AIDeck()}),FilterID,c.id) == 3
	  then
	    return 3
	  else
	    if CountPrioTarget(AIGrave(),PRIO_BANISH,1,nil,FluffalFilter) < 3
		then
		  return true
		else
		  return false
		end
	  end
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return HasID(UseLists({AIHand(),AIST()}),43698897,true) -- FFactory
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return CardsMatchingFilter(UseLists({AIST(),AIHand(),AIDeck()}),FilterID,c.id) == 3
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FFactoryCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  return UseFFactoryAux(true)
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return
	    not OPTCheck(c.id)
	    or CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK) then
	  return false
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return
	    not OPTCheck(c.id)
	    or CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FPatchworkCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  if not HasID(AIDeck(),24094653,true) -- Polymerization
	  or CountEdgeImp(AIDeck()) == 0
	  then
	    return 1
	  end
	end
	if FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return CountFPatchworkTarget() == 0
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return CountFPatchworkTarget() == 0 and not HasID(AIHand(),30068120,true) -- Sabres
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FRebornCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  then
	    return 1
	  end
	  return CardsMatchingFilter(AIGrave(),FrightfurMonFilter) > 0
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return CardsMatchingFilter(AIGrave(),FrightfurMonFilter) > 0
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return CardsMatchingFilter(AIGrave(),FrightfurMonFilter) == 0
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return CardsMatchingFilter(AIGrave(),FrightfurMonFilter) == 0
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function IFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  or not OPTCheck(c.id)
	  then
	    return 1
	  end
	  return OPTCheck(c.id) and not HasID(AIHand(),c.id,true)
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  local fusionMon = SubGroup(AIExtra(),FilterType,TYPE_FUSION)
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND)
	or FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return
	  not OPTCheck(c.id)
	  or CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	  or CardsMatchingFilter(fusionMon,FilterLevelMax,5) == 0
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  if not (
	    OPTCheck(c.id)
	    and CardsMatchingFilter(UseLists({AIHand(),AIST()}),FrightfurSTFilter2) > 0
	  )
	  then
	    return true
	  elseif CardsMatchingFilter(fusionMon,FilterLevelMax,5) == 0
	  then
	    return 10
	  else
	    return false
	  end
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return CardsMatchingFilter(fusionMon,FilterLevelMax,5) == 0
	end
  end
  return true
end
function PolyCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  then
	    return 1
	  end
	  if c.original_id == 74335036 -- FSubstitute
	  then
	    return false
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return c.original_id == 74335036 -- FSubstitute
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if HasID(AIST(),66127916,true) then -- FReserve
	  return 5
	end
    if FilterLocation(c,LOCATION_HAND) then
	  if CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 2
	  then
	    return 4
	  end
	  return
		CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return c.original_id ~= 74335036 -- FSubstitute
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function DFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  if HasID(UseLists({AIHand(),AIST()}),c.id,true)
	  then
	    return 1
	  end
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_HAND) then
	  return CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	end
	if FilterLocation(c,LOCATION_DECK)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return false
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_DISCARD then
    if FilterLocation(c,LOCATION_HAND) then
	  return CardsMatchingFilter(UseLists({AIHand(),AIST()}),FilterID,c.id) > 1
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function GCycloneCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOGRAVE then
	if FilterLocation(c,LOCATION_DECK) then
	  if CardsMatchingFilter(OppField(),FluffalFlootGateFilter) > 0
	  then
	    return 11
	  end
	  return true
	end
	return true
  end
  if loc == PRIO_DISCARD then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
-- FrightfurMon COND
function FDaredevil(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 4 + PrioFrightfurMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_EXTRA)
	or FilterLocation(c,LOCATION_ONFIELD)
	or FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFDaredevilBanish() then
		  return
		    FSummonFDaredevil(c)
		end
	  else
	    if MaterialFDaredevil() then
		  return FSummonFDaredevil(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return SpSummonFDaredevil(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return SpSummonFDaredevil(c)
	end
  end
  if loc == PRIO_TOGRAVE then
	if FilterLocation(c,LOCATION_EXTRA) 
	or FilterLocation(c,LOCATION_OVERLAY)
	or FilterLocation(c,LOCATION_ONFIELD)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 4
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_TODECK then
    return true
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FSabreToothCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 1 + PrioFrightfurMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_EXTRA)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFSabreToothBanish() then
		  if GlobalIFusion == 1 then
		    return 11
		  end
		  return FSummonFSabreTooth(c)
		end
	  else
	    if MaterialFSabreTooth() then
		  if GlobalIFusion == 1 then
		    return 11
		  end
		  return FSummonFSabreTooth(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return false --SpSummonFSabreTooth(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return false --SpSummonFSabreTooth(c)
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
	  if not HasID(AIGrave(),c.id,true) then
	    return 3
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_TODECK then
    return true
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FKrakenCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 6 + PrioFrightfurMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_EXTRA)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFKrakenBanish() then
		  return
		    FSummonFKraken(c)
		end
	  else
	    if MaterialFKraken() then
		  return FSummonFKraken(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return SpSummonFKraken(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return SpSummonFKraken(c)
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_EXTRA) then
	  return true
	end
	if FilterLocation(c,LOCATION_OVERLAY) then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  if not HasID(AIGrave(),c.id,true) then
	    return 7
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_TODECK then
    return false
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FLeoCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 1 + PrioFrightfurMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_EXTRA)
	then
	  return true
	end
	if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFLeoBanish() then
		  return FSummonFLeo(c)
		end
	  else
	    if MaterialFLeo() then
		  return FSummonFLeo(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return true
	end
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_EXTRA) then
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
  if loc == PRIO_TODECK then
    return true
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FBearCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 3 + PrioFrightfurMaterial(c,1)
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_EXTRA)
	then
	  return
	    OPTCheck(03841833) and not HasID(AIHand(),03841833,true) -- Bear
	    and not HasID(UseLists({AIHand(),AIST()}),70245411,true) -- TVendor
	    and (
	      #AIHand() > 2
		  or
		  HasID(AIHand(),72413000,true) and OPTCheck(72413000) -- Wings
		  or
		  GlobalFluffalPercent >= 0.50
	    )
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
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFBearBanish() then
		  return FSummonFBear(c)
		end
	  else
	    if MaterialFBear() then
		  return FSummonFBear(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return SpSummonFBear(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return SpSummonFBear(c)
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
  if loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FWolfCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 1 + PrioFrightfurMaterial(c,1)
  end
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
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFWolfBanish() then
		  return FSummonFWolf(c)
		end
	  else
	    if MaterialFWolf() then
		  return FSummonFWolf(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return SpSummonFWolf(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return SpSummonFWolf(c)
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
  if loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FTigerCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 5 + PrioFrightfurMaterial(c,1)
  end
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
	  if not HasID(AIGrave(),c.id,true) then
	    return 6
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) 
	  or HasID(AIMon(),c.id,true)
	  then
	    return 0
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFTigerBanish() then
		  return FSummonFTiger(c)
		end
	  else
	    if MaterialFTiger() then
		  return FSummonFTiger(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return SpSummonFTiger(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return SpSummonFTiger(c)
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
  if loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FSheepCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    if FilterAffected(c,EFFECT_CANNOT_ATTACK) then -- IFusion
	  OPTReset(c.cardid)
	  if GlobalFusionPerform > 0 then
	    GlobalIFusion = 0
	  end
	  return 9999
	else
	  return 4 + PrioFrightfurMaterial(c,1)
	end
  end
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
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if GlobalIFusion > 0 then
	    return 5
	  end
	  if GlobalFFusion > 0 then
	    if MaterialFSheepBanish() then
		  return FSummonFSheep(c)
		end
	  else
	    if MaterialFSheep() then
		  return FSummonFSheep(c)
		end
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE) then
	  return SpSummonFSheep(c)
	end
	if FilterLocation(c,LOCATION_REMOVED) then
	  return SpSummonFSheep(c)
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
	  if not HasID(AIGrave(),c.id,true) then
	    return 6
	  else
	    return 1
	  end
	end
  end
  if loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FStarveCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 0
  end
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
    if FilterLocation(c,LOCATION_EXTRA) then
	  if not HasID(AIExtra(),c.id,true) then
	    return 0
	  end
	  if MaterialFStarve() then
	    return FSummonFStarve(c)
	  end
	  return 1
	end
	if FilterLocation(c,LOCATION_GRAVE)
	or FilterLocation(c,LOCATION_REMOVED)
	then
	  return SpSummonFStarve(c)
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
  if loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_HAND) then
	  return true
	end
  end
  if loc == PRIO_BANISH then
    if FilterLocation(c,LOCATION_GRAVE) then
	  return true
	end
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return false
	end
  end
  return true
end
function FNordenCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return 10
  end
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	  local waterMon = SubGroup(UseLists({AIGrave(),AIMon()}),FilterAttribute,ATTRIBUTE_WATER)
	  --local graveMon = SubGroup(AIGrave(),FilterType,TYPE_MONSTER)
	  if CardsMatchingFilter(waterMon,FilterLevel,4) > 0
	  and HasID(AIExtra(),17412721,true) -- Norden
      and ToadallyPlayCheck()
	  and GlobalIFusion > 0
	  and #AIMon() <= 3
	  --and CardsMatchingFilter(graveMon,FilterLevelMax,4) > 0
	  then
	    GlobalIFusion = 0
	    return 11
	  else
	   return false
	  end
	end
	return true
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_OVERLAY) then
	  return 11
	end
	return true
  end
  if loc == PRIO_TODECK then
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
function FTAwesomeCond(loc,c)
  if loc == MATERIAL_TOGRAVE then
    return true
  end
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_EXTRA) then
	return true
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.cardid)
	end
	return true
  end
  if loc == PRIO_TODECK then
    if FilterLocation(c,LOCATION_ONFIELD) then
	  return not OPTCheck(c.cardid)
	end
    return true
  end
  if loc == PRIO_BANISH then
    return true
  end
  return true
end
end

MATERIAL_TOGRAVE = 21 -- Custom
--[[PRIO_TOHAND = 1
--PRIO_TOFIELD = 3
--PRIO_TOGRAVE = 5
--PRIO_DISCARD = 7
--PRIO_BANISH = 9
--MATERIAL_TOGRAVE = 21
--]]
FluffalPriorityList={
 [39246582] = {8,1,7,1,4,1,3,1,9,5,DogCond},		-- Fluffal Dog
 [13241004] = {6,2,10,1,3,1,2,1,3,2,PenguinCond},	-- Fluffal Penguin
 [03841833] = {10,3,2,1,5,2,2,1,8,3,BearCond},		-- Fluffal Bear
 [65331686] = {8,3,6,4,2,1,1,1,5,2,OwlCond},		-- Fluffal Owl
 [98280324] = {4,2,0,0,2,1,3,1,7,2,SheepCond},		-- Fluffal Sheep
 [87246309] = {5,2,8,3,1,1,2,1,4,2,OctoCond},		-- Fluffal Octo
 [02729285] = {7,4,3,1,1,0,1,1,3,1,CatCond},		-- Fluffal Cat
 [38124994] = {5,3,3,1,1,0,1,1,2,1,RabitCond},		-- Fluffal Rabit
 [06142488] = {1,1,9,3,5,0,6,1,9,8,MouseCond},		-- Fluffal Mouse
 [72413000] = {9,1,4,2,9,4,10,8,6,1,WingsCond},		-- Fluffal Wings
 [81481818] = {2,1,5,3,5,1,4,1,5,3,PatchworkCond},	-- Fluffal Patchwork
 [97567736] = {1,1,5,2,1,1,8,4,6,2,TomahawkCond},	-- Edge Imp Tomahawk
 [61173621] = {8,2,4,4,7,1,9,1,4,1,ChainCond},		-- Edge Imp Chain
 [30068120] = {7,3,4,3,6,3,5,3,5,1,SabresCond},		-- Edge Imp Sabres
 [10802915] = {1,1,1,1,9,1,8,1,9,8,TGuideCond},		-- Tour Guide
 [79109599] = {1,1,2,1,8,2,2,1,3,2,KoSCond},		-- King of the Swamp
 [06205579] = {1,1,8,1,2,1,2,1,3,2,PFusionerCond},	-- Parasite Fusioner
 [67441435] = {1,1,8,2,9,6,9,4,1,1,nil},			-- Glow-Up Bulb

 [70245411] = {9,5,1,1,4,1,2,0,1,1,TVendorCond},	-- Toy Vendor
 [06077601] = {6,1,1,1,3,1,3,0,9,1,FFusionCond},	-- Frightfur Fusion
 [43698897] = {7,3,1,1,2,1,1,0,1,1,FFactoryCond},	-- Frightfur Factory
 [34773082] = {8,4,1,1,5,1,9,0,7,1,FPatchworkCond},	-- Frightfur Patchwork
 [28039390] = {5,2,1,1,2,1,2,1,1,1,FRebornCond},	-- Frightfur Reborn
 [01845204] = {1,1,1,1,3,2,3,1,8,1,IFusionCond},	-- Instant Fusion
 [24094653] = {2,1,1,1,2,1,2,1,2,1,PolyCond},		-- Polymerization
 [94820406] = {1,1,1,1,2,1,2,1,1,1,DFusionCond},	-- Dark Fusion
 [05133471] = {1,1,1,1,7,5,6,5,1,1,GCycloneCond},	-- Galaxy Cyclone
 [43455065] = {1,1,1,1,1,1,2,1,1,1,nil},			-- Magical Spring
 [43898403] = {1,1,1,1,5,3,6,4,1,1,nil},			-- Twin Twister

 [66127916] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Fusion Reserve
 [98954106] = {9,1,1,1,1,1,1,1,1,1,nil},			-- Jar of Avarice
 [51452091] = {1,1,1,1,1,1,1,1,1,1,nil},			-- Royal Decree

 [91034681] = {1,1,8,4,1,1,1,1,5,1,FDaredevil},		-- Frightfur  Daredevil
 [80889750] = {1,1,9,3,1,1,1,1,5,1,FSabreToothCond},-- Frightfur Sabre-Tooth
 [40636712] = {1,1,8,5,5,3,1,1,2,1,FKrakenCond},	-- Frightfur Kraken
 [10383554] = {1,1,11,1,2,1,1,1,9,1,FLeoCond},		-- Frightfur Leo
 [85545073] = {5,1,5,2,3,1,1,1,4,1,FBearCond},		-- Frightfur Bear
 [11039171] = {2,1,10,1,1,0,1,1,8,1,FWolfCond},		-- Frightfur Wolf
 [00464362] = {3,1,7,4,5,4,1,1,3,1,FTigerCond},		-- Frightfur Tiger
 [57477163] = {4,1,6,2,4,2,1,1,2,1,FSheepCond},		-- Frightfur Sheep
 [41209827] = {2,1,10,1,1,1,1,1,1,1,FStarveCond}, 	-- Starve Venom Fusion Dragon
 [17412721] = {1,1,4,1,1,1,9,1,1,1,FNordenCond}, 	-- Elder Entity Norden
 [33198837] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Naturia Beast
 [42110604] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Hi-Speedroid Chanbara
 [90809975] = {1,1,1,1,3,1,1,1,1,1,FTAwesomeCond},	-- Toadally Awesome
 [83531441] = {1,1,1,1,1,1,1,1,1,1,nil}, 			-- Dante

 [07394770] = {1,1,1,1,4,3,7,3,1,1,nil}, 			-- Brilliant Fusion
 [91731841] = {1,1,1,1,4,3,8,3,1,1,nil}, 			-- Gem-Knight Material
}