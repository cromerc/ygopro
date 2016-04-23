
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
  --[[
  deck.Sum 
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

ShaddollIdentifier = 77505534 -- Shadow Games

DECK_SHADDOLL = NewDeck("Shaddoll",ShaddollIdentifier,ShaddollStartup) 


ShaddollActivateBlacklist={
67696066, -- Performage Trick Clown
68819554, -- Performage Damage Juggler
31292357, -- Performage Hat Tricker
06417578, -- El-Shaddoll Fusion
74822425, -- El-Shaddoll Shekinaga
17016362, -- Trapeze Magician
}
ShaddollSummonBlacklist={
67696066, -- Performage Trick Clown
68819554, -- Performage Damage Juggler
31292357, -- Performage Hat Tricker
17016362, -- Trapeze Magician
}
ShaddollSetBlacklist={
}
ShaddollRepoBlacklist={
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
    and not HasID(AIMon(),c.id,true,nil,nil,POS_FACEDOWN_DEFENCE,OPTCheck,c.id)
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
    return OPTCheck(77723643) 
    and CardsMatchingFilter(OppST(),DragonFilter)>0 
    and GetMultiple(77723643)==0
    and ShaddollGraveCheck(77723643)
  end
  return true
end
function BeastCond(loc)
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
ShaddollPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Shaddoll

[37445295] = {3,3,3,1,7,1,7,1,1,1,FalconCond},        -- Shaddoll Falcon
[04939890] = {5,2,2,1,5,2,5,4,1,1,HedgehogCond},      -- Shaddoll Hedgehog
[30328508] = {4,1,5,1,9,1,9,1,1,1,SquamataCond},      -- Shaddoll Squamata
[77723643] = {3,1,4,1,7,1,7,1,1,1,DragonCond},        -- Shaddoll Dragon
[03717252] = {4,1,6,1,6,1,6,1,1,1,BeastCond},         -- Shaddoll Beast

[67696066] = {6,2,5,1,6,1,1,1,1,1,ClownCond},         -- Performage Trick Clown
[68819554] = {3,1,2,1,5,1,1,1,1,1,JugglerCond},       -- Performage Damage Juggler
[31292357] = {7,1,3,1,2,1,1,1,1,1,HatCond},           -- Performage Hat Tricker

[41386308] = {1,1,1,1,2,1,1,1,1,1,MathCond},          -- Mathematician
[23434538] = {1,1,1,1,2,1,1,1,1,1},                   -- Maxx "C"
[97268402] = {1,1,1,1,2,1,1,1,1,1},                   -- Effect Veiler
[72989439] = {1,1,1,1,1,1,1,1,1,1},                   -- BLS

[24062258] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Secret Sect Druid Dru
[73176465] = {1,1,1,1,6,5,1,1,1,1,FelisCond},         -- Lightsworn Felis

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


[20366274] = {1,1,6,4,2,1,2,1,1,1,ConstructCond},     -- El-Shaddoll Construct
[94977269] = {1,1,7,3,2,1,2,1,1,1,WindaCond},         -- El-Shaddoll Winda
[74822425] = {1,1,1,1,1,1,1,1,1,1,ShekinagaCond},     -- El-Shaddoll Shekinaga
[19261966] = {1,1,1,1,1,1,1,1,1,1,AnoyatilisCond},    -- El-Shaddoll Anoyatilis

[48424886] = {1,1,1,1,1,1,1,1,1,1,EgrystalCond},      -- El-Shaddoll Egrystal

[52687916] = {1,1,1,1,1,1,1,1,1,1},                   -- Trishula
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
function UseCore()
  return HasID(AIHand(),44394295,true) and WindaCheck()
  and not Duel.IsExistingMatchingCard(ShaddollFusionFilter,1-player_ai,LOCATION_MZONE,0,1,nil)
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
function UseHedgehog()
  return OPTCheck(04939890) and HasID(AIDeck(),44394295,true)
end
function SquamataFilter(c)
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseSquamata()
  return CardsMatchingFilter(OppMon(),SquamataFilter)>0 and OPTCheck(37445295)
end
function DragonFilter2(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 and (c.level>4 
  or bit32.band(c.type,TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ)>0) 
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
  return true
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
  return false
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
      if FilterLocation(c,LOCATION_GRAVE) then
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
function ShaddollInit(cards)
  GlobalNordenFilter=nil
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(Act,04904633) and UseCore() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,00581014,false,9296225) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,44394295,UseShaddollFusion,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,52687916,SummonSyncTrishula) then
    return SpSummon()
  end
  if HasID(Act,81439173) then -- Foolish
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Rep,37445295,false,nil,nil,POS_FACEDOWN_DEFENCE,UseFalcon) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,04939890,false,nil,nil,POS_FACEDOWN_DEFENCE,UseHedgehog) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,30328508,false,nil,nil,POS_FACEDOWN_DEFENCE,UseSquamata) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,77723643,false,nil,nil,POS_FACEDOWN_DEFENCE,UseDragon) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,03717252,false,nil,nil,POS_FACEDOWN_DEFENCE,UseBeast) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,20366274,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,94977269,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,67696066,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,68819554,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,31292357,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Rep,41386308,false,nil,nil,POS_FACEDOWN_DEFENCE) then
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
  if HasID(SetST,77505534) and SetShadowGames() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  -- TODO: only for backwards compatibility
  if HasID(SetableST,85103922) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,20292186) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,12697630) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,12444060) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,29223325) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
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
function HedgehogTarget(cards)
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
function ShaddollCard(cards,min,max,id,c)
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
  if Duel.GetCurrentPhase()==PHASE_BATTLE 
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
  or HasID(AIMon(),37445295,true,FilterPosition,POS_FACEDOWN_DEFENCE) and FalconCheck()) 
  then
    result = true
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE 
  and Duel.GetTurnPlayer()==1-player_ai
  then
    local aimon,oppmon=GetBattlingMons()
    if aimon and oppmon
    and ShaddollMonsterFilter(oppmon) 
    and FilterPosition(aimon,POS_FACEDOWN_DEFENCE)
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
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    local source=Duel.GetAttacker()
    return source and source:IsControler(1-player_ai) 
    and source:GetAttack()<=1950 and #AIMon()==0 
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

function ShaddollChain(cards)
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
  if HasID(cards,04939890,false,nil,LOCATION_GRAVE) then -- Hedgehog
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
  if id == 04939890 and grave then -- Hedgehog
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
function ShaddollOption(options)
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
        result=POS_FACEUP_DEFENCE 
      end
    end
  end
  for i=1,#ShaddollDef do
    if ShaddollDef[i]==id 
    then 
      result=POS_FACEUP_DEFENCE 
    end
  end
  if GlobalClownSummon and GlobalClownSummon == id then
    GlobalClownSummon = nil
    result=POS_FACEUP_DEFENCE 
  end
  return result
end

