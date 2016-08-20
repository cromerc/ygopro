
function KozmoStartup(deck)
  deck.Init                 = KozmoInit
  deck.Card                 = KozmoCard
  deck.Chain                = KozmoChain
  deck.EffectYesNo          = KozmoEffectYesNo
  deck.Position             = KozmoPosition
  deck.YesNo                = KozmoYesNo
  deck.BattleCommand        = KozmoBattleCommand
  deck.AttackTarget         = KozmoAttackTarget
  deck.AttackBoost          = KozmoAttackBoost
  deck.Tribute              = KozmoTribute
  deck.Option               = KozmoOption
  deck.ChainOrder           = KozmoChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = KozmoActivateBlacklist
  deck.SummonBlacklist      = KozmoSummonBlacklist
  deck.RepositionBlacklist  = KozmoRepoBlacklist
  deck.SetBlacklist         = KozmoSetBlacklist
  deck.Unchainable          = KozmoUnchainable
  --[[
  
  ]]
  deck.PriorityList         = KozmoPriorityList
  
end

KozmoIdentifier = 67237709 -- Kozmotown

DECK_KOZMO = NewDeck("Kozmo",KozmoIdentifier,KozmoStartup) 


KozmoActivateBlacklist={
55885348, -- Dark Destroyer
20849090, -- Forerunner
29491334, -- Dog Fighter
94454495, -- Sliprider
93302695, -- Wickedwitch
67050396, -- Goodwitch
31061682, -- Farmgirl
56907986, -- Strawman
54063868, -- Dark Eclipser
01274455, -- Soartrooper
64280356, -- Tincan
67723438, -- Emergency Teleport
67237709, -- Kozmotown
--43898403, -- Twin Twister
23171610, -- Limiter Removal
37520316, -- Mind Control
58577036, -- Reasoning
90452877, -- Kozmojo
97077563, -- CotH

}
KozmoSummonBlacklist={
55885348, -- Dark Destroyer
20849090, -- Forerunner
29491334, -- Dog Fighter
94454495, -- Sliprider
93302695, -- Wickedwitch
67050396, -- Goodwitch
31061682, -- Farmgirl
54063868, -- Dark Eclipser
01274455, -- Soartrooper
64280356, -- Tincan

59438930, -- Ghost Ogre
56907986, -- Strawman
23434538, -- Maxx "C"
44405066, -- Red-Eyes Flare Metal Dragon
34945480, -- Outer God Azathot
95169481, -- Diamond Dire Wolf
21044178, -- Abyss Dweller
18326736, -- Planetellarknight Ptolemaeus
01639384, -- Felgrand
}
KozmoSetBlacklist={
58577036, -- Reasoning
}
KozmoRepoBlacklist={
}
KozmoUnchainable={
93302695, -- Wickedwitch
67050396, -- Goodwitch
31061682, -- Farmgirl
01274455, -- Soartrooper
64280356, -- Tincan
59438930, -- Ghost Ogre
56907986, -- Strawman
23434538, -- Maxx "C"
43898403, -- Twin Twister
67723438, -- Emergency Teleport
55885348, -- Dark Destroyer
20849090, -- Forerunner
29491334, -- Dog Fighter
94454495, -- Sliprider
90452877, -- Kozmojo
}
function KozmoFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xd2) and check
end
function KozmoMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and KozmoFilter(c,exclude)
end
function KozmoRider(c,exclude)
  return KozmoMonsterFilter(c,exclude)
  and FilterLevelMax(c,4)
end
function KozmoShip(c,exclude)
  return KozmoMonsterFilter(c,exclude)
  and FilterLevelMin(c,5)
end
function DestroyerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id)
    and CardsMatchingFilter(AICards(),KozmoRider)>0
  end
  if loc == PRIO_TOFIELD then
    return DestroyCheck(OppMon())>0
    or #OppMon()==0 and CardsMatchingFilter(AIMon(),DestroyerFilter)>0
    or #OppMon()==0 and HasIDNotNegated(AIDeck(),56907986,true)
    and DualityCheck()
    and MacroCheck()
  end
  return true
end
function ForerunnerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id)
    and CardsMatchingFilter(AICards(),KozmoRider)>0
  end
  if loc == PRIO_TOFIELD then
    return OppGetStrongestAttack()<=c.attack
    or AI.GetPlayerLP(1)<2000
  end
  return true
end
function KozmotownCond(loc,c)
  if loc == PRIO_TOHAND then
    if IsBattlePhase()
    and Duel.GetTurnPlayer()==player_ai
    and CardsMatchingFilter(AIMon(),KozmoRider)>0
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    then
      return false
    end
    return not HasID(AICards(),c.id)
  end
  return true
end
function FarmgirlCond(loc,c)
  if loc == PRIO_TOHAND then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AICards(),c.id)
    and not NormalSummonCheck()
    and BattlePhaseCheck()
    and (CanDealBattleDamage(c,OppMon())
    or not OppHasStrongestMonster())
  end
  if loc == PRIO_TOFIELD then
    return Duel.GetTurnPlayer()==player_ai
    and (CanDealBattleDamage(c,OppMon())
    or not OppHasStrongestMonster())
    and OPTCheck(c.id)
    and not GlobalSummonNegated
    and not HasID(AIMon(),31061682,true)
    and BattlePhaseCheck()
  end
  return true
end
function StrawmanCond(loc,c)
  if loc == PRIO_TOHAND then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AICards(),c.id)
    and OPTCheck(c.id)
    and not NormalSummonCheck()
    and CardsMatchingFilter(AIBanish(),KozmoShip)>0
    and AI.GetPlayerLP(1)>1000
    and DualityCheck()
  end
  if loc == PRIO_TOFIELD then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AIMon(),c.id)
    and CardsMatchingFilter(AIBanish(),KozmoShip)>0
    and AI.GetPlayerLP(1)>1000
    and not GlobalSummonNegated
  end
  return true
end
function EclipserCond(loc,c)
  return true
end
function TincanCond(loc,c)
  if loc == PRIO_TOHAND then
    if(Duel.GetTurnPlayer()==player_ai
    or Duel.GetTurnPlayer()~=player_ai
    and Duel.GetCurrentPhase()==PHASE_END)
    and not HasID(AICards(),c.id)
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    and CardsMatchingFilter(AIMon(),KozmoRider)>2
    and not GlobalSummonNegated
    then
      if CardsMatchingFilter(AIMon(),KozmoRider)>0 then
        return 6
      end
      return true
    end
    return false
  end
  if loc == PRIO_TOFIELD then
    if(Duel.GetTurnPlayer()==player_ai
    or Duel.GetTurnPlayer()~=player_ai
    and Duel.GetCurrentPhase()==PHASE_END)
    and not HasID(AIMon(),c.id)
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    and CardsMatchingFilter(AIDeck(),KozmoShip)>2
    and not GlobalSummonNegated
    then
      if CardsMatchingFilter(AIMon(),KozmoRider)>0 then
        return 6
      end
      return true
    end
    return false
  end
  return true
end
function SoartrooperCond(loc,c)
  if loc == PRIO_TOHAND then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AICards(),c.id)
    and OPTCheck(c.id)
    and not NormalSummonCheck()
    and CardsMatchingFilter(AIGrave(),KozmoRider)>0
    and AI.GetPlayerLP(1)>4000
    and DualityCheck()
  end
  if loc == PRIO_TOFIELD then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AIMon(),c.id)
    and CardsMatchingFilter(AIGrave(),KozmoRider)>0
    and AI.GetPlayerLP(1)>4000
    and not GlobalSummonNegated
  end
  return true
end
function SlipriderCond(loc,c)
  if loc == PRIO_TOHAND then
    return 
  end
  if loc == PRIO_TOFIELD then
    if Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and (FieldCheck(5)==1
    or CardsMatchingFilter(AIMon(),KozmoRider)>0
    and HasID(AIHand(),c.id,true,CardsNotEqual,c))
    then
      return 9
    end
    return DestroyCheck(OppST())>0
  end
end
function KozmojoCond(loc,c)
  if loc==PRIO_TOHAND then
    return not HasIDNotNegated(AICards(),c.id,true)
    and CardsMatchingFilter(AIField(),KozmoShip)>0
  end
  return true
end
KozmoPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Kozmo

[54063868] = {6,1,6,1,1,1,2,1,6,1,EclipserCond},  -- Dark Eclipser
[55885348] = {8,3,8,4,1,1,2,1,9,1,DestroyerCond},  -- Dark Destroyer
[20849090] = {7,2,7,3,1,1,3,1,8,1,ForerunnerCond},  -- Forerunner
[29491334] = {4,1,6,1,1,1,4,1,7,1,DogfighterCond},  -- Dog Fighter
[94454495] = {3,1,5,1,1,1,3,1,5,1,SlipriderCond},  -- Sliprider
[93302695] = {5,1,4,1,1,1,2,1,2,1,WickedwitchCond},  -- Wickedwitch
[67050396] = {1,1,3,1,1,1,4,1,2,1,GoodwitchCond},  -- Goodwitch
[31061682] = {9,2,9,2,1,1,1,1,1,1,FarmgirlCond},  -- Farmgirl
[01274455] = {4,1,4,1,1,1,1,1,1,1,SoartrooperCond}, -- Soartrooper
[56907986] = {9,1,8,1,1,1,3,1,1,1,StrawmanCond},  -- Strawman
[64280356] = {5,1,5,1,1,1,1,1,1,1,TincanCond},  -- Tincan

[37742478] = {1,1,1,1,1,1,1,1,1,1},  -- Honest
[59438930] = {1,1,1,1,1,1,1,1,1,1},  -- Ghost Ogre
[23434538] = {1,1,1,1,1,1,1,1,1,1},  -- Maxx "C"

[01475311] = {1,1,1,1,1,1,1,1,1,1},  -- Allure
[12580477] = {1,1,1,1,1,1,1,1,1,1},  -- Raigeki
[73628505] = {1,1,1,1,1,1,1,1,1,1},  -- Terraforming
[14087893] = {1,1,1,1,1,1,1,1,1,1},  -- Book of Moon
[67723438] = {1,1,1,1,1,1,1,1,1,1},  -- Emergency Teleport
[67237709] = {10,1,1,1,1,1,1,1,1,1,KozmotownCond},  -- Kozmotown
[43898403] = {1,1,1,1,1,1,1,1,1,1},  -- Twin Twister
[58577036] = {1,1,1,1,1,1,1,1,1,1},  -- Reasoning

[05851097] = {1,1,1,1,1,1,1,1,1,1},  -- Vanity
[40605147] = {1,1,1,1,1,1,1,1,1,1},  -- Notice
[84749824] = {1,1,1,1,1,1,1,1,1,1},  -- Warning
[90452877] = {8,1,1,1,1,1,1,1,1,1,Kozmojocond},  -- Kozmojo
} 
function ActivateKozmotown(c)
  return not HasID(AIST(),67237709,true,FilterPosition,POS_FACEUP)
end
function UseKozmotown(c,mode)
  if mode == 1 
  and AI.GetPlayerLP(1)>2000
  then
    OPTSet(c)
    return true
  end
  if mode == 2 then
    return TurnEndCheck() and CardsMatchingFilter(AIHand(),KozmoMonsterFilter)>2
    or not NormalSummonCheck() and CardsMatchingFilter(AIHand(),KozmoRider)==0
  end
  return false
end
function UseAllure(c)
  return CardsMatchingFilter(AIHand(),FilterAttribute,ATTRIBUTE_DARK)>0
end
function SummonFarmgirl(c,mode)
  if mode == 1 
  and (#OppMon()==0
  or not OppHasStrongestMonster()
  or CanDealBattleDamage(c,OppMon()))
  and BattlePhaseCheck()
  and not HasIDNotNegated(AIMon(),c.id,true)
  then
    return true
  end
  if mode == 2 then
    return not HasID(AIMon(),c.id,true)
  end
end
function SummonWickedWitch(c,mode)
  return true
end
function GoodwitchFilter(c,source)
  local atk = math.max(AIGetStrongestAttack(),c.attack)
  return Affected(c,TYPE_MONSTER,source.level)
  and Targetable(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP)
  and atk>c.defense
end
function SummonGoodWitch(c,mode)
  if mode == 1 
  and HasPriorityTarget(OppMon(),false,nil,GoodwitchFilter,c)
  and AI.GetPlayerLP(1)>500
  then
    return true
  end
  if mode == 2
  then
    return not HasID(AIMon(),c.id,true)
  end
end
function SummonStrawman(c,mode)
  if mode == 1 
  and CardsMatchingFilter(AIBanish(),KozmoShip)==0
  and not HasIDNotNegated(AIMon(),c.id,true)
  and DualityCheck()
  and AI.GetPlayerLP(1)>1000
  then
    return true
  end
  if mode == 2 then
    return not HasID(AIMon(),c.id,true)
  end
end
function SummonTincan(c,mode)
  if mode == 1 
  and CardsMatchingFilter(AIHand(),KozmoShip)==0
  and not HasIDNotNegated(AIMon(),c.id,true)
  and NotNegated(c)
  then  
    return true
  end
  if mode == 2 then
    return not HasID(AIMon(),c.id,true)
  end
end
function SummonSoartrooper(c,mode)
  if mode == 1 
  and CardsMatchingFilter(AIGrave(),KozmoRider)>0
  and not HasIDNotNegated(AIMon(),c.id,true)
  and NotNegated(c)
  and AI.GetPlayerLP(1)>4000
  then  
    return true
  end
  if mode == 2 then
    return not HasID(AIMon(),c.id,true)
  end
end
function UseEtele(c,mode)
  if mode == 1 then
    if HasIDNotNegated(AIST(),67237709,true,nil,nil,POS_FACEUP,FilterOPT)
    and CardsMatchingFilter(AICards(),KozmoRider)==0
    and CardsMatchingFilter(AIDeck(),
      function(c)return KozmoRider(c) and FilterLevelMax(c,3) end)>0
    and not NormalSummonCheck()
    then
      return true
    end
    if HasIDNotNegated(AIDeck(),64280356,true)
    and not HasIDNotNegated(AICards(),64280356,true)
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    then
      return true
    end
  end
  if mode == 2 then
    if #AIMon() == 0
    and (CardsMatchingFilter(AIHand(),KozmoShip)>0
    or HasIDNotNegated(AIDeck(),64280356,true))
    then
      return true
    end
  end
  return false
end
function UseRiderSummon(c)
  if (#OppMon()>0 and not CanWinBattle(c,OppMon()) and OppHasStrongestMonster()
  or HasID(AIST(),67237709,true) 
  and not NormalSummonCheck()
  or TurnEndCheck() and HasIDNotNegated(AIST(),67237709,true,nil,nil,POS_FACEUP,FilterOPT))
  --or not BattlePhaseCheck())
  and CardsMatchingFilter(AIHand(),KozmoShip)>0
  then
    OPTSet(c.id)
    return true
  end
  if HasID(AIHand(),55885348,true)
  and HasIDNotNegated(AIDeck(),56907986,true)
  and AI.GetPlayerLP(1)>1500
  and (c.id~=31061682 or not CanDealBattleDamage(c,OppMon()))
  then
    OPTSet(c.id)
    return true
  end
  if HasID(AIHand(),94454495,true)
  and FieldCheck(5) == 1
  then
    OPTSet(c.id)
    return true
  end
end
function UseFarmgirl(c,mode)
  if mode == 1 then
    if (not CanDealBattleDamage(c,OppMon())
    and OppHasStrongestMonster()
    or HasID(AIST(),67237709,true) 
    and not NormalSummonCheck()
    or TurnEndCheck() and HasIDNotNegated(AIST(),67237709,true,nil,nil,POS_FACEUP,OPTCheck))
    --or not BattlePhaseCheck())
    and CardsMatchingFilter(AIHand(),KozmoShip)>0
    then
      OPTSet(c.id)
      return true
    end
    if HasID(AIHand(),55885348,true)
    and HasIDNotNegated(AIDeck(),56907986,true)
    and AI.GetPlayerLP(1)>1000
    then
      OPTSet(c.id)
      return true
    end
    if HasID(AIHand(),94454495,true)
    and FieldCheck(5) == 1
    then
      OPTSet(c.id)
      return true
    end
  end
end
function UseStrawman(c,mode)
  if mode == 1 
  and AI.GetPlayerLP(1)>1000
  and CardsMatchingFilter(AIBanish(),KozmoShip)>0
  then
    GlobalSummonNegated=true
    return true
  end
  if mode == 2 
  and UseRiderSummon(c)
  then
    return true
  end
end
function UseGoodwitch(c,mode)
  if mode == 1  
  and HasPriorityTarget(OppMon(),false,nil,GoodwitchFilter,c)
  and AI.GetPlayerLP(1)>500
  then
    return true
  end
  if mode == 2 
  and UseRiderSummon(c)
  then
    return true
  end
  return false
end
function UseWickedwitch(c,mode)
  if mode == 1 then
    return false -- TODO
  end
  if mode == 2 
  and UseRiderSummon(c)
  then
    return true
  end
  return false
end
function UseReasoning(c,mode)
  if mode == 1 then
    return #AIMon()==0 or OppHasStrongestMonster()
  end
end
function ReasoningNumber() -- for opponent's Reasoning
  local result = MatchupCheck(58577036) -- Reasoning
  if result then return result end
  return 4
end
function UseTincan(c,mode)
  if mode == 2 
  and UseRiderSummon(c)
  then
    return true
  end
end
function UseSoartrooper(c,mode)
  if mode == 1 then
    if AI.GetPlayerLP(1)>4000
    and CardsMatchingFilter(AIGrave(),KozmoRider)>0
    then
      return true
    end
  end
  if mode == 2 
  and UseRiderSummon(c)
  then
    return true
  end
end
function KozmoInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(Act,73628505) then -- Terraforming
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,false,nil,LOCATION_SZONE,POS_FACEDOWN,ActivateKozmotown) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,false,nil,LOCATION_HAND,ActivateKozmotown) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,false,67237709*16,LOCATION_SZONE,UseKozmotown,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,58577036,UseReasoning,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67723438,UseEtele,1) then
    return Activate()
  end
  if HasID(Sum,31061682,SummonFarmgirl,1) then
    return Summon()
  end
  if HasID(Sum,56907986,SummonStrawman,1) then
    return Summon()
  end
  if HasID(Sum,64280356,SummonTincan,1) then
    return Summon()
  end
  if HasID(Sum,67050396,SummonGoodWitch,1) then
    return Summon()
  end
  if HasID(Sum,93302695,SummonWickedWitch) then
    return Summon()
  end
  if HasID(Sum,67050396,SummonGoodWitch,2) then
    return Summon()
  end
  if HasID(Sum,01274455,SummonSoartrooper,2) then
    return Summon()
  end
  if HasID(Sum,31061682,SummonFarmgirl,2) then
    return Summon()
  end
  if HasID(Sum,56907986,SummonStrawman,2) then
    return Summon()
  end
  if HasID(Sum,64280356,SummonTincan,2) then
    return Summon()
  end
  if HasIDNotNegated(Act,56907986,false,56907986*16+1,UseStrawman,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,01274455,false,93302695*16,UseSoartrooper,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67050396,false,67050396*16+1,UseGoodwitch,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,93302695,false,93302695*16+1,UseWickedwitch,1) then
    return Activate()
  end
  if HasID(Act,56907986,false,56907986*16,UseStrawman,2) then
    OPTSet(56907986)
    return Activate()
  end
  if HasIDNotNegated(Act,67050396,false,67050396*16,UseGoodwitch,2) then
    OPTSet(67050396)
    return Activate()
  end
  if HasIDNotNegated(Act,93302695,false,93302695*16,UseWickedwitch,2) then
    OPTSet(93302695)
    return Activate()
  end
  if HasIDNotNegated(Act,01274455,false,93302695*16+1,UseSoartrooper,2) then
    OPTSet(01274455)
    return Activate()
  end
  if HasID(Act,01475311,UseAllure) then -- Allure
    return Activate()
  end
  if HasID(Act,31061682,false,UseFarmgirl,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67723438,UseEtele,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,false,67237709*16+1,LOCATION_SZONE,UseKozmotown,2) then
    return Activate()
  end
  return nil
end

function DestroyerTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  if #OppMon()==0 then
    return BestTargets(cards,1,TARGET_PROTECT,DestroyerFilter)
  end
  return BestTargets(cards)
end
function ForerunnerTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards)
end
function DogFighterTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards)
end
function SlipriderTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards)
end
function WickedwitchTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards,1,TARGET_PROTECT)
end
function GoodwitchTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards,1,TARGET_FACEDOWN)
end
function FarmgirlTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
function StrawmanTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards,PRIO_TOFIELD,1,KozmoShip)
end
function KozmotownTarget(cards,min,max)
  if LocCheck(cards,LOCATION_HAND) then
    if CardsMatchingFilter(AIMon(),KozmoRider)>0
    and CardsMatchingFilter(AIHand(),KozmoShip)>0
    then
      return Add(cards,PRIO_TODECK,math.max(1,max-1),function(c) return not KozmoShip(c) end)
    end
    if CardsMatchingFilter(AIHand(),KozmoRider)>0
    then
      return Add(cards,PRIO_TODECK,math.max(1,max-1),function(c) return not KozmoRider(c) end)
    end
    return Add(cards,PRIO_TODECK,max)
  elseif LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  return Add(cards)
end
GlobalEteleSummons={}
function Eteletarget(cards)
  local result = Add(cards,PRIO_TOFIELD)
  local c = cards[1]
  cards[1].summonturn=Duel.GetTurnCount()
  GlobalEteleSummons[#GlobalEteleSummons+1]=c
  return result
end
function TincanTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,nil,nil,KozmoShip)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
end
function SoartrooperTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
end
function DarkEclipserTarget(cards)
  return Add(cards,PRIO_BANISH)
end
function KozmojoTarget(cards)
  if CurrentOwner(cards[1])==1 then
    if GlobalCardMode == 1 then
      GlobalCardMode = nil
      return Add(cards,PRIO_BANISH,1,FilterGlobalTarget)
    end
    return Add(cards,PRIO_BANISH)
  end
  return BestTargets(cards,1,TARGET_BANISH)
end
function KozmoCard(cards,min,max,id,c)
  if id == 64280356 then
    return TincanTarget(cards)
  end
  if id == 01274455 then
    return SoartrooperTarget(cards)
  end
  if id == 54063868 then
    return DarkEclipserTarget(cards)
  end
  if id == 67723438 then
    return Eteletarget(cards)
  end
  if id == 55885348 then
    return DestroyerTarget(cards)
  end 
  if id == 20849090 then
    return ForerunnerTarget(cards)
  end 
  if id == 29491334 then
    return DogFighterTarget(cards)
  end 
  if id == 94454495 then
    return SlipriderTarget(cards)
  end 
  if id == 93302695 then
    return WickedwitchTarget(cards)
  end 
  if id == 67050396 then
    return GoodwitchTarget(cards)
  end 
  if id == 31061682 then
    return FarmgirlTarget(cards)
  end 
  if id == 56907986 then
    return StrawmanTarget(cards)
  end   
  if id == 67237709 then
    return KozmotownTarget(cards,min,max)
  end
  if id == 90452877 then
    return KozmojoTarget(cards)
  end
  return nil
end
function ChainKozmotown(c)
  return true
end
function DestroyerFilter(c)
  return KozmoShip(c)
  and AvailableAttacks(c)==0
end
function ChainDestroyer(c)
  if Negated(c) then
    return false
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  if DestroyCheck(OppMon(),false,true)>0 then
    return true
  end
  if #OppMon()==0 
  and CardsMatchingFilter(AIMon(),DestroyerFilter)>0
  then
    return true
  end
  if #OppMon()==0 
  and HasIDNotNegated(AIDeck(),56907986,true)
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()~=PHASE_END
  and not IsBattlePhase()
  then
    return true
  end
end
function ChainForerunner(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  return true
end
function ChainDogFighter(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  return true
end
function ChainSliprider(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  if Negated(c) then
    return false
  end
  return DestroyCheck(OppST(),false,true)>0
end
function ChainRiderSummon(c)
  if Negated(c) then
    return false
  end
  if RemovalCheckCard(c) 
  or NegateCheckCard(c) 
  then
    if RemovalCheckCard(c,CATEGORY_DESTROY) 
    and FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT)
    then
      return false
    end
    OPTSet(c.id)
    return true
  end
  if not UnchainableCheck(c.id) then return false end
  if IsBattlePhase() then
    local aimon,oppmon=GetBattlingMons()
    if WinsBattle(oppmon,aimon) 
    and CardsEqual(c,aimon)
    and (CardsMatchingFilter(AIHand(),FilterAttackMin,oppmon:GetAttack())>0
    or HasIDNotNegated(AIHand(),55885348,true))
    and Duel.GetTurnPlayer()==1-player_ai
    then
      OPTSet(c.id)
      return true
    end
    if Duel.GetTurnPlayer()==player_ai 
    and GlobalBPEnd and not aimon
    and (AvailableAttacks(c)==0 or not CanWinBattle(c,OppMon()))
    and(CardsMatchingFilter(AIHand(),CanWinBattle,OppMon())>0
    or #OppMon()==0)
    then
      OPTSet(c.id)
      return true
    end
  end
  if HasIDNotNegated(AIHand(),55885348,true) 
  and HasPriorityTarget(OppMon(),true)
  and Duel.GetCurrentChain()<1
  and (Duel.GetTurnPlayer()~=player_ai 
  or OppHasStrongestMonster())
  then
    OPTSet(c.id)
    return true
  end
  for i=1,#GlobalEteleSummons do
    local card = GlobalEteleSummons[i]
    if CardsEqual(card,c) 
    and card.summonturn==Duel.GetTurnCount() 
    and Duel.CheckTiming(TIMING_END_PHASE)
    then
      OPTSet(c.id)
      return true
    end
  end
end
function ChainWickedwitch(c,mode)
  if mode == 1 then
    if RemovalCheckCard(c,CATEGORY_DESTROY) then
      return true
    end
    if not UnchainableCheck(c.id) then return false end
    local aimon,oppmon = GetBattlingMons()
    if Duel.GetCurrentPhase()==PHASE_BATTLE
    and WinsBattle(oppmon,aimon) 
    and CardsEqual(c,aimon)
    then
      return true
    end
  elseif mode == 2 then
    return ChainRiderSummon(c)
  end
  return false
end
function ChainGoodwitch(c)
  return ChainRiderSummon(c)
end
function ChainFarmgirl(c)
  if Duel.GetCurrentPhase()==PHASE_DAMAGE 
  and AI.GetPlayerLP(1)>500
  and NotNegated(c)
  then
    return true
  end
  if c.description==c.id*16 then
    return ChainRiderSummon(c)
  end
end
function ChainStrawman(c,mode)
  return ChainRiderSummon(c)
end
function ChainTincan(c,mode)
  if mode == 1 then
    return CardsMatchingFilter(AIDeck(),KozmoShip)>1
    and MacroCheck()
  end
  if mode == 2 then
    return ChainRiderSummon(c)
  end
end
function ChainSoartrooper(c,mode)
  return ChainRiderSummon(c)
end
function ChainEtele(c)
  if RemovalCheckCard(c) then
    return true
  end
  local aimon,oppmon=GetBattlingMons()
  if Duel.GetCurrentPhase()==PHASE_BATTLE
  and Duel.GetTurnPlayer()==player_ai
  and HasID(AIDeck(),31061682,true)
  and CanDealBattleDamage(FindID(31061682,AIDeck()),OppMon())
  and GlobalBPEnd and not aimon
  and UnchainableCheck(c.id)
  and not HasIDNotNegated(AIMon(),31061682,true,function(c) return AvailableAttacks(c)>0 end)
  then
    return true
  end
  return false
end
function KozmojoFilter(c)
  return Affected(c,TYPE_TRAP)
  and FilterRemovable(c)
end
function ChainKozmojo(c)
  local targets = SubGroup(OppField(),KozmojoFilter)
  local prio = SubGroup(targets,FilterPriorityTarget)
  local tribute = SubGroup(AIMon(),KozmoFilter)
  local ships = SubGroup(tribute,KozmoShip)
  if RemovalCheckCard(c) 
  and #targets>0
  then
    return true
  end
  if not UnchainableCheck(c) then
    return false
  end
  local removed=RemovalCheckList(tribute) 
  if #tribute>0 
  and removed
  and #targets>0
  then
    table.sort(removed,function(a,b) if KozmoShip(a) then return a end return b end)
    GlobalTargetSet(removed[1])
    GlobalCardMode=1
    return true
  end
  if #prio>0
  and #ships>0
  then
    return true
  end
  local aimon,oppmon=GetBattlingMons()
  if aimon and KozmoFilter(aimon) 
  and WinsBattle(oppmon,aimon)
  and #targets>0
  then
    GlobalTargetSet(aimon)
    GlobalCardMode=1
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_END
  and Duel.GetCurrentChain()==0
  and Duel.GetTurnPlayer()==1-player_ai
  and #targets>0
  and #ships>0
  then
    return true
  end
end

function ChainCotHKozmo(c)
  local ships = SubGroup(AIGrave(),KozmoShip)
  local targetmons = SubGroup(OppMon(),DestroyFilterIgnore)
  local priomons = SubGroup(targetmons,FilterPriorityTarget)
  local targetst = SubGroup(OppST(),DestroyFilterIgnore)
  local priost = SubGroup(targetst,FilterPriorityTarget)
  if RemovalCheckCard(c) then
    if HasID(ships,55885348,true) and #targetmons>0 then
      GlobalCardMode = 1
      GlobalTargetSet(55885348)
    elseif HasID(ships,94454495,true) and #targetst>0 then
      GlobalCardMode = 1
      GlobalTargetSet(94454495)
    end
    return true
  end
  if HasID(ships,55885348,true) and #priomons>0 then
    GlobalCardMode = 1
    GlobalTargetSet(55885348)
    return true
  end
  if HasID(ships,94454495,true) and #priost>0 then
    GlobalCardMode = 1
    GlobalTargetSet(94454495)
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_END
  and Duel.GetCurrentChain()==0
  and Duel.GetTurnPlayer()==1-player_ai
  then
    if HasID(ships,55885348,true) and #targetmons>0 then
      GlobalCardMode = 1
      GlobalTargetSet(55885348)
      return true
    end
    if HasID(ships,94454495,true) and #targetst>0 then
      GlobalCardMode = 1
      GlobalTargetSet(94454495)
      return true
    end
  end
  local aimon,oppmon=GetBattlingMons()
  if Duel.GetCurrentPhase()==PHASE_BATTLE
  and Duel.GetTurnPlayer()==player_ai
  and HasID(AIGrave(),31061682,true)
  and CanDealBattleDamage(FindID(31061682,AIGrave()),OppMon())
  and GlobalBPEnd and not aimon
  and UnchainableCheck(c.id)
  and not HasIDNotNegated(AIMon(),31061682,true,function(c) return AvailableAttacks(c)>0 end)
  then
    return true
  end
  if ChainCotH(card) then
    return true
  end
end
function KozmoChain(cards)
  if HasIDNotNegated(cards,54063868,ChainNegation,2) then
    return Chain()
  end
  if HasIDNotNegated(cards,67723438,ChainEtele) then
    return Chain()
  end
  if HasID(cards,55885348,ChainDestroyer) then
    return Chain()
  end
  if HasID(cards,20849090,ChainForerunner) then
    return Chain()
  end
  if HasID(cards,29491334,ChainDogFighter) then
    return Chain()
  end
  if HasID(cards,94454495,ChainSliprider) then
    return Chain()
  end
  if HasID(cards,93302695,false,93302695*16,ChainWickedwitch,2) then
    return Chain()
  end
  if HasID(cards,64280356,false,1028485697,ChainTincan,1) then
    return Chain()
  end
  if HasID(cards,64280356,false,1028485696,ChainTincan,2) then
    return Chain()
  end
  if HasID(cards,01274455,ChainSoartrooper) then
    return Chain()
  end
  if HasID(cards,56907986,ChainStrawman) then
    return Chain()
  end
  if HasID(cards,67050396,ChainGoodwitch) then
    return Chain()
  end
  if HasIDNotNegated(cards,93302695,false,93302695*16+1,ChainWickedwitch,1) then
    return Chain()
  end
  if HasID(cards,31061682,ChainFarmgirl) then
    return Chain()
  end
  if HasID(cards,90452877,ChainKozmojo) then
    return Chain()
  end
  if HasID(cards,97077563,ChainCotHKozmo) then
    return true
  end
  if HasID(cards,67237709,ChainKozmotown) then
    return Chain()
  end
  return nil
end
function KozmoEffectYesNo(id,card)
  if id == 55885348 and ChainDestroyer(card) then
    return 1
  end
  if id == 20849090 and ChainForerunner(card) then
    return 1
  end
  if id == 29491334 and ChainDogFighter(card) then
    return 1
  end
  if id == 94454495 and ChainSliprider(card) then
    return 1
  end
  if id == 31061682 and ChainFarmgirl(card) then
    return 1
  end
  if id == 67237709 and ChainKozmotown(card) then
    return 1
  end
  if id == 64280356 and ChainTincan(card,1) then
    return 1
  end
  return nil
end
function KozmoYesNo(desc)
end
function KozmoTribute(cards,min, max)
end
function KozmoBattleCommand(cards,targets,act)
  SortByATK(cards)
  if HasID(cards,31061682,CanDealBattleDamage,targets) then
    return Attack(CurrentIndex)
  end
end
function KozmoAttackTarget(cards,attacker)
end
function KozmoAttackBoost(cards)
end
function KozmoOption(options)
  for i,v in pairs(options) do
    if v == 90452877*16 then -- Kozmojo
      local targets = SubGroup(OppField(),KozmojoFilter)
      if #targets>0 then
        return i
      end
    end
    if v == 90452877*16+1 then -- Kozmojo
      return i
    end
  end
end
function KozmoChainOrder(cards)
end
KozmoAtt={
54063868, -- Dark Eclipser
55885348, -- Dark Destroyer
20849090, -- Forerunner
94454495, -- Sliprider
67050396, -- Goodwitch
31061682, -- Farmgirl
}
KozmoVary={
29491334, -- Dog Fighter
29491335, -- Dog Fighter token
93302695, -- Wickedwitch
01274455, -- Soartrooper
}
KozmoDef={
64280356, -- Tincan
56907986, -- Strawman
}
function KozmoPosition(id,available)
  result = nil
  for i=1,#KozmoAtt do
    if KozmoAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#KozmoVary do
    if KozmoVary[i]==id 
    then 
      if (BattlePhaseCheck() or Duel.GetCurrentPhase()==PHASE_BATTLE)
      and Duel.GetTurnPlayer()==player_ai 
      then 
        result=POS_FACEUP_ATTACK
      else 
        result=POS_FACEUP_DEFENSE 
      end
    end
  end
  for i=1,#KozmoDef do
    if KozmoDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end

