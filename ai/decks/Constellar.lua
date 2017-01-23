function ConstellarPriority()
AddPriority({
[65367484] = {2,1,5,1,3,1,1,1,1,1,ThrasherCond},      -- Thrasher
[70908596] = {8,3,9,1,8,1,1,1,5,1,KausCond},          -- Kaus
[78364470] = {7,3,6,1,5,1,1,1,7,1,PolluxCond},        -- Pollux
[41269771] = {6,2,7,1,6,1,1,1,8,1,AlgiediCond},       -- Algiedi
[06353603] = {2,1,4,1,2,1,1,1,1,1,BearCond},          -- FF Bear
[78358521] = {9,4,8,1,4,1,1,1,6,2,SombreCond},        -- Sombre
[44635489] = {4,1,4,1,1,1,1,1,3,1,SiatCond},        -- Sombre

[35544402] = {1,1,1,1,1,1,1,1,1,1,TwinkleCond},       -- Twinkle
[57103969] = {1,1,1,1,1,1,1,1,1,1,TenkiCond},         -- Tenki

[50078509] = {1,1,1,1,1,1,1,1,1,1,FiendishCond},      -- Fiendish

[73964868] = {1,1,1,1,1,1,1,1,7,1,nil},               -- Constellar Pleiades
[38495396] = {1,1,1,1,4,2,1,1,8,1,PtolemyCond},       -- Constellar Ptolemy M7
[26329679] = {1,1,1,1,1,1,1,1,9,1,nil},               -- Constellar Omega
[31386180] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Tiras
[56832966] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Utopia Lightning
[84013237] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Utopia
[31437713] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Heartlanddraco
})
end
function ConstellarFilter(c,exclude)
  return IsSetCode(c.setcode,0x53) and (exclude == nil or c.id~=exclude)
end
function ConstellarMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) and ConstellarFilter(c,exclude)
end
function ConstellarNonXYZFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) and not FilterType(c,TYPE_XYZ)
  and ConstellarFilter(c,exclude)
end
function PolluxCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),78364470,true) 
    and HasID(AIHand(),70908596,true) 
    or CardsMatchingFilter(AIHand(),ConstellarMonsterFilter)==0
  end
  return true
end
function KausCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),70908596,true) 
    and not HasID(AICards(),57103969,true,nil,nil,POS_FACEDOWN) 
    and (HasID(AIHand(),78364470,true) or HasID(AIHand(),41269771,true)
    or HasID(AIMon(),78358521,true) and not OPTCheck(783585211) and OPTCheck(783585212))
    or CardsMatchingFilter(AIHand(),ConstellarMonsterFilter)==0 and not HasAccess(70908596)
  end
  if loc == PRIO_TOGRAVE then
    return not HasID(AIGrave(),70908596,true) 
    and FilterLocation(c,LOCATION_DECK)
  end
  if loc == PRIO_TOFIELD then
    return not HasID(AIMon(),70908596,true) 
  end
  return true
end
function AlgiediCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),41269771,true) 
    and HasID(AIHand(),70908596,true) 
  end
  return true
end
function SombreCond(loc,c)
  if loc == PRIO_TOHAND then
    local cards = UseLists(AIMon(),AIMaterials(),AIGrave())
    if (FilterLocation(c,LOCATION_GRAVE) and not OPTCheck(783585211) 
    and OPTCheck(783585212) and HasIDNotNegated(AIMon(),78358521,true))
    then
      if HasID(AICards(),70908596,true) then
        return true
      end
      return false
    end
    return CardsMatchingFilter(cards,ConstellarNonXYZFilter)>1 and HasAccess(70908596) 
  end
  return true
end
function ThrasherCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function BearCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  return true
end
function PtolemyCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0
  end
  return true
end
function SummonThrasher(mode)
  if mode == 1 and (HasID(AIHand(),78364470,true) or HasID(AIHand(),41269771,true)) 
  and HasID(AIHand(),78358521,true) and not HasID(AIHand(),70908596,true)
  then
    return true
  elseif mode == 2 and CardsMatchingFilter(AIHand(),FilterLevel,4)>1 then
    return true
  elseif mode == 3 and OppGetStrongestAttack()<2100 then
    return true
  end
end
function SummonPollux(mode)
  if mode == 1 and HasID(AIHand(),70908596,true) and DualityCheck()
  and FieldCheck(4)==0 and OverExtendCheck()
  then
    return true
  elseif mode == 2 and CardsMatchingFilter(AIHand(),ConstellarMonsterFilter)>1 
  and FieldCheck(4)==0 and OverExtendCheck()
  then
    return true
  elseif mode == 3 and DualityCheck()
  and FieldCheck(4)==1 and OverExtendCheck()
  then
    return true
  end
end
function SummonAlgiedi(mode)
  if mode == 1 and HasID(AIHand(),70908596,true) and DualityCheck()
  and FieldCheck(4)==0 and OverExtendCheck()
  then  
    return true
  elseif mode == 2 and CardsMatchingFilter(AIHand(),ConstellarMonsterFilter)>1 
  and FieldCheck(4)==0 and OverExtendCheck()
  then
    return true
  elseif mode == 3 and DualityCheck() 
  and FieldCheck(4)==1 and OverExtendCheck()
  then
    return true
  end
end
function SummonKaus(mode)
  if mode == 1 and DualityCheck()
  and CardsMatchingFilter(AIMon(),ConstellarNonXYZFilter)==1 
  then
    return true
  elseif mode == 2 and DualityCheck() and OverExtendCheck()
  and (FieldCheck(4)==1 or HasIDNotNegated(AICards(),01845204,true) 
  and HasID(AIExtra(),72959823,true) and WindaCheck())
  then
    return true
  end
  return false
end
function UseKaus(c)
  local cards=SubGroup(AIMon(),FilterPosition,POS_FACEUP)
  return (CardsMatchingFilter(cards,ConstellarNonXYZFilter)>1 
  or FieldCheck(5)==1 and c.level<5)
  and FieldCheck(5)~=2
end
function SombreFilter(c)
  return ConstellarMonsterFilter(c)
end
function SummonSombre(mode)
  if mode == 1 and DualityCheck() and CardsMatchingFilter(AIGrave(),SombreFilter)>1
  and HasID(UseLists(AIHand(),AIGrave()),70908596,true) and OverExtendCheck()
  then
    return true
  elseif mode == 2 and DualityCheck() 
  and FieldCheck(4)==1 and OverExtendCheck()
  then
    return true
  end
  return false
end
function UseSombre(mode)
  if mode == 1 and OPTCheck(783585211) 
  and CardsMatchingFilter(AIGrave(),SombreFilter)>1 
  then
    GlobalCardMode = 2
    return true
  elseif mode == 2 and not OPTCheck(783585211)
  and CardsMatchingFilter(AIMon(),ConstellarNonXYZFilter)==1 
  then
    return true
  end
end
function SummonBear(c)
  return DeckCheck(DECK_CONSTELLAR) and (UseBear()
  or CanDealBattleDamage(c,OppMon())
  or FieldCheck(4)==1)
end
function UseChainConstellar(mode)
  if not DeckCheck(DECK_CONSTELLAR) then return false end
  if mode == 1 and HasID(AIHand(),78358521,true) 
  and not HasAccess(70908596) and HasID(AIDeck(),70908596,true) 
  then
    return true
  end
  if mode == 1 and HasID(AIMon(),78358521,true) and OPTCheck(783585211) 
  and not HasID(UseLists(AIHand(),AIGrave()),78358521,true)
  and HasID(AIDeck(),70908596,true) 
  then
    return true
  end
  if mode == 2 and (HasID(AIHand(),78364470,true) 
  or HasID(AIHand(),41269771,true)) and TurnEndCheck()
  then
    return true
  end
  if mode == 3 and TurnEndCheck() then
    GlobalCardMode = 2
    return true
  end
  return false
end
function SummonChainConstellar(mode)
  if not (DeckCheck(DECK_CONSTELLAR) and HasID(AIExtra(),34086406,true)) then return false end
  if mode == 1 and HasID(AIHand(),78358521,true) and not HasAccess(70908596) 
  and HasID(AIDeck(),70908596,true) and (not OppHasStrongestMonster() or OppGetStrongestAttDef()<1800)
  then
    return true
  end
  if mode == 1 and HasID(AIMon(),78358521,true) and OPTCheck(783585211) 
  and not HasID(UseLists(AIHand(),AIGrave()),78358521,true)
  and FieldCheck(4)>2
  then
    return true
  end
  if mode == 2 and (HasID(AIHand(),78364470,true) 
  or HasID(AIHand(),41269771,true)) and MP2Check(1800)
  and (not OppHasStrongestMonster() or OppGetStrongestAttDef()<1800)
  then
    return true
  end
  if mode == 3 and MP2Check(1800) 
  and (not OppHasStrongestMonster() or OppGetStrongestAttDef()<1800)
  then
    return true
  end
  return false
end
function SummonConstellar(c)
  if #AIMon() == 0 and (#OppMon() == 0 
  or c.attack>=OppGetStrongestAttDef()
  or CardsMatchingFilter(AIHand(),ConstellarMonsterFilter)>1
  or HasID(AIHand(),37742478,true))
  then
    return true
  end
  return false
end
function SiatFilter(c,level)
  return ConstellarNonXYZFilter(c)
  and FilterLevel(c,level)
end
GlobalSiatLevel = 4
function UseSiat(c,mode)
  if mode == 1 
  and CardsMatchingFilter(UseLists(AIMon(),AIGrave()),SiatFilter,5)>0
  and FieldCheck(5) == 1
  then
    GlobalSiatLevel = 5
    return true
  end
  if mode == 2
  and CardsMatchingFilter(UseLists(AIMon(),AIGrave()),SiatFilter,4)>0
  and FieldCheck(4) == 1
  then
    GlobalSiatLevel = 4
    return true
  end
end
function SummonSiat(c,mode)
  if mode == 1 
  and HasIDNotNegated(AIHand(),70908596,true)
  and not NormalSummonCheck()
  then 
    return true
  end
  if mode == 2
  and CardsMatchingFilter(AIHand(),SiatFilter,4)>0
  and not NormalSummonCheck()
  then
    return true
  end
  if mode == 3
  and CardsMatchingFilter(AIMon(),SiatFilter,5)>0
  and FieldCheck(5)==1
  then
    return true
  end
  if mode == 4
  and CardsMatchingFilter(UseLists(AIMon(),AIGrave()),SiatFilter,4)>0
  and FieldCheck(4)==1
  then
    return true
  end
end
function ConstellarInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,32807846) and UseRotA() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,57103969) and DeckCheck(DECK_CONSTELLAR) then
    OPTSet(57103969)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,44635489,UseSiat,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,70908596) and UseKaus(Act[CurrentIndex]) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,44635489,UseSiat,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,34086406,false,545382497) and UseChainConstellar(1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,78358521) and UseSombre(1) then
    OPTSet(783585211)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,78358521) and UseSombre(2) then
    OPTSet(783585212)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,34086406) and SummonChainConstellar(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,44635489,SummonSiat,1) then
    return SpSummon()
  end
  if HasID(SpSum,65367484) and SummonThrasher(1) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,78358521) and SummonSombre(1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,70908596) and SummonKaus(1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,78364470) and SummonPollux(1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,41269771) and SummonAlgiedi(1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,65367484) and SummonThrasher(2) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,44635489,SummonSiat,2) then
    return SpSummon()
  end
  if HasIDNotNegated(Sum,78364470) and SummonPollux(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,41269771) and SummonAlgiedi(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,41269771) and SummonAlgiedi(3) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,78364470) and SummonPollux(3) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,70908596) and SummonKaus(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,78358521) and SummonSombre(2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,06353603) and SummonBear(Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,65367484) and SummonThrasher(3) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Sum,44635489,SummonSiat,3) then
    return Summon()
  end
  if HasID(Sum,44635489,SummonSiat,4) then
    return Summon()
  end
  if HasID(Sum,41269771) and SummonConstellar(Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,78364470) and SummonConstellar(Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,70908596) and SummonConstellar(Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,78358521) and SummonConstellar(Sum[CurrentIndex]) then
    return {COMMAND_SUMMON,CurrentIndex}
  end

  if HasIDNotNegated(Act,34086406,false,545382498) and UseChainConstellar(3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,34086406) and SummonChainConstellar(3) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  return nil
end
function KausTarget(cards)
  return BestTargets(cards,1,TARGET_PROTECT,FilterLevel,4)
end
function SombreTarget(cards)
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    return Add(cards,PRIO_BANISH)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards)
  end
  return Add(cards,PRIO_TOFIELD)
end
function AlgiediTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function SiatTarget(cards)
  return BestTargets(cards,1,TARGET_PROTECT,FilterLevel,GlobalSiatLevel)
end
function ConstellarCard(cards,min,max,id,c)
  if c then
    id = c.id
  end
  if id == 70908596 then 
    return KausTarget(cards)
  end
  if id == 78358521 then 
    return SombreTarget(cards)
  end
  if id == 41269771 then 
    return AlgiediTarget(cards)
  end
  if id == 44635489 then
    return SiatTarget(cards)
  end
  return nil
end
function ChainAlgiedi()
  return FieldCheck(4)==1 and HasID(AIHand(),70908596,true)
  or FieldCheck(4)==2 and HasID(AIHand(),78358521,true)
  and SummonChainConstellar(1)
  or FieldCheck(4)==1 and CardsMatchingFilter(AIHand(),ConstellarMonsterFilter)>0
  and OverExtendCheck()
end
function ConstellarChain(cards)
  if HasID(cards,41269771) and ChainAlgiedi() then 
    return {1,CurrentIndex}
  end
  return nil
end

function ConstellarEffectYesNo(id,card)
  local result = nil
  if id==41269771 and ChainAlgiedi() then
    result = 1
  end
  return result
end

function ConstellarOption(options)
  for i=1,#options do
    if options[i] == 1134537537 then
      return i
    end
    if options[i] == 1134537538 then
      --return i
    end
  end
  return nil
end

ConstellarAtt={
70908596,78364470,41269771,78358521,
91949988,31386180,84013237,56832966,
26329679,31437713,
}
ConstellarDef={
72959823,44635489,
}
function ConstellarPosition(id,available)
  result = nil
  for i=1,#ConstellarAtt do
    if ConstellarAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#ConstellarDef do
    if ConstellarDef[i]==id then result=POS_FACEUP_DEFENSE end
  end
  return result
end
