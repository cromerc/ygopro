--[[
91501248, -- Pot of the Forbidden
03717252, -- Shaddoll Beast
67503139, -- Prediction Princess Crystaldine
77723643, -- Shaddoll Dragon
30328508, -- Shaddoll Squamata
26517393, -- Spirit of the Tailwind
95492061, -- Manju
31118030, -- Prediction Princess Arrowsylph
32231618, -- Prediction Princess Coinorma
04939890, -- Shaddoll Hedgehog
37445295, -- Shaddoll Falcon
97268402, -- Effect Veiler
94997874, -- Prediction Princess Tarotray

01845204, -- Instant Fusion
13048472, -- Pre-Preparation of Rites
44394295, -- Shaddoll Fusion
81439173, -- Foolish Burial
30392583, -- Prediction Ritual
06417578, -- El-Shaddoll Fusion
43898403, -- Twin Twister
04904633, -- Shaddoll Core
84749824, -- Solemn Warning

74822425, -- El-Shaddoll Shekinaga
19261966, -- El-Shaddoll Anoyatilis
94977269, -- El-Shaddoll Winda
17412721, -- Elder God Norden
52687916, -- Trishula
74586817, -- Omega
82044279, -- Clear Wing
95113856, -- Enterblathnir
56832966, -- Utopia Lightning
84013237, -- Utopia
63746411, -- Giant Hand
82633039, -- Castel
00581014, -- Emeral
]]
function ShaddollStartup(deck)
  deck.Init                 = ShaddollInit
  deck.Card                 = ShaddollCard
  deck.Chain                = ShaddollChain
  deck.EffectYesNo          = ShaddollEffectYesNo
  deck.Position             = ShaddollPosition
  deck.YesNo                = ShaddollYesNo
  deck.BattleCommand        = ShaddollBattleCommand
  deck.AttackTarget         = ShaddollAttackTarget
  deck.AttackBoost          = ShaddollAttackBoost
  deck.Tribute				      = ShaddollTribute
  deck.Option               = ShaddollOption
  deck.ChainOrder           = ShaddollChainOrder
  deck.Sum                  = ShaddollSum
  --[[
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = ShaddollActivateBlacklist
  deck.SummonBlacklist      = ShaddollSummonBlacklist
  deck.RepositionBlacklist  = ShaddollRepoBlacklist
  deck.SetBlacklist		      = ShaddollSetBlacklist
  deck.Unchainable          = ShaddollUnchainable
  --[[
  
  ]]
  deck.PriorityList         = ShaddollPriorityList
  
end

ShaddollIdentifier = 94997874 -- Prediction Princess Tarotray

DECK_SHADDOLL = NewDeck("Shaddoll",ShaddollIdentifier,ShaddollStartup) 


ShaddollActivateBlacklist={
91501248, -- Pot of the Forbidden
03717252, -- Shaddoll Beast
67503139, -- Prediction Princess Crystaldine
77723643, -- Shaddoll Dragon
30328508, -- Shaddoll Squamata
95492061, -- Manju
31118030, -- Prediction Princess Arrowsylph
32231618, -- Prediction Princess Coinorma
04939890, -- Shaddoll Hedgehog
37445295, -- Shaddoll Falcon
--97268402, -- Effect Veiler
94997874, -- Prediction Princess Tarotray

01845204, -- Instant Fusion
13048472, -- Pre-Preparation of Rites
44394295, -- Shaddoll Fusion
81439173, -- Foolish Burial
30392583, -- Prediction Ritual
06417578, -- El-Shaddoll Fusion
--43898403, -- Twin Twister
04904633, -- Shaddoll Core
--84749824, -- Solemn Warning

--74822425, -- El-Shaddoll Shekinaga
19261966, -- El-Shaddoll Anoyatilis
94977269, -- El-Shaddoll Winda
17412721, -- Elder God Norden
74009824, -- El-Shaddoll Wendigo
--[[52687916, -- Trishula
74586817, -- Omega
82044279, -- Clear Wing
95113856, -- Enterblathnir
56832966, -- Utopia Lightning
84013237, -- Utopia
63746411, -- Giant Hand
82633039, -- Castel
00581014, -- Emeral]]
}
ShaddollSummonBlacklist={
91501248, -- Pot of the Forbidden
03717252, -- Shaddoll Beast
67503139, -- Prediction Princess Crystaldine
77723643, -- Shaddoll Dragon
30328508, -- Shaddoll Squamata
26517393, -- Spirit of the Tailwind
95492061, -- Manju
31118030, -- Prediction Princess Arrowsylph
32231618, -- Prediction Princess Coinorma
04939890, -- Shaddoll Hedgehog
37445295, -- Shaddoll Falcon
97268402, -- Effect Veiler
94997874, -- Prediction Princess Tarotray

01845204, -- Instant Fusion
13048472, -- Pre-Preparation of Rites
44394295, -- Shaddoll Fusion
81439173, -- Foolish Burial
30392583, -- Prediction Ritual
06417578, -- El-Shaddoll Fusion
43898403, -- Twin Twister
04904633, -- Shaddoll Core
84749824, -- Solemn Warning

74822425, -- El-Shaddoll Shekinaga
19261966, -- El-Shaddoll Anoyatilis
94977269, -- El-Shaddoll Winda
17412721, -- Elder God Norden
52687916, -- Trishula
--74586817, -- Omega
--82044279, -- Clear Wing
95113856, -- Enterblathnir
--56832966, -- Utopia Lightning
--84013237, -- Utopia
--63746411, -- Giant Hand
--82633039, -- Castel
--00581014, -- Emeral
}
ShaddollSetBlacklist={
13048472, -- Pre-Preparation of Rites
30392583, -- Prediction Ritual
06417578, -- El-Shaddoll Fusion
}
ShaddollRepoBlacklist={
91501248, -- Pot of the Forbidden
}
ShaddollUnchainable={
06417578, -- El-Shaddoll Fusion
}
function ShaddollFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0x9d) and check
end
function PerformageFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xc6) and check
end
function PredictionPrincessFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xcc) and check
end
function ShaddollMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and ShaddollFilter(c,exclude)
end
function ShaddollSTFilter(c,exclude)
  return FilterType(c,TYPE_SPELL+TYPE_TRAP)
  and ShaddollFilter(c,exclude)
end
ShaddollFusions = {44394295,06417578,60226558}
function ShaddollHasFusion(useable)
  local cards=AICards()
  local result = false
  if useable~=nil then 
    useable = DualityCheck() and (WindaCheck() or not SpecialSummonCheck())
  end
  for i=1,#cards do
    local c = cards[i]
    for j=1,#ShaddollFusions do
      local id = ShaddollFusions[j]
      if c.id == id then
        if useable~=nil then 
          result = useable and OPTCheck(id)
        else
          result = true
        end
      end
    end
  end
  return result  
end
function PerformageMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and PerformageFilter(c,exclude)
end
function ElFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),06417578,true,OPTCheck,c.id)
  end
  return true
end
function ShaddollFusionCond(loc,c)
  if loc == PRIO_TOHAND then
    if not HasID(AICards(),44394295,true,OPTCheck,c.id) then
      if CardsMatchingFilter(OppMon(),ShaddollFusionFilter)>0 then
        return 10
      end
      return true
    end
  end
  return true
end
function SendToGraveFilter(c,id)
   return c.id == id 
  and c.turnid == Duel.GetTurnCount()
end
function ShaddollGraveCheck(id)
  return CardsMatchingFilter(AIGrave(),SendToGraveFilter,id)==0
end
function FalconCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(c.id) 
    and GetMultiple(c.id)==0 
    and (not HasID(AIMon(),c.id,true)
    or FilterLocation(c,LOCATION_MZONE))
    and ShaddollGraveCheck(c.id)
    and not (FilterLocation(c,LOCATION_DECK)
    and HasID(AICards(),c.id,true))
  end
  return true
end
function HatCheck()
  return (HasID(AIHand(),31292357,true) 
  or HasID(AIGrave(),68819554,true,OPTCheck,68819554)
  and HasID(AIDeck(),31292357,true))
  and #AllMon()>1
  and DualityCheck()
  and WindaCheck()
end
function HedgehogCond(loc)
  if loc == PRIO_TOGRAVE then
    if OPTCheck(04939890) 
    and GetMultiple(04939890)==0
    and ShaddollGraveCheck(04939890)
    then
      if CardsMatchingFilter(AICards(),ShaddollMonsterFilter)==0
      and ShaddollHasFusion(true)
      or not NormalSummonCheck()
      and (FieldCheck(4)==1
      or HatCheck())
      then
        return 8.5
      end
    end
  end
  return true
end

function SquamataCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return (OPTCheck(c.id) 
    and (HasID(AIGrave(),44394295,true) 
    and HasID(AIDeck(),04904633,true)
    or CardsMatchingFilter(AIGrave(),ShaddollMonsterFilter)<6)
    and not HasID(AIMon(),c.id,true,nil,nil,POS_FACEDOWN_DEFENSE,OPTCheck,c.id)
    and GetMultiple(c.id)==0)
    and ShaddollGraveCheck(c.id)
  end
  return true
end
function DragonFilter(c)
  return DestroyFilterIgnore(c)
end
function DragonCond(loc)
  if loc == PRIO_TOGRAVE then
    if OPTCheck(77723643) 
    and CardsMatchingFilter(OppST(),DragonFilter)>0 
    and GetMultiple(77723643)==0
    and ShaddollGraveCheck(77723643)
    and MacroCheck()
    then
      if HasPriorityTarget(OppST(),true,nil,DragonFilter) then
        return 11
      end
      return true
    end
    return false
  end
  return true
end
function BeastCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(03717252) 
    and GetMultiple(03717252)==0
    and ShaddollGraveCheck(03717252)
  end
  return true
end
function ConstructFilter(c)
  return bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)>0
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 
  and Affected(c,TYPE_MONSTER,8)
end
function ConstructCond(loc)
  if loc == PRIO_TOFIELD then
    return (OppGetStrongestAttack() < 2800 
    or HasID(AIMon(),94977269,true)
    or CardsMatchingFilter(OppMon(),ConstructFilter)>0
    or CardsMatchingFilter(AICards(),FilterLightFodder)
    or DeckFuseCheck())
    and not HasID(AIMon(),20366274,true)
  end
  return true
end
function WindaCond(loc)
  if loc == PRIO_TOFIELD then
    return (OppGetStrongestAttack() < 2200 
    or not OppHasStrongestMonster())
    and not HasID(AIMon(),94977269,true)
  end
  return true
end
function CoreCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return (NeedsCard(44394295,AIGrave(),AICards(),true) 
    and not ShaddollHasFusion())
    or NeedsCard(06417578,AIGrave(),AICards(),true) 
    or FilterLocation(c,LOCATION_MZONE)
  end
  return true
end
function FelisCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return true
  end
  return true
end
function MathCond(loc,c)
  return true
end
function ShekinagaCond(loc,c)
  return true
end
function EgrystalCond(loc,c)
  return true
end
function FusionFodder(c,attribute)
  return FilterAttribute(c,attribute)
  and not FilterID(c,72989439) -- BLS
  and not FilterID(c,97268402) -- Veiler
  and not (ShaddollMonsterFilter(c) and FilterType(c,TYPE_FUSION))
end
function ClownCond(loc,c)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AICards(),LightFodder)==0
  end
  if loc == PRIO_TOFIELD then
    return FilterLocation(c,LOCATION_GRAVE)
  end
  if loc == PRIO_TOGRAVE then 
    if OPTCheck(c.id) 
    and (Duel.GetLocationCount(player_ai,LOCATION_MZONE)>2
    or FilterLocation(c,LOCATION_MZONE))
    and (AI.GetPlayerLP(1)>1800 
    or HasIDNotNegated(AIMon(),17016362,true,FilterAttackMin,1001))
    then
      if ShaddollHasFusion(true)
      and CardsMatchingFilter(AICards(),ShaddollMonsterFilter)>0
      and CardsMatchingFilter(AICards(),FusionFodder,ATTRIBUTE_LIGHT)==0
      --and not SummonConstruct()
      then
        return 10
      end
      return true
    end
  end
  return true
end
function JugglerFilter(c,attribute)
  return PerformageFilter(c)
  and (not attribute or FilterAttribute(c,attribute))
end
function JugglerCond(loc,c)
  if loc == PRIO_TOGRAVE then 
    if OPTCheck(c.id) 
    and not HasID(AIGrave(),c.id,true)
    then
      if ShaddollHasFusion(true)
      and CardsMatchingFilter(AICards(),ShaddollMonsterFilter)>0
      and CardsMatchingFilter(AICards(),FusionFodder,ATTRIBUTE_LIGHT)==0
      and CardsMatchingFilter(AIDeck(),JugglerFilter,ATTRIBUTE_LIGHT)>0
      --and not SummonConstruct()
      then
        return 11
      end
      return true
    end
  end
  return true
end
function HatCond(loc,c)
  if loc == PRIO_TOHAND then
    return FieldCheck(4)==1 
    and (#AllMon()>1 or not NormalSummonCheck())
    or CardsMatchingFilter(AIHand(),FilterLevel,4)>0
    and not NormalSummonCheck() and #AllMon()>0
  end
  return true
end
function PotCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id)
    --[[and (HasIDNotNegated(AIMon(),94997874,true)
    or ]]
  end
  if loc == PRIO_TOGRAVE then
    return not HasAccess(c.id)
    or FilterLocation(c,LOCATION_HAND)
    --[[and (HasIDNotNegated(AIMon(),94997874,true)
    or ]]
  end
  if loc == PRIO_TOFIELD then
    return not HasID(AIMon(),c.id,true)
  end
  return true
end
function TarotrayCond(loc,c)
  if loc == PRIO_TOHAND 
  then
    return CardsMatchingFilter(AIHand(),FilterID,c.id)==0
    or HasID(AIHand(),c.id,true,SummonTarotray,1)
    and not (HasID(AIHand(),c.id,true,TarotrayTributeCheck) and FieldCheck(4)==0)
  end
  return true
end
function PredictionRitualCond(loc,c)
  if loc == PRIO_TOHAND 
  then
    return CardsMatchingFilter(AICards(),FilterID,c.id)==0
  end
  if loc == PRIO_TOGRAVE
  then
    return CardsMatchingFilter(AICards(),FilterID,c.id)>1
  end
  return true
end
ShaddollPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Shaddoll

[37445295] = {3,3,3,1,7,1,5,1,1,1,FalconCond},        -- Shaddoll Falcon
[04939890] = {5,2,2,1,5,2,8,4,1,1,HedgehogCond},      -- Shaddoll Hedgehog
[30328508] = {4,1,5,1,9,1,9,1,1,1,SquamataCond},      -- Shaddoll Squamata
[77723643] = {3,1,4,1,7,1,6,1,1,1,DragonCond},        -- Shaddoll Dragon
[03717252] = {4,1,6,1,6,1,7,1,1,1,BeastCond},         -- Shaddoll Beast

[97268402] = {1,1,1,1,2,1,1,1,1,1},                   -- Effect Veiler

[44394295] = {8,5,1,1,1,1,1,1,1,1,ShadFusionCond},    -- Shaddoll Fusion
[06417578] = {9,6,1,1,1,1,1,1,1,1,ElFusionCond},      -- El-Shaddoll Fusion
[04904633] = {4,2,1,1,8,1,8,1,1,1,CoreCond},          -- Shaddoll Core

[60226558] = {7,4,1,1,1,1,1,1,1,1,NephFusionCond},    -- Nepheshaddoll Fusion
[77505534] = {3,1,1,1,1,1,1,1,1,1},                   -- Shadow Games

[01845204] = {1,1,1,1,1,1,1,1,1,1},                   -- Instant Fusion
[12580477] = {1,1,1,1,1,1,1,1,1,1},                   -- Raigeki
[81439173] = {1,1,1,1,1,1,1,1,1,1},                   -- Foolish Burial
[14087893] = {1,1,1,1,1,1,1,1,1,1},                   -- Book of Moon
[29401950] = {1,1,1,1,1,1,1,1,1,1},                   -- Bottomless Trap Hole
[29616929] = {1,1,1,1,1,1,1,1,1,1},                   -- Traptrix Trap Hole Nightmare
[53582587] = {1,1,1,1,1,1,1,1,1,1},                   -- Torrential Tribute
[78474168] = {1,1,1,1,1,1,1,1,1,1},                   -- Breakthrough Skill
[05851097] = {1,1,1,1,1,1,1,1,1,1},                   -- Vanity's Emptiness

[31118030] = {1,1,1,1,1,1,1,1,1,1,},                  -- Prediction Princess Arrowsylph
[67503139] = {1,1,1,1,1,1,1,1,1,1,},                  -- Prediction Princess Crystaldine
[32231618] = {1,1,1,1,1,1,1,1,1,1,},                  -- Prediction Princess Coinorma
[94997874] = {6,1,1,1,1,1,1,1,1,1,TarotrayCond},      -- Prediction Princess Tarotray
[30392583] = {7,2,1,1,4,2,1,1,1,1,PredictionRitualCond}, -- Prediction Ritual

[91501248] = {6,1,9,1,10,5,1,1,1,1,PotCond},           -- Pot of the Forbidden
[26517393] = {1,1,1,1,1,1,1,1,1,1,},                  -- Spirit of the Tailwind
[95492061] = {1,1,1,1,1,1,1,1,1,1,},                  -- Manju

[20366274] = {1,1,7,4,2,1,2,1,1,1,ConstructCond},     -- El-Shaddoll Construct
[94977269] = {1,1,5,3,2,1,2,1,1,1,WindaCond},         -- El-Shaddoll Winda
[74822425] = {1,1,6,1,2,1,1,1,1,1,ShekinagaCond},     -- El-Shaddoll Shekinaga
[19261966] = {1,1,4,1,4,1,1,1,1,1,AnoyatilisCond},    -- El-Shaddoll Anoyatilis

[48424886] = {1,1,3,1,1,1,1,1,1,1,EgrystalCond},      -- El-Shaddoll Egrystal
[74009824] = {1,1,2,1,1,1,1,1,1,1},                   -- El-Shaddoll Wendigo

[52687916] = {1,1,1,1,3,1,1,1,1,1},                   -- Trishula
[17016362] = {1,1,1,1,1,1,1,1,1,1},                   -- Trapeze Magician
[82633039] = {1,1,1,1,6,1,1,1,1,1,CastelCond},        -- Skyblaster Castel
[00581014] = {1,1,1,1,1,1,1,1,1,1},                   -- Daigusto Emeral
[00581014] = {1,1,1,1,1,1,1,1,1,1},                   -- Emeral
[21044178] = {1,1,1,1,1,1,1,1,1,1},                   -- Dweller
[06511113] = {1,1,1,1,1,1,1,1,1,1},                   -- Rafflesia
} 
function ShaddollFusionFilter(c)
  return c and c.summon_type and c.previous_location
  and bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
  and bit32.band(c.previous_location,LOCATION_EXTRA)==LOCATION_EXTRA
end
function WindaCheck()
  -- returns true, if there is no Winda on the field
  return not HasIDNotNegated(AllMon(),94977269,true)
end
function FilterAttributeFusion2(c,params)
  local othercard=params[1]
  local prio=params[2]
  return ShaddollMonsterFilter(c,othercard)
  and (not prio or c.prio>=prio)
end
function FilterAttributeFusion(c,attribute,cards,prio)
  return FilterAttribute(c,attribute) 
  and CardsMatchingFilter(cards,FilterAttributeFusion2,{c,prio})>0
  and (not prio or c.prio>=prio)
end 
function CanFusionAttribute(spell,attribute,targets)
  -- no target -> can fusion in general from available cards
  -- 1 target -> can fusion using that target and any other card
  -- 2 or more targets -> can fusion from only the targets
  local cards = AICards()
  if spell == nil then
    if HasIDNotNegated(AICards(),60226558,true,OPTCheck,60226558) then
      spell = 3
    end
    if HasIDNotNegated(AICards(),06417578,true,OPTCheck,06417578) then
      spell = 2
    end
    if HasIDNotNegated(AICards(),44394295,true,OPTCheck,44394295) then
      spell = 1
    end
  end
  if spell == 1 and DeckFuseCheck then
    cards = UseLists(AICards(),AIDeck())
  end
  if not prio then
    prio = 3
  end
  if targets then
    if targets.id then
      targets = {targets}
    elseif #targets>1 then
      cards=targets
    end
  else
    targets = cards
  end
  local result = false
  AssignPriority(targets,PRIO_TOGRAVE)
  for i=1,#targets do
    local c = targets[i]
    if FilterAttributeFusion(c,attribute,targets,prio) then
      result = true
    end
  end
  return result
end
function CanFusionWinda(spell,targets,prio)
  if HasID(AIExtra(),94977269,true)
  and CanFusionAttribute(spell,ATTRIBUTE_DARK,targets,prio)
  and DualityCheck()
  then
    return true
  end
  return false
end
function CanFusionConstruct(spell,targets,prio)
  if HasID(AIExtra(),20366274,true)
  and CanFusionAttribute(spell,ATTRIBUTE_LIGHT,targets,prio)
  and DualityCheck()
  then
    return true
  end
  return false
end
function CanFusionShekinaga(spell,targets,prio)
  if HasID(AIExtra(),20366274,true)
  and CanFusionAttribute(spell,ATTRIBUTE_EARTH,targets,prio)
  and DualityCheck()
  then
    return true
  end
  return false
end
function CanFusionAnoyatilis(spell,targets,prio)
  if HasID(AIExtra(),20366274,true)
  and CanFusionAttribute(spell,ATTRIBUTE_WATER,targets,prio)
  and DualityCheck()
  then
    return true
  end
  return false
end

function DeckFuseCheck()
  return CardsMatchingFilter(OppMon(),ShaddollFusionFilter)>0
end
--[[function UseShaddollFusion()
  if HasID(AIMon(),94977269,true) and HasID(AIMon(),20366274,true) then return false end
  return OverExtendCheck()
  and (PriorityCheck(AICards(),PRIO_TOGRAVE,2,ShaddollMonsterFilter)>2
  and not HasID(AIMon(),94977269,true)
  or PriorityCheck(AICards(),PRIO_TOGRAVE,1,ShaddollMonsterFilter)>2
  and PriorityCheck(AICards(),PRIO_TOGRAVE,1,ArtifactFilter)>2
  and not HasID(AIMon(),20366274,true)
  or CardsMatchingFilter(OppMon(),ShaddollFusionFilter)>0)
end]]
function UseCore(c,mode)
  if mode==1 
  and ShaddollHasFusion()
  and WindaCheck()
  then
    return true
  end
  if mode==2
  and HasIDNotNegated(AICards(),30392583,true)
  and HasID(AIHand(),94997874,true,SummonTarotray,1)
  and not HasID(AICards(),91501248,true)
  then
    return true
  end
  if mode==3
  and HasIDNotNegated(AIExtra(),95113856,true,SummonEnterblathnir)
  and (HasIDNotNegated(AIMon(),94997874,true) and FieldCheck(9)>1
  or not HasIDNotNegated(AIMon(),94997874,true) and  FieldCheck(9)>0)
  then
    return true
  end
end
function DruFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_DARK)>0 and c.level==4 and (c.attack==0 or c.defense==0)
end
function SummonDru()
  return CardsMatchingFilter(AIGrave(),DruFilter)>0 and WindaCheck() 
  and (SummonSkyblaster() or SummonEmeral())
end
function FalconFilter2(c)
  return bit32.band(c.attribute,ATTRIBUTE_LIGHT)>0 and c.level==5 and bit32.band(c.position,POS_FACEUP)>0
end
function FalconFilter3(c)
  return bit32.band(c.race,RACE_SPELLCASTER)>0 and c.level==5 and bit32.band(c.position,POS_FACEUP)>0
end
function SummonFalcon(c)
  return (SummonMichael(FindID(04779823,AIExtra())) 
  and CardsMatchingFilter(AIMon(),FalconFilter2)>0 
  or SummonArcanite() and CardsMatchingFilter(AIMon(),FalconFilter3)>0 
  or SummonArmades(FindID(88033975,AIExtra())) and FieldCheck(3)>0)
  and (WindaCheck() or not SpecialSummonCheck(player_ai))
  and not HasID(AIMon(),c.id,true)
end
function SetFalcon()
  return TurnEndCheck() 
  and (CardsMatchingFilter(AIGrave(),FalconFilter)>0 
  or HasID(AIST(),77505534,true)
  or HasID(AIHand(),77505534,true) and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>1)
  and not HasID(AIMon(),37445295,true)
end
function SummonDragon()
  return Duel.GetTurnCount()>1 and not OppHasStrongestMonster() and OverExtendCheck(3) 
  or FieldCheck(4) == 1 and (SummonSkyblaster() or SummonEmeral())
end
function SetDragon()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2) 
  and not HasID(AIMon(),37445295,true) and OverExtendCheck()
end
function SummonHedgehog()
  return HasID(AIMon(),37445295,true,nil,nil,POS_FACEUP) 
  and SummonArmades(FindID(88033975,AIExtra()))
end
function SetHedgehog()
  return TurnEndCheck() and not HasID(AIMon(),04939890,true) 
  and OverExtendCheck(3)
end
function SummonSquamata()
  return Duel.GetTurnCount()>1 and not OppHasStrongestMonster() and OverExtendCheck(3) 
  or FieldCheck(4) == 1
end
function SetSquamata()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  and not HasID(AIMon(),37445295,true) and OverExtendCheck()
end
function SummonBeast()
  return false
end
function SetBeast()
  return false
end
function SetShadowGames()
  return Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2 
  and not HasIDNotNegated(AIST(),77505534,true)
end
function SummonShaddollFusion(spell,prio)
  return SummonConstruct(spell,prio) 
    or SummonAnoyatilis(spell,prio)
    or SummonWinda(spell,prio)
    or SummonShekinaga(spell,prio)
end
function SummonConstruct(spell,prio)
  return CanFusionConstruct(spell,nil,prio)
  and not HasIDNotNegated(AIMon(),20366274,true)
end
function SummonWinda(spell,prio)
  return CanFusionWinda(spell,nil,prio)
  and not HasIDNotNegated(AIMon(),94977269,true)
end
function SummonShekinaga(spell,prio)
  return CanFusionShekinaga(spell,nil,prio)
  and not HasIDNotNegated(AIMon(),74822425,true)
end
function SummonAnoyatilis(spell,prio)
  return CanFusionAnoyatilis(spell,nil,prio)
  and not HasIDNotNegated(AIMon(),19261966,true)
  and MatchupCheck(19261966)
end
function UseShaddollFusion(c,mode)
  if mode == 1 then
    if CardsMatchingFilter(OppMon(),ShaddollFusionFilter)>0 
    then
      if SummonShaddollFusion(1) then
        OPTSet(c.id)
        return true
      end
    end
  end
  if mode == 2 then
    if SummonShaddollFusion(1) 
    and OverExtendCheck(3)
    then
      OPTSet(c.id)
      return true
    end
  end
  if mode == 3 then
    if SummonConstruct(1,2)
    and OverExtendCheck(3)
    then
      OPTSet(c.id)
      return true
    end
  end
  return false
end
function UseElFusion(c,mode)
  if mode == 1 then
    if SummonShaddollFusion(2) 
    and OverExtendCheck(3)
    then
      OPTSet(c.id)
      return true
    end
  end
  if mode == 2 then
    if SummonConstruct(1,2)
    and OverExtendCheck(3)
    then
      OPTSet(c.id)
      return true
    end
  end
  return false
end
function SummonMathShaddoll(c)
  return true
end
function FalconFilter(c)
  return ShaddollMonsterFilter(c,37445295)
end
function UseFalcon()
  return OPTCheck(37445295) and PriorityCheck(AIGrave(),PRIO_TOFIELD,1,FalconFilter)>1
end
function UseHedgehog(c,mode)
  return OPTCheck(04939890) and CardsMatchingFilter(AIDeck(),ShaddollSTFilter)>0
end
function SquamataFilter(c)
  return Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
  and DestroyFilterIgnore(c)
end
function UseSquamata()
  return CardsMatchingFilter(OppMon(),SquamataFilter)>0 and OPTCheck(30328508)
end
function DragonFilter2(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,4)
  and (c.level>4 or bit32.band(c.type,TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ)>0) 
end
function UseDragon()
  return OPTCheck(37445295) and CardsMatchingFilter(OppMon(),DragonFilter2)>0
end
function DragonFilter3(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseDragon2()
  return OPTCheck(37445295) and CardsMatchingFilter(OppMon(),DragonFilter3)>0
end
function UseBeast()
  return OPTCheck(03717252) --and PriorityCheck(AIHand(),PRIO_TOGRAVE)>3
end
function UseJuggler(c,mode)
  if FilterLocation(c,LOCATION_GRAVE) 
  and mode == 1
  then
    return true
  end
  return false
end

function SummonHatTricker(c,mode)
  if mode == 1 then
    if TrishulaCheck(c)
    or FieldCheck(4)==1 
    and CardsMatchingFilter(AIHand(),FilterTuner,1)>0
    and not NormalSummonCheck()
    and WindaCheck()
    and SpaceCheck()>1
    then
      return true
    end
  end
  if mode == 2 then
    if FieldCheck(4)==1 
    and WindaCheck()
    then
      return true
    end
  end
  if mode == 3 then
    if FieldCheck(4)==1 
    and (WindaCheck() or not SpecialSummonCheck())
    then
      return true
    end
  end
  return false
end
function SummonClown(c,mode)
  if mode == 1 then
    if FieldCheck(4)==1 then
      return true
    end
  end
  return false
end
function SummonJuggler(c,mode)
  if mode == 1 then
    if FieldCheck(4)==1 then
      return true
    end
  end
  return false
end
function SetJuggler(c)
  if TurnEndCheck() and #AIMon()==0 then
    return true
  end
  return false
end
function SetClown(c)
  if TurnEndCheck() and #AIMon()==0 then
    return true
  end
  return false
end
function ShaddollIFFilter(c)
  return ShaddollMonsterFilter(c)
  and c.level<6
  and FilterType(c,TYPE_FUSION)
end
function ShaddollXYZSummon()
  return true -- TODO
end
GlobalIFTarget=nil
GlobalNordenFilter=nil
GlobalNordenMatch=nil
function ShaddollUseInstantFusion(c,mode)
  if AI.GetPlayerLP(1)<=1000
  or not WindaCheck()
  or not DualityCheck()
  or Duel.GetLocationCount(player_ai,LOCATION_MZONE)<2
  then
    return false
  end
  if mode == 1 then
    if TrishulaCheck() then
      GlobalIFTarget=17412721
      local lvl = GlobalNordenMatch.lvl
      local tuner = GlobalNordenMatch.tuner
      GlobalNordenFilter=
      function(c)
        return FilterLevel(c,lvl) and (tuner and FilterType(c,TYPE_TUNER)
        or not tuner and not FilterType(c,TYPE_TUNER))
      end
      GlobalNordenMatch=nil
      return true
    end
  end
  if mode == 2 then
    if HasIDNotNegated(AIExtra(),17412721,true)
    and CardsMatchingFilter(AIGrave(),FilterLevel,4)>0
    and FieldCheck(4)==0
    and ShaddollXYZSummon()
    then
      GlobalIFTarget=17412721
      GlobalNordenFilter=function(c)return FilterLevel(c,4) end
      return true
    end
  end
  if mode == 3 then
    if CardsMatchingFilter(AIExtra(),ShaddollIFFilter)>0
    and ShaddollHasFusion(true)
    and CardsMatchingFilter(AICards(),FusionFodder,ATTRIBUTE_LIGHT)>0
    and CardsMatchingFilter(AICards(),ShaddollMonsterFilter)==0
    then
      GlobalIFTarget=94977269
      return true
    end
  end
  if mode == 4 
  and HasIDNotNegated(AICards(),30392583,true)
  and HasID(AIHand(),94997874,true,SummonTarotray,1)
  and not HasID(AIHand(),94997874,true,TarotrayTributeCheck)
  and (FieldCheck(4)>0 or HandCheck(4)>0)
  and HasID(AIExtra(),94977269,true)
  then
    GlobalIFTarget=94977269
    return true
  end
end
function TrishulaCheckFilter(card,params)
  if CardsEqual(card,params[1]) or CardsEqual(card,params[2]) then
    return false
  end
  local cards = UseLists({card},params)
  local tuner = 0
  local lvl = 0
  local norden = nil
  for i=1,#cards do
    local c=cards[i]
    if FilterPosition(c,POS_FACEUP) 
    or not FilterLocation(c,LOCATION_ONFIELD)
    then
      lvl = lvl+c.level
      if FilterType(c,TYPE_TUNER) then
        tuner = tuner + 1
      end
      if FilterLocation(c,LOCATION_GRAVE) 
      and not (c.id == 67441435 and OPDCheck(c))
      then
        norden={}
        norden.lvl=c.level
        if FilterType(c,TYPE_TUNER) then
          norden.tuner=true
        end
      end
    end
  end
  if lvl == 9 and tuner == 1 then
    GlobalNordenMatch=norden
    return true
  end
  return false
end
function TrishulaCheck(c)
  if not c then
    c = FindID(17412721,AIExtra(),nil,NotNegated)
    if c == nil 
    or not (DualityCheck()
    and WindaCheck()
    and HasID(AICards(),01845204,true,OPTCheck,01845204)
    and SpaceCheck()>1)
    then
      return false
    end
  end
  if not HasIDNotNegated(AIExtra(),52687916,true,SummonSyncTrishula) 
  or not (DualityCheck()) 
  or not WindaCheck() and SpecialSummonCheck()
  then
    return false
  end
  local cards = AIMon()
  local cards2 = AIMon()
  if c.id==17412721 then
    if not NormalSummonCheck() then
      cards=AICards()
    end
    cards2=AIGrave()
  end
  local i=HasID(AIHand(),31292357,true)
  if i
  and WindaCheck()
  and SpaceCheck()>1
  and not CardsEqual(c,AIHand()[i])
  and (#AllMon()>0 or c.id==17412721)
  then
    table.insert(cards,#cards+1,AIHand()[i])
  end
  if HasID(AIGrave(),67441435,true,FilterOPD) then
    table.insert(cards,#cards+1,FindID(67441435,AIGrave()))
  end
  if HasID(AICards(),81439173,true) 
  and HasID(AIDeck(),58996430,true)
  and MacroCheck()
  then
    table.insert(cards,#cards+1,FindID(58996430,AIHand()))
  end
  local result = false
  for i=1,#cards do
    local c2=cards[i]
    if (FilterLevelMax(c2,7) 
    and FilterLocation(c2,LOCATION_MZONE)
    or FilterLevelMax(c2,4))
    and FilterLevelMax(c,4)
    and not CardsEqual(c2,c)
    and CardsMatchingFilter(cards2,TrishulaCheckFilter,{c,c2})>0
    then
      result = true
    end
  end
  return result
end
function UsePreprep(c)
  return true
end
function SummonManju(c,mode)
  if mode == 1 
  then
    return true
  end
end
function SummonTailwind(c,mode)
  if mode == 1 
  and NeedsCard(91501248,AIDeck(),AICards(),true)
  then
    return true
  end
  if mode == 2 
  then
    return true
  end
end
function TarotrayTributeCheck(source)
  local cards=SubGroup(AICards(),FilterType,TYPE_MONSTER)
  for i,c in pairs(cards) do
    if CardsEqual(c,source) then
      table.remove(cards,i)
      break
    end
  end
  for i,c in pairs(cards) do  
    for j=1,i do
      for k=1,j do
        local c2=cards[j]
        local c3=cards[k]
        if source.level<=c.level+c2.level+c3.level then
          return true
        end
      end
    end
  end
  return false
end
function SummonTarotray(c,mode)
  if mode == 1
  and NotNegated(c)
  and not HasID(AIMon(),94997874,true)
  and (c.id == 30392583
  or HasIDNotNegated(AICards(),30392583,true))
  then
    return true
  end
  if mode == 2
  and NotNegated(c)
  and not HasID(AIMon(),94997874,true)
  and HasID(AIHand(),94997874,true,TarotrayTributeCheck)
  and (c.id == 30392583
  or HasIDNotNegated(AICards(),30392583,true))
  then
    return true
  end
end
function UsePredictionRitualGrave(c,mode)
  if FilterLocation(c,LOCATION_GRAVE) then
    if c.mode == 1 
    and HasID(AICards(),30392583,true)
    and HasID(AIHand(),94997874,true,SummonTarotray,1)
    and not HasID(AIHand,94997874,true,TarotrayTributeCheck)
    then
      return true
    end
    if c.mode == 2
    and HasID(AICards(),30392583,true)
    and HasID(AIDeck(),94997874,true,SummonTarotray,1)
    and HasID(AIDeck(),94997874,true,TarotrayTributeCheck)
    then
      return true
    end
  end
end
function UseFoolishShaddoll(c,mode)
  if not MacroCheck() then
    return false
  end
  if mode == 1 
  and HasIDNotNegated(AICards(),30392583,true)
  and HasID(AIHand(),94997874,true,SummonTarotray,1)
  and not HasID(AIHand(),94997874,true,TarotrayTributeCheck)
  and HasID(AIDeck(),04939890,true,FilterOPT,true)
  then
    GlobalFoolishID = 04939890
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIMon(),91501248,true)
  and not HasAccess(91501248)
  then
    GlobalFoolishID = 91501248
    return true
  end
  if mode == 3 
  then
    return true
  end
end
function SetArrowsylph(c,mode)
  if mode == 1 
  and NeedsCard(30392583,Merge(AIDeck(),AIGrave()),AICards(),true)
  and HasID(AIHand(),94997874,true)
  then
    return true
  end
  if mode == 2
  then
    return true
  end
end
function SetCoinorma(c,mode)
  if mode == 1 
  and not HasAccess(91501248)
  and HasID(AIDeck(),91501248,true)
  and TurnEndCheck()
  then
    return true
  end
  if mode == 2
  and TurnEndCheck()
  then
    return true
  end
end
function FlipCoinorma(c,mode)
  if mode == 1
  and FilterPosition(c,POS_FACEDOWN)
  and DualityCheck()
  and NotNegated(c)
  and TurnEndCheck()
  and CardsMatchingFilter(AIDeck(),PredictionPrincessFilter)>0
  then
    return true
  end
  if mode == 2
  and FilterPosition(c,POS_FACEUP_ATTACK)
  then
    return true
  end
end
function FlipArrowsylph(c,mode)
  if mode == 1
  and FilterPosition(c,POS_FACEDOWN)
  and NotNegated(c)
  and HasID(Merge(AIDeck(),AIGrave()),30392583,true)
  then
    return true
  end
end
function SummonEnterblathnirShaddoll(c,mode)
  if mode == 1
  and NotNegated(c)
  and SummonEnterblathnir(c)
  and (FieldCheck(9)>2 
  or not HasIDNotNegated(AIMon(),94997874,true))
  then
    return true
  end
end
function UseTarotrayFaceup(c,mode)
end
function UseTarotrayFacedown(c,mode)
end
function ShaddollInit(cards)
  GlobalNordenFilter=nil
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(Act,04904633,UseCore,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,00581014,false,9296225) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,44394295,UseShaddollFusion,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,52687916,SummonSyncTrishula) then
    return SynchroSummon()
  end
  if HasID(Act,13048472,UsePreprep) then
    return Activate()
  end
  if HasID(Rep,31118030,false,FlipArrowsylph) then
    return Repo()
  end
  if HasID(Rep,67503139,false,FlipCrystaldine) then
    return Repo()
  end
  if HasIDNotNegated(Sum,95492061,SummonManju,1) then
    return Summon()
  end
  if HasIDNotNegated(Sum,26517393,SummonTailwind,1) then
    return Summon()
  end
  if HasID(Act,04904633,UseCore,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,30392583,SummonTarotray,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,30392583,UsePredictionRitualGrave,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,30392583,UsePredictionRitualGrave,2) then
    return Activate()
  end
  if HasID(Act,81439173,UseFoolishShaddoll,1) then
    return Activate()
  end
  if HasID(Act,81439173,UseFoolishShaddoll,2) then
    return Activate()
  end
  if HasID(Rep,37445295,false,nil,nil,POS_FACEDOWN_DEFENSE,UseFalcon) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,04939890,false,nil,nil,POS_FACEDOWN_DEFENSE,UseHedgehog) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,30328508,false,nil,nil,POS_FACEDOWN_DEFENSE,UseSquamata) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,77723643,false,nil,nil,POS_FACEDOWN_DEFENSE,UseDragon) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,03717252,false,nil,nil,POS_FACEDOWN_DEFENSE,UseBeast) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,20366274,false,nil,nil,POS_FACEDOWN_DEFENSE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,94977269,false,nil,nil,POS_FACEDOWN_DEFENSE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,67696066,false,nil,nil,POS_FACEDOWN_DEFENSE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,68819554,false,nil,nil,POS_FACEDOWN_DEFENSE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,31292357,false,nil,nil,POS_FACEDOWN_DEFENSE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,41386308,false,nil,nil,POS_FACEDOWN_DEFENSE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Act,68819554,UseJuggler,1) then
    return Activate()
  end
  if HasID(Act,01845204,ShaddollUseInstantFusion,1) then
    return Activate()
  end
  if HasID(SpSum,31292357,SummonHatTricker,1) then
    return SpSummon()
  end
  for i=1,#Sum do
    if TrishulaCheck(Sum[i]) then
      return Summon(i)
    end
  end
  if HasID(Act,04904633,UseCore,3) then
    return Activate()
  end
  if HasID(SpSum,95113856,SummonEnterblathnirShaddoll,1) then
    return XYZSummon()
  end
  if HasID(Sum,41386308) and SummonMathShaddoll() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,44394295,UseShaddollFusion,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,06417578,UseElFusion,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,44394295,UseShaddollFusion,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,06417578,UseElFusion,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,01845204,ShaddollUseInstantFusion,2) then
    return Activate()
  end
  if HasID(Act,01845204,ShaddollUseInstantFusion,3) then
    return Activate()
  end
  if HasID(Act,01845204,ShaddollUseInstantFusion,4) then
    return Activate()
  end
  if HasID(SpSum,31292357,SummonHatTricker,2) then
    return SpSummon()
  end
  if HasID(Sum,67696066,SummonClown,1) then
    return Summon()
  end
  if HasID(Sum,68819554,SummonJuggler,1) then
    return Summon()
  end
  if HasID(Sum,31292357,SummonHatTricker,3) then
    return Summon()
  end
  if HasID(Sum,24062258) and SummonDru() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,37445295,SummonFalcon) then
    return Summon()
  end
  if HasID(Sum,04939890) and SummonHedgehog() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,30328508) and SummonSquamata() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,77723643) and SummonDragon() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,03717252) and SummonBeast() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,81439173,UseFoolishShaddoll,3) then
    return Activate()
  end
  if HasIDNotNegated(Sum,26517393,SummonTailwind,2) then
    return Summon()
  end
  if HasID(SetMon,31118030,SetArrowsylph,1) then
    return Set()
  end
  if HasID(SetMon,32231618,SetCoinorma,1) then
    return Set()
  end
  if HasID(SetMon,37445295) and SetFalcon() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,04939890) and SetHedgehog() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,30328508) and SetSquamata() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end  
  if HasID(SetMon,77723643) and SetDragon() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,03717252) and SetBeast() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,67696066,SetClown) then
    return Set()
  end
    if HasID(SetMon,68819554,SetJuggler) then
    return Set()
  end
  if HasID(SetMon,32231618,SetCoinorma,2) then
    return Set()
  end
  if HasID(SetMon,31118030,SetArrowsylph,2) then
    return Set()
  end
  if HasID(SetST,77505534) and SetShadowGames() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  -- TODO: only for backwards compatibility
  if HasID(SetST,85103922) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetST,20292186) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetST,12697630) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetST,12444060) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetST,29223325) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(Rep,32231618,FlipCoinorma,1) then
    return Repo()
  end
  if HasID(Rep,32231618,FlipCoinorma,2) then
    return Repo()
  end
  return nil
end
function ElFusionTarget(cards,min)
  if LocCheck(cards,LOCATION_EXTRA) then
    if GlobalElFusionSummon then
      local id = GlobalElFusionSummon
      GlobalElFusionSummon = nil
      return Add(cards,PRIO_TOFIELD,1,FilterID,id)
    else
      return Add(cards,PRIO_TOFIELD,1)
    end
  else
    if #GlobalElFusionTargets>0 then
    end
  end
end
function FalconTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
GlobalHedgehogFilter = nil
function HedgehogTarget(cards)
  if GlobalHedgehogFilter then
    local filter = GlobalHedgehogFilter
    GlobalHedgehogFilter = nil
    return Add(cards,PRIO_TOHAND,1,filter)
  end
  if (FieldCheck(4)==1
  or HatCheck())
  and FilterType(cards[1],TYPE_MONSTER)
  then
    return Add(cards,PRIO_TOHAND,1,FilterLevel,4)
  end
  return Add(cards)
end
function SquamataTarget(cards,c)
  if FilterLocation(c,LOCATION_ONFIELD) then
    return BestTargets(cards,1,true)
  else
    return Add(cards,PRIO_TOGRAVE)
  end
end
function DragonTarget(cards)
  return BestTargets(cards,1,TARGET_DESTROY)
end
function BeastTarget(cards)
  return Add(cards,PRIO_TOGRAVE)
end
function ShaddollFusionTarget(cards)
  local result=nil
  if LocCheck(cards,LOCATION_EXTRA) then
    if SummonConstruct() then
      result = Add(cards,PRIO_TOFIELD,1,FilterID,20366274)
    end
    result = Add(cards,PRIO_TOFIELD)
  else
    result = Add(cards,PRIO_TOGRAVE)
  end
  if result == nil then result = {math.random(#cards)} end
  SetMultiple(cards[1].id)
  return result
end
function ConstructTarget(cards,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards)
  else
    return Add(cards,PRIO_TOGRAVE)
  end
end
function WindaTarget(cards)
  return Add(cards)
end
function CoreTarget(cards)
  return Add(cards)
end
function ShadowGamesTarget(cards,min,max)
  local result = nil
  if LocCheck(cards,LOCATION_DECK) then
    result = Add(cards,PRIO_TOGRAVE)
  else
    result={}
    for i=1,#cards do
      local id=cards[i].id
      if id==37445295 and UseFalcon() 
      or id==04939890 and UseHedgehog()
      or id==30328508 and UseSquamata()
      or id==77723643 and UseDragon2()
      or id==03717252 and UseBeast()
      then
        result[#result+1]=i
      end
    end
  end
  if result == nil then result = {math.random(#cards)} end
  if #result>max then result = Add(cards,PRIO_TOGRAVE) end
  SetMultiple(cards[result[1]].id)
  return result
end
function JugglerTarget(cards)
  return Add(cards)
end
GlobalClownSummon=nil
function ClownTarget(cards)
  local result = Add(cards,PRIO_TOFIELD)
  GlobalClownSummon = cards[1].id
  return result
end
function PreprepTarget(cards)
  return Add(cards)
end
function ManjuTarget(cards)
  return Add(cards)
end
function TailwindTarget(cards)
  return Add(cards)
end
function PredictionRitualTarget(cards)
  return Add(cards,PRIO_TOFIELD,1,FilterID,94997874)
end
function TarotrayTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOFIELD,1,FilterGlobalTarget,cards)
  end
  if LocCheck(cards,LOCATION_HAND) 
  or LocCheck(cards,LOCATION_GRAVE) 
  then
    if NeedsCard(91501248,cards,AIMon()) then
      return Add(cards,PRIO_TOFIELD,1,FilterID,91501248)
    end
    return Add(cards,PRIO_TOFIELD,1,FilterLocation,LOCATION_GRAVE)
  end
  if FilterPosition(cards[1],POS_FACEDOWN) then
    return Add(cards,PRIO_TOFIELD,1,FilterType,TYPE_FLIP)
  end
  if FilterPosition(cards[1],POS_FACEUP) then
    return BestTargets(cards,1,TARGET_FACEDOWN)
  end
end
function ShaddollCard(cards,min,max,id,c) 
  if id == 94997874 then
    return TarotrayTarget(cards)
  end
  if id == 95492061 then
    return ManjuTarget(cards)
  end
  if id == 13048472 then
    return PreprepTarget(cards)
  end
  if id == 26517393 then
    return TailwindTarget(cards)
  end
  if id == 30392583 then
    return PredictionRitualTarget(cards)
  end
  if id == 68819554 then
    return JugglerTarget(cards)
  end  
  if id == 67696066 then
    return ClownTarget(cards)
  end
  if id == 06417578 then
    return ElFusionTarget(cards,min)
  end
  if id == 06417578 then
    return ElFusionTarget(cards,min)
  end
  if id == 37445295 then
    return FalconTarget(cards)
  end
  if id == 04939890 then
    return HedgehogTarget(cards)
  end
  if id == 30328508 then
    return SquamataTarget(cards,c)
  end
  if id == 77723643 then
    return DragonTarget(cards)
  end
  if id == 03717252 then
    return BeastTarget(cards)
  end
  if id == 44394295 then
    return ShaddollFusionTarget(cards)
  end
  if id == 20366274 then
    return ConstructTarget(cards,c)
  end
  if id == 94977269 then
    return WindaTarget(cards)
  end
  if id == 04904633 then
    return CoreTarget(cards)
  end
  if id == 77505534 then
    return ShadowGamesTarget(cards,min,max)
  end
  return nil
end
function ShaddollFinishCheck()
 return #OppMon()==0
 and (AI.GetPlayerLP(2)<=2800 and CanFusionConstruct(2)
 or AI.GetPlayerLP(2)<=2700 and CanFusionAnoyatilis(2)
 or AI.GetPlayerLP(2)<=2600 and CanFusionShekinaga(2)
 or AI.GetPlayerLP(2)<=2200 and CanFusionWinda(2))
end
GlobalElFusionTargets={}
GlobalElFusionSummon=nil
function ChainElFusion(c)
  GlobalElFusionTargets={}
  GlobalElFusionSummon=nil
  local targets = {}
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if RemovalCheckCard(c) or NegateCheckCard(c) then
      targets[#targets+1]=c
    end
  end
  if RemovalCheckCard(c) then
    if SummonShaddollFusion(2)
    or #targets>0
    then
      if #targets>0 then 
        GlobalElFusionTargets=targets
      end
      OPTSet(c.id)
      return true
    end
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()==player_ai
  and ShaddollFinishCheck()
  then
    OPTSet(c.id)
    return true
  end
  return false
end
function FalconCheck(c)
  return OPTCheck(37445295)
  and CardsMatchingFilter(AIGrave(),FalconFilter)==0
  and DualityCheck()
  and (WindaCheck() or not SpecialSummonCheck())
  and MacroCheck()
end
function ChainShadowGames(c)
  local result = false
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if RemovalCheckCard(c) then
    if e and e:GetHandler():GetCode()==12697630 then 
      return false
    end
    return true
  end
  if not UnchainableCheck(77505534) then
    return false
  end
  if RemovalCheck(37445295) and (UseFalcon() or FalconCheck()) then
    result = true
  end
  if RemovalCheck(04939890) and UseHedgehog() then
    result = true
  end
  if RemovalCheck(30328508) and UseSquamata() then
    result = true
  end
  if RemovalCheck(77723643) and UseDragon2() then
    result = true
  end
  if RemovalCheck(03717252) and UseBeast() then
    result = true
  end
  if Duel.GetCurrentPhase()==PHASE_END 
  and Duel.GetTurnPlayer()==1-player_ai
  and (HasID(AIDeck(),77723643,true) and DragonCond(PRIO_TOGRAVE) 
  or HasID(AIDeck(),04939890,true) and HedgehogCond(PRIO_TOGRAVE) 
  or HasID(AIMon(),37445295,true,FilterPosition,POS_FACEDOWN_DEFENSE) and FalconCheck()) 
  then
    result = true
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()==1-player_ai
  then
    local aimon,oppmon=GetBattlingMons()
    if aimon and oppmon
    and ShaddollMonsterFilter(oppmon) 
    and FilterPosition(aimon,POS_FACEDOWN_DEFENSE)
    and WinsBattle(oppmon,aimon)
    and (aimon:IsCode(77723643) and UseDragon2() 
    or aimon:IsCode(30328508) and UseSquamata()
    or aimon:IsCode(37445295) and FalconCheck())
    then
      result = true
    end
  end
  if result and e then
    c = e:GetHandler()
    result = (c and c:GetCode()~=12697630)
  end
  return result
end
function ChainCore()
  if IsBattlePhase() then
    local source=Duel.GetAttacker()
    if source and source:IsControler(1-player_ai) 
    and (source:GetAttack()<=1950 or source:GetAttack()>=0.8*AI.GetPlayerLP(1))
    and #AIMon()==0 
    then
      return true
    end
    local aimon,oppmon=GetBattlingMons()
    if Duel.GetTurnPlayer()==player_ai 
    and GlobalBPEnd and not aimon
    and (#OppMon()>0 and OppGetStrongestAttDef()<1450
    or #OppMon()==0)
    then
      return true
    end
  end
end
function ChainClown(c)
  return (AI.GetPlayerLP(1)>1800 
  or HasIDNotNegated(AIMon(),17016362,true,FilterAttackMin,1001))
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>0
end
function ChainJuggler(c)
  return false --TODO: everything
end
function ChainForbiddenPot(c)
  return true
end
function FlipForbiddenPot(c)
  return NotNegated(c)
  and OPTCheck(c.id)
  and FilterPosition(c,POS_FACEDOWN)
end
function ChainTarotraySummon(c)
  return NotNegated(c) 
  and (CardsMatchingFilter(AIGrave(),FilterType,TYPE_FLIP)>0
  or NeedsCard(91501248,AIHand(),AIMon())
  or NeedsCard(03717252,AIHand(),AIMon())
  or #AIMon()<3 and CardsMatchingFilter(AIHand(),FilterType,TYPE_FLIP)>0)
end
function ChainTarotrayFacedown(c,mode)
  --return true
  if RemovalCheckCard(c) 
  or NegateCheckCard(c)
  then
    return true
  end
  if not OPTCheck(c.id) 
  or Negated(c)
  then
    return false
  end
  if mode == 1 
  and HasID(AIMon(),91501248,true,FilterPosition,POS_FACEUP)
  and Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetTurnPlayer()==1-player_ai
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(91501248,AIMon(),nil,FilterPosition,POS_FACEUP))
    return true
  end
  local aimon,oppmon=GetBattlingMons()
  if mode == 2 
  and IsBattlePhase()
  and aimon 
  and aimon:GetCode()==91501248
  and OPTCheck(91501248)
  and Duel.GetTurnPlayer()==1-player_ai
  then
    GlobalCardMode = 1
    GlobalTargetSet(aimon)
    return true
  end
  if mode == 3
  and IsBattlePhase()
  and aimon 
  and FilterType(aimon,TYPE_FLIP)
  and OPTCheck(aimon)
  and Duel.GetTurnPlayer()==1-player_ai
  then
    GlobalCardMode = 1
    GlobalTargetSet(aimon)
    return true
  end
  if mode == 4
  and IsBattlePhase()
  and oppmon
  and (WinsBattle(oppmon,aimon) or CanFinishGame(oppmon))
  and Affected(oppmon,TYPE_MONSTER,9)
  and Targetable(oppmon,TYPE_MONSTER)
  and Duel.GetTurnPlayer()==1-player_ai
  then
    GlobalCardMode = 1
    GlobalTargetSet(oppmon)
    return true
  end
  local cg = NegateCheck()
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  local source = nil
  if e then
    source = e:GetHandler()
  end
  if mode == 5
  and CardsMatchingFilter(AIMon(),FilterFlipFaceup)>0
  --and Duel.GetTurnPlayer()==1-player_ai
  and Duel.CheckTiming(TIMING_END_PHASE)
  then
    return true
  end
end
function ChainTarotrayFaceup(c,mode)
  if RemovalCheckCard(c) 
  or NegateCheckCard(c)
  then
    return true
  end
  if not OPTCheck(c.id) 
  or Negated(c)
  then
    return false
  end
  if mode == 1
  and HasID(AIMon(),91501248,true,FlipForbiddenPot)
  and Duel.CheckTiming(TIMING_END_PHASE)
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(91501248,AIMon(),nil,FlipForbiddenPot))
    return true
  end
  if mode == 2 
  and HasID(AIMon(),91501248,true,FlipForbiddenPot)
  and Duel.CheckTiming(TIMING_STANDBY)
  and #OppHand()==1
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(91501248,AIMon(),nil,FlipForbiddenPot))
    return true
  end
  if mode == 3
  and HasID(AIMon(),91501248,true,FlipForbiddenPot)
  and Duel.GetTurnPlayer()==1-player_ai
  and ChainPotDestroy()
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(91501248,AIMon(),nil,FlipForbiddenPot))
    return true
  end
  if mode == 4
  and CardsMatchingFilter(AIMon(),FilterFlip,true)>0
  --and Duel.GetTurnPlayer()==1-player_ai
  and Duel.CheckTiming(TIMING_END_PHASE)
  then
    return true
  end
  if mode == 5
  and HasID(AIMon(),30328508,true,nil,nil,POS_FACEDOWN_DEFENSE,UseSquamata) 
  and Duel.GetTurnPlayer()==1-player_ai
  and HasPriorityTarget(OppMon(),true,nil,SquamataFilter)
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(30328508,AIMon(),nil,FilterPosition,POS_FACEDOWN))
    return true
  end
  if mode == 6
  and HasID(AIMon(),77723643,true,nil,nil,POS_FACEDOWN_DEFENSE,UseDragon) 
  and Duel.GetTurnPlayer()==1-player_ai
  and HasPriorityTarget(OppMon(),true,nil,DragonFilter2)
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(77723643,AIMon(),nil,FilterPosition,POS_FACEDOWN))
    return true
  end
end
function PotDestroyFilter(c)
  return DestroyFilter(c)
  and Affected(c,TYPE_MONSTER,9)
end
function ChainPotDestroy()
  local targets = SubGroup(OppMon(),PotDestroyFilter,c)
  local prio = SubGroup(targets,PriorityTarget)
  return #targets>2 or #prio>1 or #prio>0 and #targets>0
  or #targets>0 and ExpectedDamage()>AI.GetPlayerLP(2)
end
function UseHedgehogGrave(c)
  if HasIDNotNegated(AICards(),30392583,true)
  and HasID(AIMon(),94997874,true,SummonTarotray,1)
  and not HasID(AIMon(),94997874,true,SummonTarotray,2)
  then
    if HasID(AICards(),03717252,true) then
      GlobalHedgehogFilter=function(c) return FilterLevelMin(c,4) end
    else
      GlobalHedgehogFilter=function(c) return FilterLevelMin(c,5) end
    end
  end
  return true
end

function ChainArrowsylph(c)
  return true
end
function ChainCrystaldine(c)
  return true
end
function ChainCoinorma(c)
  return true
end
function ChainFusionsGrave(c)
  if ShaddollMonsterFilter(c)
  and FilterType(c,TYPE_FUSION)
  and FilterLocation(c,LOCATION_GRAVE)
  then
    return true
  end
end
function ShaddollChain(cards)
  for i,c in pairs(cards) do
    if ChainFusionsGrave(c) then
      return Chain(i)
    end
  end
  if HasID(cards,31118030,ChainArrowsylph) then
    return Chain()
  end
  if HasID(cards,67503139,ChainCrystaldine) then
    return Chain()
  end
  if HasID(cards,32231618,ChainCoinorma) then
    GlobalCoinormaTurn = Duel.GetTurnCount()
    return Chain()
  end
  if HasID(cards,91501248,ChainForbiddenPot) then
    OPTSet(91501248)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16,ChainTarotrayFaceup,1) then 
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16,ChainTarotrayFaceup,2) then 
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16,ChainTarotrayFaceup,3) then 
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16,ChainTarotrayFaceup,4) then 
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16+1,ChainTarotrayFacedown,1) then
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16+1,ChainTarotrayFacedown,2) then
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16+1,ChainTarotrayFacedown,3) then
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16+1,ChainTarotrayFacedown,4) then
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16+1,ChainTarotrayFacedown,5) then
    OPTSet(94997874)
    return Chain()
  end
  if HasID(cards,94997874,false,94997874*16+2,ChainTarotraySummon) then
    return Chain()
  end
  if HasID(cards,31292357) then -- Hat Tricker
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,06417578,ChainElFusion) then
    return true
  end
  if HasID(cards,77505534,ChainShadowGames) then
    return {1,CurrentIndex}
  end
  if HasID(cards,37445295,false,nil,LOCATION_ONFIELD,UseFalcon) then
    OPTSet(37445295)
    return {1,CurrentIndex}
  end
  if HasID(cards,04939890,false,nil,LOCATION_ONFIELD,UseHedgehog) then
    OPTSet(04939890)
    return {1,CurrentIndex}
  end
  if HasID(cards,30328508,false,nil,LOCATION_ONFIELD,UseSquamata) then
    OPTSet(30328508)
    return {1,CurrentIndex}
  end
  if HasID(cards,77723643,false,nil,LOCATION_ONFIELD,UseDragon2) then -- Shaddoll Dragon
    OPTSet(77723643)
    return {1,CurrentIndex}
  end
  if HasID(cards,03717252,false,nil,LOCATION_ONFIELD,UseBeast) then
    OPTSet(03717252)
    return {1,CurrentIndex}
  end
  if HasID(cards,37445295,false,nil,LOCATION_GRAVE) then -- Falcon
    OPTSet(37445295)
    return {1,CurrentIndex}
  end
  if HasID(cards,04939890,false,nil,LOCATION_GRAVE,UseHedgehogGrave) then -- Hedgehog
    OPTSet(04939890)
    return {1,CurrentIndex}
  end
  if HasID(cards,30328508,false,nil,LOCATION_GRAVE) then -- Squamata
    OPTSet(30328508)
    return {1,CurrentIndex}
  end
  if HasID(cards,77723643,false,nil,LOCATION_GRAVE) and CardsMatchingFilter(OppST(),DestroyFilter)>0 then
    OPTSet(77723643)
    return {1,CurrentIndex}
  end
  if HasID(cards,03717252,false,nil,LOCATION_GRAVE) then -- Beast
    OPTSet(03717252)
    return {1,CurrentIndex}
  end
  if HasID(cards,20366274) then -- Construct
    return {1,CurrentIndex}
  end
  if HasID(cards,94977269) then -- Winda
    return {1,CurrentIndex}
  end
  if HasID(cards,04904633,false,nil,LOCATION_GRAVE) then -- Core
    return {1,CurrentIndex}
  end
  if HasID(cards,24062258) then -- Dru
    return {1,CurrentIndex}
  end
  if HasID(cards,04904633,ChainCore) then
    return {1,CurrentIndex}
  end
  if HasID(cards,67696066,ChainClown) then
    OPTSet(67696066)
    return {1,CurrentIndex}
  end
  return nil
end
function ShaddollEffectYesNo(id,card)
  local field = bit32.band(card.location,LOCATION_ONFIELD)>0
  local grave = bit32.band(card.location,LOCATION_GRAVE)>0
  if ChainFusionsGrave(card) then
    return true
  end
  if id == 94997874 
  and card.description==id*16+2 
  and ChainTarotraySummon(card)
  then
    return true
  end
  if id == 31118030 and ChainArrowsylph(card) then
    return true
  end
  if id == 32231618 and ChainCoinorma(card) then
    GlobalCoinormaTurn = Duel.GetTurnCount()
    return true
  end  
  if id == 67503139 and ChainCrystaldine(card) then
    return true
  end
  if id == 91501248 and ChainForbiddenPot(card) then
    OPTSet(id)
    return true
  end
  if id == 67696066 and ChainClown(card) then
    OPTSet(id)
    return 1
  end
  if id == 37445295 and field and UseFalcon() then
    OPTSet(37445295)
    return 1
  end
  if id == 04939890 and field and UseHedgehog() then
    OPTSet(04939890)
    return 1
  end
  if id == 30328508 and field and UseSquamata() then
    OPTSet(30328508)
    return 1
  end
  if id == 77723643 and field then --Dragon
    OPTSet(77723643)
    return 1
  end
  if id == 03717252 and field and UseBeast() then
    OPTSet(03717252)
    return 1
  end
  if id == 37445295 and grave then -- Falcon
    OPTSet(37445295)
    return 1
  end
  if id == 04939890 and grave and UseHedgehogGrave(c) then -- Hedgehog
    OPTSet(04939890)
    return 1
  end
  if id == 30328508 and grave then -- Squamata
    OPTSet(30328508)
    return 1
  end
  if id == 77723643 and grave and CardsMatchingFilter(OppST(),DragonFilter)>0 then 
    OPTSet(77723643)
    return 1
  end
  if id == 03717252 and grave then -- Beast
    OPTSet(03717252)
    return 1
  end
  if id == 31292357 then -- Hat Tricker
    return 1
  end
  if id == 20366274 -- Construct
  or id == 94977269 -- Winda
  or id == 19261966 -- Anoyatilis
  or id == 04904633 -- Core
  or id == 24062258 -- Dru
  then
    return 1
  end
  return nil
end
function ShaddollSum(cards,sum,c)
  if c and c.id == 30392583 then
    if HasID(cards,91501248) then
      return {CurrentIndex}
    end
    if HasID(cards,04904633) then
      return {CurrentIndex}
    end
    AssignPriority(cards,PRIO_TOGRAVE)
    table.sort(cards,function(a,b)return a.prio>b.prio end)
    local levels = 0
    local result = {}
    for i,c in pairs(cards) do
      levels = levels + c.level
      result[i]=c.index
      if (c.level >= sum) then
        result={c.index}
        break
      end
      if levels >= sum then
        break
      end
    end
    if result and #result>0 then
      return result
    end
  end

end
function ShaddollYesNo(desc)
end
function ShaddollTribute(cards,min, max)
end
function ShaddollBattleCommand(cards,targets,act)
end
function ShaddollAttackTarget(cards,attacker)
end
function ShaddollAttackBoost(cards)
end
function ForbiddenPotOption(result)
  if result[2]
  and DestroyCheck(OppMon(),true)>2
  and OppHasStrongestMonster()
  then
    return result[2]
  end
  if result[4]
  and Duel.GetTurnPlayer()==1-player_ai
  and #OppHand()<1
  and not OppHasStrongestMonster()
  then
    return result[4]
  end
  if result[1] 
  and #AIHand()<2
  then
    return result[1]
  end
  if result[3] 
  and Duel.GetTurnPlayer()==player_ai
  and BattlePhaseCheck()
  and ExpectedDamage()>AI.GetPlayerLP(2)
  and not OppHasStrongestMonster()
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN)>1
  then
    return result[3]
  end
  if result[2] 
  and Duel.GetTurnPlayer()==player_ai
  and BattlePhaseCheck()
  and ExpectedDamage()>AI.GetPlayerLP(2)
  and DestroyCheck(OppMon(),true)==#OppMon
  then
    return result[2]
  end
  if result[2]
  and OppHasStrongestMonster()
  and DestroyCheck(OppMon())==#OppMon()
  then
    return result[2]
  end
  if result[1]
  and Duel.GetTurnPlayer()==player_ai
  and not Duel.GetCurrentPhase()==PHASE_END
  and #AIHand()<6
  and #AIDeck()>2
  then
    return result[1]
  end
  if result[1]
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetTurnCount()==1
  and #AIHand()<5
  then
    return result[1]
  end
  if result[4] then
    return result[4]
  end
  if result[1] then
    return result[1]
  end
end
function ShaddollOption(options)
  local result = {}
  for i,v in pairs(options) do
    if v == 91501248*16 then -- draw 
      result[1]=i
    end
    if v == 91501248*16+2 then -- destroy monsters
      result[2]=i
    end
    if v == 91501248*16+1 then -- return S/T
      result[3]=i
    end
    if v == 91501248*16+3 then -- shuffle from hand
      result[4]=i
    end
  end
  if #result>0 then
    return ForbiddenPotOption(result)
  end
end
function ShaddollChainOrder(cards)
end
ShaddollAtt={
  94977269,48424886 -- Winda,Egrystal
}
ShaddollVary={
  74822425,04904633, -- Shekinaga,Core
}
ShaddollDef={
  74009824, -- El-Shaddoll Wendigo
}
function ShaddollPosition(id,available)
  result = nil
  for i=1,#ShaddollAtt do
    if ShaddollAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#ShaddollVary do
    if ShaddollVary[i]==id 
    then 
      if BattlePhaseCheck() 
      and Duel.GetTurnPlayer()==player_ai 
      then 
        result=nil 
      else 
        result=POS_FACEUP_DEFENSE 
      end
    end
  end
  for i=1,#ShaddollDef do
    if ShaddollDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  if GlobalClownSummon and GlobalClownSummon == id then
    GlobalClownSummon = nil
    result=POS_FACEUP_DEFENSE 
  end
  return result
end

