--- OnSelectCard ---
--
-- Called when AI has to select a card. Like effect target or attack target
-- Example card(s): Caius the Shadow Monarch, Chaos Sorcerer, Elemental HERO The Shining
-- 
-- Parameters:
-- cards = table of cards to select
-- minTargets = how many you must select min
-- maxTargets = how many you can select max
-- triggeringID = id of the card that is responsible for the card selection
--
-- Return: 
-- result = table containing target indices


function OnSelectCard(cards, minTargets, maxTargets, triggeringID,triggeringCard)
  local result = {}
-------------------------------------------------
-- **********************************************
-- General purpose functions, for selecting 
-- targets when XYZ summoning, attacking etc.
-- **********************************************
-------------------------------------------------

  -- AI attack target selection
  -- redirected to SelectBattleComand.lua
  if IsBattlePhase() 
  and GlobalAIIsAttacking 
  and Duel.GetCurrentChain()==0
  and not triggeringCard
  then 
    local c = FindCard(GlobalCurrentAttacker,Field())
    result = AttackTargetSelection(cards,c)
    GlobalAIIsAttacking = nil
    return result
  end
  
  -- Summoning material selection
  -- redirected to SelectTribute.lua
  if not triggeringCard 
  and GlobalMaterial==true
  and Duel.GetCurrentChain()==0
  then  
    GlobalMaterial = nil
    local id = GlobalSSCardID
    GlobalSSCardID = nil
    return OnSelectMaterial(cards,minTargets,maxTargets,id)
  end

if DeckCheck(DECK_EXODIA) then
  return ExodiaCard(cards,minTargets,maxTargets,triggeringID,triggeringCard)
end
-- other decks 
-- redirect to respective deck files
  local result = nil
  
  local d = DeckCheck()
  if d and d.Card then
    result = d.Card(cards,minTargets,maxTargets,triggeringID,triggeringCard)
  end
  if result ~= nil then
    if type(result) == "table" then
      return result
    else
      print("Warning: returning invalid card selection: "..triggeringID)
    end
  end

  local SelectCardFunctions={
  FireFistCard,HeraldicOnSelectCard,GadgetOnSelectCard,
  BujinOnSelectCard,MermailOnSelectCard,
  SatellarknightOnSelectCard,ChaosDragonOnSelectCard,HATCard,
  QliphortCard,NobleCard,NekrozCard,BACard,DarkWorldCard,
  GenericCard,ConstellarCard,BlackwingCard,HarpieCard,HEROCard,
  }
  for i=1,#SelectCardFunctions do
    local func = SelectCardFunctions[i]
    result = func(cards,minTargets,maxTargets,triggeringID,triggeringCard)
    if result ~= nil then
      if type(result) == "table" then
        return result
      else
        print("Warning: returning invalid card selection: "..triggeringID)
      end
    end
  end
  result = {}

  --------------------------------------------
  -- Select minimum number of valid XYZ material monsters,   
  -- with lowest attack as tributes.
  --------------------------------------------   
 if (GlobalSSCardID ~= nil and GlobalSSCardID ~= 91949988 
 and GlobalSSCardType ~= nil and GlobalSSCardType > 0 
 or PtolemySSMode == 1 and GlobalSSCardID == 38495396 
 and GlobalSSCardType == nil)
 and not triggeringCard
 then
  local function compare(a,b)
    return a.attack < b.attack
  end
  if GlobalSSCardID == 44505297 then    --Inzektor Exa-Beetle
    GlobalActivatedCardID = GlobalSSCardID
  end
  if GlobalSSCardID == 63504681 then -- Rhomgomiant
    minTargets=maxTargets
  end
  local Ptolemaios=nil
  if GlobalSSCardID == 18326736 then -- Ptolemaios
    minTargets=math.min(maxTargets,math.max(minTargets,3))
    Ptolemaios=true
    if minTargets == 2 then
    end
  end
  GlobalSSCardID = nil
  GlobalSSCardType = nil
	PtolemySSMode = nil
  if Ptolemaios==true and minTargets == 1 
  then
    GlobalSSCardID = 18326736
    GlobalSSCardType = TYPE_XYZ
  end
	local list = {}
    for i=1,#cards do
      if cards[i] and bit32.band(cards[i].type,TYPE_MONSTER) > 0 
      and IsTributeException(cards[i].id) == 0
      then   
        cards[i].index=i
        list[#list+1]=cards[i]
        if cards[i].id == 38331564 and (minTargets>=3 or Ptolemaios) then
          if CardsMatchingFilter(OppField(),ScepterFilter)>0 then
            cards[i].attack = -3
          else
            cards[i].attack = -1
          end
        end
        if cards[i].id == 91110378 then
          cards[i].attack = -2
        end
      end
    end
    table.sort(list,compare)
    result={}
    check={}
    for i=1,minTargets do
      result[i]=list[i].index
      check[i]=list[i]
    end
    if #Field()>3 then
      GlobalScepterOverride = GlobalScepterOverride + CardsMatchingFilter(check,FilterID,38331564)
    end
    return result
  end
  
  --------------------------------------------
  -- Select valid tribute targets when tribute 
  -- summoning a "Toon" monster.
  --------------------------------------------   
 if GlobalSSCardSetcode ~= nil 
 and (GlobalSSCardSetcode == 98 
 or GlobalSSCardSetcode == 4522082 )
 and not triggeringCard
 then
  local result = {}
  local preferred = {}
  local valid = {}
  local function compare(a,b)
    return a.attack < b.attack
  end
  GlobalSSCardSetcode = nil
  for i=1,#cards do
    if cards[i].owner == 2 or TributeWhitelist(cards[i].id) > 0 or bit32.band(cards[i].type,TYPE_TOKEN) > 0 then
	  cards[i].index=i
	  preferred[#preferred+1]=cards[i]
	elseif cards[i].rank == 0 and cards[i].level <= GlobalSSCardLevel and 
      cards[i].attack < GlobalSSCardAttack and IsTributeException(cards[i].id) == 0 then
	  cards[i].index=i
	  valid[#valid+1]=cards[i]
    end
  end
  for i=1,minTargets do
    if preferred[i] then
      table.sort(preferred,compare)
	   result[i]=preferred[i].index
    else
      table.sort(valid,compare)
	  result[i]=valid[i-#preferred].index
      end
   end
   return result
  end
  
-------------------------------------------------
-- **********************************************
-- Functions to select targets when only one 
-- target is required at time.
-- **********************************************
-------------------------------------------------
  
  --------------------------------------------
  -- Select index of highest attack point 
  -- face up monster type card.
  --------------------------------------------   
  if GlobalActivatedCardID == 90374791 or -- Armed Changer
     GlobalActivatedCardID == 00242146 or -- Ballista of Rampart Smashing
     GlobalActivatedCardID == 61127349 or -- Big Bang Shot
     GlobalActivatedCardID == 65169794 or -- Black Pendant      
     GlobalActivatedCardID == 69243953 or -- Butterfly Dagger - Elma
	 GlobalActivatedCardID == 22046459 or -- Megamorph 
	 GlobalActivatedCardID == 05183693 or -- Amulet of Ambition
	 GlobalActivatedCardID == 46910446 or -- Chthonian Alliance 
	 GlobalActivatedCardID == 40619825 then -- Axe of Despair    
     GlobalActivatedCardID = nil
	 return Get_Card_Index(cards, 1, "Highest", TYPE_MONSTER, POS_FACEUP)
  end
      
  --------------------------------------------     
  -- Inzektor Exa-Beetle
  -- 4 different selections
  -- *Select strongest available monster to equip from grave
  -- *Select random material to detach
  -- *Select own card to destroy. Prefer equipped monster, then
  --  any spell/traps or himself, otherwise random available card
  -- *Select strongest enemy monster to destroy
  -------------------------------------------- 
  
  if GlobalActivatedCardID == 44505297 then -- Inzektor Exa-Beetle
    if GlobalCardMode == nil then
      GlobalActivatedCardID = nil
      return {HighestATKIndexTotal(cards)}
    end
    GlobalCardMode = GlobalCardMode - 1
    if GlobalCardMode <= 1 then
      GlobalActivatedCardID = nil
      GlobalCardMode = nil
    end
    if GlobalCardMode == 2 then
      return {math.random(#cards)}
    elseif GlobalCardMode == 1 then
      for i=1,#cards do
        if bit32.band(cards[i].type,TYPE_MONSTER) > 0 and cards[i].location == LOCATION_SZONE then 
          return {i}
        end
        if bit32.band(cards[i].type,TYPE_SPELL) > 0 or bit32.band(cards[i].type,TYPE_TRAP) > 0
        or cards[i].id == 44505297
        then
          result[#result+1]=i
        end
      end 
      if #result==0 then result=cards end
      return {result[math.random(#result)]}
    else
      return Get_Card_Index(cards, 2, "Highest", nil, POS_FACEUP)
    end
  end
  
  --------------------------------------------     
  -- Detach any material for Tiras's, Keeper of Genesis
  -- effect cost.
  --------------------------------------------   
  if triggeringID == 31386180 then -- Tiras, Keeper of Genesis
   local material = Get_Mat_Table(31386180)
   for i=1,#cards do
	 if cards[i].cardid == material[i].cardid then
	   return {1}
      end
   end
end 
  
  --------------------------------------------     
  -- Select Players strongest monster, if he controls any
  -- stronger monsters than AI, or select any spell or trap card player controls (for now)
  --------------------------------------------   
  if triggeringID == 31386180 then -- Tiras, Keeper of Genesis
	if Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
      return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
	  else
       return getRandomSTIndex(cards, 2)
      end
   end
  
  --------------------------------------------     
  -- Select AI's weakest monster by attack points in hand.
  --------------------------------------------   
  if GlobalActivatedCardID == 04178474 or   -- Raigeki Break 
     GlobalActivatedCardID == 70231910 then -- Dark Core
   if GlobalCardMode == 1 then
	  GlobalCardMode = nil 
      return Get_Card_Index(cards, 1, "Lowest", nil, nil)
     end
  end
  
  
  --------------------------------------------     
  -- Select Players strongest monster, if he controls any
  -- stronger monsters than AI, or select any spell or trap card player controls (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 04178474 then -- Raigeki Break
   if GlobalCardMode == nil then
   for i=1,#cards do
      if cards[i] ~= false then 
        if Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
		 GlobalActivatedCardID = nil 
		 return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
		  else
          GlobalActivatedCardID = nil
		  return getRandomSTIndex(cards, 2)
         end
       end
     end
   end
  return Index
end
 
  ------------------------------------------------------------
  -- Tribute lowest attack monster.
  ------------------------------------------------------------
  if GlobalActivatedCardID == 41426869 then -- Black Illusion Ritual
	 GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 1, "Lowest", nil, nil)
   end

  --------------------------------------------
  -- Select Players random Spell or Trap card
  --------------------------------------------   
  --if GlobalActivatedCardID == 05318639 or -- Mystical Space Typhoon 
	 if GlobalActivatedCardID == 71413901 then -- Breaker the Magical Warrior 
	 GlobalActivatedCardID = nil
     return getRandomSTIndex(cards, 2)
   end
     
  --------------------------------------------     
  -- Select monster not of a BanishBlacklist
  --------------------------------------------   
  if GlobalActivatedCardID == 33347467 then -- Ghost Ship
	for i=1,#cards do
      if cards[i] ~= false then 
        if BanishBlacklist(cards[i].id) == 0 then
		 result[1] = i
		  GlobalActivatedCardID = nil
		  return result
        end
      end
    end	
  end
   

  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 74131780 or GlobalActivatedCardID == 80117527 then -- Exiled Force, No. 11 Big Eye 
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
    end
   
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if triggeringID == 54652250 then -- Man-Eater Bug
     if Get_Card_Count(OppMon()) > 0 then 
        GlobalActivatedCardID = nil
		return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
        end
     end
	 for i=1,#cards do
       if Get_Card_Count(OppMon()) == 0 then 
		 if cards[i].id == 54652250 then
		  return {i}
        end
      end
    end

  
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 64631466 then -- Relinquished
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
   end
  
  --------------------------------------------     
  -- Select AI's random spell/trap card in hand
  --------------------------------------------   
  if GlobalActivatedCardID == 00423585 then -- Summoner Monk
    if GlobalCardMode == 1 then   
	   GlobalCardMode = nil	  
       return {math.random(#cards)}
      end
   end

 
  
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 25774450 then -- Mystic Box
   if GlobalCardMode == 1 then   
      GlobalCardMode = nil
      return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
    end
  end

  
  --------------------------------------------     
  -- Select AI'S weakest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 25774450 then -- Mystic Box
   if GlobalCardMode == nil then   
      GlobalActivatedCardID = nil  
      return Get_Card_Index(cards, 1, "Lowest", nil, nil)
     end
  end	
  
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 87880531 then -- Diffusion Wave-Motion
   local HighestATK = 0
   local HighestIndex = 1
    for i=1,#cards do
      if bit32.band(cards[i].type,TYPE_MONSTER) == TYPE_MONSTER and cards[i].owner == 1 and cards[i].race == RACE_SPELLCASTER and
		 cards[i].level >= 7 and cards[i].attack > HighestATK then
          HighestIndex = i
          HighestATK = cards[i].attack        
	      return HighestIndex
	      end
       end
    end

  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 18807108 then -- Spellbinding Circle 
     GlobalActivatedCardID = nil 
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
   end

   
  --------------------------------------------     
  -- Select AI's weakest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedEffectID == 40619825 then -- Axe of Despair
   if GlobalCardMode == 1 then
      GlobalActivatedEffectID = nil
	  GlobalCardMode = nil
      return Get_Card_Index(cards, 1, "Lowest", nil, nil)
      end
   end

  --------------------------------------------     
  -- Select AI's weakest monster by attack points in hand.
  --------------------------------------------   
  if GlobalActivatedCardID == 70231910 then -- Dark Core 
   if GlobalCardMode == 1 then
	  GlobalCardMode = nil 
      return Get_Card_Index(cards, 1, "Lowest", nil, nil)
      end
   end
  
  --------------------------------------------     
  -- Select Players strongest monster by attack points on field.
  --------------------------------------------   
  if GlobalActivatedCardID == 70231910 then -- Dark Core 
   if GlobalCardMode == nil then
	  GlobalActivatedCardID = nil
      return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, nil)	
      end
   end

  --------------------------------------------     
  -- Select AI's strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 83746708 then -- Mage Power 
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 1, "Highest", TYPE_MONSTER, nil)
   end

  
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 68005187 then -- Soul Exchange 
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
    end

	
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if triggeringID == 98045062 then -- Enemy Controller 
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
    end

  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 51945556 then -- Zaborg the Thunder Monarch 
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
    end
	
  --------------------------------------------     
  -- Select AI's monster by level in hand
  --------------------------------------------   
  if GlobalActivatedCardID == 23265313 then -- Cost Down 
     GlobalActivatedCardID = nil  
     return Index_By_Level(cards,1,"Lowest",TYPE_MONSTER,nil,"<=",4)
    end
	
  

 --------------------------------------------     
  -- Select monsters that work well in the grave, 
  -- otherwise just check for bosses
  -------------------------------------------- 
  if GlobalActivatedCardID == 14536035 then -- Dark Grepher
    local preferred={}
    for i=1,#cards do
      if cards[i] then
        if cards[i].id == 09411399 and Get_Card_Count_ID(AIGrave(),cards[i].id,nil) == 0 or    -- Destiny Hero - Malicious
           cards[i].id == 33420078 and Get_Card_Count_ID(AIGrave(),cards[i].id,nil) == 0       -- Plaguespreader Zombie
        then 
          preferred[#preferred+1]=i
        end
        if BanishBlacklist(cards[i].id) == 0 then
          result[#result+1]=i
        end
      end
    end
    if #preferred > 0 then 
      result = preferred 
    end
    if GlobalCardMode == 2 then
      GlobalCardMode = 1
    else
      GlobalActivatedCardID = nil
      GlobalCardMode = nil
    end
    result={result[math.random(#result)]}
    return result
  end
  
  --------------------------------------------     
  -- Detach first 2 materials
  -- Destroy strongest face-up enemy monster
  -- Destroy random spell/trap card
  --------------------------------------------   
  if GlobalActivatedCardID == 75253697 then -- Number 72: Line Monster Chariot Hishna
    if GlobalCardMode == nil then
      GlobalCardMode = 1
      return {1,2}
    elseif GlobalCardMode == 1 then
      GlobalCardMode = 2
      return {Get_Card_Index(cards, 2, "Highest", nil, POS_FACEUP)}
    elseif GlobalCardMode == 2 then
      GlobalCardMode = nil
      return {math.random(#cards)}
    end
  end	

  -------------------------------------------- 
  -- Make Hieratic Dragon King of Atum always 
  -- summon Red Eyes Darkness Metal Dragon, if possible
  --------------------------------------------   
  if GlobalActivatedCardID == 27337596 then -- Hieratic Dragon King of Atum
    if GlobalCardMode == nil then
      GlobalCardMode = 1
      return {math.random(#cards)}
    end
    GlobalCardMode = nil
    for i=1,#cards do
      if cards[i] and cards[i].id == 88264978 then -- Red-Eyes Darkness Metal Dragon
        return {i}
      end
    end
    return {math.random(#cards)}
  end		
  
 --------------------------------------------     
  -- Search Tefnuit, if he is not in hand already
  -- otherwise, search Su. 
  -- If it doesn't find either, pick at random
  --------------------------------------------   
  if GlobalActivatedCardID == 25377819 then -- Hieratic Seal of Convocation
    GlobalActivatedCardID = nil
    local id = 77901552 -- Hieratic Dragon of Tefnuit
	if Get_Card_Count_ID(AIHand(),id,nil) > 0 then
      id = 03300267 -- Hieratic Dragon of Su
    end
    for i=1,#cards do
      if cards[i] and cards[i].id == id then
        return {i}
      end
    end
    return {math.random(#cards)}
  end
  
  --------------------------------------------     
  -- Select Players strongest monster by attack points on the field.
  --------------------------------------------   
  if GlobalActivatedCardID == 29267084 then -- Shadow Spell 
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
    end
  
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Ai's specified type monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 91595718 or -- Book of Secret Arts
     GlobalActivatedCardID == 53610653 then -- Bound Wand
     GlobalActivatedCardID = nil
     return Index_By_Race(cards, 1,"Highest",TYPE_MONSTER,POS_FACEUP,"==",RACE_SPELLCASTER)
    end

  
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Ai's specified type monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 46009906 then -- Beast Fangs
     GlobalActivatedCardID = nil
     return Index_By_Race(cards, 1,"Highest",TYPE_MONSTER,POS_FACEUP,"==",RACE_BEAST)
    end

  
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects 
  -- only on opponents monsters
  -- select Ai's specified type monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 88190790 then -- Assault Armor
     GlobalActivatedCardID = nil
     return Index_By_Race(cards, 1,"Highest",TYPE_MONSTER,POS_FACEUP,"==",RACE_WARRIOR)
    end
  
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Ai's specified type monster with strongest attack (for now)
  --------------------------------------------   
   if GlobalActivatedCardID == 86198326 or  -- 7 Completed
      GlobalActivatedCardID == 63851864 then -- Break! Draw!
      GlobalActivatedCardID = nil
      return Index_By_Race(cards, 1,"Highest",TYPE_MONSTER,POS_FACEUP,"==",RACE_MACHINE)
    end
   
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Ai's specified type monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 18937875 then -- Burning Spear
     GlobalActivatedCardID = nil
     return Index_By_ATT(cards,1,"Highest",TYPE_MONSTER,POS_FACEUP,"==",ATTRIBUTE_FIRE)
    end
  
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Ai's specified type monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 39897277 or GlobalActivatedCardID == 82878489 then -- Elf's Light, Shine Palace
     GlobalActivatedCardID = nil
     return Index_By_ATT(cards,1,"Highest",TYPE_MONSTER,POS_FACEUP,"==",ATTRIBUTE_LIGHT)
    end
 
  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's monster of specified id with strongest attack (for now)
  --------------------------------------------   
   if GlobalActivatedCardID == 53586134 then -- Bubble Blaster   
       GlobalActivatedCardID = nil		  
       return Index_By_ID(cards,1,"Highest",nil,POS_FACEUP,"==",79979666)
      end

	  
  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's monster of specified id with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 00303660 then -- Amplifier 
     GlobalActivatedCardID = nil  
     return Index_By_ID(cards,1,"Highest",nil,POS_FACEUP,"==",77585513)
    end

  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's monster of specified id with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 40830387 or -- Ancient Gear Fist
     GlobalActivatedCardID == 37457534 then -- Ancient Gear Tank 
     GlobalActivatedCardID = nil		 
     return Index_By_SetCode(cards,1,"Highest",nil,POS_FACEUP,"==",7)
    end
  
  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's monster of specified id with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 79965360 then -- Amazoness Heirloom 
     GlobalActivatedCardID = nil		 
      return Index_By_SetCode(cards,1,"Highest",nil,POS_FACEUP,"==",4)
    end

  
  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's monster of specified id with strongest attack (for now)
  --------------------------------------------   
   if GlobalActivatedCardID == 19596712 or -- Abyss-scale of Cetus
      --GlobalActivatedCardID == 72932673 or -- Abyss-scale of the Mizuchi
      GlobalActivatedCardID == 08719957 then -- Abyss-scale of the Kraken       
      GlobalActivatedCardID = nil		 
      return Index_By_SetCode(cards,1,"Highest",nil,POS_FACEUP,"==",7667828)
    end
   
  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's monster of specified id with strongest attack (for now)
  --------------------------------------------   
   if GlobalActivatedCardID == 59385322 then -- Core Blaster       
      GlobalActivatedCardID = nil		 
      return Index_By_SetCode(cards,1,"Highest",nil,POS_FACEUP,"==",29)
    end

  --------------------------------------------
  -- Make sure Ai uses power up cards only on his own monsters,
  -- select Ai's attack pos monster with strongest attack, 
  -- whos attack is equal or below 1000 (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 84740193 then -- Buster Rancher    
     GlobalActivatedCardID = nil 
     return Index_By_Attack(cards,1,"Highest",nil,POS_FACEUP,"<=",1000)
    end
   
  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Opp's attack pos monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 41587307 or -- Broken Bamboo Sword
     GlobalActivatedCardID == 46967601 or -- Cursed Bill
     GlobalActivatedCardID == 56948373 or -- Mask of the accursed  
     GlobalActivatedCardID == 75560629 then -- Flint     
     GlobalActivatedCardID = nil
     return Get_Card_Index(cards,2,"Highest",nil,POS_FACEUP_ATTACK)
    end

  --------------------------------------------
  -- Make sure Ai uses equip cards with negative effects
  -- only on opponents monsters
  -- select Opp's non machine type monster with strongest attack (for now)
  --------------------------------------------   
  if GlobalActivatedCardID == 24668830 or -- Germ Infection
     GlobalActivatedCardID == 50152549 then -- Paralyzing Potion
     GlobalActivatedCardID = nil
     return Index_By_Race(cards,2,"Highest",TYPE_MONSTER,POS_FACEUP,"~=",RACE_MACHINE)
    end
  
  --------------------------------------------
  -- Discard all possible monster type cards
  --------------------------------------------   
  if triggeringID == 41142615 then -- The Cheerful Coffin 
    local result = {}
    for i=1,#cards do
      local c = cards[i]
      if DarkWorldMonsterFilter(c) and #result<maxTargets then
        result[#result+1]=i
      end
    end
    if #result==0 then result = Add(cards,PRIO_DISCARD) end
    return result
  end
  
  
  --------------------------------------------
  -- Banish monster's from AI's grave only, and select max available count
  --------------------------------------------   
  if GlobalActivatedCardID == 05758500 then -- Soul Release 
	local BanishCount= 1
	for i=1,#cards do
      if bit32.band(cards[i].type,TYPE_MONSTER) == TYPE_MONSTER and cards[i].owner == 1 then
	  result[BanishCount]= i;
	  GlobalActivatedCardID = nil
	   if (BanishCount<maxTargets) then BanishCount=BanishCount+1 else break end
      end
   end
  return result
end
  	
	--------------------------------------------
  -- Banish monster's from AI's grave only, and select max available count
  --------------------------------------------   
  if GlobalActivatedCardID == 43973174 then -- The Flute of Summoning Dragon 
	local SummonCount= 1
	local HighestATK   = 0
	for i=1,#cards do
      if (bit32.band(cards[i].type,TYPE_MONSTER) == TYPE_MONSTER and cards[i].race == RACE_DRAGON) and cards[i].attack >= HighestATK then	  
	  HighestATK = cards[i].attack
	  result[SummonCount]= i;
	  GlobalActivatedCardID = nil
	   if (SummonCount<maxTargets) then SummonCount=SummonCount+1 else break end
      end
   end
  return result
end
	
  -----------------------------------------------------------
  -- If the AI activates Monster Reborn, Call of the Haunted,
  -- or other special-summon cards (to be added later), let
  -- it choose the monster with the highest ATK for now.
  -----------------------------------------------------------
  if GlobalActivatedCardID == 83764718 or   -- Reborn
     GlobalActivatedCardID == 09622164 or   -- D.D.R.
     GlobalActivatedCardID == 71453557 or   -- Autonomous Action Unit
	 GlobalActivatedCardID == 42534368 or   -- Silent Doom
	 GlobalActivatedCardID == 43434803 or   -- The Shallow Grave
	 GlobalActivatedCardID == 37694547 then -- Geartown    
	local HighestATK = 0
    local HighestIndex = 1
    for i=1,#cards do
        if cards[i].attack > HighestATK then
          HighestIndex = i
          HighestATK = cards[i].attack
        end
    end
    GlobalActivatedCardID = nil
    result[1] = HighestIndex
    return result
  end
  
  -----------------------------------------------------
  -- When Monster Reincarnation resolves, the AI should
  -- always choose the monster with the highest ATK
  -- that isn't an extra deck monster.
  -----------------------------------------------------
  if GlobalActivatedCardID == 74848038 then
    if GlobalCardMode == nil then
       GlobalActivatedCardID = nil 
       return Get_Card_Index(cards,1,"Highest",TYPE_MONSTER+TYPE_EFFECT,nil)
      end
   end
 
  ------------------------------------------------------------
  -- For the Monster Reincarnation discard cost, the AI should
  -- simply discard the lowest ATK monster card in hand.
  ------------------------------------------------------------
  if GlobalActivatedCardID == 74848038 then
    if GlobalCardMode == 1 then
       GlobalCardMode = nil
       return Get_Card_Index(cards, nil, "Lowest", nil, nil)
      end
   end

  ----------------------------------------------------------------
  -- For Mecha Phantom Beast Dracossack's tributing cost
  -- tribute only his summoned Mecha Tokens.
  ----------------------------------------------------------------
  if GlobalActivatedCardID == 22110647 then 
	if GlobalCardMode == 1 then
       GlobalCardMode = nil
     for i=1,#cards do
      if cards[i].id ~= 22110647 and cards[i].attack == 0 then
         result[1] = i
         return result
        end
      end
    end
  end
   
  ----------------------------------------------------------------
  -- Target Player's monster with highest attack when 
  -- Mecha Phantom Beast Dracossack's card destroy effect is used.
  ----------------------------------------------------------------
   if GlobalActivatedCardID == 22110647 then
	if GlobalCardMode == nil then
       GlobalActivatedCardID = nil
	   return Get_Card_Index(cards, 2, "Highest", TYPE_MONSTER, POS_FACEUP)
	  end
    end

  -------------------------------------------------------
  -- Charge of the Light Brigade: The AI should never add
  -- Wulf, Lightsworn Beast to hand. Anything else is OK.
  -------------------------------------------------------
  if GlobalActivatedCardID == 94886282 then
     GlobalActivatedCardID = nil
     return Index_By_ID(cards,1,"Highest",TYPE_MONSTER, nil,"~=",58996430)
    end

  ---------------------------------------------------------
  -- When the effect of Tanngnjostr of the Nordic Beasts is
  -- activated, try to special summon a tuner or a level 3
  -- Nordic Beast monster.
  ---------------------------------------------------------
  if GlobalActivatedCardID == 14677495 then
    for i=1,#cards do
      if IsNordicTuner(cards[i].id) == 1 or
         cards[i].level == 3 then
         GlobalActivatedCardID = nil
         return {i}
        end
      end
    end
    
  -------------------------------------------------
  -- When activating Toon Table of Contents, search
  -- another copy of Toon Table to thin the deck.
  -------------------------------------------------
  if GlobalActivatedCardID == 89997728 then
    for i=1,#cards do
      if cards[i].id == 89997728 then
         GlobalActivatedCardID = nil
         return {i}
        end
      end
    end

  --------------------------------------------
  -- For Worm Xex's effect, the AI should look
  -- for and send Worm Yagan to the grave.
  --------------------------------------------
  if GlobalActivatedCardID == 11722335 then
     GlobalActivatedCardID = nil 
     return Index_By_ID(cards, 1, "Highest", nil, nil, "==", 47111934)
    end


  -------------------------------------
  -- The AI should tribute a card other
  -- than Worm King for its effect!
  -------------------------------------
  if GlobalActivatedCardID == 10026986 then
    if GlobalCardMode == 1 then
       GlobalCardMode = nil
       return Index_By_ID(cards, 1, "Lowest", nil, nil, "~=", 10026986)
      end
   end
    
  -----------------------------------------------
  -- When "Worm Cartaros" is flipped AI should add Xex if
  -- possible. Otherwise add the first occurring
  -- monster (for now, anyway).
  -----------------------------------------------
  if triggeringID == 51043243 then -- Worm Cartaros
     return Index_By_ID(cards, 1, "Highest", nil, nil, "==", 11722335) 
    end



  --------------------------------------------
  -- Reset these variable if it gets this far.
  --------------------------------------------
  GlobalActivatedCardID = nil
  GlobalCardMode = nil
  GlobalAIIsAttacking = false
  GlobalSSCardID = nil
  GlobalSSCardSetcode = nil
  
  
  if triggeringID == 0 and not triggeringCard
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_END 
  and minTargets==maxTargets and minTargets == #AIHand()-6
  and LocCheck(cards,LOCATION_HAND,true)
  then
    --probably end phase discard
    return Add(cards,PRIO_TOGRAVE,minTargets)
  end
  
  
  -- always choose the mimimum amount of targets and select random targets
  local targets = {}
  for i,c in pairs(cards) do
    targets[i]=c
    c.index=i
  end
  for i=1,minTargets do
    local r=math.random(1,#targets)
    local c=targets[r]
    table.remove(targets,r)
    result[i]=c.index
  end

  return result 
end

