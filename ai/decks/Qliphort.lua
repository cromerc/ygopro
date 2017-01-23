
function QliphortPriority()
AddPriority({
--Qliphort:
[65518099] = {9,4,1,1,5,1,7,5,1,1,ToolCond},          -- Qliphort Tool
[51194046] = {8,3,1,1,5,1,7,5,1,1,MonolithCond},      -- Qliphort Monolith
[27279764] = {7,2,1,1,1,1,1,1,1,1,KillerCond},        -- Apoqliphort Killer
[90885155] = {5,2,5,2,2,1,3,1,1,1,ShellCond},         -- Qliphort Shell
[64496451] = {6,2,5,2,2,1,4,1,1,1,DiskCond},          -- Qliphort Disk
[13073850] = {7,2,4,2,2,1,5,1,1,1,StealthCond},       -- Qliphort Stealth
[37991342] = {5,3,7,4,8,4,1,1,1,1,GenomeCond},        -- Qliphort Genome
[91907707] = {5,3,6,3,9,4,2,1,1,1,ArchiveCond},       -- Qliphort Archive
[16178681] = {7,2,1,1,1,1,1,1,1,1,OddEyesCond},       -- Odd-Eyes Pendulum Dragon
[43241495] = {5,1,1,1,1,1,1,1,1,1,LynxCond},          -- Performapal Trampolynx

[79816536] = {9,4,1,1,1,1,1,1,1,1,SummonersCond},     -- Summoners Art
[17639150] = {8,2,1,1,1,1,1,1,1,1,SacrificeCond},     -- Qliphort Sacrifice
[25067275] = {1,1,1,1,1,1,1,1,1,1,SADCond},           -- Swords At Dawn
[31222701] = {10,1,1,1,1,1,1,1,1,1,WaveringEyesCond}, -- Wavering Eyes

[04450854] = {5,2,1,1,1,1,1,1,1,1,ApoCond},           -- Apoqliphort
[05851097] = {3,1,1,1,0,0,1,1,1,1,nil},               -- Vanitys Emptiness
[82732705] = {3,1,1,1,0,0,1,1,1,1,nil},               -- Skill Drain
[88197162] = {2,1,1,1,0,0,1,1,1,1,nil},               -- Soul Transition
[20426097] = {2,1,1,1,0,0,1,1,1,1,nil},               -- Re-qliate
[24348807] = {2,1,1,1,0,0,1,1,1,1,nil},               -- Lose A Turn

})
end
function QliphortFilter(c,exclude)
  return IsSetCode(c.setcode,0xaa) and (exclude == nil or c.id~=exclude)
end

function QliphortAttackBonus(id,level)
  if level == 4 then
    if id == 90885155 or id == 64496451 
    or id == 13073850
    then
      return 1000
    elseif id == 37991342 or id == 91907707 then
      return 600
    end
  end
  return 0
end
GlobalTribute={}
function TributeCount(add)
  local result = GlobalTribute[Duel.GetTurnCount()]
  if add then
    if result==nil then
      result = 0
    end
    result = result + add
    GlobalTribute[Duel.GetTurnCount()]=result
    return
  end
  if result then
    return result
  end
  return 0
end
function TributeCheck(amount)
  if HasID(AIST(),17639150,true,nil,nil,nil,FilterPosition,POS_FACEUP) then
    amount = math.max(amount-1,1)
  end
  local result = PriorityCheck(AIMon(),PRIO_TOGRAVE,amount,QliphortFilter)
  if result == -1 then return false end
  return result
end
function SkillDrainCheck()
  return HasIDNotNegated(AllST(),82732705,true,FilterPosition,POS_FACEUP)
end

function ToolCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIST()}),65518099,true)
  end
  return true
end
function SummonersCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIST()}),65518099,true) and HasID(AIDeck(),65518099,true)
  end
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_MZONE) 
    and not HasID(AIHand(),13073850,true)
  end
  return true
end
function KillerCond(loc,c)
  if loc == PRIO_TOHAND then
    return TributeSummonKiller()
  end
  return true
end
function ShellCond(loc,c)
  if loc == PRIO_TOHAND then
    return TributeSummonShell() and not HasID(AIHand(),90885155,true)
  end
  if loc == PRIO_TOFIELD then
    return SkillDrainCheck()
  end
  return true
end
function MonolithCond(loc,c)
  if loc == PRIO_TOHAND then
    if HasID(AICards(),65518099,true) then
      return 5
    end
    return QliPendulumSummon(2) and not HasID(AIHand(),51194046,true)
  end
  return true
end
function DiskCond(loc,c)
  if loc == PRIO_TOHAND then
    return (TributeSummonDisk() or QliPendulumSummon(2))and not HasID(AIHand(),64496451,true)
  end
  if loc == PRIO_TOFIELD then
    return SkillDrainCheck()
  end
  return true
end
function StealthCond(loc,c)
  if loc == PRIO_TOHAND then
    return (TributeSummonStealth(1) or QliPendulumSummon(2))and not HasID(AIHand(),13073850,true)
  end
  if loc == PRIO_TOFIELD then
    return SkillDrainCheck()
  end
  return true
end
function WaveringEyesCondCond(loc,c)
  if loc == PRIO_TOHAND then
    local cards = UseLists(AIHand(),AllPendulum())
    if CardsMatchingFilter(cards,FilterType,TYPE_PENDULUM)>1 
    and HasID(AIDeck(),65518099,true)
    then
      return true
    end
  end
  return true
end
function GenomeCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIMon(),AIExtra()}),37991342,true)
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(OppST(),DestroyFilter) 
    > CardsMatchingFilter(AIMon(),FilterID,37991342) + GetMultiple(37991342)
  end
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(OppST(),DestroyFilter) > GetMultiple(37991342)
  end
end
function ArchiveFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,6)
  and not ToHandBlacklist(c.id) 
end
function ArchiveCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIMon(),AIExtra()}),91907707,true) or QliPendulumSummon(2)
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(OppMon(),ArchiveFilter) 
    > CardsMatchingFilter(AIMon(),FilterID,00706925) + GetMultiple(00706925)
  end
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(OppMon(),ArchiveFilter) > GetMultiple(00706925)
  end
  return true
end
function OddEyesCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIST()}),65518099,true)
  end
  return true
end
function LynxCond(loc,c)
  if loc == PRIO_TOHAND then
    if HasID(UseLists({AIHand(),AIST()}),65518099,true) then
      return true
    end
    return false
  end
  return true
end
function SacrificeCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIST()}),17639150,true) 
    and (PriorityCheck(AIHand(),PRIO_TOFIELD)>2 or CardsMatchingFilter(AIMon(),QliphortFilter)>0)
    and not QliPendulumSummon(2) and not (#AIMon()>1)
  end
  return true
end
function ApoCond(loc,c)
  if loc == PRIO_TOHAND then
    return HasID(AIExtra(),65518099,true)
  end
  return true
end

function UseTool(c)
  if bit32.band(c.location,LOCATION_HAND)>0 then
    return ScaleCheck() == false or ScaleCheck() < 8
  elseif bit32.band(c.location,LOCATION_SZONE)>0 then
    if AI.GetPlayerLP(1)<=800 then return false end
    return AI.GetPlayerLP(1)>4000 or ScaleCheck() ~= true
    and QliPendulumSummon(2) or OppHasStrongestMonster()
  end
  return false
end
function UseSacrifice()
  return not HasID(AIST(),17639150,true,nil,nil,nil,FilterPosition,POS_FACEUP) 
  and CardsMatchingFilter(AIMon(),QliphortFilter)>0
end
function QliPendulumSummon(count)
  if count == nil then count = 1 end
  return CardsMatchingFilter(AIExtra(),QliphortFilter)>=count
  and DualityCheck() and PendulumSummonCheck()
end
function TributeSummonShell()
  if TributeCheck(2) and (not SkillDrainCheck() 
  or TributeCheck(2)>5 and OppHasStrongestMonster())
  and not NormalSummonCheck(player_ai) 
  then
    return true
  end
  return false
end
function TributeSummonStealth(mode)
  if TributeCheck(2) 
  and not NormalSummonCheck(player_ai)
  and (mode == 1 and (TributeCheck(1)>5 
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN)>0
  or TributeCheck(3) and HasID(AIMon(),65518099,true))
  or mode == 2 and TributeCheck(2)>5) 
  then
    return true
  end
  return false
end
function TributeSummonDisk()
  if TributeCheck(2) and (not SkillDrainCheck() and DualityCheck() 
  or TributeCheck(2)>5 and OppHasStrongestMonster())
  and not NormalSummonCheck(player_ai)
  then
    return true
  end
  return false
end
function TributeSummonKiller()
  if TributeCheck(3) 
  and (not SkillDrainCheck() 
  or TributeCheck(3)>5 
  and OppHasStrongestMonster())
  and not NormalSummonCheck(player_ai)
  and (ExpectedDamage(2)<AI.GetPlayerLP(2)
  or OppHasStrongestMonster())
  then
    return true
  end
  return false
end
function TributeSummonArchive()
  if TributeCheck(1) and TributeCheck(1)>5 and OppHasStrongestMonster() then
    return true
  end
  return false
end
function TributeSummonGenome()
  if TributeCheck(1) and TributeCheck(1)>5 and OppHasStrongestMonster() then
    return true
  end
  return false
end
function TributeSummonMonolith()
  if TributeCheck(1) and TributeCheck(1)>5 and OppHasStrongestMonster() then
    return true
  end
  return false
end
function SummonArchive()
  if OverExtendCheck() then
    return true
  end
  return false
end
function SummonGenome()
  if OverExtendCheck() then
    return true
  end
  return false
end
function SummonShell()
  if OverExtendCheck() then
    return true
  end
  return false
end
function SummonDisk()
  if OverExtendCheck() then
    return true
  end
  return false
end
function SummonStealth()
  if OverExtendCheck() then
    return true
  end
  return false
end
function UseGenome()
  return ScaleCheck() and ScaleCheck()<9 and QliPendulumSummon()
end
function UseArchive()
  return ScaleCheck()==9 and QliPendulumSummon()
end
function UseDisk()
  return ScaleCheck()==9 and QliPendulumSummon() and not TributeSummonDisk()
end
function UseStealth()
  return ScaleCheck()==9 and QliPendulumSummon() and not TributeSummonStealth(1)
end
function UseShell()
  return ScaleCheck() and ScaleCheck()<9 and QliPendulumSummon() and not TributeSummonShell()
end
function UseTrampolynx()
  return ScaleCheck()==9 and QliPendulumSummon()
end
function UseMonolith()
  return ScaleCheck()==9 and QliPendulumSummon()
end
function UseOddEyes()
  return (ScaleCheck()==9 and QliPendulumSummon() 
  or not HasID(UseLists(AIMon(),AIST()),65518099,true)
  or not HasID(UseLists(AIMon(),AIST()),43241495,true))
  and not HasID(AIST(),16178681,true)
end
function UseDualityQliphort()
  return DeckCheck(DECK_QLIPHORT) and (ScaleCheck()==false or not QliPendulumSummon())
end
GlobalPendulum=0
function PendulumSummonCheck()
  return GlobalPendulum~=Duel.GetTurnCount()
end
function UseSAD(sum)
  return UnchainableCheck(25067275) and CardsMatchingFilter(AIMon(),QliphortFilter)>0
  and (CardsMatchingFilter(sum,FilterLevel,7)>0 or CardsMatchingFilter(sum,FilterLevel,8)>0)
end
function SetScaleWaveringEyes(c)
  local count = CardsMatchingFilter(AllPendulum(),WaveringEyesFilter,true) 
  if HasIDNotNegated(AICards(),31222701,true,FilterOPT,true)
  and FilterLocation(c,LOCATION_HAND)
  and FilterType(c,TYPE_PENDULUM)
  and (count<2 and HasID(AIDeck(),65518099,true)
  and count+CardsMatchingFilter(AIHand(),FilterType,TYPE_PENDULUM)>1
  or count==2 and CardsMatchingFilter(OppField(),WaveringEyesFilter2)>0
  or count==3 and HasID(AIDeck(),31222701,true))
  then
    return true
  end
  return false
end
function WaveringEyesFilter(c)
  return Affected(c,TYPE_SPELL)
  and DestroyCheck(c)
end
function WaveringEyesFilter2(c)
  return Affected(c,TYPE_SPELL)
  and Targetable(c,TYPE_SPELL)
  and not ListHasCard(OppPendulum(),c)
end
function UseWaveringEyes(c,mode)
  if mode == 1 then
    local count = CardsMatchingFilter(AllPendulum(),WaveringEyesFilter,true)
    if count>1 and HasID(AIDeck(),65518099,true)
    or count>2 and CardsMatchingFilter(OppField(),WaveringEyesFilter2)>0
    or count>3 and HasID(AIDeck(),31222701,true)
    then
      return true
    end
  end
  return false
end
function QliphortInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  GlobalQliphortNormalSummon = nil
  if HasIDNotNegated(Act,65518099,false,FilterLocation,LOCATION_SZONE) 
  and UseTool(Act[CurrentIndex]) and HasID(AIST(),43241495,true) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  for i=1,#SpSum do
    if PendulumCheck(SpSum[i]) and QliPendulumSummon() then
      GlobalPendulumSummoning = true
      GlobalPendulum=Duel.GetTurnCount()
      return {COMMAND_SPECIAL_SUMMON,i}
    end
  end
  if HasID(Act,27279764) then -- Killer
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,79816536) then -- Summoners Art
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,25067275) and UseSAD(Sum) then 
    GlobalDuality=Duel.GetTurnCount()
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,17639150) and UseSacrifice() then 
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,65518099,false,FilterLocation,LOCATION_HAND,UseTool) then
    return Activate()
  end
  for i=1,#Act do
    if SetScaleWaveringEyes(Act[i]) then
      return Activate(i)
    end
  end
  if HasIDNotNegated(Act,31222701,UseWaveringEyes,1) then
    OPTSet(31222701)
    return Activate()
  end
  if HasID(Act,51194046) and UseMonolith() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,43241495) and UseTrampolynx() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,16178681) and UseOddEyes() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,91907707) and UseArchive() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,65518099,false,FilterLocation,LOCATION_SZONE) 
  and UseTool(Act[CurrentIndex]) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,37991342) and UseGenome() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,64496451) and UseDisk() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,13073850) and UseStealth() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,90885155) and UseShell() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,27279764) and TributeSummonKiller() then
    TributeCount(3)
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,13073850) and TributeSummonStealth(1) then
    TributeCount(2)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,64496451) and TributeSummonDisk() then
    TributeCount(2)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,90885155) and TributeSummonShell() then
    TributeCount(2)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,13073850) and TributeSummonStealth(2) then
    TributeCount(2)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,98645731) and UseDualityQliphort() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,51194046) and TributeSummonMonolith() then
    TributeCount(1)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,37991342) and TributeSummonGenome() then
    TributeCount(1)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,91907707) and TributeSummonArchive() then
    TributeCount(1)
    GlobalQliphortNormalSummon = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,37991342) and SummonGenome() then
    GlobalQliphortNormalSummon = 2
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,91907707) and SummonArchive() then
    GlobalQliphortNormalSummon = 2
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,90885155) and SummonShell() then
    GlobalQliphortNormalSummon = 2
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,64496451) and SummonDisk() then
    GlobalQliphortNormalSummon = 2
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,13073850) and SummonStealth() then
    GlobalQliphortNormalSummon = 2
    return {COMMAND_SUMMON,CurrentIndex}
  end
  return nil
end
function QliphortOption(options)
  local i = GlobalQliphortNormalSummon
  if i then
    GlobalQliphortNormalSummon = nil
    return(i)
  end
end
function QliphortTribute(cards,min,max)
  if DeckCheck(AI_QLIPHORT) then
    if HasID(AIST(),17639150,false,nil,nil,nil,FilterPosition,POS_FACEUP) then
      min = math.max(min-1,1)
    end
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return nil
end
function SacrificeTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards)
end
function ArchiveTarget(cards)
  local result = BestTargets(cards,1,TARGET_TOHAND,TargetCheck) 
  TargetSet(cards[1])
  return result
end
function GenomeTarget(cards)
  local result = BestTargets(cards,1,TARGET_DESTROY,TargetCheck) 
  TargetSet(cards[1])
  return result
end
function TrampolynxTarget(cards)
  for i=1,#cards do
    if cards[i].id == 65518099 then
      return {i}
    end
  end
  return {math.random(#cards)}
end
function FilterTool(c,loc)
  return FilterID(c,65518099) and FilterLocation(c,loc)
end
function StealthTarget(cards)
  if HasPriorityTarget(OppField(),false,nil,TargetCheck) then
    return BestTargets(cards,1,TARGET_TOHAND,TargetCheck)
  end
  if HasID(AIMon(),65518099,true) then
    return BestTargets(cards,1,TARGET_TOHAND,FilterTool,LOCATION_MZONE)
  end
  if HasID(AIST(),65518099,true) then
    return BestTargets(cards,1,TARGET_TOHAND,FilterTool,LOCATION_SZONE)
  end
  return BestTargets(cards,1,TARGET_TOHAND,TargetCheck)
end
function SoulTransitionTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function SADTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function WaveringEyesTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  return BestTargets(cards,1,PRIO_BANISH)
end
function QliphortCard(cards,min,max,id,c)
  if c then
    id = c.id
  end
  if GlobalPendulumSummoning then
    GlobalPendulumSummoning = nil
    local x = CardsMatchingFilter(AIExtra(),QliphortFilter)
    if x<2 and CardsMatchingFilter(AIHand(),QliphortFilter,65518099)>0 then x = x+1 end
    if CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN)>0 then
      x = math.min(x,2)
    end
    x = math.min(x,max)
    return Add(cards,PRIO_TOFIELD,x)
  end
  if id == 31222701 then
    return WaveringEyesTarget(cards)
  end
  if id == 65518099 then -- Tool
    return Add(cards)
  end
  if id == 79816536 then -- Summoners Art
    return Add(cards)
  end
  if id == 17639150 then
    return SacrificeTarget(cards)
  end
  if id == 91907707 then
    return ArchiveTarget(cards)
  end
  if id == 37991342 then
    return GenomeTarget(cards)
  end
  if id == 64496451 then -- Disk
    return Add(cards,PRIO_TOFIELD,2)
  end
  if id == 16178681 then -- Odd-Eyes
    return Add(cards)
  end
  if id == 04450854 then -- Apoqliphort
    return Add(cards,PRIO_EXTRA,max)
  end
  if id == 43241495 then
    return TrampolynxTarget(cards)
  end
  if id == 13073850 then
    return StealthTarget(cards)
  end
  if id == 88197162 then
    return SoulTransitionTarget(cards)
  end
  if id == 25067275 then
    return SADTarget(cards)
  end
  return nil
end
function ChainArchive()
  return CardsMatchingFilter(SubGroup(OppMon(),TargetCheck),ArchiveFilter)>0
end
function ChainGenome()
  return CardsMatchingFilter(SubGroup(OppST(),TargetCheck),DestroyFilter)>0
end
function ChainApoqliphort()
  if RemovalCheck(04450854) then
    return true
  end
  return (Duel.GetCurrentPhase()==PHASE_END or Duel.GetTurnPlayer()==PLAYER_AI) 
  and PriorityCheck(AIExtra(),PRIO_EXTRA,3,QliphortFilter)>2
end
function ChainVanity(c)
  for i=1,Duel.GetCurrentChain() do
    if Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_SPECIAL_SUMMON) 
    and  Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_PLAYER)~=player_ai 
    then
      return true
    end
  end
  if MKBCheck(c) and Duel.GetTurnPlayer()~=player_ai then
    return true
  end
  if HasIDNotNegated(AIMon(),83994433,true) 
  and Duel.GetTurnPlayer()~=player_ai 
  and not OppHasStrongestMonster()
  then
    return true
  end
  if ScytheCheck() and not OppHasStrongestMonster() 
  and Duel.GetCurrentChain() == 0
  then
    return true
  end
  return false
end
function ChainReqliate(c)
  local cards = SubGroup(AIField(),FilterPosition,POS_FACEUP)
  return CardsMatchingFilter(cards,QliphortFilter,20426097)>0 
end
function ChainLoseTurn(c)
  return true
end
function StealthFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,8)
  and not ToHandBlacklist(c.id)
end
function ChainStealth(c)
  return CardsMatchingFilter(OppField(),StealthFilter)>0 
  or HasID(AIField(),65518099,true)
end
function ChainSoulTransition(c)
  if RemovalCheckCard(c) then
    return true
  end
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if RemovalCheckCard(c) then
      GlobalTargetSet(c)
      GlobalCardMode = 1
      return true
    end
  end
  if HasID(AIMon(),91907707,true) 
  and HasPriorityTarget(OppMon(),false,nil,ArchiveFilter)
  and UnchainableCheck(88197162)
  then
    GlobalTargetSet(FindID(91907707,AIMon()))
    GlobalCardMode = 1
    return true
  end
  if HasID(AIMon(),37991342,true) 
  and (HasPriorityTarget(OppST(),false,nil,DestroyFilter)
  or DestroyCheck(OppST())>0 and Duel.GetCurrentPhase()==PHASE_END
  and Duel.GetTurnPlayer()~=player_ai)
  and UnchainableCheck(88197162)
  then
    GlobalTargetSet(FindID(37991342,AIMon()))
    GlobalCardMode = 1
    return true
  end
  local aimon,oppmon = GetBattlingMons()
  if WinsBattle(oppmon,aimon) 
  and aimon:IsSetCard(0xaa) 
  and UnchainableCheck(88197162)
  and (not (ExpectedDamage(1)>=AI.GetPlayerLP(1))
  or HasID(AIMon(),91907707,true)
  or #AIMon()>1)
  and Duel.GetTurnPlayer()==1-player_ai
  then
    GlobalTargetSet(aimon)
    GlobalCardMode = 1
    return true
  end
  return false
end
function ChainSAD(c)
  if RemovalCheckCard(c) then
    return true
  end
  local aimon,oppmon = GetBattlingMons()
  if WinsBattle(oppmon,aimon) 
  and aimon:IsSetCard(0xaa) 
  and UnchainableCheck(25067275)
  then
    GlobalTargetSet(aimon)
    GlobalCardMode = 1
    return true
  end
  return false
end
function ChainWaveringEyes(card)
  if RemovalCheckCard(card)
  and DestroyCheck(OppPendulum(),true)>0
  then
    return true
  end
  if not UnchainableCheck(31222701) then return false end
  local targets = {}
  for i=1,#AIST() do
    local c = AIST()[i]
    if RemovalCheckCard(i) then
      targets[#targets+1]=c
    end
  end
  if #targets>1
  or #targets>0 and DestroyCheck(OppPendulum(),true)>0
  then
    return true
  end
  if DestroyCheck(AllPendulum(),true)>0 
  and AI.GetPlayerLP(2)<=500
  then
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai 
  and( DestroyCheck(OppPendulum(),true)>1 
  or DestroyCheck(AllPendulum(),true)>2 
  and CardsMatchingFilter(OppField(),WaveringEyesFilter2)>0 
  or DestroyCheck(AllPendulum(),true)>3 
  and HasID(AIDeck(),31222701,true))
  then
    return true
  end
  return false
end
function QliphortChain(cards)
  if HasID(cards,31222701,ChainWaveringEyes) then
    OPTSet(31222701)
    return {1,CurrentIndex}
  end
  if HasID(cards,88197162,ChainSoulTransition) then
    return {1,CurrentIndex}
  end
  if HasID(cards,91907707) and ChainArchive() then
    return {1,CurrentIndex}
  end
  if HasID(cards,37991342) and ChainGenome() then
    return {1,CurrentIndex}
  end
  if HasID(cards,04450854) and ChainApoqliphort() then
    return {1,CurrentIndex}
  end
  if HasID(cards,05851097) and ChainVanity(cards[CurrentIndex]) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,64496451) then -- Disk
    return {1,CurrentIndex}
  end
  if HasID(cards,16178681) then -- Odd-Eyes
    return {1,CurrentIndex}
  end
  if HasID(cards,43241495) then -- Trampolynx
    return {1,CurrentIndex}
  end
  if HasID(cards,17639150) then -- Sacrifice
    return {1,CurrentIndex}
  end
  if HasID(cards,51194046) then -- Monolith
    return {1,CurrentIndex}
  end
  if HasID(cards,20426097,ChainReqliate) then
    return {1,CurrentIndex}
  end
  if HasID(cards,25067275,ChainSAD) then
    GlobalDuality = 1
    return {1,CurrentIndex}
  end
  if HasID(cards,24348807,ChainLoseTurn) then
    return {1,CurrentIndex}
  end
  if HasID(cards,13073850,ChainStealth) then
    return {1,CurrentIndex}
  end
  return nil
end
function QliphortEffectYesNo(id,card)
  local result = nil
  if id==91907707 and ChainArchive() then
    result = 1
  end
  if id==37991342 and ChainGenome() then
    result = 1
  end
  if id==64496451 or id==16178681 or id==43241495  -- Disk, Odd-Eyes,Trampolynx
  or id==17639150 or id==51194046 -- Sacrifice, Monolith
  and NotNegated(card)
  then
    result = 1
  end
  if id == 13073850 and ChainStealth(card) then
    result = 1
  end
  return result
end
QliphortAtt={
  27279764,90885155,64496451, --Killer, Shell, Disk
  37991342,91907707,13073850, -- Genome, Archive, Stealth
  51194046, -- Monolith
}
QliphortDef={
  65518099 -- Tool
}
function QliphortPosition(id,available)
  result = nil
  for i=1,#QliphortAtt do
    if QliphortAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#QliphortDef do
    if QliphortDef[i]==id then result=POS_FACEUP_DEFENSE end
  end
  return result
end
