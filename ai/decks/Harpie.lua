function HarpiePriority()
AddPriority({

-- Harpie

[75064463] = {7,1,6,1,3,2,2,2,1,1,QueenCond},   -- Harpie Queen
[80316585] = {4,1,4,1,5,2,4,2,1,1,CyberCond},   -- Cyber Harpie Lady
[56585883] = {8,1,8,1,8,0,5,2,1,1,HarpistCond}, -- Harpie Harpist
[90238142] = {9,4,9,1,1,1,6,3,1,1,ChannelerCond},-- Harpie Channeler
[91932350] = {3,1,5,1,4,2,3,2,1,1,Lady1Cond},   -- Harpie Lady #1
[68815132] = {6,1,7,1,2,2,2,2,1,1,DancerCond},  -- Harpie Dancer

[90219263] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Elegant Egotist
[19337371] = {12,6,1,1,9,1,1,1,1,1,SignCond},    -- Hysteric Sign
[15854426] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Divine Wind of Mist Valley
[75782277] = {5,1,1,1,3,1,1,1,1,1,nil},         -- Harpie's Hunting Ground

[77778835] = {13,1,1,1,1,1,1,1,1,1,nil},         -- Hysteric Party

[22653490] = {1,1,1,1,1,1,3,1,1,1,nil},         -- Chidori
[85909450] = {1,1,1,1,1,1,3,1,1,1,nil},         -- HPPD
[86848580] = {1,1,1,1,1,1,3,1,1,1,nil},         -- Zerofyne

[89399912] = {1,1,1,1,7,1,1,1,1,1,nil},         -- Tempest
[52040216] = {1,1,1,1,6,1,1,1,1,1,nil},         -- Pet Dragon
[94145683] = {1,1,1,1,1,1,1,1,1,1,nil},         -- Swallow's

})
end

HarpieLady={
56585883, -- Harpie Harpist
75064463, -- Harpie Queen
80316585, -- Cyber Harpie Lady
91932350, -- Harpie Lady #1
76812113, -- Harpie Lady
68815132, -- Harpie Dancer
90238142, -- Harpie Channeler
}
function LadyFilter(c,negated)
  if negated then return c.id == 76812113 end
  for i=1,#HarpieLady do
    if c.original_id == HarpieLady[i] then 
      return true
    end
  end
  return false
end
function LadyCount(cards,negated,filter,opt)
  return CardsMatchingFilter(SubGroup(cards,filter,opt),LadyFilter,negated)
end
function HarpieFilter(c,exclude)
  return IsSetCode(c.setcode,0x64) and (exclude == nil or c.id~=exclude)
end
function HarpieCount(cards,filter,opt)
  return CardsMatchingFilter(SubGroup(cards,filter,opt),FilterID,76812113)
end
function PartyCheck(c,count)
  return c.id==77778835 and FilterPosition(c,POS_FACEUP)
  and CardTargetCheck(c)==0
end
function QueenCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.original_id,true)
  end
  if loc == PRIO_EXTRA then
    if FilterLocation(c,LOCATION_HAND) then
      return false
    end
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetMultiple(c.original_id)==0
    end
  end
  return true
end
function Lady1Cond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.original_id,true)
  end
  if loc == PRIO_EXTRA then
    if FilterLocation(c,LOCATION_HAND) then
      return false
    end
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetMultiple(c.original_id)==0
    end
  end
  return true
end
function CyberCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.original_id,true)
  end
  if loc == PRIO_EXTRA then
    if FilterLocation(c,LOCATION_HAND) then
      return false
    end
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetMultiple(c.original_id)==0
    end
  end
  return true
end
function DancerCond(loc,c)
  if loc == PRIO_TOHAND then
    if HasIDNotNegated(AICards(),15854426,true,FilterOPT)
    and not HasID(AIHand(),c.original_id,true)
    then
      return 10
    end
    return not HasID(AIHand(),c.original_id,true)
  end
  if loc == PRIO_TOFIELD then
    if HasIDNotNegated(AICards(),15854426,true,FilterOPT)
    and not HasID(AIMon(),c.original_id,true)
    and OPTCheck(68815132)
    and GetMultiple(c.original_id)==0
    then
      return 10
    end
    return not HasID(AIMon(),c.original_id,true)
    and OPTCheck(c.original_id)
    and GetMultiple(c.original_id)==0
  end
  return true
end
function HarpistGraveFilter(c)
  return c.original_id == 56585883 
  and c.turnid == Duel.GetTurnCount()
end
function HarpistSearchFilter(c)
  return FilterRace(c,RACE_WINDBEAST) 
  and c.level==4
  and c.attack<=1500
end
function HarpistCond(loc,c)
  if loc==PRIO_TOGRAVE then
    return OPTCheck(56585883) 
    and CardsMatchingFilter(AIGrave(),HarpistGraveFilter)==0
    and CardsMatchingFilter(AIDeck(),HarpistSearchFilter)>0
  end
  if loc == PRIO_EXTRA then
    if FilterLocation(c,LOCATION_HAND) then
      return false
    end
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetMultiple(c.original_id)==0
      and not HarpistGraveFilter(c)
    end
  end
  if loc == PRIO_TOFIELD then
    return GetMultiple(c.original_id)==0
  end
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_ONFIELD)
    and UseHarpist(c)
    and not HasID(AIHand(),56585883,true)
    then
      return 11
    end
  end
  return true
end
function ChannelerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.original_id,true)
    or FilterLocation(c,LOCATION_ONFIELD)
  end
  if loc == PRIO_TOFIELD then
    return not HasID(AIMon(),c.original_id,true)
    and OPTCheck(c.original_id)
    and GetMultiple(c.original_id)==0
    and UseChanneler(c)
    and FieldCheck(4)==0
  end
  if loc == PRIO_EXTRA then
    if FilterLocation(c,LOCATION_HAND) then
      return false
    end
    if FilterLocation(c,LOCATION_GRAVE) then
      return GetMultiple(c.original_id)==0
    end
  end
  return true
end
function SignGraveFilter(c)
  return c.id == 19337371 and c.turnid == Duel.GetTurnCount()
end
function SignCheck(cards)
  return (cards == nil or HasID(cards,19337371,true))
  and OPTCheck(19337371)
  and CardsMatchingFilter(AIGrave(),SignGraveFilter)==0
end
function SignCond(loc,c)
  if loc==PRIO_TOHAND then
    return FilterLocation(c,LOCATION_ONFIELD) or DiscardOutlets()>0
  end
  if loc==PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_ONFIELD+LOCATION_HAND)
    and SignCheck()
  end
  return true
end
function UseDivineWind(c,cards)
  return DualityCheck() and OPTCheck(68815132)
  and HasIDNotNegated(UseLists(cards,AIMon()),68815132,true)
  and (not HasID(AIST(),75782277,true) or DestroyCheck(OppST(),false,true)==0)
end
function UseHHG(c,cards)
  return (DestroyCheck(OppST(),false,true)>0 
  or SignCheck(AIST()))
  and (CardsMatchingFilter(cards,LadyFilter,SkillDrainCheck())>0
  or HasIDNotNegated(AIMon(),90238142,true,UseChanneler))
  and not (HasID(AIST(),75782277,true) or HasID(AIST(),15854426,true))
end
function DancerYesNo()
  if FieldCheck(4)==1 
  and not (HasIDNotNegated(AIST(),15854426,true,FilterOPT)
  and DualityCheck())
  or FieldCheck(4)==0
  and (HasIDNotNegated(AIST(),15854426,true,FilterOPT)
  or HasIDNotNegated(AICards(),90219263,true)
  or HasIDNotNegated(AIHand(),90238142,true,UseChanneler))
  and DualityCheck()
  or HasIDNotNegated(AIST(),75782277,true) 
  and DestroyCheck(OppST())>0
  or HasIDNotNegated(AIHand(),56585883,true,UseHarpist)
  then 
    return 1
  end
  return 0
end
function UseDancer(c,mode)
  if mode == 1 and (HasIDNotNegated(AIST(),75782277,true)
  and DestroyCheck(OppST(),false,true)>0
  or HasIDNotNegated(AIST(),15854426,true,FilterOPT)
  and DualityCheck()
  or HasID(AIMon(),90238142,true)
  and LadyCount(AIHand())>0
  or HasID(AIHand(),90238142,true)
  and FieldCheck(4)==1)
  or HasID(AICards(),56585883,true,UseHarpist)
  then
    return true
  end
  if mode == 3
  and HasID(AIMon(),00581014,true)
  and SummonEmeralHarpie()
  and (LadyCount(AIHand())>0
  or FieldCheck(4)>1)
  then
    GlobalCardMode=1
    GlobalTargetSet(FindID(00581014,AIMon()))
    return true
  end
  if mode == 2 
  and #AIMon()>3
  and TurnEndCheck()
  then
    return true
  end
  return false
end
function SummonDancer(c,mode)
  if mode == 1 and (HasIDNotNegated(AIST(),75782277,true)
  and DestroyCheck(OppST(),false,true)>0
  or HasIDNotNegated(AIST(),15854426,true,FilterOPT)
  and DualityCheck())
  and OPTCheck(68815132)
  then
    return true
  end
  if mode == 2 
  and HasID(AIMon(),00581014,true,SummonEmeralHarpie)
  and (LadyCount(AIHand())>1 or FieldCheck(4)>0)
  and OPTCheck(68815132)
  then
    return true
  end
  return false
end
function UseQueen(c,cards)
  return not HasID(AICards(),75782277,true)
  and UseHHG(FindID(75782277,AIDeck()),cards)
end
function UseChanneler(c)
  return OPTCheck(90238142) 
  and DualityCheck()
  and (FieldCheck(4)==2 and SummonHPPD()
  or FilterLocation(c,LOCATION_MZONE) and FieldCheck(4)==1
  or FieldCheck(4)==0 and OverExtendCheck(2,5))
end
function SummonChanneler(c)
  if UseChanneler(c)
  and CardsMatchingFilter(AIHand(),HarpieFilter)>1
  then
    return true
  end
  return false
end
function HarpistFilter(c)
   return (PriorityTarget(c) 
   or c.attack>AIGetStrongestAttack())
   and Affected(c,TYPE_MONSTER,4)
   and Targetable(c,TYPE_MONSTER)
   and FilterPosition(c,POS_FACEUP)
end
function SummonHarpist(c)
  if UseHarpist(c)
  then
    return true
  end
  return false
end
function SummonHarpie(c,mode)
  if mode == 1 and (FieldCheck(4)==1 
  or HasID(AICards(),90219263,true)  
  and LadyCount(AIDeck(),true)>0)
  and OverExtendCheck() and DualityCheck()
  then
    return true
  end
  if mode == 2 
  and (DestroyCheck(OppST())>0 or SignCheck(AIST()))
  and HasIDNotNegated(AIST(),75782277,true)
  and LadyFilter(c)
  then
    return true
  end
  if mode == 3 
  and OppHasStrongestMonster() 
  and c.attack>OppGetStrongestAttDef()
  then
    return true
  end
  if mode == 4
  and (#AIHand()>5
  or c.attack>1600)
  then
    return true
  end
end
function UseParty(c,mode)
  if mode == 1 
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>3
  and LadyCount(AIGrave())>3
  then
    return true
  end
  if mode == 2
  and OppHasStrongestMonster() 
  and (LadyCount(AIGrave())>1
  and SignCheck(AIHand())
  or LadyCount(AIHand())>0)
  then
    return true
  end
  if mode == 3
  and OppHasStrongestMonster() 
  and (LadyCount(AIGrave())>1
  or LadyCount(AIHand())>0)
  then
    return true
  end
  return false
end
function UseSign(c,cards)
  return LadyCount(AIDeck(),true)>0
  and SignCheck()
  and ((FieldCheck(4,LadyFilter)==1
  or LadyCount(cards)>0)
  and OppHasStrongestMonster()
  or CardsMatchingFilter(AIHand(),FilterID,19337371)>1
  or HasID(AICards(),05318639,true))
  --or TurnEndCheck() and DiscardOutlets()==0
end
function UseEgotist(c)
  return OverExtendCheck()
end
function SetSign(c,cards)
  return (HasID(AIHand(),75782277,true)
  and (LadyCount(cards)>0
  or HasID(AIMon(),90238142,true,UseChanneler))
  or HasID(AIHand(),75064463,true)
  and (LadyCount(cards)>1
  or HasID(AIMon(),90238142,true,UseChanneler)))
  and not (DestroyCheck(OppST())==0
  and not HasPriorityTarget(OppST(),DestroyFilter)
  and HasID(cards,90238142,true,SummonChanneler)
  and CardsMatchingFilter(AIHand(),HarpieFilter)>2)
  and SignCheck()
  and not HasID(AIST(),19337371,true)
end
function SummonHPPD(c)
  return AI.GetPlayerLP(2)<=4000
  and MP2Check(2000)
end
function RepoHPPD(c)
  return FilterPosition(c,POS_DEFENSE) and c.xyz_material_count>0
  and not FilterAffected(c,EFFECT_DISABLE)
end
function SummonZerofyne(c)
  return CardsMatchingFilter(Field(),FilterPosition,POS_FACEUP)>5
  and #OppMon()>0 and BattlePhaseCheck() and OppHasStrongestMonster()
end
function SummonZephyrosHarpie(source,mode)
  if not DeckCheck(DECK_HARPIE) then return false end
  if mode == 1 
  and AI.GetPlayerLP(1)>400
  then
    for i=1,#AIST() do
      local c=AIST()[i]
      if PartyCheck(c,0) then
        GlobalCardMode = 1
        GlobalTargetSet(c)
        return true
      end
    end
    if HasID(AIST(),19337371,true,nil,nil,POS_FACEUP) 
    and DiscardOutlets()>0
    then
      return true
    end
  end
  if mode == 2 
  and FieldCheck(4) == 1
  and CardsMatchingFilter(AIST(),FilterPosition,POS_FACEUP)>0
  and OverExtendCheck()
  and AI.GetPlayerLP(1)>400
  then
    return true
  end
  if mode == 3 
  and FieldCheck(4) == 1
  and OverExtendCheck()
  then
    return true
  end
  return false
end
function SummonEmeralHarpie(c)
  if not DeckCheck(DECK_HARPIE) then return false end
  if LadyCount(UseLists(AIMon(),AIGrave(),AIMaterials()))>5
  and LadyCount(AIGrave())>2
  and MP2Check(1800) 
  and not OppHasStrongestMonster()
  then
    return true
  end
  return false
end
function SummonChainHarpie(c)
  return (HasID(AIDeck(),14785765,true)
  or HasID(AIDeck(),56585883,true) 
  and not HasID(AIMon(),56585883,true)
  and LadyCount(AIHand())<2
  and CardsMatchingFilter(AIGrave(),HarpistGraveFilter)==0
  and OPTCheck(56585883))
  and (not OppHasStrongestMonster() 
  or OppGetStrongestAttDef()<1800)
  and MP2Check(c)
end
function UseChainHarpie(c,mode)
  if not DeckCheck(DECK_HARPIE) then return false end
  if mode ==1 then
    if HasID(AIDeck(),14785765,true) 
    then
      return true
    end
    if HasID(AIDeck(),56585883,true)
    and not HasID(c.xyz_materials,56585883,true)
    and LadyCount(AIHand())<2
    and CardsMatchingFilter(AIGrave(),HarpistGraveFilter)==0
    and OPTCheck(56585883)
    then
      return true
    end
  end
  if mode == 2
  and EPAddedCards()==0 
  and not HasID(c.xyz_materials,56585883,true)
  and TurnEndCheck()
  then
    GlobalCardMode=2
    return true
  end
  if mode == 3 
  and TurnEndCheck()
  then
    return true
  end
  return false
end
function HarpieInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(SetST,19337371,SetSign,Sum) then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasIDNotNegated(Act,75782277,UseHHG,Sum) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,15854426,UseDivineWind,Sum) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,75064463,UseQueen,Sum) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,77778835,UseParty,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,00581014) and DeckCheck(DECK_HARPIE) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,68815132,UseDancer,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,68815132,UseDancer,1) then
    OPTSet(68815132)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,90238142,UseChanneler) then
    OPTSet(90238142)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,34086406,false,545382497,UseChainHarpie,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Sum,68815132,SummonDancer,1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,68815132,SummonDancer,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,90238142,SummonChanneler) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Sum,56585883,SummonHarpist) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,14785765,SummonZephyrosHarpie,1) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,85909450,SummonHPPD) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,34086406,SummonChainHarpie) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,86848580) then -- Zerofyne
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  for j=1,4 do
    for i=1,#HarpieLady do
      if HasID(Sum,HarpieLady[i],SummonHarpie,j) then
        return {COMMAND_SUMMON,CurrentIndex}
      end
    end
  end
  if HasID(Sum,14785765,SummonZephyrosHarpie,2) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Act,90219263,UseEgotist) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,77778835,UseParty,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSum,00581014,SummonEmeralHarpie) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,85909450,SummonHPPD) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,86848580,SummonZerofyne) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,19337371,UseSign,Sum) then
    OPTSet(19337371)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,14785765,SummonZephyrosHarpie,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,77778835,UseParty,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Rep,85909450,RepoHPPD) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Act,68815132,UseDancer,2) then
    OPTSet(68815132)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,34086406,false,545382498,UseChainHarpie,2) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,34086406,false,545382497,UseChainHarpie,3) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  return nil
end
function ChannelerTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards,PRIO_TOFIELD)
end
function HarpistTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  if CurrentOwner(cards[1])==1 then
    return Add(cards,PRIO_TOHAND)
  end
  return BestTargets(cards,1,TARGET_TOHAND)
end
function DancerTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return GlobalTargetGet(cards,true)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
function PartyTarget(cards,min)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards,PRIO_TOFIELD,min)
end
function HHGTarget(cards)
  if HasID(cards,19337371) and SignCheck() 
  and not HasPriorityTarget(cards,DestroyFilter)
  then
    return {CurrentIndex}
  end
  if HasID(cards,75782277) and DestroyCheck(OppST(),false,true)==0 then
    return {CurrentIndex}
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function ZephyrosTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  if HasID(cards,19337371) then 
    return {CurrentIndex}
  end
  return BestTargets(cards,1,TARGET_TOHAND)
end
function HarpieCard(cards,min,max,id,c)

  if id == 76812113 then
    id = c.original_id
  end
  if id == 14785765 then
    return ZephyrosTarget(cards)
  end
  if id == 90238142 then
    return ChannelerTarget(cards)
  end
  if id == 56585883 then
    return HarpistTarget(cards)
  end
  if id == 68815132 then
    return DancerTarget(cards)
  end
  if id == 90219263 then -- Egotist
    return Add(cards,PRIO_TOFIELD)
  end
  if id == 19337371 then -- Sign
    return Add(cards)
  end
  if id == 15854426 then -- Divine Wind
    return Add(cards,PRIO_TOFIELD)
  end
  if id == 77778835 then
    return PartyTarget(cards,min)
  end
  if id == 85909450 then -- HPPD
    return Add(cards,PRIO_TOGRAVE)
  end
  if id == 86848580 then -- Zerofyne
    return Add(cards,PRIO_TOGRAVE)
  end
  if id == 75782277 then
    return HHGTarget(cards)
  end
  return nil
end
--
function HarpistBounceFilter(c,source)
  return FilterRace(c,RACE_WINDBEAST)
  and (not FilterType(c,TYPE_XYZ) or c.xyz_material_count==0)
  and not CardsEqual(c,source)
end
function UseHarpist(c)
  return CardsMatchingFilter(AIMon(),HarpistBounceFilter,c)>0
  and CardsMatchingFilter(OppMon(),HarpistFilter)>0
  and NotNegated(c)
  and OPTCheck(56585884)
end
function ChainHarpist(c)
  if FilterLocation(c,LOCATION_MZONE) 
  and UseHarpist(c)
  then
    OPTSet(56585884)
    return true
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    OPTSet(56585883)
    return true
  end
  return false
end
function ChainParty(c)
  if Duel.GetCurrentPhase()==PHASE_END
  and Duel.GetTurnPlayer()~=player_ai
  and SignCheck(AIHand())
  and UnchainableCheck(77778835)
  then
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE
  and Duel.GetTurnPlayer()~=player_ai
  and UnchainableCheck(77778835)
  then
    local aimon,oppmon=GetBattlingMons()
    if CanFinishGame(oppmon) 
    and #AIMon()==0
    then
      return true
    end
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE
  and Duel.GetTurnPlayer()==player_ai
  and UnchainableCheck(77778835)
  then
    local loccount=Duel.GetLocationCount(player_ai,LOCATION_MZONE)
    local atk = TotalATK(AIGrave(),loccount,LadyFilter)
    if #OppMon()==0
    and atk>=AI.GetPlayerLP(2)
    and ExpectedDamage(2)==0
    then
      return true
    end
  end
  return false
end
function HarpieChain(cards)
  if HasID(cards,19337371) then -- Sign
    OPTSet(19337371)
    return {1,CurrentIndex}
  end
  if HasID(cards,15854426) then -- Divine Wind
    OPTSet(cards[CurrentIndex].cardid)
    return {1,CurrentIndex}
  end
  if HasID(cards,56585883,ChainHarpist) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,77778835,ChainParty) then
    return {1,CurrentIndex}
  end
  return nil
end
function HarpieEffectYesNo(id,card)
  local result = nil
  if id == 19337371 -- Sign
  then
    OPTSet(19337371)
    result = 1
  end
  if id == 15854426 -- Divine Wind 
  then
    OPTSet(card.cardid)
    result = 1
  end
  if id == 56585883 and ChainHarpist(card)
  then
    result = 1
  end
  return result
end

function HarpieOption(options)
  return nil
end

HarpieAtt={
76812113, -- Harpie Lady
75064463, -- Harpie Queen
80316585, -- Cyber Harpie Lady
56585883, -- Harpie Harpist
90238142, -- Harpie Channeler
91932350, -- Harpie Lady #1
68815132, -- Harpie Dancer
86848580, -- Zerofyne
85909450, -- HPPD
}
HarpieDef={

}
function HarpiePosition(id,available)
  result = nil
  for i=1,#HarpieAtt do
    if HarpieAtt[i]==id 
    then 
      if Duel.GetCurrentPhase()==PHASE_BATTLE
      and Duel.GetTurnPlayer()~=player_ai
      then
        result=POS_FACEUP_DEFENSE
      else
        result=POS_FACEUP_ATTACK
      end
    end
  end
  for i=1,#HarpieDef do
    if HarpieDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end

