--- OnSelectTribute ---
--
-- Called when AI has to tribute monster(s). 
-- Example card(s): Caius the Shadow Monarch, Beast King Barbaros, Hieratic
-- 
-- Parameters (3):
-- cards = available tributes
-- minTributes = minimum number of tributes
-- maxTributes = maximum number of tributes
--
-- Return:
-- result = table containing tribute indices



--------------------------------------------------- 
-- always prefer mind-controlled, whitelisted or 
-- token monsters, otherwise check for rank, 
-- attack and tribute exceptions.
---------------------------------------------------
function OnSelectTribute(cards,minTributes, maxTributes) 
  local preferred = {}
  local valid = {}
  local result = nil
  local d = DeckCheck()
  if d and d.Tribute then
    result = d.Tribute(cards,minTributes,maxTributes) 
  end
  if result ~= nil then return result end
  result = QliphortTribute(cards,minTributes, maxTributes)
  if result ~= nil then return result end
  if DeckCheck(DECK_CHAOSDRAGON) then
    return Add(cards,PRIO_TOGRAVE,minTributes)
  end
  result = {}
  for i=1,#cards do
	if cards[i].owner == 2 or TributeWhitelist(cards[i].id) > 0 or 
	   bit32.band(cards[i].type,TYPE_TOKEN) > 0  then      
	  preferred[#preferred+1]=i
    elseif cards[i].rank == 0 and cards[i].level <= GlobalActivatedCardLevel and 
      cards[i].attack < GlobalActivatedCardAttack and IsTributeException(cards[i].id) == 0 then
	  valid[#valid+1]=i
    end
  end
  for i=1,minTributes do
    if preferred[i] then
      result[i]=preferred[i]
    else
      result[i]=valid[i-#preferred]
    end
  end
  return result
end
--from OnSelectCard
function OnSelectMaterial(cards,min,max,id)
  local result = nil
  local d = DeckCheck()
  if d and d.Material then
    result = d.Material(cards,min,max,id) 
  end
  if result ~= nil then return result end
  if id == 18326736 then -- Ptolemaios
    if GlobalPtolemaiosID == 10443957 -- Cyber Dragon Infinity
    then 
      GlobalPtolemaiosID = nil
      return Add(cards,PRIO_TOGRAVE,math.max(min,math.min(3,max)))
    end
    if GlobalPtolemaiosID == 09272381 -- Constellarknight Diamond
    then 
      GlobalPtolemaiosID = nil
      return Add(cards,PRIO_TOGRAVE,2)
    end
  end
  if id == 09272381 -- Constellarknight Diamond
  then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return Add(cards,PRIO_TOGRAVE,min)
end






