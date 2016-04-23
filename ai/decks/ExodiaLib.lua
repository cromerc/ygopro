-- ExodiaLib:
function ExodiaInit(cards)
  local summon = cards.summonable_cards
  local activate = cards.activatable_cards
  local cardid = 0
  
  for i=1,#summon do
    if summon[i].id == 70791313 then --royal magic library
      return COMMAND_SUMMON,i
    end
  end
  
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 39910367 then --endymion
      return COMMAND_ACTIVATE,i
    end
  end
  
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 70791313 then --royal magic library
      return COMMAND_ACTIVATE,i
    end
  end
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 89997728 then --toon table of contents
      if HasID(AIMon(),70791313,true) then
        return COMMAND_ACTIVATE,i
      end
    end
  end
  local c = FindID(70791313,AIMon())
  if HasID(activate,75014062) and c and c:get_counter(0x3001)<2 then -- Spell Power Grasp
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(activate,55144522) then -- Pot of Greed
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(activate,74029853) then -- Golden Bamboo Sword
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(activate,41587307) then -- Broken Bamboo Sword
    return COMMAND_ACTIVATE,CurrentIndex
  end
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 39701395 then --cards of consonance
      return COMMAND_ACTIVATE,i
    end
  end
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 38120068 then --trade-in
      return COMMAND_ACTIVATE,i
    end
  end
  
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 98645731 then --pot of duality
      return COMMAND_ACTIVATE,i
    end
  end
  
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 70368879 then -- upstart
      return COMMAND_ACTIVATE,i
    end
  end
  if HasID(activate,33782437) then -- One Day of Piece
    return COMMAND_ACTIVATE,CurrentIndex
  end
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 85852291 then --magical mallet
      return COMMAND_ACTIVATE,i
    end
  end
  
  for i=1,#activate do
    cardid = activate[i].id
    if cardid == 15259703 then --toon world
      if HasID(AIMon(),70791313,true) then
        return COMMAND_ACTIVATE,i
      end
    end
  end
  if HasID(activate,75014062) then -- Spell Power Grasp
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if #AIHand()>6 and #cards.st_setable_cards > 0 
  then
    return COMMAND_SET_ST,1
  end
  --go to end phase
  return COMMAND_TO_END_PHASE,1
end

-- ExodiaLib
function ExodiaCard(cards,minTargets,maxTargets,triggeringID,triggeringCard)
  local id = triggeringID
  local result = {}
  if triggeringCard then
    id = triggeringCard.id
  end
  if id == 89997728 then --toon table of contents
    for i=1,#cards do
      if cards[i].id == 89997728 then -- find toon table of contents
        result[1]=i
        return result
      end
    end
  elseif id == 98645731 then --duality
    if not HasID(AIMon(),70791313,true) then
      --ai does not control royal magic library, search for it
      for i=1,#cards do
        if cards[i].id == 70791313 then
          result[1]=i
          return result
        end
      end
    else
      --ai controls royal magic library, search for a spell card
      for i=1,#cards do
        if bit32.band(cards[i].type, TYPE_SPELL) > 0 then
          result[1]=i
          return result
        end
      end
    end
  elseif id == 85852291 then --mallet
    if not HasID(AIMon(),70791313,true)then
      for i=1,maxTargets do
        result[i]=i
      end
    else
      for i=1,#cards do
        if bit32.band(TYPE_MONSTER,cards[i].type) > 0 
        or cards[i].id == 75014062 and not HasID(AIDeck(),75014062,true)
        or cards[i].id == 15259703 and HasID(AIHand(),89997728,true)
        or cards[i].id == 89997728 and CardsMatchingFilter(AIHand(),FilterID,89997728)>1
        then
          result[#result+1] = i
        end
      end
    end
    if #result < minTargets then
      for i=1,maxTargets do
        result[i]=i
      end
    end
    return result
  elseif id == 75014062 then
    result = {IndexByID(cards,70791313)} 
  end
  if #result < minTargets then
    for i=1,minTargets do
      result[i]=i
    end
  end
  if triggeringID == 0 and not triggeringCard
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_END 
  and minTargets==maxTargets and minTargets == #AIHand()-6
  and LocCheck(cards,LOCATION_HAND,true)
  then
    --probably end phase discard
    return Add(cards,PRIO_TOGRAVE,minTargets)
  end
  return result
end