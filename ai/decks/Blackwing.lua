function BlackwingPriority()
AddPriority({

[81105204] = {7,1,1,1,3,1,1,1,8,1,KrisCond},    -- Kris
[58820853] = {5,3,1,1,1,1,1,1,5,1,ShuraCond},   -- Shura
[49003716] = {4,1,1,1,4,1,1,1,8,1,BoraCond},    -- Bora
[14785765] = {3,1,1,1,6,4,1,1,1,1,ZephCond},    -- Zephyros
[85215458] = {9,4,1,1,3,1,1,1,5,1,KalutCond},   -- Kalut
[02009101] = {8,3,3,1,2,1,1,1,6,1,GaleCond},    -- Gale
[55610595] = {2,1,5,1,7,3,1,1,7,1,PinakaCond},  -- Pinaka
[28190303] = {10,1,1,1,4,1,1,1,7,1,GladiusCond},-- Gladius
[22835145] = {6,2,1,1,1,4,1,1,6,1,BlizzardCond},-- Blizzard
[73652465] = {11,1,1,1,4,1,1,1,7,1,OroshiCond}, -- Oroshi
[97268402] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Veiler

[91351370] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Black Whirlwind

[53567095] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Icarus
[72930878] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Black Sonic

[81983656] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Hawk Joe
[69031175] = {1,1,5,1,3,1,1,1,1,1,nil},         -- Armor Master
[73580471] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Black Rose
[95040215] = {1,1,8,1,2,1,1,1,1,1,nil},         -- Nothung
[98012938] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Vulcan
[73347079] = {1,1,1,1,7,1,1,1,1,1,ForceStrixCond},-- Force Strix
[76067258] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Master Key Beetle
[16051717] = {1,1,9,6,1,1,1,1,1,1,RaikiriCond}, -- Raikiri


-- Crow Tag Force

[75498415] = {4,1,1,1,1,1,1,1,1,1,nil},         -- Sirocco
[72714392] = {1,1,8,2,5,3,1,1,2,1,VayuCond},    -- Vayu
[24508238] = {1,1,1,1,1,1,1,1,5,1,nil},         -- D.D. Crow
[42703248] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Trunade
[83764719] = {8,1,1,1,1,1,1,1,1,1,nil},         -- Monster Reborn
[27174286] = {1,1,1,1,1,1,1,1,1,1,nil},         -- RftDD
[44095762] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Mirror Force
[59616123] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Trap Stun
[59839761] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Delta Crow
[41420027] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Solemn Judgment

[52687916] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Trishula
[27315304] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Mist Wurm
[33236860] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Silverwing
[09012916] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Black-Winged Dragon
[23693634] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Colossal Fighter
[50321796] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Brionac
[76913983] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Armed Wing
[90953320] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Hyper Librarian
[26593852] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Catastor


})
end
 
function BlackwingFilter(c,exclude)
  return IsSetCode(c.setcode,0x33) and (exclude == nil or c.id~=exclude)
end
function BlackwingTunerFilter(c,exclude)
  return BlackwingFilter(c,exclude) and FilterType(c,TYPE_TUNER)
end
function BlackwingNonTunerFilter(c,exclude)
  return BlackwingFilter(c,exclude) and not FilterType(c,TYPE_TUNER)
end
function BlackwingSynchroFilter(c,exclude)
  return BlackwingFilter(c,exclude) and FilterType(c,TYPE_SYNCHRO)
end
function HasWhirlwind()
  return HasIDNotNegated(AIST(),91351370,true,nil,nil,POS_FACEUP)
end
function SynchroCheck(level,nontunercount)
  local tuners={}
  local nontuners={}
  local levels={}
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if c.level>0 then
      if FilterType(c,TYPE_TUNER) then
        tuners[#tuners+1]=c.level
      else
        nontuners[#nontuners+1]=c.level
      end
    end
  end
  if #tuners == 0 or #nontuners == 0 then
    return false
  end
  for i=1,#nontuners do
    for j=1,#nontuners do
      local a,b
      if i==j then
        a=0
        b=0
      else
        a=nontuners[i]
        b=nontuners[j]
      end
      levels[a+b]=true
    end
  end
  for i=1,#tuners do
    for j=1,#nontuners do
      levels[tuners[i]+nontuners[j]]=0
    end
  end
end

function BounceFilter(c)
  return c.id == 50078509 and FilterPosition(c,POS_FACEUP)
  or c.id == 97077563 and CothCheck(c)
end
-- favourable targets to return to the hand 
-- for Zephyros and Vulcan
function BounceTargets(cards,filter,opt)
  local result = 0
  for i=1,#cards do
    local c = cards[i]
    if c and (filter == nil 
    or (opt == nil and filter(c) 
    or filter(c,opt)))
    then
      if BounceFilter(c) then
        result = result+1
      end
    end
  end
  return result
end

function KrisCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and FieldCheck(3,BlackwingTunerFilter)==1
  end
  return true
end
function ShuraCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
  end
  return true
end
function BoraCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and FieldCheck(3,BlackwingTunerFilter)==1
  end
  return true
end
function ZephCond(loc,c)
  return true
end
function KalutCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and (Duel.GetTurnPlayer()==1-player_ai
    or Duel.GetCurrentPhase()==PHASE_END
    or HasID(AIMon(),58820853,true))
    and CardsMatchingFilter(AICards(),BlackwingFilter)>0
  end
  return true
end
function GaleCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (FieldCheck(4,BlackwingFilter)==1
    or FieldCheck(3,BlackwingNonTunerFilter)==1)
  end
  return true
end
function PinakaCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_MZONE)
  end
  if loc == PRIO_TOFIELD then
    return FilterLocation(c,LOCATION_DECK)
  end
  return true
end
function VayuCond(loc,c)
  if loc == PRIO_TOFIELD then
    return FilterLocation(c,LOCATION_DECK)
  end
  return true
end
function GladiusCond(loc,c)
  if loc == PRIO_TOHAND then
    return FieldCheck(3,FilterType,TYPE_TUNER)==1 
    and #AIMon()==1
  end
  return true
end
function BlizzardCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and CardsMatchingFilter(AIGrave(),BlizzardFilter)>0
    and DualityCheck()
  end
  return true
end
function OroshiCond(loc,c)
  if loc == PRIO_TOHAND then
    return (HasID(AIMon(),95040215,true)
    or HasID(AIMon(),22835145,true))
    --or SynchroCheck(6))
    and HasID(AIExtra(),81983656,true)
    and Duel.GetTurnPlayer()==player_ai
    and not (Duel.GetCurrentPhase()==PHASE_END)
  end
  return true
end
function ForceStrixCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_MZONE)
    and c.xyz_material_count==0
  end
  return true
end
function CastelCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_MZONE)
    and c.xyz_material_count==0
  end
  return true
end
function RaikiriCond(loc,c)
  if loc == PRIO_TOFIELD then
    return DestroyCheck(OppField(),nil,nil,nil,RaikiriFilter)>0
  end
  return true
end
function GaleFilter(c,atk)
  return Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,3)
  and (atk==nil or c.attack*.5<=atk)
end
function UseGale()
  return CardsMatchingFilter(OppMon(),GaleFilter)>0
end
function SummonGale(mode)
  if mode == 2 and DualityCheck() 
  and (HasID(AIHand(),28190303,true)
  or HasWhirlwind() and HasID(AIDeck(),28190303,true))
  and #AIMon()==0
  then
    return true
  end
  if mode == 1 and OverExtendCheck(3)
  then
    return true
  end
  if mode == 3 and (FieldCheck(4)==1 
  or FieldCheck(3,BlackwingNonTunerFilter)==1)
  then
    return true
  end
  if mode == 4 and OppHasStrongestMonster() 
  and CardsMatchingFilter(OppMon(),GaleFilter,math.min(AIGetStrongestAttack(),1300))>0
  then
    return true
  end
  return false
end
function SummonShura(mode,c)
  ApplyATKBoosts({c})
  if mode == 1 
  and not HasID(AIMon(),58820853,true)
  and CanWinBattle(c,OppMon(),true)
  then
    return true
  end
  if mode == 2 
  and (OverExtendCheck(3) or HasWhirlwind())
  then
    return true
  end
  return false
end
function BlizzardFilter(c)
  return BlackwingFilter(c) and c.level==4
end
function SummonBlizzard()
  return CardsMatchingFilter(AIGrave(),BlizzardFilter)>0
  and DualityCheck() and WindaCheck()
  and not HasID(AIMon(),95040215,true)
end
function SummonPinaka(mode)
  if mode == 1 and DualityCheck() 
  and (HasID(AIHand(),28190303,true)
  or HasWhirlwind() and HasID(AIDeck(),28190303,true))
  and #AIMon()==0
  then
    return true
  end
  if mode == 2 and DualityCheck()
  and (HasID(AIHand(),81105204,true) 
  or HasID(AIHand(),49003716,true) 
  or FieldCheck(4)>0)
  then
    return true
  end
  return false
end
function SummonZephyros(mode)
  if DeckCheck(DECK_HARPIE) then return false end
  if mode == 1 and (OverExtendCheck(3) or HasWhirlwind()) then
    return true
  elseif mode == 2 and BounceTargets(AIField())>0 
  and OverExtendCheck(3) and AI.GetPlayerLP(1)>400
  then
    return true
  elseif mode == 3 and #AIMon()==0 and AI.GetPlayerLP(1)>400 then
    return true
  end
  return false
end
function SummonKris(mode)
  if mode == 1 and OverExtendCheck(3) then
    return true
  elseif mode == 2 and (OverExtendCheck(3) or HasWhirlwind()) then
    return true
  elseif mode == 3 and FieldCheck(3,BlackwingTunerFilter)==1 then
    return true
  end
  return false
end
function SummonGladius(mode)
  if mode == 1 and WindaCheck()
  and FieldCheck(3,FilterType,TYPE_TUNER)==1
  then
    return true
  elseif mode == 2 and DualityCheck()
  and FieldCheck(3,FilterType,TYPE_TUNER)==1
  then
    return true
  end
  return false
end
function SummonOroshi()
  return WindaCheck() and HasID(AIMon(),95040215,true)
  and HasID(AIExtra(),81983656,true)
end
function SummonNothung(mode)
  if mode == 1 
  and (not HasID(AIMon(),95040215,true)
  or AI.GetPlayerLP(2)<=800)
  then
    return true
  elseif mode == 2 then
    return true
  end
  return false
end
function HawkJoeFilter(c)
  return BlackwingSynchroFilter(c) 
  and FilterRace(c,RACE_WINDBEAST)
  and FilterRevivable(c)
end
function SummonHawkJoe(mode)
  if mode == 1 and WindaCheck()
  and (CardsMatchingFilter(AIGrave(),HawkJoeFilter)>0
  or HasID(AIMon(),73652465,true) and HasID(AIMon(),95040215,true))
  then
    return true
  end
  return false
end
function SummonBora(mode)
  if mode == 1 and FieldCheck(3,BlackwingTunerFilter)==1
  then
    return true
  end
  if mode == 2 and OverExtendCheck(3)
  then
    return true
  end
  if mode == 3 and (HasWhirlwind()
  or #AIMon()==0)
  then
    return true
  end
  return false
end
function SummonForceStrix()
  if TurnEndCheck() then
    return true
  end
  return false
end
function SummonKalut()
  if DualityCheck() 
  and (HasID(AIHand(),02009101,true)
  or HasWhirlwind() and NeedsCard(02009101,AIDeck(),AIHand(),true))
  and #AIMon()==0
  and #OppMon()>0
  then
    return true
  end
  return false
end
function SummonArmorMaster()
  return MP2Check(2500)
end
function UseIcarus()
  local targets = SubGroup(OppField(),IcarusFilter)
  local targets2 = SubGroup(targets,PriorityTarget)
  if #targets2>0 and #targets>1 
  and OppHasStrongestMonster()
  then
    return true
  end
  return false
end
function SummonMKB()
  return OppGetStrongestAttDef()<2500
  and DualityCheck()
  and (HasID(AIST(),05851097,true)
  or HasID(AIST(),38296564,true))
  and HasIDNotNegated(AIExtra(),76067258,true)
  and MP2Check(2500)
end
function UseMKB()
  return true
end
function UseSirocco()
  return OppHasStrongestMonster() 
  and CardsMatchingFilter(AIMon(),BlackwingFilter)>0
end
function SummonSirocco()
  return #AIMon()==0 and #OppMon()>0
end
function UseVayu()
  return OverExtendCheck(3) and BattlePhaseCheck()
end
function SetVayu()
  return TurnEndCheck()
end
function RftDDFilter(c)
  return FilterType(c,TYPE_MONSTER)
  and FilterRevivable(c)
end
function UseRftDD()
  return CardsMatchingFilter(AIBanish(),RftDDFilter)>2 
  and BattlePhaseCheck() and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>2
end
function SetRftDD()
  return CardsMatchingFilter(AIBanish(),RftDDFilter)>2 
  and TurnEndCheck()
end
function SummonSyncTrishula(c)
  return #OppField()>0 and #OppHand()>0
  and HasID(AIExtra(),c.id,true)
  and (NotNegated(c) or OppHasStrongestMonster()
  and OppGetStrongestAttDef()<c.attack)
end
function SummonBlackwing(c)
  ApplyATKBoosts({c})
  if OppHasStrongestMonster() 
  and OppGetStrongestAttDef()<c.attack
  or HasIDNotNegated(AICards(),53567095,true)
  then
    return true
  end
  return false
end
function ArmedWingFilter(c,source)
  return BattleTargetCheck(c,source)
  and FilterPosition(c,POS_DEFENSE)
  and (FilterPrivate(c) or c.defense<source.attack+500)
end
function ArmedWingCheck(c,targets)
 return NotNegated(c) and CardsMatchingFilter(targets,ArmedWingFilter,c)>0
end
function SummonArmedWing(c)
  return ArmedWingCheck(c,OppMon())
  or OppGetStrongestAttDef()<c.attack
end
function SummonVulcanBW(c)
  return DeckCheck(DECK_BLACKWING) and SummonVulcan(c)
  and BounceTargets(AIField())>0
end
function SummonRaikiri(c,params)
  local mode = params[1]
  local cards = params[2]
  local targets = DestroyCheck(OppField(),nil,nil,nil,RaikiriFilter)
  local bws = CardsMatchingFilter(cards,RaikiriSummonFilter) 
  + CardsMatchingFilter(AIMon(),BlackwingFilter) -2
  if mode == 1 and targets>1 and bws>1
  then
    return true
  end
  if mode == 2 and targets>0 and bws>0
  and MP2Check(c.attack)
  then
    return true
  end
  return false
end
function UseRaikiri(c)
  return DestroyCheck(OppField(),nil,nil,nil,RaikiriFilter)>0
end
function RaikiriSummonFilter(c)
  return BlackwingFilter(c) and not FilterType(c,TYPE_SYNCHRO)
end
function BlackwingInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,16051717,true)
  and DestroyCheck(OppField())>CardsMatchingFilter(AIMon(),BlackwingFilter)-1
  then
    for i=1,#Sum do
      if RaikiriSummonFilter(Sum[i]) then
        return Summon(i)
      end
    end
    for i=1,#SpSum do
      if RaikiriSummonFilter(SpSum[i]) then
        return SpSummon(i)
      end
    end
  end
  if HasIDNotNegated(Act,16051717,UseRaikiri)then
    return Activate()
  end
  if HasIDNotNegated(Act,91351370) and #Sum>0 then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,02009101) and UseGale() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,76067258) and UseMKB() then
    GlobalCardMode=1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,73347079) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,81983656) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,27174286) and UseRftDD() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,52687916,SummonSyncTrishula) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,73652465) and SummonOroshi() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,81983656) and SummonHawkJoe(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,16051717,SummonRaikiri,{1,SpSum}) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,98012938) and SummonVulcanBW() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,95040215) and SummonNothung(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,28190303) and SummonGladius(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,49003716) and SummonBora(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,02009101) and SummonGale(3) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,22835145) and SummonBlizzard() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,75498415) and SummonSirocco() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,58820853) and SummonShura(1,Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,28190303) and SummonGladius(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,55610595) and SummonPinaka(1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,02009101) and SummonGale(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,55610595) and SummonPinaka(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,58820853) and SummonShura(2,Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,14785765) and SummonZephyros(1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,81105204) and SummonKris(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,49003716) and SummonBora(3) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,49003716) and SummonBora(2) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,02009101) and SummonGale(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,81105204) and SummonKris(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Act,14785765) and SummonZephyros(2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,85215458) and SummonKalut() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,95040215) and SummonNothung(2) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,16051717,SummonRaikiri,{2,SpSum}) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,76067258) and SummonMKB() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,73347079) and SummonForceStrix() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,69031175) and SummonArmorMaster() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,76913983,SummonArmedWing) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,53567095) and UseIcarus() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,02009101) and SummonGale(4) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Sum,02009101) and SummonGale(4) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,81105204,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,58820853,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,14785765,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,49003716,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,22835145,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,02009101,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,55610595,SummonBlackwing) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,14785765) and SummonZephyros(3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SetMon,72714392) and SetVayu() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasIDNotNegated(Act,72714392) and UseVayu() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,75498415) and UseSirocco() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SetST,27174286) and SetRftDD() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  return nil
end
function HawkJoeTarget(cards,source)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD)
  end
  if RemovalCheckCard(source,CATEGORY_DESTROY,nil,nil,Duel.GetCurrentChain()-1)then--,nil,Duel.GetCurrentChain()) then
    return BestTargets(cards)
  end
  local e = Duel.GetChainInfo(Duel.GetCurrentChain()-1,CHAININFO_TRIGGERING_EFFECT)
  if Duel.GetCurrentChain()>1 and e then
    return BestTargets(cards,1,TARGET_OTHER)
  end
  local aimon,oppmon = GetBattlingMons()
  if aimon and oppmon then
    return BestTargets(cards,1,TARGET_BATTLE,nil,nil,nil,GetCardFromScript(oppmon))
  end
  return BestTargets(cards)
end
function ForceStrixTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards)
end
function BlizzardTarget(cards)
  return Add(cards,PRIO_TOFIELD,1,FilterLevel,4)
end
function IcarusTarget(cards,min)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  elseif min==1 then
    return Add(cards,PRIO_TOGRAVE)
  else
    return BestTargets(cards,2,TARGET_DESTROY,Affected,TYPE_TRAP)
  end
end
GlobalMKB={}
function MKBSet(target,source)
  GlobalMKB[target.cardid]=source.cardid
  return
end
function MKBCheck(target)
  if target == nil then return false end
  local source = GlobalMKB[target.cardid]
  if source == nil then return false end
  source = FindCard(source,Field())
  if source == nil then return false end
  if target and source and FilterLocation(target,LOCATION_ONFIELD) 
  and NotNegated(source)
  and FilterLocation(source,LOCATION_ONFIELD)
  and FilterAffected(target,EFFECT_INDESTRUCTABLE_EFFECT)
  then
    return source
  end
  return false
end
function MKBTarget(cards,source)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if GlobalCardMode == 1 then
    local result = nil
    GlobalCardMode = nil
    if HasID(cards,38296564,true) then
      result=IndexByID(cards,38296564)
      MKBSet(cards[result],source)
      return {result}
    elseif HasID(cards,05851097,true) then
      result=IndexByID(cards,05851097)
      MKBSet(cards[result],source)
      return {result}
    else
      result = BestTargets(cards,1,TARGET_PROTECT)
      MKBSet(cards[1],source)
      return result
    end
  end
  return Add(cards,PRIO_TOGRAVE,1,function(c) 
    return c.id~=05851097 and c.id~=38296564 
  end)
end
function DDCrowTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function RaikiriFilter(c)
  return DestroyFilter(c)
  and Affected(c,TYPE_MONSTER,7)
end
function RaikiriTarget(cards,max)
  local count = math.max(1,math.min(CardsMatchingFilter(OppField(),RaikiriFilter),max))
  return BestTargets(cards,count,TARGET_DESTROY)
end
function BlackwingCard(cards,min,max,id,c)
  if c then
    id = c.id
  end
  if id == 16051717 then
    return RaikiriTarget(cards,max)
  end
  if id == 02009101 then 
    return BestTargets(cards,1,TARGET_OTHER)
  end
  if id == 95040215 then 
    return BestTargets(cards,1,TARGET_OTHER)
  end
  if id == 91351370 then
    return Add(cards)
  end
  if id == 55610595 then
    return Add(cards)
  end
  if id == 81983656 then
    return HawkJoeTarget(cards,c)
  end
  if id == 58820853 then
    return Add(cards,PRIO_TOFIELD)
  end
  if id == 73347079 then
    return ForceStrixTarget(cards)
  end
  if id == 22835145 then
    return BlizzardTarget(cards)
  end
  if id == 53567095 then
    return IcarusTarget(cards,min)
  end
  if id == 76067258 then
    return MKBTarget(cards,c)
  end
  if id == 24508238 then
    return DDCrowTarget(cards,c)
  end
  if id == 52687916 then -- Synch Trishula
    return BestTargets(cards,1,TARGET_BANISH)
  end
  if id == 27174286 then -- RftDD
    return BestTargets(cards,PRIO_TOFIELD,max)
  end
  return nil
end
function ChainKalut()
  local aimon,oppmon=GetBattlingMons() 
  local count = CardsMatchingFilter(AIHand(),FilterID,85215458)
  if aimon and (AttackBoostCheck(1400*count) 
  or CanFinishGame(aimon,oppmon,aimon:GetAttack()+1400*count))
  and UnchainableCheck(85215458)
  then
    return true
  end
  return false
end
function BlackSonicFilter(c)
  return FilterPosition(c,POS_ATTACK)
  and Affected(c,TYPE_TRAP)
end
function ChainBlackSonic(c)
  if RemovalCheckCard(c) then
    return true
  end
  local targets = SubGroup(OppMon(),BlackSonicFilter)
  local targets2 = SubGroup(targets,PriorityTarget)
  local aimon,oppmon = GetBattlingMons()
  if (WinsBattle(oppmon,aimon) 
  or #targets>1
  or #target2>0)
  and UnchainableCheck(72930878)
  then
    return true
  end
end
function IcarusFilter(c)
  return DestroyFilterIgnore(c)
  and Targetable(c,TYPE_TRAP)
  and Affected(c,TYPE_TRAP)
end
function ChainIcarus(card)
  local targets = SubGroup(OppField(),IcarusFilter)
  local prio = HasPriorityTarget(targets)
  local removal = {}
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if FilterRace(c,RACE_WINDBEAST) 
    and RemovalCheckCard(c)
    then
      removal[#removal+1]=c
    end
  end
  if (#removal>0 and UnchainableCheck(53567095)
  or RemovalCheckCard(card))
  and #targets>1
  then
    if #removal>0 then
      BestTargets(removal,1,TARGET_PROTECT)
      GlobalTargetSet(removal[1])
      GlobalCardMode=1
    end
    return true
  end
  if prio and #targets>1 
  and Duel.GetTurnPlayer()==1-player_ai
  and UnchainableCheck(53567095) 
  then
    return true
  end
  if IsBattlePhase() 
  and Duel.GetTurnPlayer()==1-player_ai
  then
    local aimon,oppmon = GetBattlingMons()
    local Kalutcount = CardsMatchingFilter(AIHand(),FilterID,85215458)
    if WinsBattle(oppmon,aimon) and #targets>1 
    and UnchainableCheck(53567095)
    and not (AttackBoostCheck(1400*Kalutcount) and MacroCheck()) 
    then
      return true
    end
  end
  return false
end
function ChainHawkJoe(c)
  if Negated(c) then return false end
  local aimon,oppmon = GetBattlingMons()
  if Duel.GetTurnPlayer()~=player_ai 
  and WinsBattle(oppmon,aimon) 
  and Duel.GetCurrentChain()==0
  then
    return true
  end
  if Duel.GetCurrentChain()>0 then
    return true
  end
  return false
end
function ChainDDCrow(card)
  local c=CheckTarget(card,OppGrave(),true,FilterType,TYPE_MONSTER)
  if c and UnchainableCheck(24508238) then
    GlobalCardMode=1
    GlobalTargetSet(c)
    return true
  end
  local c=CheckSS(card,OppGrave(),true,LOCATION_GRAVE,FilterType,TYPE_MONSTER)
  if c and UnchainableCheck(24508238) then
    GlobalCardMode=1
    GlobalTargetSet(c)
    return true
  end
  local darkcount = CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_DARK)
  local crowcount = CardsMatchingFilter(AIHand(),FilterID,24508238)
  if HasIDNotNegated(AIHand(),65192027,true) and DestroyCheck(OppField())>1
  and darkcount<3 and darkcount+crowcount>=3 and #OppGrave()>=crowcount-darkcount
  and UnchainableCheck(24508238) and Duel.GetTurnPlayer()==player_ai
  then
    return true
  end
  return false
end
function DeltaCrowFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
  and DestroyCheck(c)
  and Targetable(c,TYPE_TRAP)
  and Affected(c,TYPE_TRAP)
end
function ChainDeltaCrow(c)
  local targets = CardsMatchingFilter(OppST(),DeltaCrowFilter)
  if RemovalCheckCard(c) then
    return true
  end
  local count = 0
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if RemovalCheckCard(c) and BlackwingFilter(c) then
      count = count+1
    end
  end
  if count>=CardsMatchingFilter(AIMon(),BlackwingFilter) then
    return UnchainableCheck(59839761)
  end
  if (Duel.GetCurrentPhase()==PHASE_END 
  and Duel.GetTurnPlayer()~=player_ai
  or Duel.GetTurnPlayer()==player_ai)
  and targets>1 
  then
    return UnchainableCheck(59839761)
  end
end
function BlackwingChain(cards)
  if HasIDNotNegated(cards,59839761,ChainDeltaCrow) then 
    return {1,CurrentIndex}
  end
  if HasID(cards,85215458) and ChainKalut() then 
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,91351370) then -- Black Whirlwind
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,95040215) then -- Nothung
    return {1,CurrentIndex}
  end
  if HasID(cards,55610595) then -- Pinaka
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,58820853) then -- Shura
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,22835145) then -- Blizzard
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,72930878,nil,LOCATION_HAND,ChainBlackSonic) then 
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,72930878,ChainBlackSonic) then 
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,53567095,ChainIcarus) then 
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,81983656,ChainHawkJoe) then 
    return {1,CurrentIndex}
  end
  if HasID(cards,24508238,ChainDDCrow) then
    return {1,CurrentIndex}
  end
  return nil
end
function BlackwingEffectYesNo(id,card)
  local result = nil
  if id==85215458 and ChainKalut() then
    result = 1
  end
  if id==91351370 and NotNegated(card) then -- Black Whirlwind
    result = 1
  end
  if id==95040215 and NotNegated(card) then -- Nothung
    result = 1
  end
  if id==58820853 and NotNegated(card) then -- Shura
    result = 1
  end
  if id == 55610595 then -- Pinaka
    result = 1
  end
  if id == 22835145 and NotNegated(card) then -- Blizzard
    result = 1
  end
  if id == 81983656 and ChainHawkJoe(card) then
    result = 1
  end
  return result
end

function BlackwingOption(options)
  return nil
end

BlackwingAtt={
81105204, -- Kris
58820853, -- Shura
49003716, -- Bora
14785765, -- Zephyros
85215458, -- Kalut
02009101, -- Gale
81983656, -- Hawk Joe
69031175, -- Armor Master
33698022, -- Moonlight Rose
95040215, -- Nothung
76067258, -- Master Key Beetle

75498415, -- Sirocco
52687916, -- Trishula
27315304, -- Mist Wurm
33236860, -- Silverwing
09012916, -- Black-Winged Dragon
23693634, -- Colossal Fighter
50321796, -- Brionac
76913983, -- Armed Wing
90953320, -- Hyper Librarian
26593852, -- Catastor
}
BlackwingDef={
28190303, -- Gladius
22835145, -- Blizzard
73652465, -- Oroshi
73347079, -- Force Strix

72714392, -- Vayu
24508238, -- D.D. Crow
}
function BlackwingPosition(id,available)
  result = nil
  for i=1,#BlackwingAtt do
    if BlackwingAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#BlackwingDef do
    if BlackwingDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end

