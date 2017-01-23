------------------------
------- MATERIAL -------
------------------------
function MaterialFDaredevil(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if GlobalEdgeImpMaterial > 0
  and GlobalFluffalMaterial > 0
  then
    return true
  end
  return false
end
function MaterialFDaredevilBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFDaredevil(cards)
end
function MaterialFSabreTooth(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if (
    HasID(AIMon(),40636712,true) -- FKraken
	or HasID(AIMon(),85545073,true) -- FBear
	or HasID(AIMon(),00464362,true) -- FTiger
    or HasID(AIMon(),57477163,true) -- FSheep
  )
  and (
    GlobalEdgeImpMaterial + GlobalFluffalMaterial > 1
	or
	GlobalEdgeImpMaterial + GlobalFluffalMaterial > 0
	and #OppField() < 2
	and BattlePhaseCheck()
  )
  then
    return true
  end
  return false
end
function MaterialFSabreToothBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  if CardsMatchingFilter(AIGrave(),FrightfurMonFilter) > 1
  and GlobalEdgeImpMaterial + GlobalFluffalMaterial > 1
  then
    return true
  end
  return false
end

function MaterialFKraken(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if GlobalEdgeImpMaterial > 0
  and GlobalFluffalMaterial > 0
  then
    return true
  end
  return false
end
function MaterialFKrakenBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFKraken(cards)
end

function MaterialFLeo(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if (
    HasID(cards,34688023,true) -- Saw
	or CardsMatchingFilter(cards,SubstituteMaterialFilter) > 0
  )
  and GlobalFluffalMaterial > 0
  then
    return true
  end
  return false
end
function MaterialFLeoBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFLeo(cards)
end

function MaterialFBear(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if
  HasID(cards,30068120,true) -- Sabres
  and HasID(cards,03841833,true) -- Bear
  or
  HasID(cards,30068120,true) -- Sabres
  and CardsMatchingFilter(cards,SubstituteMaterialFilter) > 0
  or
  HasID(cards,03841833,true) -- Bear
  and CardsMatchingFilter(cards,SubstituteMaterialFilter) > 0
  then
    return true
  end
  return false
end
function MaterialFBearBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFBear(cards)
end

function MaterialFWolf(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if HasID(cards,30068120,true) -- Sabres
  and GlobalFluffalMaterial > 0
  then
    return true
  end
  return false
end
function MaterialFWolfBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFWolf(cards)
end

function MaterialFTiger(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if (
    HasID(cards,30068120,true) -- Sabres
	or
	CardsMatchingFilter(cards,SubstituteMaterialFilter) > 0
  )
  and GlobalFluffalMaterial > 0
  then
    return true
  end
  return false
end
function MaterialFTigerBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFTiger(cards)
end

function MaterialFSheep(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIHand()})
  end
  if (
    HasID(cards,61173621,true) -- Chain
	or
	CardsMatchingFilter(cards,SubstituteMaterialFilter) > 0
  )
  and GlobalFluffalMaterial > 0
  then
    return true
  end
  return false
end
function MaterialFSheepBanish(cards)
  if cards == nil then
    cards = UseLists({AIMon(),AIGrave()})
  end
  return MaterialFSheep(cards)
end

function MaterialFStarve()
  --print("MaterialFStarve")
  local countStarveMaterial = 0
  local fsabre = CardsMatchingFilter(AIMon(),FilterID,80889750) -- FSabretooth
  local frightfurs = CardsMatchingFilter(AIMon(),FrightfurMonFilter)
  local monSubgroup = SubGroup(AIMon(),NotFrightfurMonFilter)
  countStarveMaterial = CardsMatchingFilter(monSubgroup,FilterAttribute,ATTRIBUTE_DARK)
  if (frightfurs - fsabre) > 0
  then
    countStarveMaterial = countStarveMaterial + 1
  end
  --print(fsabre,frightfurs,countStarveMaterial)
  if countStarveMaterial >= 2
  and GlobalPolymerization == 1
  then
    return true
  end
  return false
end

--[[
91034681, -- Frightfur Daredevil
80889750, -- Frightfur Sabre-Tooth
40636712, -- Frightfur Kraken
10383554, -- Frightfur Leo
85545073, -- Frightfur Bear
11039171, -- Frightfur Wolf
00464362, -- Frightfur Tiger
57477163, -- Frightfur Sheep
41209827, -- Starve Venom Fusion Dragon
]]