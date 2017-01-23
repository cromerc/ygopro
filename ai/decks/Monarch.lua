
function MonarchStartup(deck)
  deck.Init                 = MonarchInit
  deck.Card                 = MonarchCard
  deck.Chain                = MonarchChain
  deck.EffectYesNo          = MonarchEffectYesNo
  deck.Position             = MonarchPosition
  deck.YesNo                = MonarchYesNo
  deck.BattleCommand        = MonarchBattleCommand
  deck.AttackTarget         = MonarchAttackTarget
  deck.AttackBoost          = MonarchAttackBoost
  deck.Tribute				      = MonarchTribute
  deck.Option               = MonarchOption
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = MonarchActivateBlacklist
  deck.SummonBlacklist      = MonarchSummonBlacklist
  deck.RepositionBlacklist  = MonarchRepoBlacklist
  deck.SetBlacklist		    = MonarchSetBlacklist
  deck.Unchainable          = MonarchUnchainable
  --[[
  
  ]]
  deck.PriorityList         = MonarchPriorityList
  
end

MonarchIdentifier = 09126351 -- Swap Frog

DECK_MONARCH = NewDeck("Frog Monarchs",MonarchIdentifier,MonarchStartup) 

MonarchActivateBlacklist={
23689697, -- Mega Mobius
04929256, -- Mobius
41386308, -- Mathematician
09126351, -- Swap Frog
01357146, -- Ronintoadin
61318483, -- Jackfrost
12538374, -- Treeborn
33609262, -- Tenacity
--05318639, -- MST
79844764, -- Stormforth
98045062, -- Econ
36776089, -- Centaurea
01249315, -- Herald of Pure Light
58058134, -- Slacker
46895036, -- Ghostrick Dullahan
53334641, -- Ghostrick Angel of Mischief
02766877, -- Daigusto Phoenix
}
MonarchSummonBlacklist={
47297616, -- LADD
23689697, -- Mega Mobius
87288189, -- Mega Caius
44330098, -- Gorz
47084486, -- Vanity's Fiend
04929256, -- Mobius
09748752, -- Caius
73125233, -- Raiza
41386308, -- Mathematician
09126351, -- Swap Frog
23434538, -- Maxx "C"
01357146, -- Ronintoadin
61318483, -- Jackfrost
12538374, -- Treeborn
97268402, -- Veiler

--82044279, -- Clear Wing
50091196, -- Formula
01639384, -- Felgrand
91949988, -- Gaia Dragon
--38495396, -- Ptolemy
92661479, -- Bounzer
--15561463, -- Gauntlet Launcher
36776089, -- Centaurea
01249315, -- Herald of Pure Light
10002346, -- Gachi
58058134, -- Slacker
46895036, -- Ghostrick Dullahan
53334641, -- Ghostrick Angel of Mischief
02766877, -- Daigusto Phoenix
}
MonarchSetBlacklist={
33609262, -- Tenacity
05318639, -- MST
79844764, -- Stormforth
98045062, -- Econ
}
MonarchRepoBlacklist={
61318483, -- Jackfrost
}
MonarchUnchainable={
79844764, -- Stormforth
98045062, -- Econ
46895036, -- Dullahan
}
function TreebornCond(loc,c)
  local cards = UseLists(AIMon(),AIGrave(),AIMaterials())
  if loc == PRIO_TOGRAVE then
    if CardsMatchingFilter(cards,FilterID,12538374)==0 
    or FilterLocation(c,LOCATION_HAND+LOCATION_OVERLAY) 
    then
      return 9
    elseif CardsMatchingFilter(cards,FilterID,12538374)==1 then
      --return 7
    else
      return 5
    end
  end
  if loc == PRIO_BANISH then
    if CardsMatchingFilter(cards,FilterID,12538374)>0 then
      return true
    else
      return false
    end
  end
  return true
end
function SwapCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_DECK)
  end
  return true
end
MonarchPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Monarch

[47297616] = {6,1,1,1,1,1,1,1,1,1,nil}, -- LADD
[23689697] = {4,1,1,1,1,1,1,1,1,1,nil}, -- Mega Mobius
[87288189] = {5,1,1,1,1,1,1,1,1,1,nil}, -- Mega Caius
[44330098] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Gorz
[47084486] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Vanity's Fiend
[04929256] = {3,1,1,1,1,1,1,1,1,1,nil}, -- Mobius
[09748752] = {7,1,1,1,1,1,1,1,1,1,nil}, -- Caius
[73125233] = {6,1,1,1,1,1,1,1,1,1,nil}, -- Raiza
[41386308] = {1,1,1,1,2,1,1,1,1,1,nil}, -- Mathematician
[09126351] = {3,1,1,1,4,2,1,1,6,1,SwapCond}, -- Swap Frog
[23434538] = {1,1,1,1,3,1,1,1,1,1,nil}, -- Maxx "C"
[01357146] = {1,1,1,1,6,1,1,1,1,1,nil}, -- Ronintoadin
[61318483] = {1,1,1,1,2,1,1,1,1,1,nil}, -- Jackfrost
[12538374] = {1,1,1,1,1,1,1,1,2,1,TreebornCond}, -- Treeborn
[97268402] = {1,1,1,1,2,1,1,1,1,1,nil}, -- Veiler

[33609262] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Tenacity
[05318639] = {1,1,1,1,1,1,1,1,1,1,nil}, -- MST
[79844764] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Stormforth
[98045062] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Econ

[43202238] = {1,1,7,1,1,1,1,1,1,1,nil}, -- Yazi
[82044279] = {1,1,6,1,1,1,1,1,1,1,nil}, -- Clear Wing
[73580471] = {1,1,4,1,1,1,1,1,1,1,nil}, -- Black Rose
[50091196] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Formula
[01639384] = {1,1,5,1,1,1,1,1,1,1,nil}, -- Felgrand
[91949988] = {1,1,4,1,1,1,1,1,1,1,nil}, -- Gaia Dragon
[38495396] = {1,1,4,1,1,1,1,1,1,1,nil}, -- Ptolemy
[92661479] = {1,1,4,1,1,1,1,1,1,1,nil}, -- Bounzer
[15561463] = {1,1,3,1,1,1,1,1,1,1,nil}, -- Gauntlet Launcher
[36776089] = {1,1,2,1,1,1,1,1,1,1,nil}, -- Centaurea
[01249315] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Herald of Pure Light
[10002346] = {1,1,1,1,1,1,1,1,1,1,nil}, -- Gachi
[46895036] = {1,1,6,1,1,1,1,1,1,1,nil}, -- Dullahan
[58058134] = {1,1,2,1,1,1,1,1,1,1,nil}, -- Slacker
} 
function MonarchFilter(c,exclude)
  return IsSetCode(c.setcode,0xbe) and (exclude == nil or c.id~=exclude)
end
function FrogFilter(c,exclude)
  return IsSetCode(c.setcode,0x12) and (exclude == nil or c.id~=exclude)
end
function MonarchMonsterFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return (FilterAttack(c,2400) or FilterAttack(c,2800))
  and FilterDefense(c,1000) and check
end
function TributeCount(mega)
  local result = 0
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if not FilterAffected(c,EFFECT_UNRELEASABLE_SUM) then
      if mega and FilterSummon(c,SUMMON_TYPE_ADVANCE) then
        result=result+2
      else
        result=result+1
      end
    end
  end
  if GlobalStormforth == Duel.GetTurnCount() 
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    result=result+1
  end
  return result
end
function TributeSummons(tributes,mode)
  local result = 0
  if not tributes then tributes = 1 end
  if not mode then mode = 1 end
  for i=1,#AIHand() do
    local c = AIHand()[i]
    if tributes == 2 
    and (c.id==47297616 and SummonLADD(c,mode)
    or c.id==23689697 and SummonMegaMobius(c,mode)
    or c.id==87288189 and SummonMegaCaius(c,mode)
    or c.id==44330098 and SummonGorz(c,mode))
    then
      result=result+1
    end
    if tributes == 1
    and (c.id==47084486 and SummonVanity(c,mode)
    or c.id==04929256 and SummonMobius(c,mode)
    or c.id==09748752 and SummonCaius(c,mode)
    or c.id==73125233 and SummonRaiza(c,mode))
    then
      result=result+1
    end
  end
  return result
end

--[[
47297616 -- LADD
23689697 -- Mega Mobius
87288189 -- Mega Caius
44330098 -- Gorz
47084486 -- Vanity's Fiend
04929256 -- Mobius
09748752 -- Caius
73125233 -- Raiza
41386308 -- Mathematician
09126351 -- Swap Frog
23434538 -- Maxx "C"
01357146 -- Ronintoadin
61318483 -- Jackfrost
12538374 -- Treeborn
97268402 -- Veiler

33609262 -- Tenacity
05318639 -- MST
79844764 -- Stormforth
98045062 -- Econ

43202238 -- Yazi
82044279 -- Clear Wing
73580471 -- Black Rose
50091196 -- Formula
01639384 -- Felgrand
91949988 -- Gaia Dragon
38495396 -- Ptolemy
92661479 -- Bounzer
15561463 -- Gauntlet Launcher
36776089 -- Centaurea
01249315 -- Herald of Pure Light
10002346 -- Gachi
46895036 -- Dullahan
58058134 -- Slacker
]]
function UseTenacity(c)
  return not LADDCheck()
end
GlobalStormforth = 0
function StormforthFilter(c,filter)
  local check = true
  if filter then 
    check=CardsMatchingFilter(OppField(),function(card) 
     return not CardsEqual(c,card) and filter(card) 
    end)>0
  end
  return Affected(c,TYPE_SPELL) 
  and not FilterAffected(c,EFFECT_UNRELEASABLE_SUM) 
  and check
end
function UseStormforth(c)
  if CardsMatchingFilter(OppMon(),StormforthFilter)>0 
  and Duel.GetTurnPlayer()==player_ai
  and not NormalSummonCheck()
  and (TributeCount() == 0 and TributeSummons(1,2)>0 or TributeCount() == 1 
  and TributeSummons(1,2)==0 and TributeSummons(2,2)>0)
  and not LADDCheck()
  then
    GlobalStormforth = Duel.GetTurnCount()
    return true
  end
end
function SummonSwap(c,mode)
  if mode==1 then
    return not HasAccess(12538374) and MacroCheck() and NotNegated(c)
  end
  if mode==2 then
    return CardsMatchingFilter(AIDeck(),SwapFilter)>0 and MacroCheck() and NotNegated(c)
  end
  return false
end
function SSSwap(c,mode)
  if mode==1 
  and (HasID(AIHand(),12538374,true) 
  or HasID(AIHand(),01357146,true)
  or CardsMatchingFilter(AIHand(),FilterID,09126351)>1)
  and (TributeCount() == 0 and TributeSummons(1,1)>0 or TributeCount() == 1 
  and TributeSummons(1,1)==0 and TributeSummons(2,1)>0)
  and not LADDCheck()
  then
    GlobalSSCardID=09126351
    return true
  end
  if mode==2
  and (HasID(AIHand(),12538374,true) 
  or HasID(AIHand(),01357146,true)
  or CardsMatchingFilter(AIHand(),FilterID,09126351)>1)
  and NormalSummonCheck()
  and not LADDCheck()
  then
    GlobalSSCardID=09126351
    return true
  end
  return false
end
function UseSwap(c,mode)
  if mode==1 then
    if MP2Check() and #AIHand()<6 then
      GlobalCardMode=1
      return true
    end
  end
  return false
end
function SummonMath(c,mode)
  local cards = UseLists(AIMon(),AIGrave())
  if mode==1 then
    return not HasID(cards,12538374,true) and MacroCheck() and NotNegated(c)
  end
  if mode==2 then
    return CardsMatchingFilter(AIDeck(),SwapFilter)>0 and MacroCheck() and NotNegated(c)
  end
  if mode==3 then
    return OppHasStrongestMonster() 
    and OppGetStrongestAttDef()<=c.attack
    or #OppMon()==0 
    and ExpectedDamage(2)<AI.GetPlayerLP(2) 
    and ExpectedDamage(2)+c.attack>=AI.GetPlayerLP(2)
  end
  return false
end
function SetMath(c,mode)
  return TurnEndCheck()
end
function SetTreeborn(c,mode)
  local cards=UseLists(AIMon(),AIGrave(),AIMaterials())
  if mode==1 then
    return not HasID(cards,12538374,true)
  elseif mode==2 then
    return TurnEndCheck()
  end
  return false
end
function SetRonin(mode)
  return TurnEndCheck()
end
function SummonMegaMobius(c,mode)
  if mode==1 and NotNegated(c) then
    return DestroyCheck(OppST())>1
  end
  if mode==2 then
    return OppHasStrongestMonster()
    and (HasPriorityTarget(OppMon())
    or #OppMon()>1)
  end
  return false
end
function SummonLADD(c,mode)
  if mode == 1 and NotNegated(c) then
    return OppGetStrongestAttDef()<c.attack
  end
  if mode == 2 and NotNegated(c) then
    return true
  end
  return false
end
function MegaCaiusFilter(c)
  return Affected(c,TYPE_MONSTER,8)
  and Targetable(c,TYPE_MONSTER)
  and CurrentOwner(c)==2
end
function SummonMegaCaius(c,mode)
  if mode == 1 and NotNegated(c) 
  and CardsMatchingFilter(OppField(),MegaCaiusFilter)>0
  then
    GlobalSummonedCard = c
    return true
  end
  if mode == 2 and NotNegated(c) 
  and CardsMatchingFilter(OppField(),StormforthFilter,MegaCaiusFilter)>0
  then
    GlobalSummonedCard = c
    return true
  end
  return false
end
function SummonMobius(c,mode)
  if mode==1 and NotNegated(c) then
    return DestroyCheck(OppST())>0
  end
  if mode==2 then
    return OppHasStrongestMonster()
    and (HasPriorityTarget(OppMon())
    or #OppMon()>1)
  end
  return false
end
function CaiusFilter(c)
  return Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
  and CurrentOwner(c)==2
end
function SummonCaius(c,mode)
  if mode == 1 and NotNegated(c) then
    return CardsMatchingFilter(OppField(),CaiusFilter)>0
  end
  if mode == 2 and NotNegated(c) then
    return CardsMatchingFilter(OppField(),StormforthFilter,CaiusFilter)>0
  end
  return false
end
function SummonRaiza(c,mode)
  if mode == 1 and NotNegated(c) then
    return CardsMatchingFilter(OppField(),CaiusFilter)>0
  end
  if mode == 2 and NotNegated(c) then
    return CardsMatchingFilter(OppField(),StormforthFilter,CaiusFilter)>0
  end
  return false
end
function SummonVanity(c,mode)
  if mode == 1 and NotNegated(c) then
    return GlobalStormforth == Duel.GetTurnCount() 
    or OppGetStrongestAttDef()<c.attack
  end
  if mode == 2 and NotNegated(c) then
    return true
  end
  return false
end
function SummonGorz(c,mode)
  if mode==2 then
    return GlobalStormforth == Duel.GetTurnCount() 
    and HasPriorityTarget(OppMon(),false,nil,StormForthFilter)
  end
  return false
end
function SummonVeiler(c,mode)
  if mode==1 then
    if FieldCheck(1)>0 
    and HasIDNotNegated(AIExtra(),50091196,true) -- Formula
    and DualityCheck()
    then
      return true
    end
    if FieldCheck(7)>0
    and HasIDNotNegated(AIExtra(),76774528,true) -- Scrap
    and DualityCheck()
    and CardsMatchingFilter(OppField(),DestroyFilter)>0
    and HasID(AIMon(),12538374,true)
    then
      return true
    end
    if FieldCheck(6)>0
    and TurnEndCheck()
    and DualityCheck()
    and OppGetStrongestAttack()<2500
    then
      return true
    end
  end
  return false
end
function SummonTreeborn(c,mode)
  if mode==1 then
    if CardsMatchingFilter(AIMon(),FilterTuner,1)==1
    and HasIDNotNegated(AIExtra(),50091196,true) -- Formula
    and DualityCheck()
    then
      return true
    end
    if FieldCheck(1)>0
    and (HasIDNotNegated(AIExtra(),46895036,SummonDullahan,1)
    or HasIDNotNegated(AIExtra(),46895036,SummonDullahan,2))
    then
      return true
    end
  end
  return false
end
function SummonRonin(c,mode)
  local cards = UseLists(AIMon(),AIGrave(),AIMaterials())
  if mode == 1 then
    return (CardsMatchingFilter(AIGrave(),FrogFilter,12538374)>0
    or CardsMatchingFilter(cards,FilterID,12538374)>1)
    and not LADDCheck()
    and (TributeSummons(2,1)>0 and TributeCount()==1)
    and not NormalSummonCheck()
  end
  if mode == 2 then
    return (CardsMatchingFilter(AIGrave(),FrogFilter,12538374)>0
    or CardsMatchingFilter(cards,FilterID,12538374)>1)
    and not LADDCheck()
    and (TributeSummons(1,1)>0 and TributeCount()==0
    or TributeSummons(2,1)>0 and TributeCount()==1)
    and not NormalSummonCheck()
  end
  if mode == 3 then
    return (CardsMatchingFilter(AIGrave(),FrogFilter,12538374)>0
    or CardsMatchingFilter(cards,FilterID,12538374)>1)
    and FieldCheck(2)==1
    and (OppHasStrongestMonster() or BattlePhaseCheck())
  end
  return false
end
function SummonBounzer(c,mode)
  if mode == 1 then
    return OppGetStrongestAttDef<c.attack
    and MP2Check(c)
    and NotNegated(c)
    and not LADDCheck()
  end
  return false
end
function DullahanFilter(c,atk)
  if not atk then atk = 99999 end
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,1)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and FilterAttackMax(c,atk*2)
end
function SummonDullahan(c,mode)
  local cards = UseLists(AIMon(),AIGrave())
  if mode == 1 then
    return HasID(AIExtra(),46895036,true)
    and HasID(cards,61318483,true)
    and not NormalSummonCheck()
    and (TributeSummons(1,1)>0
    or TributeSummons(2,1)>0 
    and TributeCount()>1)
    and GlobalStormforth ~= Duel.GetTurnCount()
  end
  if mode == 2 then
    local atk = 1200
    if HasID(AIExtra(),53334641,true) then atk = 2000 end
    atk = math.max(AIGetStrongestAttack(true),atk)
    if GlobalStormforth ~= Duel.GetTurnCount()
    and HasID(AIExtra(),46895036,true)
    and AIGetStrongestAttack(true)<=OppGetStrongestAttack()
    and CardsMatchingFilter(OppMon(),DullahanFilter,atk)
    then
      return true
    end
  end
end
function UseDullahan(c,mode)
  if mode == 1 
  and not NormalSummonCheck()
  and (TributeSummons(1,1)>0
  or TributeSummons(2,1)>0 
  and TributeCount()>1)
  and CardsMatchingFilter(OppMon(),DullahanFilter)>0
  then
    OPTSet(c)
    return true
  end
  if mode == 2 
  and HasID(AIExtra(),53334641,SummonAngel)
  and CardsMatchingFilter(OppMon(),DullahanFilter)>0
  then
    OPTSet(c)
    return true
  end
end
function RepoJackfrost(c,mode)
  if FilterPosition(c,POS_FACEDOWN_DEFENSE)
  and FieldCheck(1)>0
  and HasID(AIExtra(),46895036,true,SummonDullahan,mode)
  then
    return true
  end
  return false
end
function SummonAngel(c,mode)
  return HasID(AIMon(),46895036,true)
end
function SummonFormula(c)
  return true
end
function SummonSlacker(c,mode)
  return TurnEndCheck()
end
function DownerdFilter(c)
  return FilterType(c,TYPE_XYZ) 
  and c.rank>4
  and c.xyz_material_count==0
end
function SummonDownerdMonarch(c,mode)
  return CardsMatchingFilter(AIMon(),DownerdFilter)>0
end
function CentaureaFilter(c,source)
  return not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
  and AttackBlacklistCheck(c,source)
  and Affected(c,TYPE_MONSTER,2)
  and PriorityTarget(c)
end
function SummonCentaurea(c,mode)
  return OppHasStrongestMonster()
  and (CardsMatchingFilter(OppMon(),CentaureaFilter,c)>0
  or CanWinBattle(c,OppMon()))
end
function SummonGachi(c,mode)
  return true
end
function SummonScrap(c,mode)
  if mode == 1 then
    local cards=UseLists(AIMon(),AIGrave())
    if HasID(cards,12538374,true) 
    and CardsMatchingFilter(OppField(),DestroyFilter)>0
    and MP2Check(c)
    then  
      return true
    end
    if OppHasStrongestMonster() 
    and OppGetStrongestAttDef()<=c.attack
    then
      return true
    end
  end
  return false
end
function SummonPhoenix(c,mode)
  if mode == 1 then
    local atk = math.max(c.attack,AIGetStrongestAttack(false,PhoenixFilter))
    if (#OppMon()==0 or OppGetStrongestAttDef()<atk)
    and BattlePhaseCheck()
    then
      return true
    end
  end
  return false
end
function PhoenixFilter(c)
  return FilterAttribute(c,ATTRIBUTE_WIND)
  and (#OppMon()==0 or CanWinBattle(c,OppMon()))
  and Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,2)
end
function UsePhoenix(c,mode)
  return BattlePhaseCheck()
  and CardsMatchingFilter(AIMon(),PhoenixFilter)
end
function MonarchInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(Act,33609262,UseTenacity) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,79844764,UseStormforth) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,09126351,SSSwap,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,09126351,SSSwap,2) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(Act,09126351,UseSwap,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Rep,61318483,RepoJackfrost,1) then
      return COMMAND_CHANGE_POS,CurrentIndex
  end
 if HasID(Act,46895036,UseDullahan,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,46895036,SummonDullahan,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(Act,01357146,SummonRonin,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  local mode = 1
  if GlobalStormforth == Duel.GetTurnCount() then
    mode = 2
  end
  if HasID(Sum,23689697,SummonMegaMobius,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,47297616,SummonLADD,mode) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,87288189,SummonMegaCaius,mode) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,04929256,SummonMobius,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,09748752,SummonCaius,mode) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,73125233,SummonRaiza,mode) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,47084486,SummonVanity,mode) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,04929256,SummonMobius,2) and mode==2 then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,23689697,SummonMegaMobius,2) and mode==2 then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,44330098,SummonGorz,mode) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Act,01357146,SummonRonin,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Sum,09126351,SummonSwap,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,41386308,SummonMath,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,09126351,SummonSwap,2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,41386308,SummonMath,2) then
    return COMMAND_SUMMON,CurrentIndex
  end

  if HasID(Sum,92661479,SummonBounzer,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Rep,61318483,RepoJackfrost,2) then
      return COMMAND_CHANGE_POS,CurrentIndex
  end
 if HasID(Act,46895036,UseDullahan,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,46895036,SummonDullahan,2) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,53334641,SummonAngel) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(Sum,12538374,SummonTreeborn,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,97268402,SummonVeiler,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(SpSum,50091196,SummonFormula) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,76774528,SummonScrap,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,82044279,SummonClearWing) then
    --return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,58058134,SummonSlacker) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,72167543,SummonDownerdMonarch) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(Act,01357146,SummonRonin,3) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,02766877,UsePhoenix) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,02766877,SummonPhoenix,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,36776089,SummonCentaurea) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,10002346,SummonGachi) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SetMon,12538374,SetTreeborn,1) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasIDNotNegated(Sum,41386308,SummonMath,3) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(SetMon,41386308,SetMath) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,12538374,SetTreeborn,2) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,01357146,SetRonin) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  return nil
end
--[[
47297616 -- LADD
23689697 -- Mega Mobius
87288189 -- Mega Caius
44330098 -- Gorz
47084486 -- Vanity's Fiend
04929256 -- Mobius
09748752 -- Caius
73125233 -- Raiza
41386308 -- Mathematician
09126351 -- Swap Frog
23434538 -- Maxx "C"
01357146 -- Ronintoadin
61318483 -- Jackfrost
12538374 -- Treeborn
97268402 -- Veiler

33609262 -- Tenacity
05318639 -- MST
79844764 -- Stormforth
98045062 -- Econ

43202238 -- Yazi
82044279 -- Clear Wing
73580471 -- Black Rose
50091196 -- Formula
01639384 -- Felgrand
91949988 -- Gaia Dragon
38495396 -- Ptolemy
92661479 -- Bounzer
15561463 -- Gauntlet Launcher
36776089 -- Centaurea
01249315 -- Herald of Pure Light
10002346 -- Gachi
46895036 -- Dullahan
58058134 -- Slacker
]]
function SwapTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode=nil
    return Add(cards,PRIO_TOHAND,1,FilterID,09126351)
  end
  if LocCheck(cards,LOCATION_HAND) then
    GlobalSSCardID = nil
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards,PRIO_TOGRAVE,1,FilterLocation,LOCATION_DECK)
end
function CaiusTarget(cards)
  if AI.GetPlayerLP(2)<=1000 then
    return BestTargets(cards,1,TARGET_BANISH,FilterAttribute,ATTRIBUTE_DARK)
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function RaizaTarget(cards)
  return BestTargets(cards,1,TARGET_TODECK)
end
function StormforthTargetFilter(c)
  return not Targetable(c,TYPE_MONSTER)
  or not Affected(c,TYPE_MONSTER,6)
end
function StormforthTargetFilter2(c)
  return not BattleTargetCheck(c,nil)
end
function StormforthTarget(cards)
  if CardsMatchingFilter(cards,StormforthTargetFilter)>0 then
    return BestTargets(cards,1,TARGET_TOGRAVE,StormforthTargetFilter)
  elseif CardsMatchingFilter(cards,StormforthTargetFilter2)>0 then
    return BestTargets(cards,1,TARGET_TOGRAVE,StormforthTargetFilter2)
  end
  return BestTargets(cards,1,TARGET_TOGRAVE)
end
function RoninTarget(cards)
  return Add(cards,PRIO_BANISH)
end
function MobiusFilter(c)
  return Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
  and DestroyFilter(c)
  and CurrentOwner(c)==2
end
function MegaMobiusFilter(c)
  return Affected(c,TYPE_MONSTER,8)
  and Targetable(c,TYPE_MONSTER)
  and DestroyFilter(c)
  and CurrentOwner(c)==2
end
function MobiusTarget(cards,max)
  local temp = SubGroup(cards,MobiusFilter)
  local count = math.max(math.min(DestroyCheck(temp,false,true),max),1)
  return BestTargets(cards,count,TARGET_DESTROY)
end
function MegaMobiusTarget(cards,max)
  local temp = SubGroup(cards,MegaMobiusFilter)
  local count = math.max(math.min(DestroyCheck(temp,false,true),max),1)
  return BestTargets(cards,count,TARGET_DESTROY)
end
function MegaCaiusTarget(cards,max)
  local temp = SubGroup(cards,MegaCaiusFilter)
  local count = math.max(math.min(#temp,max),1)
  return BestTargets(cards,count,TARGET_BANISH)
end
function RoninTarget(cards)
  return Add(cards,PRIO_BANISH)
end
function DullahanTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_TOGRAVE)
end
function PhoenixTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then  
    return Add(cards,PRIO_TOGRAVE)
  end
  return BestTargets(cards,1,TARGET_PROTECT)
end
function MonarchCard(cards,min,max,id,c)
  if not c and GlobalStormforth==Duel.GetTurnCount()
  and min==1 and max==1 and Duel.GetTurnPlayer()==player_ai
  and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  then
    return StormforthTarget(cards)
  end
  if id == 09126351 or GlobalSSCardID == 09126351 then
    return SwapTarget(cards)
  end
  if id == 41386308 then -- Mathematician
    return Add(cards,PRIO_TOGRAVE)
  end
  if id == 09748752 then
    return CaiusTarget(cards)
  end
  if id == 73125233 then
    return RaizaTarget(cards)
  end
  if id == 01357146 then
    return RoninTarget(cards)
  end
  if id == 04929256 then
    return MobiusTarget(cards,max)
  end
  if id == 23689697 then
    return MegaMobiusTarget(cards,max)
  end
  if id == 87288189 then
    return MegaCaiusTarget(cards,max)
  end
  if id == 01357146 then
    return RoninTarget(cards)
  end
  if id == 46895036 then
    return DullahanTarget(cards)
  end
  if id == 47297616 then -- LADD
    return Add(cards,PRIO_TOFIELD)
  end
  return nil
end
function ChainTreeborn(c)
  if LADDCheck(1000) then
    return false
  end
  return true
end
function EconFilter(c)
  return Targetable(c,TYPE_SPELL) 
  and Affected(c,TYPE_SPELL)
  and FilterPosition(c,POS_FACEUP)
end
function ChainEcon(c)
  if Duel.GetTurnPlayer()==player_ai 
  and Duel.GetCurrentPhase()==PHASE_STANDBY
  and HasID(AIMon(),12538374,true) 
  and CardsMatchingFilter(OppMon(),EconFilter)>0
  and (TributeSummons(2)>0
  or TributeSummons()>0)
  and UnchainableCheck(98045062)
  then
    return true
  end
end
function SwapFilter(c)
  return FilterRace(c,RACE_AQUA) 
  and FilterLevelMax(c,2)
end
function LADDFilter(c,atk)
  if not atk then atk = 500 end
  return NotNegated(c) 
  and c.attack>=atk 
  and c.defense>=atk
end
function LADDCheck(atk)
  return HasID(AIMon(),47297616,true,LADDFilter,atk)
end
function ChainSwap(c)
  if CardsMatchingFilter(AIDeck(),SwapFilter)>0 
  and not LADDCheck()
  then
    return true
  end
  return false
end
function ChainMath(c)
  if CardsMatchingFilter(AIDeck(),SwapFilter)>0 
  and not LADDCheck()
  then
    return true
  end
  return false
end
function ChainGorz(c)
  local aimon,oppmon=GetBattlingMons()
  if OppGetStrongestAttack()<=c.attack then
    return true
  end
  if oppmon and OppGetStrongestAttack()>=oppmon:GetAttack() then
    return true
  end
  if OppGetStrongestAttack(CanAttack,true)>=0.7*AI.GetPlayerLP(1)
  then
    return true
  end
  return false
end
function ChainJackfrost(c)
  local cards = GetAttackers()
  local aimon,oppmon=GetBattlingMons()
  if BattleDamage(nil,oppmon)>=AI.GetPlayerLP(1) then
    return true
  end
  if HasIDNotNegated(AIHand(),44330098,true) -- Gorz
  and not DualityCheck()
  and #AIField()==0
  then
    return false
  end
  if BattleDamage(nil,oppmon)>=0.7*AI.GetPlayerLP(1) then
    return true
  end
  if ExpectedDamage()==BattleDamage(nil,oppmon)
  then 
    return true
  end
  return false
end
function ChainMobius(c)
  return DestroyCheck(OppST())>0
end
function ChainMegaMobius(c)
  return DestroyCheck(OppST())>0
end
function ChainDullahan(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  if RemovalCheckCard(c) 
  and CardsMatchingFilter(OppMon(),DullahanFilter)>0
  then
    return true
  end
  local aimon,oppmon=GetBattlingMons() 
  if aimon and oppmon
  and Duel.GetCurrentPhase()==PHASE_DAMAGE
  and AttackBoostCheck(0,oppmon:GetAttack()*0.5) 
  and DullahanFilter(oppmon)
  and UnchainableCheck(46895036)
  then
    GlobalCardMode=1
    GlobalTargetSet(oppmon)
    OPTSet(c)
    return true
  end
end
function ChainCentaurea(c)
  return true
end
function MonarchChain(cards)
  if HasID(cards,46895036,ChainDullahan) then
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,12538374,ChainTreeborn) then
    return 1,CurrentIndex
  end
  if HasID(cards,09126351,ChainSwap) then
    return 1,CurrentIndex
  end
  if HasID(cards,41386308,ChainMath) then
    return 1,CurrentIndex
  end
  if HasID(cards,44330098,ChainGorz) then
    return 1,CurrentIndex
  end
  if HasID(cards,61318483,ChainJackfrost) then
    return 1,CurrentIndex
  end
  if HasID(cards,04929256,ChainMobius) then
    return 1,CurrentIndex
  end
  if HasID(cards,23689697,ChainMegaMobius) then
    return 1,CurrentIndex
  end
  if HasID(cards,98045062,ChainEcon) then
    return 1,CurrentIndex
  end
  if HasID(cards,36776089,ChainCentaurea) then
    return {1,CurrentIndex}
  end
  return nil
end
function MonarchEffectYesNo(id,card)
  if id == 46895036 and ChainDullahan(card) then 
    return 1
  end
  if id == 12538374 and ChainTreeborn(card) then 
    return 1
  end
  if id == 09126351 and ChainSwap(card) then 
    return 1
  end
  if id == 41386308 and ChainMath(card) then 
    return 1
  end
  if id == 44330098 and ChainGorz(card) then 
    return 1
  end
  if id == 61318483 and ChainJackfrost(card) then 
    return 1
  end
  if id == 04929256 and ChainMobius(card) then 
    return 1
  end
  if id == 23689697 and ChainMegaMobius(card) then 
    return 1
  end
  if id == 36776089 and ChainCentaurea(card) then 
    return 1
  end
  return nil
end

function MonarchYesNo(desc)
  if desc == 92 then -- Stormforth tribute enemy
    return 1
  end
  return nil
end

function MonarchOption(options)
  for i=1,#options do
    if options[i] == 1568720993 then  -- Econ
      return i
    end
  end
  return nil
end
    
function MonarchTribute(cards,min, max)
end
function MonarchBattleCommand(cards,targets,act)
end
function MonarchAttackTarget(cards,attacker)
end
function DullahanCheck(c)
  return c.xyz_material_count>0
  and OPTCheck(c)
end
function MonarchAttackBoost(cards)
  -- Dullahan
  if HasIDNotNegated(AICards(),46895036,true,DullahanCheck) then
    for i=1,#cards do
      local c = cards[i]
      if Targetable(c,TYPE_MONSTER) 
      and Affected(c,TYPE_MONSTER,1)
      and CurrentOwner(c)==2
      then
        c.attack=c.attack*.5
        c.bonus=c.attack*-.5
      end
    end
  end
end

MonarchAtt={
47297616, -- LADD
23689697, -- Mega Mobius
87288189, -- Mega Caius
44330098, -- Gorz
47084486, -- Vanity's Fiend
04929256, -- Mobius
09748752, -- Caius
73125233, -- Raiza
43202238, -- Yazi
82044279, -- Clear Wing
73580471, -- Black Rose
01639384, -- Felgrand
91949988, -- Gaia Dragon
38495396, -- Ptolemy
92661479, -- Bounzer
36776089, -- Centaurea
46895036, -- Dullahan
02766877, -- Daigusto Phoenix
}
MonarchDef={
23434538, -- Maxx "C"
01357146, -- Ronintoadin
61318483, -- Jackfrost
12538374, -- Treeborn
97268402, -- Veiler
50091196, -- Formula
01249315, -- Herald of Pure Light
58058134, -- Slacker
10002346, -- Gachi
44330099, -- Gorz token
}
function MonarchPosition(id,available)
  result = nil
  for i=1,#MonarchAtt do
    if MonarchAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#MonarchDef do
    if MonarchDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  if id==09126351 and TurnEndCheck() then
    result=POS_FACEUP_DEFENSE 
  end
  if id==53334641 and TurnEndCheck() then
    result=POS_FACEUP_DEFENSE 
  end
  return result
end

