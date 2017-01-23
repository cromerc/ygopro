--- OnSelectInitCommand() ---
--
-- Called when the system is waiting for the AI to play a card.
-- This is usually in Main Phase or Main Phase 2
-- 
--
-- Parameters (3):
-- cards = a table containing all the cards that the ai can use
-- 		cards.summonable_cards = for normal summon
-- 		cards.spsummonable_cards = for special special summon
-- 		cards.repositionable_cards = for changing position
-- 		cards.monster_setable_cards = monster cards for setting
-- 		cards.st_setable_cards = spells/traps for setting
-- 		cards.activatable_cards = for activating
-- to_bp_allowed = is entering battle phase allowed?
-- to_ep_allowed = is entering end phase allowed?
--
--[[
Each "card" object has the following fields:
card.id
card.original_id --original ----printed card id. Example: Elemental HERO Prisma can change id, but the original_id will always be 89312388
card.type --Refer to /script/constant.lua for a list of card types
card.attack
card.defense
card.base_attack
card.base_defense
card.level
card.base_level
card.rank
card.race --monster type
card.attribute
card.position
card.setcode --indicates the archetype
card.location --Refer to /script/constant.lua for a list of locations
card.xyz_material_count --number of material attached
card.xyz_materials --table of cards that are xyz material
card.owner --1 = AI, 2 = player
card.status --Refer to /script/constant.lua for a list of statuses
card:is_affected_by(effect_type) --Refer to /script/constant.lua for a list of effects
card:get_counter(counter_type) --Checks how many of counter_type this card has. Refer to /strings.conf for a list of counters

Sample usage

if card:is_affected_by(EFFECT_CANNOT_CHANGE_POSITION) then
	--this card cannot change position
end
if card:is_affected_by(EFFECT_CANNOT_RELEASE) then
	--this card cannot be tributed
end
if card:is_affected_by(EFFECT_DISABLE) or card:is_affected_by(EFFECT_DISABLE_EFFECT) then
	--this card's effect is currently negated
end

if card:get_counter(0x3003) > 0 then
	--this card has bushido counters
end

if(cards.activatable_cards[i].xyz_material_count > 0) then
local xyzmat = cards.activatable_cards[i].xyz_materials
	for j=1,#xyzmat do
		----print("material " .. j .. " = " .. xyzmat[j].id)
	end
end


-- Return:
-- command = the command to execute
-- index = index of the card to use
-- 
-- Here are the available commands
]]
COMMAND_LET_AI_DECIDE  = -1
COMMAND_SUMMON         = 0
COMMAND_SPECIAL_SUMMON = 1
COMMAND_CHANGE_POS     = 2
COMMAND_SET_MONSTER    = 3
COMMAND_SET_ST         = 4
COMMAND_ACTIVATE       = 5
COMMAND_TO_NEXT_PHASE  = 6
COMMAND_TO_END_PHASE   = 7

GlobalBPAllowed = nil
function OnSelectInitCommand(cards, to_bp_allowed, to_ep_allowed)
  ------------------------------------------
  -- The first time around, it sets the AI's
  -- turn (only if the AI is playing first).
  ------------------------------------------
  if not player_ai then player_ai = 1 end -- probably puzzle mode, so player goes first
  set_player_turn(true)
  DeckCheck()
  GlobalAIIsAttacking = nil
  GlobalMaterial = nil
  ResetOncePerTurnGlobals()
  GlobalBPAllowed = to_bp_allowed
  SurrenderCheck()
  ---------------------------------------
  -- Don't do anything if the AI controls
  -- a face-up Light and Darkness Dragon.
  ---------------------------------------
  
  --if player_ai.xyz_material_count > 1 then
    --error
  --end
  
  if LADDCheck(atk) then

    return COMMAND_TO_NEXT_PHASE,1
  end
  
  -- Lancelot
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if c.id == 66547759 and NotNegated(c)
    and OPTCheck(c.cardid) and c.xyz_material_count>0
    then
      return COMMAND_TO_NEXT_PHASE,1
    end
  end
  
  ---------------------------------------
  -- Don't do anything if the AI controls
  -- a face-up C106: Giant Hand Red with
  -- a "Number" monster as XYZ material,
  -- that didn't use its effect this turn
  ---------------------------------------
  
  local aimon = AIMon()
  local card = nil
  for i=1,#aimon do
    if aimon[i].id==55888045 then
      card = aimon[i]
    end
  end
  if card and bit32.band(card.position,POS_FACEUP)>0 
  and Duel.GetTurnCount() ~= GlobalC106
  and NotNegated(card)
  then
    local materials = card.xyz_materials
    for i=1,#materials do
      if bit32.band(materials[i].setcode,0x48)>0 then
        return COMMAND_TO_NEXT_PHASE,1
      end
    end
  end
  --------------------------------------------------
  -- Storing these lists of cards in local variables
  -- for faster access and gameplay.
  --------------------------------------------------
  local ActivatableCards = cards.activatable_cards
  local SummonableCards = cards.summonable_cards
  local SpSummonableCards = cards.spsummonable_cards
  local RepositionableCards = cards.repositionable_cards
  
  --------------------------------------------
  -- Activate Heavy Storm only if the opponent
  -- controls 2 more S/T cards than the AI.
  --------------------------------------------
  for i=1,#ActivatableCards do
    if (ActivatableCards[i].id == 19613556 or ActivatableCards[i].id == 42703248) and
       Get_Card_Count(OppST()) >= Get_Card_Count(AIST()) + 2 then
      return COMMAND_ACTIVATE,i
    end
  end
 -------------------------------------------------
-- **********************************************
--        Functions for specific decks
-- **********************************************
-------------------------------------------------
ExtraCheck=(DeckCheck(DECK_BUJIN) 
or DeckCheck(DECK_TELLARKNIGHT) 
or DeckCheck(DECK_NOBLEKNIGHT))
--or DeckCheck(DECK_NEKROZ))

if DeckCheck(DECK_EXODIA) then
  return ExodiaInit(cards)
end

local backup = CopyMatrix(cards)
local DeckCommand,DeckCommand2 = nil,nil
local d = DeckCheck()
DeckCommand = SummonExtraDeck(cards,true)
if DeckCommand ~= nil and (d == 0 
or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
then
  if DeckCommand[1]~=COMMAND_ACTIVATE 
  or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
  then
    return DeckCommand[1],DeckCommand[2]
  end
end

if HasID(SpSummonableCards,80696379,SummonMeteorburst,1) then
  return SynchroSummon()
end
-- If the AI can attack for game, attempt to do so first

-- opp has no monsters to defend
if #OppMon()==0 
and ExpectedDamage(2,FilterPosition,POS_ATTACK)>AI.GetPlayerLP(2)
and to_bp_allowed
and BattlePhaseCheck()
then
  return COMMAND_TO_NEXT_PHASE,1
end

-- AI has a direct attacker
local g=SubGroup(AIMon(),FilterAffected,EFFECT_DIRECT_ATTACK)
local result = 0
for i=1,#g do
  local c=g[i]
  if CanAttack(c,true)
  and CanDealBattleDamage(c)
  then
    result=result+c.attack
  end
end
if result>AI.GetPlayerLP(2) 
and to_bp_allowed
and BattlePhaseCheck()
then
  return COMMAND_TO_NEXT_PHASE,1
end

-- AI can attack for game on an opponent's monster
for i,source in pairs(AIMon()) do
  for j,target in pairs(OppMon()) do
    if CanFinishGame(source,target)
    and to_bp_allowed
    and BattlePhaseCheck()
    then
      return COMMAND_TO_NEXT_PHASE,1
    end
  end
end
if d and d.Init then
  DeckCommand,DeckCommand2 = d.Init(cards,to_bp_allowed,to_ep_allowed)
end
if DeckCommand ~= nil then
  if type(DeckCommand)=="table" then
    if DeckCommand[2]==0
    then
      print("Warning: null command for OnSelectInit")
      print("attempting to execute deck command: "..DeckCommand[1]..", "..DeckCommand[2])
      PrintCallingFunction()
    end
    --print("executing deck command: "..DeckCommand[1]..", "..DeckCommand[2])
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  else
    if DeckCommand2==0
    then
      print("Warning: null command for OnSelectInit")
      print("attempting to execute deck command: "..DeckCommand..", "..DeckCommand2)
      PrintCallingFunction()
    end
    --print("executing deck command: "..DeckCommand..", "..DeckCommand2)
    if DeckCommand~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand2])
    then
      return DeckCommand,DeckCommand2
    end
  end
end
if not ExtraCheck then 
  DeckCommand = ChaosDragonOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = FireFistInit(cards, to_bp_allowed, to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = HeraldicOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = GadgetOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not DeckCheck(DECK_TELLARKNIGHT) then 
  DeckCommand = BujinOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = MermailOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not DeckCheck(DECK_BUJIN) then 
  DeckCommand = SatellarknightOnSelectInit(cards,to_bp_allowed,to_ep_allowed)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end  
if not ExtraCheck then 
  DeckCommand = HATInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = QliphortInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not (DeckCheck(DECK_BUJIN) or DeckCheck(DECK_TELLARKNIGHT) or DeckCheck(DECK_NEKROZ)) then 
  DeckCommand = NobleInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not (DeckCheck(DECK_BUJIN) or DeckCheck(DECK_TELLARKNIGHT) or DeckCheck(DECK_NOBLEKNIGHT)) then 
  DeckCommand = NekrozInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
--[[if not ExtraCheck then 
  DeckCommand = BAInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    return DeckCommand[1],DeckCommand[2]
  end
end]]
if not ExtraCheck then 
  DeckCommand = DarkWorldInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = ConstellarInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = BlackwingInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
if not ExtraCheck then 
  DeckCommand = HarpieInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end
--[[if not ExtraCheck then 
  DeckCommand = HEROInit(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2] ])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end]]
if not ExtraCheck then 
  DeckCommand = SummonExtraDeck(cards)
  if DeckCommand ~= nil and (d == 0 
  or BlacklistCheckInit(DeckCommand[1],DeckCommand[2],d,backup))
  then
    if DeckCommand[1]~=COMMAND_ACTIVATE 
    or InfiniteLoopCheck(ActivatableCards[DeckCommand[2]])
    then
      return DeckCommand[1],DeckCommand[2]
    end
  end
end

--
-------------------------------------------------
-- **********************************************
--   Activate these cards before anything else :O
-- **********************************************
-------------------------------------------------

  -----------------------------------------------------
  -- Activate Hieratic Seal of Convocation 
  -- whenever it's possible.
  -----------------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 25377819 then  -- Hieratic Seal of Convocation
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
    end
  end  
  
  --------------------------------------------------
  -- Special Summon Hieratic Dragon of Tefnuit
  -- whenever it's possible.
  --------------------------------------------------  
  for i=1,#SpSummonableCards do 
    if SpSummonableCards[i].id == 77901552 then  -- Hieratic Dragon of Tefnuit
      return COMMAND_SPECIAL_SUMMON,i
    end
  end

  --------------------------------------------------
  -- Special Summon Hieratic Dragon of Su
  -- whenever possible, triggering the effect
  -- of other Hieratics
  --------------------------------------------------  
  for i=1,#SpSummonableCards do 
    if SpSummonableCards[i].id == 03300267 then  -- Hieratic Dragon of Su
      return COMMAND_SPECIAL_SUMMON,i
    end
  end
  
  ------------------------------------------
  -- Always activate the Mini Dragon Rulers'
  -- effects if in hand and if possible.
  ------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 27415516 or   -- Stream
       ActivatableCards[i].id == 53797637 or   -- Burner
       ActivatableCards[i].id == 89185742 or   -- Lightning
       ActivatableCards[i].id == 91020571 then -- Reactan
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
    end
  end
  
  ----------------------------------------------------
  -- Always try to turn a defense-position Tanngnjostr
  -- to attack position to trigger its effect.
  ----------------------------------------------------
  for i=1,#RepositionableCards do
    if RepositionableCards[i].id == 14677495 then
      if RepositionableCards[i].position == POS_FACEUP_DEFENSE or
         RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then
         GlobalActivatedCardID = RepositionableCards[i].id
        return COMMAND_CHANGE_POS,i
      end
    end
  end
  
  
-------------------------------------------------
-- **********************************************
--            Spell card activation :D
-- **********************************************
-------------------------------------------------

  ----------------------------------
  -- Activate any search cards here.
  ----------------------------------
  for i=1,#ActivatableCards do
    if CardIsASearchCard(ActivatableCards[i].id) == 1 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
    end
  end

  
  -- activate field spells already on the field
  for i,c in pairs(ActivatableCards) do
    if FilterType(c,TYPE_SPELL) 
    and FilterType(c,TYPE_FIELD)
    and FilterLocation(c,LOCATION_SZONE)
    --and FilterPosition(c,POS_FACEDOWN)
    and NecrovalleyCheck(c)       
    and CardIsScripted(c.id) == 0
    and NotNegated(c) 
    and InfiniteLoopCheck(c)
    then
      return COMMAND_ACTIVATE,i
    end
  end
  
  -- activate field spells, if the AI doesn't control one already
  for i,c in pairs(ActivatableCards) do
    if FilterType(c,TYPE_SPELL) 
    and FilterType(c,TYPE_FIELD)
    and FilterLocation(c,LOCATION_HAND)
    and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD)==0
    and NecrovalleyCheck(c)       
    and CardIsScripted(c.id) == 0
    and NotNegated(c) 
    and InfiniteLoopCheck(c)
    then
      return COMMAND_ACTIVATE,i
    end
  end 
    
  ------------------------------------------------
  -- Activate Soul Exchange only in Main Phase 1
  -- and if the AI has a level 5+ monster in hand.
  ------------------------------------------------
  if AI.GetCurrentPhase() == PHASE_MAIN1 then
    for i=1,#ActivatableCards do
      if ActivatableCards[i].id == 68005187 then -- Soul Exchange
        local AIHand = AIHand()
		for x=1,#AIHand do
          if AIHand[x].level >= 5 and Get_Card_Count(AI.GetOppMonsterZones()) > 0 then
			if AIMonCountLowerLevelAndAttack(AIHand[x].level,AIHand[x].attack) +1 >= AIMonGetTributeCountByLevel(AIHand[x].level) and GlobalSummonedThisTurn == 0 then
			   GlobalActivatedCardID = ActivatableCards[i].id
               GlobalAdditionalTributeCount = GlobalAdditionalTributeCount + 1
			   GlobalSoulExchangeActivated = 1
			  return COMMAND_ACTIVATE,i
             end
           end
         end
       end
     end
   end

  ------------------------------------------------
  -- Activate Change of Heart only in Main Phase 1
  -- and if the AI has a level 5+ monster in hand.
  ------------------------------------------------
  if AI.GetCurrentPhase() == PHASE_MAIN1 then
    for i=1,#ActivatableCards do
      if ActivatableCards[i].id == 04031928 then
        local AIHand = AI.GetAIHand()
        for x=1,#AIHand do
          if AIHand[x] ~= false then
            if AIHand[x].level >= 5 then
              GlobalActivatedCardID = ActivatableCards[i].id
              return COMMAND_ACTIVATE,i
            end
          end
        end
      end
    end
  end

  -------------------------------------------------------------
  -- Activate Creature Swap only if the opponent and AI control
  -- 1 monster each, and the opponent's monster is stronger.
  -------------------------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 31036355 then
      if Get_Card_Count(AI.GetOppMonsterZones()) == 1 and Get_Card_Count(AIMon()) == 1 then
        if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") then
           GlobalActivatedCardID = ActivatableCards[i].id
          return COMMAND_ACTIVATE,i
        end
      end
    end
  end

  ----------------------------------------------------------
  -- Activate Monster Reincarnation only if the monster with
  -- the highest ATK in the AI's graveyard is stronger than
  -- the monsters in the AI's hand, and the AI has at least
  -- 1 monster in hand.
  --
  -- To do: Make an exception for Honest and other cards.
  ----------------------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 74848038 then
     if Get_Card_Count_ID(UseLists({AIMon(),AIST(),OppMon(),OppST()}), 47355498, POS_FACEUP) ==  0 then 
	  local AIHand = AIHand()
      local AIGrave = AIGrave()
      local GraveHighestATK = 0
      local HandHighestATK = 0
      for x=1,#AIGrave do
         if AIGrave[x].attack > GraveHighestATK then
            GraveHighestATK = AIGrave[x].attack
          end
       end
      for x=1,#AIHand do
         if AIHand[x].attack > HandHighestATK then
            HandHighestATK = AIHand[x].attack
          end
       end
     if GraveHighestATK > HandHighestATK then
        GlobalCardMode = 1
        GlobalActivatedCardID = ActivatableCards[i].id
        return COMMAND_ACTIVATE,i
       end
     end
   end
 end

  ---------------------------------------------
  -- Elf's Light, Shine Palace : activate only  
  -- if AI has one or more light attribute
  -- monster on the field. 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 39897277 or ActivatableCards[i].id == 82878489 then -- Elf's Light, Shine Palace
    if Get_Card_Count_ATT(AIMon(),"==",ATTRIBUTE_LIGHT,POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end   
  
  ---------------------------------------------
  -- Burning Spear: activate only if AI has one or more 
  -- fire attribute monster on the field 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 18937875 then -- Burning Spear
    if Get_Card_Count_ATT(AIMon(),"==",ATTRIBUTE_FIRE,POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end   
 end    
   
  ---------------------------------------------
  -- 7 Completed, Break! Draw! :activate only  
  -- if AI has one or more machine race
  -- monster on the field. 
  ---------------------------------------------
   for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 86198326 or  -- 7 Completed
      ActivatableCards[i].id == 63851864 then -- Break! Draw!
    if Get_Card_Count_Race(AIMon(),"==",RACE_MACHINE,POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end   
 end  
  
  ---------------------------------------------
  -- Assault Armor: activate only if AI has one or more 
  -- warrior race monster on the field 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 88190790 then -- Assault Armor
    if Get_Card_Count_Race(AIMon(),"==",RACE_WARRIOR,POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end     
 end  
  
  ---------------------------------------------
  -- Beast Fangs: activate only if AI has one or more 
  -- beast race monster on the field 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 46009906 then -- Beast Fangs
    if Get_Card_Count_Race(AIMon(),"==",RACE_BEAST,POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end 
 end
  
  ---------------------------------------------
  -- Book of Secret Arts, Bound Wand: activate only  
  -- if AI has one or more machine race
  -- monster on the field. 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 91595718 or -- Book of Secret Arts
      ActivatableCards[i].id == 53610653 then -- Bound Wand
    if Get_Card_Count_Race(AIMon(),"==",RACE_SPELLCASTER,POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end 
 end 
  
  ---------------------------------------------
  -- Activate Abyss-scale of Cetus, Abyss-scale of the Kraken, 
  -- Abyss-scale of the Mizuchi only if 
  -- AI controls 1 or more "Mermail" monster.
  --------------------------------------------- 
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 19596712 or -- Abyss-scale of Cetus
      --ActivatableCards[i].id == 72932673 or -- Abyss-scale of the Mizuchi
      ActivatableCards[i].id == 08719957 then -- Abyss-scale of the Kraken      
    if Archetype_Card_Count(AIMon(), 7667828, POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end      
 end

 ---------------------------------------------
  -- Activate Core Blaster only if 
  -- AI controls 1 or more "Koa'ki Meiru" monster
  -- and Player controls any light or dark attribute monsters.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 59385322 then -- Core Blaster   
    if Archetype_Card_Count(AIMon(), 29, POS_FACEUP) > 0 then  
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end      
 end
 
  ---------------------------------------------
  -- Activate Amazoness Heirloom only if 
  -- AI controls 1 or more "Amazoness"  monster.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 79965360 then -- Amazoness Heirloom
    if Archetype_Card_Count(AIMon(), 4, POS_FACEUP) > 0 then  
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end   
 end   
 
  ---------------------------------------------
  -- Activate Ancient Gear Fist, Ancient Gear Tank only if 
  -- AI controls 1 or more "Ancient Gear"  monster.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 40830387 or -- Ancient Gear Fist
      ActivatableCards[i].id == 37457534 then -- Ancient Gear Tank
    if Archetype_Card_Count(AIMon(), 7, POS_FACEUP) > 0 then  
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end    
 end
  
  ---------------------------------------------
  -- Activate Amplifier only if 
  -- AI controls 1 or more "Jinzo" monster.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if Get_Card_Count_ID(AIST(),ActivatableCards[i].id, POS_FACEUP) == 0 then 
    if ActivatableCards[i].id == 00303660 then -- Amplifier 
     if Get_Card_Count_ID(UseLists({AIMon(),AIST()}),77585513, POS_FACEUP) > 0 then -- Jinzo      
        GlobalActivatedCardID = ActivatableCards[i].id
	   return COMMAND_ACTIVATE,i
      end
    end
  end   
end 
  
  ---------------------------------------------
  -- Activate Bubble Blaster only if 
  -- AI controls 1 or more "Elemental Hero Bubbleman" monster.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 53586134 then -- Bubble Blaster
    if Get_Card_Count_ID(UseLists({AIMon(),AIST()}),79979666, POS_FACEUP) > 0 then -- Elemental Hero Bubbleman      
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end  
 end
  
  ---------------------------------------------
  -- Activate Amulet of Ambition only if 
  -- AI controls 1 or more normal monsters.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 05183693 then -- Amulet of Ambition
    if Get_Card_Count_Type(AIMon(), TYPE_MONSTER, "==",POS_FACEUP) > 0 then      
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end      
 end
  
  ---------------------------------------------
  -- AI Will activate Bait Doll only if player
  -- has any spell or trap cards on the field
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 07165085 then -- Bait Doll
    if Get_Card_Count_Pos(OppST(), POS_FACEDOWN) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end
 end 
  
  ---------------------------------------------
  -- Activate Buster Rancher only if 
  -- AI controls 1 or more monsters with attack points of
  -- 1000 or below.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 84740193 then -- Buster Rancher
    if Get_Card_Count_Att_Def(AIMon(), "<=", 1000, nil, POS_FACEUP) > 0 then      
       GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end      
 end
  
  ---------------------------------------------
  -- AI should activate: Broken Bamboo Sword, 
  -- Cursed Bill, Mask of the accursed, Flint 
  -- only if player has any face up attack position monsters on the field
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if Get_Card_Count_ID(AIST(),ActivatableCards[i].id, POS_FACEUP) == 0 then
    if ActivatableCards[i].id == 41587307 or -- Broken Bamboo Sword
       ActivatableCards[i].id == 46967601 or -- Cursed Bill
       ActivatableCards[i].id == 56948373 or -- Mask of the accursed  
       ActivatableCards[i].id == 75560629 then -- Flint 
     if Get_Card_Count_Pos(OppMon(), POS_FACEUP_ATTACK) > 0 then
        GlobalActivatedCardID = ActivatableCards[i].id
	   return COMMAND_ACTIVATE,i
      end
	end
  end
end
  
  ---------------------------------------------
  -- AI should activate: Armed Changer, Axe of Despair,
  -- Ballista of Rampart Smashing, Big Bang Shot, Black Pendant
  -- 
  -- only if he has any face up position monsters on the field
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 90374791 or -- Armed Changer
      ActivatableCards[i].id == 00242146 or -- Ballista of Rampart Smashing
      ActivatableCards[i].id == 61127349 or -- Big Bang Shot
      ActivatableCards[i].id == 65169794 or -- Black Pendant      
      ActivatableCards[i].id == 69243953 or -- Butterfly Dagger - Elma
	  ActivatableCards[i].id == 40619825 then -- Axe of Despair   
    if Get_Card_Count_Pos(AIMon(), POS_FACEUP) > 0 and SpSummonableCards[i] == nil and SummonableCards[i] == nil then
	   GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end
 end
    
  ---------------------------------------------
  -- AI should activate: Germ Infection, Paralazying Poison 
  -- only if player has any face up monsters non machine race monsters on the field
  ---------------------------------------------
 for i=1,#ActivatableCards do  
  if Get_Card_Count_ID(AIST(),ActivatableCards[i].id, POS_FACEUP) == 0 then
    if ActivatableCards[i].id == 24668830 or -- Germ Infection
       ActivatableCards[i].id == 50152549 then -- Paralyzing Potion
	 if Get_Card_Count_Race(OppMon(),"~=",RACE_MACHINE,POS_FACEUP) > 0 then
        GlobalActivatedCardID = ActivatableCards[i].id
       return COMMAND_ACTIVATE,i
      end
	end
  end
end 
    
  ---------------------------------------------
  -- AI should activate: Chthonian Alliance, 
  -- only if player has face up monsters with same name 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
    if ActivatableCards[i].id == 46910446 then -- Chthonian Alliance 
     if MonCountSameID() > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Dark Core, 
  -- only if player has face up monsters with 1700 
  -- or more attack points.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 70231910 then -- Dark Core 
    if Get_Card_Count_Att_Def(OppMon(), ">=", 1700, nil, POS_FACEUP) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
       GlobalCardMode = 1
	  return COMMAND_ACTIVATE,i
     end
   end
 end
   
  ---------------------------------------------
  -- AI should activate: Soul Release, 
  -- only if AI has 4 or more monster cards in graveyard
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 05758500 then -- Soul Release 
    if Get_Card_Count_Type(AIGrave(),TYPE_MONSTER,">",nil) >= 3 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Cost Down, 
  -- only if AI has level 5 or 6 monster in hand
  ---------------------------------------------
   for i=1,#ActivatableCards do  
    if ActivatableCards[i].id == 23265313 and AI.GetCurrentPhase() == PHASE_MAIN1 then -- Cost Down
     local AIHand = AIHand()
      for x=1,#AIHand do
		if AIHand[x].level > 6 and Card_Count_Specified(AIHand, nil, nil, nil, nil, "<=", 4, nil, nil, nil) > 0 then
		  if AIMonCountLowerLevelAndAttack(AIHand[i].level,AIHand[i].attack) > 0 and GlobalSummonedThisTurn == 0 then
		    GlobalActivatedCardID = ActivatableCards[i].id
		    GlobalCostDownActivated = 1
		   return COMMAND_ACTIVATE,i
		   end
        end
	   for x=1,#AIHand do
		 if AIHand[x].level == 5 or AIHand[x].level == 6 and 
		    Card_Count_Specified(AIHand, nil, nil, nil, nil, "<=", 4, nil, nil, nil) > 0 then
		    GlobalActivatedCardID = ActivatableCards[i].id
		    GlobalCostDownActivated = 1
		   return COMMAND_ACTIVATE,i
          end
		end
      end
    end
  end 
  
  ---------------------------------------------
  -- AI should activate: Megamorph, 
  -- only if AI's strongest monster's attack points are 
  -- 1500 or higher and AI's lp is lower than player's
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 22046459 then -- Megamorph
    if Get_Card_Count_Pos(AIMon(), POS_FACEUP) > 0 then
	 if AI.GetPlayerLP(1) < AI.GetPlayerLP(2) and Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") >= 1500 then
        GlobalActivatedCardID = ActivatableCards[i].id
       return COMMAND_ACTIVATE,i
      end
    end
  end
end
  
  ---------------------------------------------
  -- AI should activate: Enemy Controller, 
  -- only if AI's strongest monster's attack points are 
  -- lower than player's, and player's strongest monster's 
  -- def points are lower than AI's strongest monster's attack.
  ---------------------------------------------
 for i=1,#ActivatableCards do  
  if ActivatableCards[i].id == 98045062 then -- Enemy Controller
	if Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and 
	   Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(OppMon(), "attack", ">", POS_FACEUP_ATTACK, "defense") then
      --return COMMAND_ACTIVATE,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: The Flute of Summoning Dragon, 
  -- only if AI has any dragon type monsters in hand.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 43973174 then -- The Flute of Summoning Dragon
    if Get_Card_Count_Race(AIHand(),RACE_DRAGON,nil) > 0 then
       GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Card Destruction, 
  -- only if AI has no other spell or trap cards in hand.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 72892473 then -- Card Destruction
    if Get_Card_Count_Type(AIHand(), TYPE_TRAP, ">") == 0 and 
	   Get_Card_Count_Type(AIHand(), TYPE_SPELL, ">") == 0 then
	   GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end
 end
         
  ---------------------------------------------
  -- AI should activate: Mystic Box, 
  -- only if AI has monster with 1400 attack or lower
  -- and opponent controls a strong monster. 
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 25774450 then -- Mystic Box
    if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") and 
	   Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") >= 2000 and Get_Card_Att_Def(OppMon(), "attack", ">", POS_FACEUP_ATTACK, "defense") <= 1400 then
	   GlobalCardMode = 1
	   GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Mage Power, 
  -- only if AI's monster can become stronger than
  -- any player's monster as result.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 83746708 then -- Mage Power
    if (Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") + 500 * (Get_Card_Count(AIST()) +1)) >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and
	    Get_Card_Count_Pos(AIMon(), POS_FACEUP) > 0 and SummonableCards[i] == nil and SpSummonableCards[i] == nil then 
	    GlobalActivatedCardID = ActivatableCards[i].id
	   return COMMAND_ACTIVATE,i
     end
   end
 end
  
  ---------------------------------------------
  -- AI should activate: Swords of Revealing Light, 
  -- only if AI has nothing to summon and player
  -- controls stronger monsters.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 72302403 or ActivatableCards[i].id == 58775978 then -- Swords of Revealing Light, Nightmare's Steelcage
    if Get_Card_Count_ID(UseLists({AIMon(),AIST()}),72302403, POS_FACEUP) == 0 and 
	   Get_Card_Count_ID(UseLists({AIMon(),AIST()}),58775978,POS_FACEUP) == 0 then  
      if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def_Pos(AIMon()) or 
         Get_Card_Count(AIMon()) == 0 and Get_Card_Count_Pos(AIMon(), POS_FACEUP_ATTACK) > 0 then
	     GlobalActivatedCardID = ActivatableCards[i].id
	    return COMMAND_ACTIVATE,i
       end
     end
   end
 end 
 
  ---------------------------------------------
  -- AI should activate: Card Destruction, 
  -- only if AI has no other spell or trap cards in hand.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 87880531 then -- Diffusion Wave-Motion
    if Card_Count_Specified(AIMon(), nil, nil, nil, nil, ">=", 7, RACE_SPELLCASTER, nil, nil) > 0 and 
	   ActivatableCards[i].attack > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and
	   Get_Card_Count(OppMon()) >= 2 then
	   GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end
 end
   
  ---------------------------------------------
  -- AI should activate: Black Illusion Ritual, 
  -- if opponent controls any cards.
  ---------------------------------------------      
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 41426869 then -- Black Illusion Ritual
      if Get_Card_Count(AI.GetOppMonsterZones()) > 0 then
        return COMMAND_ACTIVATE,i
      end
    end
  end
  
  ---------------------------------------------
  -- AI should activate: Toon World, Toon Kingdom
  -- if he doesn't control one of these cards already
  ---------------------------------------------   
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 15259703 or ActivatableCards[i].id == 500000090 then -- Toon World, Toon Kingdom
      if Get_Card_Count_ID(AIST(),15259703, POS_FACEUP) == 0 and Get_Card_Count_ID(AIST(),500000090, POS_FACEUP) == 0 then
		return COMMAND_ACTIVATE,i
      end
    end
  end
  
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 54031490 then -- Shien's Smoke Signal
      if Get_Card_Count_ID(AIHand(),83039729,nil) > 0 or 
         Get_Card_Count_ID(AIHand(),02511717,nil) > 0 or
		 Get_Card_Count_ID(AIHand(),01498130,nil) > 0 or
		 Get_Card_Count_ID(AIHand(),49721904,nil) > 0 or
		 Get_Card_Count_ID(AIHand(),27821104,nil) > 0 or
		 Get_Card_Count_ID(AIHand(),65685470,nil) > 0  then
		GlobalActivatedCardID = ActivatableCards[i].id
		return COMMAND_ACTIVATE,i
      end
    end
  end
    
   
-------------------------------------------------
-- **********************************************
--         Trap card activation :P
-- **********************************************
-------------------------------------------------
  
  ---------------------------------------------
  -- AI should activate: Zero Gravity, 
  -- only if Player is about to attack or attacked.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 83133491 then  -- Zero Gravity
    if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 83133491, POS_FACEUP) ==  0 
    and AI.GetCurrentPhase() == PHASE_DAMAGE 
    and Duel.GetTurnPlayer() == 1-player_ai
    then
	   GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end

  ---------------------------------------------
  -- AI should activate: Spellbinding Circle, 
  -- only if AI has no other spell or trap cards in hand.
  ---------------------------------------------
  for i=1,#ActivatableCards do   
   if ActivatableCards[i].id == 18807108 then -- Spellbinding Circle
    if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") and 
	   Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(OppMon()," attack", ">", POS_FACEUP_ATTACK, "defense") and 
	   Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") >= 1700 then
	   GlobalActivatedCardID = ActivatableCards[i].id
	  return COMMAND_ACTIVATE,i
     end
   end
 end
 
  ---------------------------------
  -- Activate Raigeki Break only if
  -- the opponent controls a card.
  ---------------------------------
  for i=1,#ActivatableCards do 
   if ActivatableCards[i].id == 04178474 then -- Raigeki B
     if Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") or 
	    Get_Card_Count(OppST()) > 0 then
        GlobalActivatedCardID = ActivatableCards[i].id
        GlobalCardMode = 1
	   return COMMAND_ACTIVATE,i
      end
    end
  end	
  
  ---------------------------------------------
  -- AI should activate: Return from the Different Dimension,
  -- only if AI can bring out strong tribute monster as result, 
  -- or if player or AI has 0 monsters on the field (just in case)
  ---------------------------------------------
  for i=1,#ActivatableCards do
   if ActivatableCards[i].id == 27174286 then -- Return from the Different Dimension
   local AIHand = AIHand()
   local HandHighestATK = 0
   local Result = 0
  if IsBattlePhase() and Duel.GetTurnPlayer() == 1-player_ai and 
     Get_Card_Count_Type(AIBanish(),TYPE_MONSTER,">",nil) >= 3 and Get_Card_Count(AIMon()) == 0 then 
   return 1,i
  end
 if AI.GetCurrentPhase() == PHASE_MAIN1 
 and Get_Card_Count_Type(AIBanish(),TYPE_MONSTER,">",nil) >= 3 
 and Duel.GetTurnPlayer() == player_ai and Get_Card_Count(AIMon()) == 0 then	
  for x=1,#AIHand do
    if AIHand[x].attack > HandHighestATK then
       HandHighestATK = AIHand[x].attack       
      if AIHand[x].level >= 5 and
         HandHighestATK >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then
	      return COMMAND_ACTIVATE,i
	      end
        end
      end
    end
  end 
end
   
-------------------------------------------------
-- **********************************************
--       Monster card effect activation :B
-- **********************************************
-------------------------------------------------  


  ------------------------------------------
  -- Activate Malefic Truth Dragon's special
  -- summon effect only if Skill Drain or a
  -- field spell is face-up.
  ------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 37115575 then
      if Get_Card_Count_ID(UseLists({AIMon(),AIST(),OppMon(),OppST()}), 82732705, POS_FACEUP) > 0 or 
	     Get_Card_Count_Type(UseLists ({AIST(),OppST()}), TYPE_FIELD + TYPE_SPELL, "==", POS_FACEUP) > 0 then
        GlobalActivatedCardID = ActivatableCards[i].id
        return COMMAND_ACTIVATE,i
      end
    end
  end
  
  ---------------------------------------------
  -- Activate Worm King's effect only if the AI
  -- controls a "Worm" monster other than King
  -- and the opponent controls at least 1 card.
  ---------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 10026986 then
      if Get_Card_Count(OppMon()) > 0 or Get_Card_Count(OppST()) > 0 then
        local AIMons = AIMon()
        for x=1,#AIMons do
          if AIMons[x].id ~= 10026986 and
             AIMons[x].setcode == 62 then
             GlobalActivatedCardID = ActivatableCards[i].id
             GlobalCardMode = 1
            return COMMAND_ACTIVATE,i
           end
         end
       end
     end
   end
  
  ---------------------------------------------
  -- AI should activate:  Cocoon of Evolution, 
  -- only if AI controls face up Petit Moth.
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 40240595 then  -- Cocoon of Evolution
	if Get_Card_Count_ID(UseLists({AIMon(),AIST()}),58192742,POS_FACEUP) > 0 and  
	   Get_Card_Count_ID(UseLists({AIMon(),AIST()}),40240595,POS_FACEUP) ==  0 then -- Petit Moth	 
	   GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end
 
  ---------------------------------------------
  -- AI should activate: Breaker the Magical Warrior's 
  -- effect only if opponent controls any spell or trap cards
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 71413901 then  -- Breaker the Magical Warrior
    if Get_Card_Count(OppST()) > 0 then
	   GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end
 
  ---------------------------------------------
  -- AI should activate: Kuriboh's effect only if
  -- his about to take 1500 or more points of battle damage
  ---------------------------------------------
  for i=1,#ActivatableCards do  
   if ActivatableCards[i].id == 40640057 then  -- Kuriboh
    if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") - Get_Card_Att_Def(AIMon(),attack,">",POS_FACEUP_ATTACK,attack) >= 1500 then
	   return COMMAND_ACTIVATE,i
      end
    end
  end
 
  ---------------------------------------------
  -- AI should activate: Summoner Monk, 
  -- only if AI has "Battlin' Boxer Switchitter"
  -- in deck.
  ---------------------------------------------  
  for i=1,#ActivatableCards do  
    if ActivatableCards[i].id == 00423585 then  -- Summoner Monk
    if Get_Card_Count_ID(AIDeck(),68144350,nil) > 0 then -- Battlin' Boxer Switchitter
       GlobalCardMode = 1
      GlobalActivatedCardID = ActivatableCards[i].id
      return COMMAND_ACTIVATE,i
     end
   end
 end
 
  -------------------------------------------------------  
  -- AI should activate "Exiled Force" if players
  -- strongest attack position monster has more attack points than AI's.
  -------------------------------------------------------
   for i=1,#ActivatableCards do  
	if ActivatableCards[i].id == 74131780 then -- Exiled Force
      if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") and 
	     Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") >= 1900 then
		 GlobalActivatedCardID = ActivatableCards[i].id
		return COMMAND_ACTIVATE,i
       end
     end
   end
 
 
   -----------------------------------------------------
  -- Activate Destiny Hero - Malicious only, if a lvl
  -- 6 monster or a tuner is faceup on the field
  -----------------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 09411399 then
      local AIMons=AI.GetAIMonsterZones()
      for j=1,#AIMons do
        if AIMons[j] and bit32.band(AIMons[j].position,POS_FACEUP)> 0 and
          (AIMons[j].level == 6 or bit32.band(AIMons[j].type,TYPE_TUNER)>0) then
          GlobalActivatedCardID = ActivatableCards[i].id
          return COMMAND_ACTIVATE,i
        end
      end
    end
  end
  

  
  ------------------------------------------
  -- Activate Dark Grepher only if the AI has 
  -- non-boss DARK monsters in hand
  ------------------------------------------
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 14536035 then
      local DarkMonsters = Sort_List_By(AIHand(),nil,ATTRIBUTE_DARK,nil,">",TYPE_MONSTER)
	  if Card_Count_From_List(BanishBlacklist,DarkMonsters,"~=") > 0 then
        GlobalActivatedCardID = ActivatableCards[i].id
        GlobalCardMode = 2
        return COMMAND_ACTIVATE,i
      end
    end
  end
  
  ---------------------------------------------
  -- AI should activate: Relinquished, 
  -- if opponent controls any cards.
  ---------------------------------------------      
  for i=1,#ActivatableCards do
    if ActivatableCards[i].id == 64631466 then -- Relinquished
      if Get_Card_Count(AI.GetOppMonsterZones()) > 0 then
         GlobalActivatedCardID = ActivatableCards[i].id
		return COMMAND_ACTIVATE,i
      end
    end
  end
   
   
  ---------------------------------------------------------
  -- ***************************************************** 
  -- Activate anything else that isn't scripted above
  -- *****************************************************
  ---------------------------------------------------------
  for i=1,#ActivatableCards do
    local c = ActivatableCards[i]
    if (Get_Card_Count_ID(AIST(),c.id, POS_FACEUP) == 0 
    or FilterLocation(c,LOCATION_SZONE)
    and FilterPosition(c,POS_FACEUP))
    and NecrovalleyCheck(c)
    and not FilterType(c,TYPE_FIELD)           
    and CardIsScripted(c.id) == 0
    and NotNegated(c) 
    and c.description ~= 1160 -- Pendulum scale activation
    and InfiniteLoopCheck(c)
    then
      GlobalActivatedCardID = c.id
      return COMMAND_ACTIVATE,i
    end
  end
  
  -----------------------------------------------------
  -- Temporarily increase the ATK of monster cards that
  -- either have built-in ATK boosts while attacking or
  -- are affected that way by another card.
  -----------------------------------------------------
  ApplyATKBoosts(RepositionableCards)

  
-------------------------------------------------
-- **********************************************
-- Cards whose position should be changed before 
-- summoning/special summoning >_>
-- **********************************************
-------------------------------------------------
  
  --------------------------------------------------
  -- If AI will be able to XYZ summon a monster, turn required material monsters 
  -- to face up position if they are face down on the field
  --------------------------------------------------   
	for i=1,#RepositionableCards do
	  if ChangePosToXYZSummon(cards, SummonableCards, RepositionableCards) == 1 then -- Check if any XYZ can be summoned
		if RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then -- Only change position of face down monsters
		  if isMonLevelEqualToRank(RepositionableCards[i].level,RepositionableCards[i].id) == 1 then -- Check if monster's level is equal to XYZ monsters rank        
		  return COMMAND_CHANGE_POS,i
         end
       end
     end
   end  
  
  -----------------------------------------------------
  -- Flip up Ryko only if the opponent controls a card.
  -----------------------------------------------------
  for i=1,#RepositionableCards do
    if RepositionableCards[i].id == 21502796 then
      if RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then
        if Get_Card_Count(AI.GetOppMonsterZones()) > 0 or Get_Card_Count(OppST()) > 0 then
          return COMMAND_CHANGE_POS,i
         end
       end
     end
   end

  -------------------------------------------
  -- Flip up Swarm of Locusts if the opponent
  -- controls a Spell or Trap card.
  -------------------------------------------
  for i=1,#RepositionableCards do
    if RepositionableCards[i].id == 41872150 then
      if RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then
        if Get_Card_Count(OppST()) > 0 then
          return COMMAND_CHANGE_POS,i
        end
      end
    end
  end

  -------------------------------------------
  -- Flip up certain monsters if the opponent
  -- controls a Monster.
  -------------------------------------------
  for i=1,#RepositionableCards do
    if RepositionableCards[i].id == 15383415 or   -- Swarm of Scarabs
       RepositionableCards[i].id == 54652250 or   -- Man-Eater Bug
	   RepositionableCards[i].id == 52323207 then -- Golem Sentry
      if RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then
        if Get_Card_Count(OppST()) > 0 then
          return COMMAND_CHANGE_POS,i
        end
      end
    end
  end

  --------------------------------------
  -- Always flip up certain set monsters
  -- regardless of the situation.
  --------------------------------------
  for i=1,#RepositionableCards do
    if RepositionableCards[i].id == 02326738 or   -- Des Lacooda
       RepositionableCards[i].id == 03510565 or   -- Stealth Bird
       RepositionableCards[i].id == 33508719 or   -- Morphing Jar
	   RepositionableCards[i].id == 44811425 then -- Worm Linx
	  if RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then
        return COMMAND_CHANGE_POS,i
      end
    end
  end
  
-------------------------------------------------
-- **********************************************
--          Card Special summoning ^_^
-- **********************************************
-------------------------------------------------
  
  --------------------------------------------------
  -- Special Summon a Malefic monster if and only if
  -- there's a face-up field spell or Skill Drain.
  --------------------------------------------------
  if Get_Card_Count_ID(UseLists({AIMon(),AIST(),OppMon(),OppST()}), 82732705, POS_FACEUP) > 0 or 
     Get_Card_Count_Type(UseLists ({AIST(),OppST()}), TYPE_FIELD + TYPE_SPELL, "==", POS_FACEUP) > 0 then
    for i=1,#SpSummonableCards do
      if SpSummonableCards[i].id == 01710476 then -- Sin End
        return COMMAND_SPECIAL_SUMMON,i
      end
    end
    for i=1,#SpSummonableCards do
      if SpSummonableCards[i].id == 00598988 then -- Sin Bow
        return COMMAND_SPECIAL_SUMMON,i
      end
    end
    for i=1,#SpSummonableCards do
      if SpSummonableCards[i].id == 09433350 then -- Sin Blue
        return COMMAND_SPECIAL_SUMMON,i
      end
    end
    for i=1,#SpSummonableCards do
      if SpSummonableCards[i].id == 36521459 then -- Sin Dust
        return COMMAND_SPECIAL_SUMMON,i
      end
    end
    for i=1,#SpSummonableCards do
      if SpSummonableCards[i].id == 55343236 then -- Sin Red
        return COMMAND_SPECIAL_SUMMON,i
      end
    end
  end



  -------------------------------------------------------  
  -- AI should summon Perfectly Ultimate Great Moth only if he 
  -- controls cocoon of evolution  at it's 6th stage of evolution.
  -------------------------------------------------------
  for i=1,#SpSummonableCards do   
	if SpSummonableCards[i].id == 48579379 then -- Perfectly Ultimate Great Moth.
	 if Get_Card_Count_ID(UseLists({AIMon(),AIST()}), 40240595, POS_FACEUP) > 0 and GlobalCocoonTurnCount >= 6 then -- Cocoon of Evolution     
	   return COMMAND_SPECIAL_SUMMON,i
      end
    end
  end
    
  -----------------------------------------------------
  -- Summon "Ghost Ship" if valid monsters can be banished
  -----------------------------------------------------
  for i=1,#SpSummonableCards do
    if SpSummonableCards[i].id == 33347467 then -- Ghost Ship
	  if Card_Count_From_List(BanishBlacklist, AIGrave(),"~=") > 0 then
		GlobalActivatedCardID = SpSummonableCards[i].id
		return COMMAND_SPECIAL_SUMMON,i
        end
      end
    end
  
  --------------------------------------------------
  -- Special summon Dark Grepher only, if there
  -- are non-boss lvl 5+ DARK cards in your hand
  --------------------------------------------------  
    for i=1,#SpSummonableCards do
      local id = SpSummonableCards[i].id
      if id == 14536035 then          --Dark Grepher
        local DarkMonsters = Sort_List_By(AIHand(),nil,ATTRIBUTE_DARK,nil,">",TYPE_MONSTER)
        for j=1,#DarkMonsters do
          if DarkMonsters[j].level > 5 and BanishBlacklist(DarkMonsters[j].id) == 0 then
            GlobalActivatedCardID = id
            return COMMAND_SPECIAL_SUMMON,i
          end
        end
      end
    end
  
  
    
  
  -------------------------------------------------------
  -- *************************************************
  -- XYZ and Synchro summon all cards not specified above
  -- *************************************************
  -------------------------------------------------------   
   for i=1,#SpSummonableCards do
	 CalculatePossibleSummonAttack(SpSummonableCards)
	  if SpSummonableCards[i].rank > 0 and SpecialSummonBlacklist(SpSummonableCards[i].id) == 0 then 
	   if SpSummonableCards[i].id ~= 38495396 then
		if AIMonOnFieldMatCount(SpSummonableCards[i].rank) >= GetXYZRequiredMatCount() then 
		  GlobalSSCardLevel = SpSummonableCards[i].level
          GlobalSSCardAttack = SpSummonableCards[i].attack
		  GlobalSSCardType = bit32.band(SpSummonableCards[i].type,TYPE_XYZ)
		  GlobalSSCardID = SpSummonableCards[i].id
       --print("generic XYZ summon")
		   return COMMAND_SPECIAL_SUMMON,i
           end
         end
       end
     end

  -------------------------------------------------------
  -- "Toon" monster tribute summoning logic
  -------------------------------------------------------   
   for i=1,#SpSummonableCards do	  
	 if SpSummonableCards[i].setcode == 4522082 or SpSummonableCards[i].setcode == 98 then
	  if SpSummonableCards[i].level >= 5 and NormalSummonBlacklist(SpSummonableCards[i].id) == 0 and 
	   (AIMonCountLowerLevelAndAttack(SpSummonableCards[i].level,SpSummonableCards[i].attack) + GlobalAdditionalTributeCount) >= AIMonGetTributeCountByLevel(SpSummonableCards[i].level) then
        if SpSummonableCards[i].type ~= TYPE_MONSTER + TYPE_EFFECT + TYPE_FLIP and 
           (SpSummonableCards[i].attack >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and SpSummonableCards[i].attack > Get_Card_Att_Def(OppMon(), attack, ">", POS_FACEUP_ATTACK, defense)) or 
		   CanChangeOutcome(cards, SpSummonableCards, cards.activatable_cards) == 1 then   
		  GlobalSSCardSetcode = SpSummonableCards[i].setcode
		  GlobalSSCardLevel = SpSummonableCards[i].level
		  GlobalSSCardAttack = SpSummonableCards[i].attack
		  GlobalAdditionalTributeCount = GlobalAdditionalTributeCount-1
		  return COMMAND_SPECIAL_SUMMON,i
          end
        end
      end
    end
 	 
  ---------------------------------------------------
  -- *************************************************
  -- Special Summon anything else not specified above
  -- *************************************************
  ---------------------------------------------------
  for i=1,#SpSummonableCards do
    if SpSummonableCards[i].rank <= 0 or SpSummonableCards[i].rank == nil then
      if (SpSummonableCards[i].setcode ~= 4522082 and SpSummonableCards[i].setcode ~= 98) or SpSummonableCards[i].level < 5 then 
        if SpecialSummonBlacklist(SpSummonableCards[i].id)==0 then
          return COMMAND_SPECIAL_SUMMON,i
        end
      end
    end
  end  
  
  
-------------------------------------------------
-- **********************************************
--       Normal summon and set cards D:
-- **********************************************
-------------------------------------------------
  
  -------------------------------------------
  -- Set trap cards in Main Phase 1 if
  -- AI has "Cardcar D" in hand.
  -------------------------------------------
  if #cards.st_setable_cards > 0 and Get_Card_Count_ID(AIHand(),45812361,nil) > 0 then
    local setCards = cards.st_setable_cards
    for i=1,#setCards do
      if bit32.band(setCards[i].type,TYPE_TRAP) > 0 or bit32.band(setCards[i].type,TYPE_SPELL) > 0 then
        return COMMAND_SET_ST,i
      end
    end
  end

  -------------------------------------------
  -- Try to summon monster who requires a tribute
  -- when "Soul Exchange" is activated.
  -------------------------------------------
  if GlobalSoulExchangeActivated == 1 then
   for i=1,#SummonableCards do
	 CalculatePossibleSummonAttack(SummonableCards)
	   if SummonableCards[i].level >= 5 and NormalSummonBlacklist(SummonableCards[i].id) == 0 and 
	     (AIMonCountLowerLevelAndAttack(SummonableCards[i].level,SummonableCards[i].attack) + GlobalAdditionalTributeCount) >= AIMonGetTributeCountByLevel(SummonableCards[i].level) then
        if SummonableCards[i].type ~= TYPE_MONSTER + TYPE_EFFECT + TYPE_FLIP and 
           (SummonableCards[i].attack >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and SummonableCards[i].attack > Get_Card_Att_Def(OppMon(), "attack", ">", POS_FACEUP_ATTACK, "defense")) or 
		   CanChangeOutcome(cards, SummonableCards, cards.activatable_cards) == 1 then   
		   GlobalActivatedCardLevel = SummonableCards[i].level
           GlobalActivatedCardAttack = SummonableCards[i].attack
		   GlobalSummonedCardID = SummonableCards[i].id
		   GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		   GlobalSoulExchangeActivated = 0
		  return COMMAND_SUMMON,i
        end
      end
    end
  end  
  
  -------------------------------------------
  -- Summon monster of level 6 or 5 when 
  -- "Cost Down" is activated
  -------------------------------------------
  if GlobalCostDownActivated == 1 then 
   for i=1,#SummonableCards do
	 if SummonableCards[i].base_level == 6 or SummonableCards[i].base_level == 5 then   
	   GlobalCostDownActivated = 0
	   GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
	    return COMMAND_SUMMON,i
        end
      end
    end
  
  --------------------------------------------
  -- AI should always summon "Cardcar D" 
  -- if he has a backrow.
  --------------------------------------------
  for i=1,#SummonableCards do
    if SummonableCards[i].id == 45812361 then -- Cardcar D
     if Get_Card_Count(AIST()) > 1 then
	    GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
	   return COMMAND_SUMMON,i
      end
    end
  end
  
  if HasID(SummonableCards,34627841) and HasID(AIHand(),89631139,true) then
    return COMMAND_SUMMON,CurrentIndex
  end
  
  if HasID(RepositionableCards,34627841,FilterPosition,POS_FACEDOWN_DEFENSE) 
  and HasID(AIHand(),89631139,true) 
  then
    return COMMAND_CHANGE_POS,CurrentIndex
  end
  --------------------------------------------
  -- Certain monsters are best normal summoned
  -- when the opponent controls Spells/Traps.
  --------------------------------------------
  for i=1,#SummonableCards do
    if SummonableCards[i].id == 71413901 then  -- Breaker
      if Get_Card_Count(OppST()) > 0 then
        GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SUMMON,i
      end
    end
  end

  --------------------------------------------
  -- Certain monsters are best normal summoned
  -- when the opponent controls Spells/Traps.
  --------------------------------------------
  for i=1,#SummonableCards do
    if SummonableCards[i].id == 71413901 or   -- Breaker
       SummonableCards[i].id == 22624373 then -- Lyla
      if Get_Card_Count(OppST()) > 0 then
        GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SUMMON,i
      end
    end
  end

  -------------------------------------------------------  
  -- Synchron Explorer should only be summoned when there
  -- is a Synchron tuner monster in the graveyard.
  -------------------------------------------------------
  for i=1,#SummonableCards do
    if SummonableCards[i].id == 36643046 then
      local AIGrave = AI.GetAIGraveyard()
      for x=1,#AIGrave do
        if IsSynchronTunerMonster(AIGrave[x].id) then
          GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		  return COMMAND_SUMMON,i
        end
      end
    end
  end

  -------------------------------------------------------  
  -- AI should summon Zaborg the Thunder Monarch only if
  -- player controls any monsters.
  -------------------------------------------------------
  for i=1,#SummonableCards do   
	if SummonableCards[i].id == 51945556 then -- Zaborg the Thunder Monarch.
	  if Get_Card_Count(AI.GetOppMonsterZones()) > 0 and AIMonCountLowerLevelAndAttack(SummonableCards[i].level,SummonableCards[i].attack) + GlobalAdditionalTributeCount >= 
	     AIMonGetTributeCountByLevel(SummonableCards[i].level) then
		 GlobalActivatedCardID = SummonableCards[i].id
         GlobalActivatedCardAttack = SummonableCards[i].attack
         GlobalActivatedCardLevel = SummonableCards[i].level
		 GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SUMMON,i
       end
     end
   end
  
  -------------------------------------------------------  
  -- AI should summon Lord of D. if he can use The Flute of Summoning Dragon
  -- to summon dragon type monster to the field.
  -------------------------------------------------------
  for i=1,#SummonableCards do   
	if SummonableCards[i].id == 17985575 then -- Lord of D.
     if Get_Card_Count_ID(UseLists({AIMon(),AIHand(),AIST()}), 43973174, nil) > 0 then -- The Flute of Summoning Dragon
        GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
	   return COMMAND_SUMMON,i
      end
    end
  end
  
  
  -------------------------------------------------------  
  -- AI should summon Winged Kuriboh if he
  -- has no monsters on field, and player has attack position monsters on field
  -------------------------------------------------------
  for i=1,#SummonableCards do   
	if SummonableCards[i].id == 57116033 then -- Winged Kuriboh
     if Get_Card_Count_Pos(OppMon(), POS_FACEUP) > 0 and Get_Card_Count(AIMon()) == 0 then
        GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
	   return COMMAND_SET_MONSTER,i
      end
    end
  end
  
  -------------------------------------------------------  
  -- AI should always summon "Summoner Monk" instead of setting.
  -------------------------------------------------------
  for i=1,#SummonableCards do   
	if SummonableCards[i].id == 00423585 then -- Summoner Monk
       GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SUMMON,i
       end
     end 

    
  -------------------------------------------------------  
  -- AI should summon "Exiled Force" if players
  -- strongest attack position monster has more attack points than AI's.
  -------------------------------------------------------
  for i=1,#SummonableCards do   
	if SummonableCards[i].id == 74131780 then -- Exiled Force
      if Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") > Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") and Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") >= 1900 then
		GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SUMMON,i
       end
     end
   end
  
  -------------------------------------------------------  
  -- AI should summon "Neo-Spacian Grand Mole" if player
  -- controls any level 4+ or XYZ type monsters.
  -------------------------------------------------------
  for i=1,#SummonableCards do   
	if SummonableCards[i].id == 80344569 then -- Neo-Spacian Grand Mole
     local OppMon = AI.GetOppMonsterZones() 
	  for x=1,#OppMon do
       if OppMon[x] ~= false then
		if OppMon[x].level > 4 or OppMon[x].rank > 0 then	
		 return COMMAND_SUMMON,i
         end
       end
     end
   end
 end
 
  -------------------------------------------------------
  -- Venus should be summoned if AI can bring out stronger monster to the field 
  -------------------------------------------------------
  for i=1,#SummonableCards do
    if SummonableCards[i].id == 64734921 then -- The Agent of Creation - Venus
      local AIHand = AIHand()
      local HandHighestATK = 0
      for x=1,#AIHand do
        if AIHand[x].attack > HandHighestATK then
         HandHighestATK = AIHand[x].attack       
        if AIHand[x].level >= 5 and
         HandHighestATK > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") then 
          if Get_Card_Count_ID(AIHand,39552864,nil) > 0 or   -- Mystical Shine Ball
             Get_Card_Count_ID(AIDeck(),39552864,nil) > 0 then -- Mystical Shine Ball                 
             GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
			return COMMAND_SUMMON,i
           end
         end
       end
     end
   end
 end
  -------------------------------------------------------
  -- *****************************************************
  --        General tribute summoning logic
  -- *****************************************************
  -------------------------------------------------------   
  ---------------------
  -- Summoning
  ---------------------
   for i=1,#SummonableCards do	  
	   CalculatePossibleSummonAttack(SummonableCards)
	   if SummonableCards[i].level >= 5 and NormalSummonBlacklist(SummonableCards[i].id) == 0 and 
	     (AIMonCountLowerLevelAndAttack(SummonableCards[i].level,SummonableCards[i].attack) + GlobalAdditionalTributeCount) >= AIMonGetTributeCountByLevel(SummonableCards[i].level) then
        if SummonableCards[i].type ~= TYPE_MONSTER + TYPE_EFFECT + TYPE_FLIP and 
          (SummonableCards[i].attack >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack") and
		   SummonableCards[i].attack > Get_Card_Att_Def(OppMon(), attack, ">", POS_FACEUP_ATTACK, defense)) or 
		   CanChangeOutcome(cards, SummonableCards, cards.activatable_cards) == 1 then   
		   GlobalActivatedCardLevel = SummonableCards[i].level
           GlobalActivatedCardAttack = SummonableCards[i].attack
		   GlobalSummonedCardID = SummonableCards[i].id
		   GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		   GlobalAdditionalTributeCount = GlobalAdditionalTributeCount-1
		  return COMMAND_SUMMON,i
        end
      end
    end
  ---------------------
  -- Setting
  ---------------------
   for i=1,#SummonableCards do
       CalculatePossibleSummonAttack(SummonableCards)
	   if SummonableCards[i].level >= 5 and NormalSummonBlacklist(SummonableCards[i].id) == 0 and
	      AIMonCountLowerLevelAndAttack(SummonableCards[i].level,SummonableCards[i].attack) >= AIMonGetTributeCountByLevel(SummonableCards[i].level) then
         if SummonableCards[i].type == TYPE_MONSTER + TYPE_EFFECT + TYPE_FLIP or 
           (SummonableCards[i].attack < Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack") and 
		    SummonableCards[i].defense >= Get_Card_Att_Def(AIMon(),"attack",">",POS_FACEUP,"attack")) and 
		    CanChangeOutcome(cards, SummonableCards, cards.activatable_cards) == 0 then   
		    GlobalActivatedCardLevel = SummonableCards[i].level
            GlobalActivatedCardAttack = SummonableCards[i].attack
		    GlobalSummonedCardID = SummonableCards[i].id
		    GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		    GlobalAdditionalTributeCount = GlobalAdditionalTributeCount-1
		   return COMMAND_SET_MONSTER,i
         end
       end   
	 end 

  -------------------------------------------------------
  -- *****************************************************
  --       General normal summoning and setting logic 
  -- *****************************************************
  -------------------------------------------------------   

      
	-----------------------------------------------------------------------
  -- Check if monster isn't of a flip effect type, and has more attack points
  -- than player's strongest monster, or if any actions can be taken to increase strength of summonable monster,
	-- or if any XYZ monsters can be special summoned as result, and Summon or Set monster depending on result.
	-----------------------------------------------------------------------
  for i=1,#SummonableCards do
    local c = SummonableCards[i]
	  if NormalSummonBlacklist(c.id) == 0 
    and not FilterType(c,TYPE_FLIP)
    and c.level < 5 
    and c.id ~= 31305911          -- Marshmallon
    and c.id ~= 23205979          -- Spirit Reaper
    and c.id ~= 62892347          -- A.F. The Fool
    and c.id ~= 12538374          -- Treeborn Frog
    and c.id ~= 15341821          -- Dandylion
    and c.id ~= 41872150          -- Locusts
    and c.defense-c.attack < 1000
    and c.attack >= 1000 
    and (c.attack >= Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP,"attack")
    or CanChangeOutcome(cards, SummonableCards, cards.activatable_cards) == 1 )
    or NormalSummonWhitelist(c.id) == 1
    then
      GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
      return COMMAND_SUMMON,i
    end
  end
  
  -- force a synchro or xyz summon, if AI still controls Norden and a target
  if TurnEndCheck()
  and HasID(AIMon(),17412721,true)
  then
    local norden = FindID(17412721,AIMon())
    local target = nil
    if CardTargetCheck(norden) then
      target = GetCardFromScript(GetScriptFromCard(norden):GetCardTarget():GetFirst())
    end
    if target and FilterTuner(target) then
      for i,c in pairs(SpSummonableCards) do
        if FilterType(c,TYPE_SYNCHRO) 
        and FilterLevel(c,norden.level+target.level)
        then
          GlobalMaterial = true
          GlobalSSCardID = c.id
          return COMMAND_SPECIAL_SUMMON,i
        end
      end
    end
    if target and FilterLevel(target,4) then
      for i,c in pairs(SpSummonableCards) do
        if FilterType(c,TYPE_XYZ) 
        and FilterRank(c,4)
        then
          GlobalMaterial = true
          GlobalSSCardID = c.id
          return COMMAND_SPECIAL_SUMMON,i
        end
      end
    end
  end
       
  
  ---------------------------------------------------
  -- If an in-hand monster has a flip effect, set it.
  ---------------------------------------------------
  if #cards.monster_setable_cards > 0 then
    for i=1,#cards.monster_setable_cards do
      if cards.monster_setable_cards[i].level < 5 and cards.monster_setable_cards[i].type == TYPE_MONSTER + TYPE_EFFECT + TYPE_FLIP
      and NormalSummonBlacklist(cards.monster_setable_cards[i].id) == 0
      then
        GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SET_MONSTER,i
      end
    end
  end
  
  --------------------------------------
  -- If it gets this far, set a monster.
  --------------------------------------
  -- if Get_Card_Count(AIMon()) == 0 then -- AI was limited to set monster only when he had none, instead of building up defense, why ?
    for i=1,#cards.monster_setable_cards do
      if NormalSummonBlacklist(cards.monster_setable_cards[i].id) == 0 then
       if cards.monster_setable_cards[i].level < 5 then
		  GlobalSummonedThisTurn = GlobalSummonedThisTurn+1
		return COMMAND_SET_MONSTER,i
      end
    end
  end
 
-------------------------------------------------
-- **********************************************
--         Card position changing :)
-- **********************************************
-------------------------------------------------

  --------------------------------------------------
  -- Flip any "Toon" monster to attack position if AI
  -- controls "Toon World" or "Toon Kingdom".
  --------------------------------------------------
  for i=1,#RepositionableCards do  
   if RepositionableCards[i] ~= false then
    if isToonUndestroyable(RepositionableCards) == 1 then 
	  if RepositionableCards[i].position == POS_FACEUP_DEFENSE or
         RepositionableCards[i].position == POS_FACEDOWN_DEFENSE then   
	   return COMMAND_CHANGE_POS,i
       end 
     end
   end 
 end  
  
  --------------------------------------------------
  -- Always change "Maiden with Eyes of Blue" to
  -- attack position if possible.
  --------------------------------------------------
  for i=1,#RepositionableCards do  
   if RepositionableCards[i] ~= false then
    if (RepositionableCards[i].id == 88241506 or RepositionableCards[i].id == 15914410) -- Maiden with Eyes of Blue, Mechquipped Angineer
    and RepositionableCards[i].position == POS_FACEUP_DEFENSE then
	   return COMMAND_CHANGE_POS,i
       end 
     end
   end 
  
  --------------------------------------------------
  -- If AI's monster has less attack than the
  -- opponent's strongest monster, turn it to defense position 
  -- in MP2.
  --------------------------------------------------
  for i=1,#RepositionableCards do	  
  local c = RepositionableCards[i]
    if FilterPosition(c,POS_ATTACK)
    and RepositionBlacklist(c.id) == 0 	
    then
      local ChangePosOK = false
      if c.attack < Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP_ATTACK,"attack")
      and (Duel.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed)
      or FilterAffected(c,EFFECT_CANNOT_ATTACK)
      or FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
      then
        ChangePosOK = true
      end
      if ChangePosOK and (c.attack >= 1500 and c.defense >= c.attack
      or c.attack < 1500 and c.defense-c.attack <= 200
      or c.defense-c.attack >= 0)
      or c.attack < 1000 
      or c.defense-c.attack >= 500
      then
        return COMMAND_CHANGE_POS,i
      end
    end
  end
  
 --------------------------------------------------
 -- If the AI controls a monster with higher attack,
 -- than any of the opponent's monsters, 
 -- and opponent controls one or less monsters in attack position, 
 -- turn as many monsters as we can to attack position.
 --------------------------------------------------  
  local ChangePosOK = false
  for i=1,#AIMon() do
    local c=AIMon()[i]
    if c.attack > Get_Card_Att_Def(OppMon(),"attack",">",POS_FACEUP_ATTACK,"attack") 
    and c.attack > Get_Card_Att_Def(OppMon(),"defense",">",POS_FACEUP_DEFENSE,"defense") 
    and Duel.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed
    then
      ChangePosOK = true
    end
  end
  for i=1,#RepositionableCards do
    local c = RepositionableCards[i]
    if FilterPosition(c,POS_DEFENSE)
    and RepositionBlacklist(c.id)==0
    and (ChangePosOK and c.attack > 1000 and c.defense-c.attack < 500
    and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
    and not FilterAffected(c,EFFECT_CANNOT_ATTACK_ANNOUNCE)
    or c.attack >= 1500 and c.attack > c.defense)
    then
      return COMMAND_CHANGE_POS,i
    end
  end

-------------------------------------------------
-- **********************************************
--         Spell and trap card setting :|
-- **********************************************
-------------------------------------------------
  
  ---------------------------------------------------------
  -- Set trap and quick-play cards in Main Phase 2, 
  -- or if it's the first turn of the duel.
  ---------------------------------------------------------
  if #cards.st_setable_cards > 0 and (AI.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed) then
    local setCards = cards.st_setable_cards
    local setThisTurn = 0
    local aist=AIST()
    for i=1,#aist do
      if bit32.band(aist[i].status,STATUS_SET_TURN)>0 then
        setThisTurn=setThisTurn+1
      end
    end
    for i=1,#setCards do
      if (setThisTurn < 3 or DeckCheck(DECK_HAT)) and #AIST()<4
      and SetBlacklist(setCards[i].id)==0 
      and (bit32.band(setCards[i].type,TYPE_TRAP) > 0 
      or bit32.band(setCards[i].type,TYPE_QUICKPLAY) > 0 )
      and not HasID(AIST(),92512625,true) 
      and DiscardCheck()
      then
        return COMMAND_SET_ST,i
      end
    end
  end

  -------------------------------------------------------
  -- Set spell cards as a bluff if the AI has no backrow.
  -- Should obviously only do this if the AI doesn't have
  -- Treeborn Frog in the Graveyard or on the field, or
  -- if the AI has Gorz in hand.
  -------------------------------------------------------
  if not HasID(AIHand(),44330098,true) -- Gorz
  and not HasID(UseLists(AIMon(),AIGrave()),12538374, nil) -- Treeborn Frog
  and (AI.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed)
  then
    for i=1,#cards.st_setable_cards do
      local c = cards.st_setable_cards[i]
      if FilterType(c,TYPE_SPELL) and not FilterType(c,TYPE_FIELD)
      and SetBlacklist(c.id)==0 and Get_Card_Count(AIST()) < 2
      and not HasID(AIST(),92512625,true) -- Solemn Advice
      and DiscardCheck()
      then
        return COMMAND_SET_ST,i
      end
    end
  end
  
  if (Duel.GetCurrentPhase() == PHASE_MAIN2 or not GlobalBPAllowed)
  and #AIHand()+EPAddedCards()>6 and #cards.st_setable_cards > 0 
  then
    return COMMAND_SET_ST,1
  end

  ----print("DECISION: go to next phase")
  ------------------------------------------------------------
  -- Proceed to the next phase, and let AI write epic line in chat
  ------------------------------------------------------------
  -- there should be check here to see if the next phase is disallowed (like Karakuri having to attack)  I'm too lazy to make it right now, sorry. :*	
	return COMMAND_TO_NEXT_PHASE,1
end

