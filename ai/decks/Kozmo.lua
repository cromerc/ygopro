
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
64063868, -- Dark Eclipser
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
59496924, -- Landwalker
12408276, -- Dark Lady
37679169, -- Delta Shuttle
09929398, -- Gofu
66413481, -- Yaksha
54149433, -- Garunix
57554544, -- Fire King Island
85252081, -- Granpulse
}
KozmoSummonBlacklist={
55885348, -- Dark Destroyer
20849090, -- Forerunner
29491334, -- Dog Fighter
94454495, -- Sliprider
93302695, -- Wickedwitch
67050396, -- Goodwitch
31061682, -- Farmgirl
64063868, -- Dark Eclipser
01274455, -- Soartrooper
64280356, -- Tincan
59496924, -- Landwalker
12408276, -- Dark Lady
37679169, -- Delta Shuttle
09929398, -- Gofu
66413481, -- Yaksha
54149433, -- Garunix

59438930, -- Ghost Ogre
56907986, -- Strawman
23434538, -- Maxx "C"
44405066, -- Red-Eyes Flare Metal Dragon
34945480, -- Outer God Azathot
95169481, -- Diamond Dire Wolf
21044178, -- Abyss Dweller
18326736, -- Planetellarknight Ptolemaeus
01639384, -- Felgrand
62709239, -- Break Sword
85252081, -- Granpulse
95992081, -- Leviair
36776089, -- Centaurea
65305468, -- F0
25862681, -- AFD
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
12408276, -- Dark Lady
85252081, -- Granpulse
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
function FireKingFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0x81) and check
end
function FireKingMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and FireKingFilter(c,exclude)
end
function KozmoRider(c,exclude)
  return KozmoMonsterFilter(c,exclude)
  and FilterRace(c,RACE_PSYCHO)
end
function KozmoShip(c,exclude)
  return KozmoMonsterFilter(c,exclude)
  and FilterRace(c,RACE_MACHINE)
  and FilterLevelMin(c,5)
end

function DestroyerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and (CardsMatchingFilter(AICards(),KozmoRider)>0
    or FireKingIslandCheck())
  end
  if loc == PRIO_TOFIELD then
    return DestroyCheck(OppMon())>0
    or #OppMon()==0 and CardsMatchingFilter(AIMon(),DestroyerFilter)>0
    or #OppMon()==0 and HasIDNotNegated(AIDeck(),56907986,true) and #AIMon()<2 -- Strawman 
    and DualityCheck()
    and MacroCheck()
  end
  return true
end
function ForerunnerCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and (CardsMatchingFilter(AICards(),KozmoRider)>0
    or FireKingIslandCheck())
  end
  if loc == PRIO_TOFIELD then
    if OppGetStrongestAttack()<=c.attack
    or AI.GetPlayerLP(1)<2000
    or (HasID(AIST(),90452877,true) -- Kozmojo
    and CardsMatchingFilter(AIMon(),KozmoShip)==0)
    or HasIDNotNegated(AIMon(),12408276,true) -- Dark Lady
    then
      return true
    end
    return false
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
    if HasID(AICards(),c.id,true) then
      return false
    end
  end
  return true
end
function FarmgirlCond(loc,c)
  if loc == PRIO_TOHAND then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AICards(),c.id,true)
    and not NormalSummonCheck()
    and BattlePhaseCheck()
    and (CanDealBattleDamage(c,OppMon())
    or not OppHasStrongestMonster())
  end
  if loc == PRIO_TOFIELD then
    if IsBattlePhase()
    and Duel.GetTurnPlayer()==player_ai
    and (CanDealBattleDamage(c,OppMon()) 
    or OppMon()==0)
    and not GlobalSummonNegated
    and not HasID(AIMon(),c.id,true)
    then
      return 9
    end
    return Duel.GetTurnPlayer()==player_ai
    and (CanDealBattleDamage(c,OppMon())
    or not OppHasStrongestMonster())
    and OPTCheck(c.id)
    and not GlobalSummonNegated
    and not HasID(AIMon(),c.id,true)
    and BattlePhaseCheck()
  end
  return true
end
function StrawmanCond(loc,c)
  if loc == PRIO_TOHAND then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not HasID(AICards(),c.id,true)
    and OPTCheck(c.id)
    and not NormalSummonCheck()
    and CardsMatchingFilter(AIBanish(),KozmoShip)>0
    and AI.GetPlayerLP(1)>1000
    and DualityCheck()
  end
  if loc == PRIO_TOFIELD then
    if KozmoComboCheck(1,2)
    and HasIDNotNegated(AIST(),57554544,true)
    then
      return 12
    end
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not (HasID(AIMon(),c.id,true)
    or HasID(AIHand(),c.id,true) 
    and NormalSummonsAvailable()>0)
    and CardsMatchingFilter(AIBanish(),KozmoShip)>0
    and AI.GetPlayerLP(1)>1000
    and not GlobalSummonNegated
  end
  if loc == PRIO_TOGRAVE then
    if HasIDNotNegated(AIMon(),01274455,true,FilterOPT) -- Soartrooper
    and CardsMatchingFilter(AIBanish(),KozmoShip)>0
    and SpaceCheck()>1
    and AI.GetPlayerLP(1)>4000
    and not HasID(AIMon(),c.id,true)
    then
      return true
    end
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
    and not HasID(AICards(),c.id,true)
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    and CardsMatchingFilter(AIMon(),KozmoRider)>2
    and not GlobalSummonNegated
    then
      if CardsMatchingFilter(AIMon(),KozmoRider)>0 then
        --return 6
      end
      return true
    end
    return false
  end
  if loc == PRIO_TOFIELD then
    if(Duel.GetTurnPlayer()==player_ai
    or Duel.GetTurnPlayer()~=player_ai
    and Duel.GetCurrentPhase()==PHASE_END)
    and not HasID(AIMon(),c.id,true)
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    and CardsMatchingFilter(AIDeck(),KozmoShip)>2
    and not GlobalSummonNegated
    then
      if CardsMatchingFilter(AIMon(),KozmoRider)>0 then
        --return 6
      end
      return true
    end
    return false
  end
  return true
end
function KozmoXYZCheck(level)
  level=level or 3
  if not CanSpecialSummon() then
    return false
  end
  if level == 3 then
    if HasIDNotNegated(AIExtra(),31320433,true,SummonNightmareSharkFinish) then
      return true
    elseif HasIDNotNegated(AIExtra(),95992081,true,SummonLeviairKozmo,2) then
      return true
    elseif HasIDNotNegated(AIExtra(),62709239,true,SummonBreakSwordKozmo,2) then
      return true
    elseif HasIDNotNegated(AIExtra(),62709239,true,SummonBreakSwordKozmo,3) then
      return true
    elseif HasIDNotNegated(AIExtra(),85252081,true,SummonGranpulseKozmo,2) then
      return true
    end
  end
  if level == 5 then
    if HasID(AIExtra(),58069384,true,SummonNova,1) then
      return true
    end
    if HasID(AIExtra(),58069384,true,SummonPleiades,1) then
      return true
    end
  end
  return false -- TODO
end
function SoartrooperCond(loc,c)
  if loc == PRIO_TOHAND then
    return Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not IsBattlePhase()
    and not HasID(AICards(),c.id,true)
    and OPTCheck(c.id)
    and not NormalSummonCheck()
    and CardsMatchingFilter(AIGrave(),KozmoRider)>0
    and AI.GetPlayerLP(1)>4000
    and DualityCheck()
  end
  if loc == PRIO_TOFIELD then
    if KozmoComboCheck(1,2)
    and not HasID(AIST(),57554544,true) -- Fire King Island
    --and HasIDNotNegated(AIGrave(),56907986,true) -- Strawman
    and Duel.GetCurrentPhase()~=PHASE_END
    then
      return 12
    end
    if Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    --and not HasID(AIMon(),c.id,true)
    and CardsMatchingFilter(AIGrave(),KozmoRider)>0
    and AI.GetPlayerLP(1)>4000
    and not GlobalSummonNegated
    then
      if FieldCheck(3)==1
      and FilterLocation(c,LOCATION_GRAVE)
      and CardsMatchingFilter(AIGrave(),KozmoRider)>1
      and SpaceCheck()>1
      and KozmoXYZCheck(3)
      then
        return 9
      end
      if HasIDNotNegated(AIGrave(),56907986,true) -- Strawman
      and CardsMatchingFilter(AIBanish(),KozmoShip)>0
      and (FieldCheck(3)==1
      or (HasIDNotNegated(AIMon(),25862681,true) -- AFD
      and HandCheck(3)>0))
      and SpaceCheck()>2
      then
        return 9
      end
      return true
    end
    return false
  end
  if loc == PRIO_TOGRAVE then
    if not HasID(AIGrave(),c.id,true)
    and HasID(AIMon(),c.id,true,FilterOPT)
    and SpaceCheck()>2
    and AI.GetPlayerLP(1)>4000
    then
      return true
    end
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
    and KozmoXYZCheck(5)
    then
      return 9
    end
    return DestroyCheck(OppST())>0
  end
end
function KozmojoCond(loc,c)
  if loc==PRIO_TOHAND then
    if HasIDNotNegated(AICards(),c.id,true)
    or CardsMatchingFilter(AIMon(),KozmoShip)==0
    or FireKingIslandCheck() and CardsMatchingFilter(AIHand(),KozmoShip)==0
    or BattlePhaseCheck() and CardsMatchingFilter(AIMon(),KozmoRider)>0
    then
      return false
    end
  end
  return true
end
function LandwalkerCond(loc,c)
  if loc == PRIO_TOFIELD then
    if HasIDNotNegated(AIMon(),12408276,true) -- Dark Lady
    or (HasID(AIST(),90452877,true) -- Kozmojo
    and CardsMatchingFilter(AIMon(),KozmoShip)==0)
    then
      return true
    end
    return false
  end
  return true
end
function DeltaShuttleCond(loc,c)
  if loc==PRIO_TOFIELD then
    if KozmoComboCheck(1)
    and not HasID(AIST(),57554544,true) -- Fire King Island
    then
      return 13
    end
    if KozmoComboCheck(3)
    and HasID(AIST(),57554544,true) -- Fire King Island
    then
      return 13
    end
    if (HasIDNotNegated(AIMon(),01274455,true) -- Soartrooper
    or HasIDNotNegated(AIHand(),01274455,true) -- Soartrooper
    and NormalSummonsAvailable()>0)
    and CardsMatchingFilter(AIGrave(),KozmoRider)<2
    and CardsMatchingFilter(AIMon(),KozmoRider)<2
    and AI.GetPlayerLP(1)>4000
    and Duel.GetTurnPlayer()==player_ai
    and Duel.GetCurrentPhase()~=PHASE_END
    and not IsBattlePhase()
    then 
      return 10
    end
  end
  return true
end
function DarkLadyCond(loc,c)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AICards(),KozmoRider)>0
  end
  if loc == PRIO_TOFIELD then
    if HasIDNotNegated(AIMon(),c.id,true) then
      return 1
    end
    if (Duel.GetTurnPlayer()~=player_ai
    or Duel.GetCurrentPhase()==PHASE_END)
    and (CardsMatchingFilter(AIMon(),KozmoShip)>0
    or not HasID(AIST(),90452877,true)) -- Kozmojo
    then
      return true
    end
    return false
  end
  if loc == PRIO_TOGRAVE then
    if HasIDNotNegated(AIMon(),01274455,true,FilterOPT) -- Soartrooper
    and SpaceCheck()>0
    and AI.GetPlayerLP(1)>3000
    and not HasID(AIMon(),c.id,true)
    and not HasID(AIGrave(),c.id,true)
    then
      return 9
    end
    return not HasID(AIGrave(),c.id,true)
  end
  return true
end
function FireKingIslandCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIHand(),KozmoShip)>0
    and CardsMatchingFilter(AIDeck(),FireKingMonsterFilter)>0
    and not HasID(AICards(),c.id,true)
    then
      return true
    end
    if HasID(AICards(),67237709,true) then -- Kozmotown
      return 5
    end
    if HasIDNotNegated(AIMon(),25862681,true) -- AFD
    --and ChainCheck(25862681,1) -- AFD
    then
      return true
    end
    return false
  end
  return true
end
KozmoPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Kozmo

[64063868] = {6,1,6,1,1,1,2,1,6,1,EclipserCond},  -- Dark Eclipser
[55885348] = {8,3,8,4,1,1,2,1,9,1,DestroyerCond},  -- Dark Destroyer
[20849090] = {6,2,6,3,1,1,3,1,8,1,ForerunnerCond},  -- Forerunner
[29491334] = {4,1,6,1,1,1,4,1,7,1,DogfighterCond},  -- Dog Fighter
[94454495] = {3,1,5,1,1,1,3,1,5,1,SlipriderCond},  -- Sliprider
[93302695] = {5,1,4,1,1,1,2,1,2,1,WickedwitchCond},  -- Wickedwitch
[67050396] = {1,1,3,1,1,1,4,1,2,1,GoodwitchCond},  -- Goodwitch
[31061682] = {4,2,4,2,1,1,1,1,1,1,FarmgirlCond},  -- Farmgirl
[01274455] = {10,1,8,1,3,1,1,1,1,1,SoartrooperCond}, -- Soartrooper
[56907986] = {9,1,7,1,5,1,3,1,1,1,StrawmanCond},  -- Strawman
[64280356] = {2,1,2,1,1,1,1,1,1,1,TincanCond},  -- Tincan
[59496924] = {2,1,5,1,1,1,1,1,1,1,Landwalkercond},  -- Landwalker
[12408276] = {7,1,6,3,4,2,1,1,1,1,DarkLadyCond},  -- Dark Lady
[37679169] = {1,1,2,1,1,1,1,1,1,1,DeltaShuttleCond},  -- Delta Shuttle

[09929398] = {1,1,1,1,1,1,1,1,1,1},  -- Gofu
[66413481] = {1,1,1,1,1,1,8,1,1,1},  -- Yaksha
[54149433] = {1,1,1,1,1,1,9,1,1,1,GarunixCond},  -- Garunix
[37742478] = {1,1,1,1,1,1,1,1,1,1},  -- Honest
[59438930] = {1,1,1,1,1,1,1,1,1,1},  -- Ghost Ogre
[23434538] = {1,1,1,1,1,1,1,1,1,1},  -- Maxx "C"

[01475311] = {1,1,1,1,1,1,1,1,1,1},  -- Allure
[12580477] = {1,1,1,1,1,1,1,1,1,1},  -- Raigeki
[73628505] = {1,1,1,1,1,1,1,1,1,1},  -- Terraforming
[14087893] = {1,1,1,1,1,1,1,1,1,1},  -- Book of Moon
[67723438] = {1,1,1,1,1,1,1,1,1,1},  -- Emergency Teleport
[67237709] = {6,2,1,1,1,1,1,1,1,1,KozmotownCond},  -- Kozmotown
[43898403] = {1,1,1,1,1,1,1,1,1,1},  -- Twin Twister
[58577036] = {1,1,1,1,1,1,1,1,1,1},  -- Reasoning
[57554544] = {8,1,1,1,1,1,1,1,1,1,FireKingIslandCond},  -- Fire King Island

[05851097] = {1,1,1,1,1,1,1,1,1,1},  -- Vanity
[40605147] = {1,1,1,1,1,1,1,1,1,1},  -- Notice
[84749824] = {1,1,1,1,1,1,1,1,1,1},  -- Warning
[90452877] = {8,1,1,1,1,1,1,1,1,1,KozmojoCond},  -- Kozmojo

[25862681] = {1,1,1,1,1,1,1,1,1,1},  -- AFD
} 
function ActivateKozmotown(c,mode)
  if mode == 1 
  and FilterLocation(c,LOCATION_SZONE)
  and FilterPosition(c,POS_FACEDOWN)
  then
    return true
  end
  if mode == 2 
  and FilterLocation(c,LOCATION_HAND)
  and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD)==0
  and (CardsMatchingFilter(AIBanish(),KozmoMonsterFilter)>0
  or UseKozmotown(c,2)
  or HasIDNotNegated(AIMon(),25862681,true))--AFD
  then
    return true
  end
  if mode == 3
  then
    if KozmoComboCheck(3,6) 
    and HasID(AIField(),57554544,true) -- Fire King Island
    then
      return true
    end
    if KozmoComboCheck(4) 
    and HasID(AIField(),57554544,true) -- Fire King Island
    and HasID(AIGrave(),01274455,true) -- Soartrooper
    then
      return true
    end
    if KozmoComboCheck(5) 
    and HasID(AIField(),57554544,true) -- Fire King Island
    and HasID(AIMon(),94454495,true) -- Sliprider
    then
      return true
    end
  end
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
    and CardsMatchingFilter(AIHand(),KozmoMonsterFilter)>0
  end
  if mode == 3 
  then
    if KozmoComboCheck(3,4,5,6)
    and c.description==c.id*16
    then
      return true
    end
    if KozmoComboCheck(6)
    and c.description==c.id*16+1
    and HasIDNotNegated(AIMon(),10443957,true) -- Infinity
    and HasID(AIHand(),55885348,true) -- Dark Destroyer
    then
      return true
    end
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
    return CardsMatchingFilter(AIMon(),KozmoRider)==0
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
    return CardsMatchingFilter(AIMon(),KozmoRider)==0
  end
end
function SummonStrawman(c,mode)
  if mode == 1 
  and CardsMatchingFilter(AIBanish(),KozmoShip)>0
  and not HasIDNotNegated(AIMon(),c.id,true)
  and DualityCheck()
  and AI.GetPlayerLP(1)>1000
  then
    return true
  end
  if mode == 2 then
    return CardsMatchingFilter(AIMon(),KozmoRider)==0
  end
  if mode == 3
  and HasID(AIMon(),09929398,true) -- Gofu
  and HasID(AIExtra(),25862681,true) -- AFD
  and HasID(AICards(),67237709,true) -- Kozmotown
  and CanSpecialSummon()
  then
    return true
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
    return CardsMatchingFilter(AIMon(),KozmoRider)==0
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
    return CardsMatchingFilter(AIMon(),KozmoRider)==0
  end
end
function UseEtele(c,mode)
  if mode == 1 then
    if HasIDNotNegated(AIST(),67237709,true,nil,nil,POS_FACEUP,FilterOPT) -- Kozmotown
    and CardsMatchingFilter(AICards(),KozmoRider)==0
    and CardsMatchingFilter(AIDeck(),
      function(c)return KozmoRider(c) and FilterLevelMax(c,3) end)>0
    and not NormalSummonCheck()
    then
      return true
    end
    if HasIDNotNegated(AIDeck(),64280356,true) -- Tincan
    and not HasIDNotNegated(AICards(),64280356,true) -- Tincan
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    then
      --return true
    end
  end
  if mode == 2 then
    if #AIMon() == 0
    and (CardsMatchingFilter(AIHand(),KozmoShip)>0
    or HasIDNotNegated(AIDeck(),64280356,true)) -- Tincan
    then
      return true
    end
  end
  if mode == 3
  and HasID(AIMon(),09929398,true) -- Gofu
  then
    if HasIDNotNegated(AIExtra(),73580471,true,UseFieldNuke,-2) -- Black Rose
    and CardsMatchingFilter(AIDeck(),ETeleFilter,2)>0
    then
      GlobalEteleLevel = 2
      return true
    end
    if HasIDNotNegated(AIExtra(),76774528,true,SummonScrapKozmo,0)
    and CardsMatchingFilter(AIDeck(),ETeleFilter,3)>0
    then
      GlobalEteleLevel = 3
      return true
    end
    if HasIDNotNegated(AIExtra(),25862681,true,SummonAFD,0)
    and CardsMatchingFilter(AIDeck(),ETeleFilter,2)>0
    then
      GlobalEteleLevel = 2
      return true
    end
  end
  return false
end
function UseRiderSummon(c)
  if (#OppMon()>0 
  and not CanWinBattle(c,OppMon()) 
  and OppHasStrongestMonster()
  or HasID(AIST(),67237709,true) -- Kozmotown
  and not NormalSummonCheck()
  or TurnEndCheck() 
  and HasIDNotNegated(AIST(),67237709,true,nil,nil,POS_FACEUP,FilterOPT)) -- Kozmotown
  --or not BattlePhaseCheck())
  and CardsMatchingFilter(AIHand(),KozmoShip)>0
  then
    OPTSet(c.id)
    return true
  end
  if HasID(AIHand(),55885348,true) -- Dark Destroyer
  and HasIDNotNegated(AIDeck(),56907986,true) -- Strawman
  and AI.GetPlayerLP(1)>1500
  and (CardsMatchingFilter(AIHand(),KozmoShip)>1 
  or HasIDNotNegated(AIHand(),12408276,true)) -- Dark Lady
  and (c.id~=31061682 or not CanDealBattleDamage(c,OppMon())) -- Farmgirl
  and MP2Check()
  then
    OPTSet(c.id)
    return true
  end
  if (CardsMatchingFilter(AIHand(),KozmoShip,55885348)>0 -- Dark Destroyer
  or HasIDNotNegated(AIHand(),12408276,true)) -- Dark Lady
  and MP2Check()
  then
    OPTSet(c.id)
    return true
  end
  if HandCheck(5,FilterRace,RACE_MACHINE)>0
  and FieldCheck(5,FilterRace,RACE_MACHINE) == 1
  and MP2Check()
  then
    OPTSet(c.id)
    return true
  end
  if FieldCheck(3)>1
  and HasIDNotNegated(AIExtra(),95992081,true) -- Leviair
  and (c.level<4 or CardsMatchingFilter(AIBanish(),KozmoRider,12408276)>0)
  and CanSpecialSummon()
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
    if HasID(AIHand(),55885348,true) -- Dark Destroyer
    and HasIDNotNegated(AIDeck(),56907986,true) -- Strawman
    and AI.GetPlayerLP(1)>1000
    then
      OPTSet(c.id)
      return true
    end
    if HasID(AIHand(),94454495,true) -- Sliprider
    and FieldCheck(5) == 1
    then
      OPTSet(c.id)
      return true
    end
  end
end
function UseStrawman(c,mode)
  if mode == 1 
  and c.description==c.id*16+1
  and AI.GetPlayerLP(1)>1000
  and CardsMatchingFilter(AIBanish(),KozmoShip)>0
  then
    GlobalSummonNegated=true
    return true
  end
  if mode == 2 
  and c.description==c.id*16
  and UseRiderSummon(c)
  then
    return true
  end
  if mode == 3
  then
    if c.description==c.id*16+1
    and KozmoComboCheck(4,5)
    and HasID(AIBanish(),01274455,true) -- Soartrooper
    then
      return true
    end
    if c.description==c.id*16
    and KozmoComboCheck(1,2)
    then
      return true
    end
   if c.description==c.id*16
    and KozmoComboCheck(3,4)
    and HasID(AIHand(),55885348,true) -- Dark Destroyer
    then
      return true
    end
    if c.description==c.id*16
    and KozmoComboCheck(5)
    and HasID(AIMon(),01274455,true) -- Soartrooper
    and HasID(AIHand(),55885348,true) -- Dark Destroyer
    then
      return true
    end
  end
  if mode == 4
  and c.description==c.id*16+1
  and HasIDNotNegated(AIExtra(),73580471,true,UseFieldNuke,-1) -- Black Rose
  and HasID(AIMon(),09929398,true) -- Gofu
  and CardsMatchingFilter(AIBanish(),KozmoShip)>0
  and AI.GetPlayerLP(1)>1000
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
    if c.description==c.id*16+1
    and AI.GetPlayerLP(1)>4000
    and CardsMatchingFilter(AIGrave(),KozmoRider)>0
    then
      return true
    end
    if c.description==c.id*16+1
    and AI.GetPlayerLP(1)>2000
    and HasIDNotNegated(AIGrave(),12408276,true) -- Dark Lady
    then
      return true
    end
  end
  if mode == 2 
  and c.description==c.id*16
  and UseRiderSummon(c)
  then
    return true
  end
  if mode == 3
  then
    if c.description==c.id*16+1
    and NeedsCard(56907986,AIGrave(),AIMon(),true) -- Strawman
    and KozmoComboCheck(1,2,5,6)
    then
      return true
    end
    if c.description==c.id*16+1
    and KozmoComboCheck(3)
    and CardsMatchingFilter(AIMon(),FilterID,c.id)<2
    then
      OPTSet(c)
      return true
    end
    if c.description==c.id*16+1
    and KozmoComboCheck(4)
    and (CardsMatchingFilter(AIMon(),FilterID,c.id)<2
    or HasID(AIMon(),37679169,true) -- Delta Shuttle
    and NeedsCard(56907986,AIGrave(),AIMon(),true))
    then
      OPTSet(c)
      return true
    end
    if c.description==c.id*16+1
    and NeedsCard(12408276,AIGrave(),AIMon(),true) -- Dark Lady
    and KozmoComboCheck(6)
    then
      return true
    end
    if c.description==c.id*16
    and KozmoComboCheck(3,4)
    and CardsMatchingFilter(AIMon(),FilterID,c.id)==2
    and HasID(AIHand(),37679169,true) -- Delta Shuttle
    and not OPTCheck(c)
    then
      return true
    end
    if c.description==c.id*16
    and KozmoComboCheck(5)
    and HasID(AIMon(),56907986,true) -- Strawman
    then
      return true
    end
  end
end
function FireKingIslandCheck()
  return HasIDNotNegated(AICards(),57554544,true,FilterOPT,true)
  and CardsMatchingFilter(AIDeck(),FireKingMonsterFilter)>0
  and CanSpecialSummon()
  and OPTCheck(57554544) -- Fire King Island
end
function UseFireKingIsland(c,mode)
  if mode == 1
  and FilterLocation(c,LOCATION_SZONE)
  and FilterPosition(c,POS_FACEUP)
  and c.description==c.id*16
  and CardsMatchingFilter(AIHand(),KozmoShip)>0
  and CanSpecialSummon()
  then
    OPTSet(c.id)
    return true
  end
  if mode == 2
  and (FilterPosition(c,POS_FACEDOWN)
  or FilterLocation(c,LOCATION_HAND)
  and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD)==0
  or KozmoComboCheck(1,2,3,4,5,6)
  and HasID(AIHand(),67237709,true))
  and CardsMatchingFilter(AIHand(),KozmoShip)>0
  and CanSpecialSummon()
  and OPTCheck(c.id)
  then
    return true
  end
end
function SummonGofu(c,mode)
  if mode == 1
  and (NormalSummonsAvailable()>0
  and HandCheck(2)>0 
  or HasIDNotNegated(AICards(),67723438,true)) -- Etele
  and HasID(AICards(),67237709,true) -- Kozmotown
  and HasIDNotNegated(AIExtra(),25862681,true) -- AFD
  and CardsMatchingFilter(AIDeck(),FilterType,TYPE_FIELD)>0
  and CardsMatchingFilter(AIHand(),KozmoShip)==0
  and CanSpecialSummon()
  then
    return true
  end
  if mode == 2
  and (NormalSummonsAvailable()>0
  and HandCheck(2)>0 
  or HasIDNotNegated(AICards(),67723438,true)) -- Etele
  and HasIDNotNegated(AIExtra(),73580471,true,UseFieldNuke,-3) -- Black Rose
  and CanSpecialSummon()
  then
    return true
  end
  if mode == 3
  and (NormalSummonsAvailable()>0
  and HandCheck(3)>0 
  or HasIDNotNegated(AICards(),67723438,true)) -- Etele
  and HasIDNotNegated(AIExtra(),76774528,true,SummonScrapKozmo,0) -- Scrap Dragon
  and CardsMatchingFilter(AIHand(),KozmoShip)==0
  and CanSpecialSummon()
  then
    GlobalGofuTokens = true
    return true
  end
  if mode == 4
  and TurnEndCheck()
  and CanSpecialSummon()
  then
    GlobalGofuTokens = true
    return true
  end
end
function SummonAFD(c,mode)
  if mode == 1
  and HasID(AICards(),67237709,true) -- Kozmotown
  and CanSpecialSummon()
  then
    return true
  end
end
function UseAFD(c,mode)
  if mode == 1
  and c.description==c.id*16
  and HasID(AIST(),67237709,true) -- Kozmotown
  then
    return true
  end
  if mode == 2
  and c.description==c.id*16+1
  and CanSpecialSummon()
  and not BattlePhaseCheck()
  then
    return true
  end
end
function UseAllureKozmo(c,mode)
  if mode == 1
  and (HasIDNotNegated(AIST(),67237709,true,OPTCheck) -- Kozmotown
  or HasIDNotNegated(AIMon(),56907986,true)) -- Strawman
  and UseAllure(c)
  and not KozmoComboCheck(1,2,3,4,5,6)
  then
    return true
  end
  if mode == 2
  and UseAllure(c)
  then
    return true
  end
end
function UseDeltaShuttle(c,mode)
  if mode == 1
  and KozmoComboCheck(1,2,3,4,6)
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIMon(),01274455,true) -- Soartrooper
  then
    return true
  end
end
function SummonGarunix(c,mode)
  if mode == 1
  and FieldCheck(3)==1
  and CanXYZSummon(3)
  then
    return true
  end
  if mode == 2
  and KozmoComboCheck(1,3,4,5)
  then
    return true
  end
  if mode == 3
  and HasID(AIMon(),09929398,true)
  and HasIDNotNegated(AIExtra(),SummonScrapKozmo(0),true)
  then
    return true
  end
end
function SummonLeviairKozmo(c,mode)
  if mode == 1
  then
    if KozmoComboCheck(1,2,5)
    then
      return true
    end
    if KozmoComboCheck(4)
    and HasID(AIBanish(),56907986,true) -- Strawman
    then
      return true
    end
    if KozmoComboCheck(6)
    and HasID(AIMon(),12408276,true) -- Dark Lady
    then
      return true
    end
  end
  if mode == 2
  and HasIDNotNegated(AIBanish(),56907986,true) -- Strawman
  and CardsMatchingFilter(AIBanish(),KozmoShip)>0
  then 
    return true
  end
end
function UseLeviairKozmo(c,mode)
  if mode == 1
  and KozmoComboCheck(1,2,4,5,6) 
  then
    return true
  end
  if mode == 2
  then
    return true
  end
end
function SummonPureHeraldKozmo(c,mode)
  if mode == 1
  and KozmoComboCheck(2)
  then
    return true
  end
end
function UsePureHeraldKozmo(c,mode)
  if mode == 1
  and KozmoComboCheck(2)
  then
    return true
  end
end

function SummonBreakSwordKozmo(c,mode)
  local targets = CardsMatchingFilter(OppField(),PKBreakSwordFilter)
  local prio = CardsMatchingFilter(OppField(),PKBreakSwordFilter,true)
  local fodder = CardsMatchingFilter(AIField(),KozmoDestroyFilter)
  if mode == 1
  and targets>0
  then
    if KozmoComboCheck(3)
    then
      return true
    end
    if KozmoComboCheck(4)
    and HasID(AIMon(),56907986,true) -- Strawman
    then
      return true
    end
  end
  if mode == 2
  and prio>0
  and OppHasStrongestMonster()
  then
    return true
  end
  if mode == 3
  and targets>0
  and fodder>0
  then
    return true
  end
end
function UseBreakSwordKozmo(c,mode)
  local targets = CardsMatchingFilter(OppField(),PKBreakSwordFilter)
  local prio = CardsMatchingFilter(OppField(),PKBreakSwordFilter,true)
  local fodder = CardsMatchingFilter(AIField(),KozmoDestroyFilter)
  if mode == 1
  and targets>0
  and KozmoComboCheck(3,4)
  and HasID(AIST(),67237709,true) -- Kozmotown
  then
    return true
  end
  if mode == 2
  and prio>0
  and OppHasStrongestMonster()
  then
    return true
  end
  if mode == 3
  and targets>0
  and fodder>0
  then
    return MP2Check(c)
    or CardsMatchingFilter(OppST(),FilterBackrow)==0  
  end
end
function SummonGranpulseKozmo(c,mode)
  if mode == 1
  then
    if KozmoComboCheck(3)
    then
      return true
    end
    if KozmoComboCheck(4)
    and HasID(AIMon(),56907986,true) -- Strawman
    then
      return true
    end
  end
  if mode == 2
  and CardsMatchingFilter(OppST(),GranpulseFilter)>0
  and MP2Check(c)
  then
    return true
  end
end

function UseGranpulseKozmo(c,mode)
  if mode == 1
  and KozmoComboCheck(3,4)
  and HasID(AIST(),67237709,true) -- Kozmotown
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(OppST(),GranpulseFilter)>0
  then
    return true
  end
end
function SummonNovaKozmo(c,mode)
  if mode == 1
  and KozmoComboCheck(1,2,3,4,5,6)
  then
    return true
  end
end
function UseGoldSarcKozmo(c,mode)
  if mode == 1 
  and not KozmoComboCheck(1,2,3,4,5,6)
  then
    return true
  end
  if mode == 2 
  then
    return true
  end
end
function NormalSummonKozmo(c,mode)
  if mode == 1
  and OppHasStrongestMonster()
  and c.attack>=OppGetStrongestAttDef()
  and BattlePhaseCheck()
  then
    return true
  end
  if mode == 2
  and HasID(AIMon(),09929398,true)-- Gofu
  and c.level>4
  and CardsMatchingFilter(AIMon(),KozmoMonsterFilter)==0
  then
    return true
  end
  if mode == 3
  and c.level == 3
  and HasID(AIMon(),09929398,true) -- Gofu
  and HasIDNotNegated(AIExtra(),SummonScrapKozmo(0),true)
  then
    return true
  end
  if mode == 4
  and c.level == 2
  and HasID(AIMon(),09929398,true) -- Gofu
  and HasIDNotNegated(AIExtra(),73580471,true,UseFieldNuke,-2) -- Black Rose
  then
    return true
  end
end
function SummonYaksha(c,mode)
  if mode == 1
  and #AIMon()==0
  and CardsMatchingFilter(AIHand(),KozmoShip)>0
  and (CanWinBattle(c,OppMon()
  or CardsMatchingFilter(OppMon(),YakshaCrashCheck)>0))
  and BattlePhaseCheck()
  then
    return true
  end
  if mode == 2 -- TODO: Break Sword/Scrap Dragon fodder
  then
  end
end
function SetYaksha(c,mode)
  if mode == 1
  and #AIMon()==0
  and TurnEndCheck()
  then
    return true
  end
end
function UseScrapKozmo(c,mode)
  local targets = CardsMatchingFilter(OppField(),PKBreakSwordFilter)
  local prio = CardsMatchingFilter(OppField(),PKBreakSwordFilter,true)
  local fodder = CardsMatchingFilter(AIField(),KozmoDestroyFilter)
  if mode == 1
  and prio>0
  and OppHasStrongestMonster()
  then
    return true
  end
  if mode == 2
  and targets>0
  and fodder>0
  then
    return MP2Check(c)
    or CardsMatchingFilter(OppST(),FilterBackrow)==0
  end
end
function SummonScrapKozmo(c,mode)
  local targets = CardsMatchingFilter(OppField(),PKBreakSwordFilter)
  local prio = CardsMatchingFilter(OppField(),PKBreakSwordFilter,true)
  local fodder = CardsMatchingFilter(AIField(),KozmoDestroyFilter)
  if not CanSpecialSummon() then return false end
  if (mode == 0 or mode == 1)
  and prio>0
  and OppHasStrongestMonster()
  then
    return true
  end
  if (mode == 0 or mode == 2)
  and targets>0
  --and fodder>0
  then
    return true
  end
end
function KozmoComboIntegrityCheck()
  -- cancel a combo, if the player interrupts it
  if GlobalKozmoCombo[Duel.GetTurnCount()] then
    local cards = NegateCheckList(AIField(),nil,nil,function(c) return c:IsControler(1-player_ai) end)
    if cards then
      GlobalKozmoCombo[Duel.GetTurnCount()]=nil
    end
    cards = RemovalCheckList(AIField(),nil,nil,nil,nil,function(c) return c:IsControler(1-player_ai) end)
    if cards then
      GlobalKozmoCombo[Duel.GetTurnCount()]=nil
    end
  end
end
GlobalKozmoCombo={}
function KozmoComboCheck(...)
 local args={select("1", ...)}
 if not CanSpecialSummon()
 or not MacroCheck()
 then
   GlobalKozmoCombo={}
   return false
 end
 for i,combo in pairs(args) do
  if GlobalKozmoCombo[Duel.GetTurnCount()] 
  and combo == GlobalKozmoCombo[Duel.GetTurnCount()]
  then
    return true
  end
 end
 local ships = SubGroup(AIHand(),KozmoShip,64063868) -- Dark Eclipser
 for i,combo in pairs(args) do
  if combo == 1 -- Island + Slip + Ship
  and HasIDNotNegated(ships,94454495,true) -- Sliprider
  and CardsMatchingFilter(ships,FilterLevelMin,6)>0
  and FireKingIslandCheck()
  and NormalSummonsAvailable()>0
  and SpaceCheck()>4
  and HasIDNotNegated(AIExtra(),95992081,true) -- Leviair
  and HasIDNotNegated(AIExtra(),58069384,true) -- Nova
  and HasIDNotNegated(AIExtra(),10443957,true) -- Infinity
  and CardsMatchingFilter(AIDeck(),FilterID,01274455)>0 -- Soartrooper
  and CardsMatchingFilter(AIDeck(),FilterID,56907986)>1 -- Strawman
  and CardsMatchingFilter(AIDeck(),FilterID,37679169)>0 -- Delta Shuttle
  and AI.GetPlayerLP(1)>3000
  then
    print("Kozmo Combo 1 detected")
    GlobalKozmoCombo[Duel.GetTurnCount()]=combo
    return true
  end
  if combo == 2 -- Island + Slip + Delta
  and HasIDNotNegated(ships,94454495,true) -- Sliprider
  and HasIDNotNegated(ships,37679169,true) -- Delta Shuttle
  and FireKingIslandCheck()
  and NormalSummonsAvailable()>0
  and SpaceCheck()>4
  and HasIDNotNegated(AIExtra(),95992081,true) -- Leviair
  and HasIDNotNegated(AIExtra(),58069384,true) -- Nova
  and HasIDNotNegated(AIExtra(),10443957,true) -- Infinity
  and HasIDNotNegated(AIExtra(),01249315,true) -- Pure Herald
  and CardsMatchingFilter(AIDeck(),FilterID,01274455)>1 -- Soartrooper
  and CardsMatchingFilter(AIDeck(),FilterID,56907986)>1 -- Strawman
  and CardsMatchingFilter(AIDeck(),FilterID,12408276)>0 -- Dark Lady
  and AI.GetPlayerLP(1)>3000
  then
    print("Kozmo Combo 2 detected")
    GlobalKozmoCombo[Duel.GetTurnCount()]=combo
    return true
  end
  if combo == 3 -- Island + Ship + Town
  and CardsMatchingFilter(ships,FilterLevelMin,6)>0
  and HasIDNotNegated(AIHand(),67237709,true) -- Kozmotown
  and FireKingIslandCheck()
  and NormalSummonsAvailable()>0
  and SpaceCheck()>4
  and HasIDNotNegated(AIExtra(),85252081,true) -- Granpulse
  and HasIDNotNegated(AIExtra(),58069384,true) -- Nova
  and HasIDNotNegated(AIExtra(),10443957,true) -- Infinity
  and CardsMatchingFilter(AIDeck(),FilterID,01274455)>1 -- Soartrooper
  and CardsMatchingFilter(AIDeck(),FilterID,56907986)>1 -- Strawman
  and CardsMatchingFilter(AIDeck(),FilterID,12408276)>0 -- Dark Lady
  and CardsMatchingFilter(AIDeck(),FilterID,37679169)>0 -- Delta Shuttle
  and AI.GetPlayerLP(1)>4000
  then
    print("Kozmo Combo 3 detected")
    GlobalKozmoCombo[Duel.GetTurnCount()]=combo
    return true
  end
  if combo == 4 -- Island + Delta + Town
  and HasIDNotNegated(ships,37679169,true) -- Delta Shuttle
  and HasIDNotNegated(AIHand(),67237709,true) -- Kozmotown
  and FireKingIslandCheck()
  and NormalSummonsAvailable()>0
  and SpaceCheck()>4
  and HasIDNotNegated(AIExtra(),95992081,true) -- Leviair
  and HasIDNotNegated(AIExtra(),58069384,true) -- Nova
  and HasIDNotNegated(AIExtra(),10443957,true) -- Infinity
  and CardsMatchingFilter(AIDeck(),FilterID,01274455)>2 -- Soartrooper
  and CardsMatchingFilter(AIDeck(),FilterID,56907986)>0 -- Strawman
  and CardsMatchingFilter(AIDeck(),FilterID,12408276)>0 -- Dark Lady
  and AI.GetPlayerLP(1)>6000
  then
    print("Kozmo Combo 4 detected")
    GlobalKozmoCombo[Duel.GetTurnCount()]=combo
    return true
  end
  if combo == 5 -- Island + Slip + Town
  and HasIDNotNegated(ships,94454495,true) -- Sliprider
  and HasIDNotNegated(AIHand(),67237709,true) -- Kozmotown
  and FireKingIslandCheck()
  and NormalSummonsAvailable()>0
  and SpaceCheck()>4
  and HasIDNotNegated(AIExtra(),95992081,true) -- Leviair
  and HasIDNotNegated(AIExtra(),58069384,true) -- Nova
  and HasIDNotNegated(AIExtra(),10443957,true) -- Infinity
  and CardsMatchingFilter(AIDeck(),FilterID,01274455)>0 -- Soartrooper
  and CardsMatchingFilter(AIDeck(),FilterID,56907986)>0 -- Strawman
  and CardsMatchingFilter(AIDeck(),FilterID,12408276)>0 -- Dark Lady
  and CardsMatchingFilter(AIDeck(),FilterLevel,5)>0
  and AI.GetPlayerLP(1)>4000
  then
    print("Kozmo Combo 5 detected")
    GlobalKozmoCombo[Duel.GetTurnCount()]=combo
    return true
  end
  if combo == 6 -- Island + DD + Town
  and HasIDNotNegated(ships,55885348,true) -- Dark Destroyer
  and HasIDNotNegated(AIHand(),67237709,true) -- Kozmotown
  and FireKingIslandCheck()
  and NormalSummonsAvailable()>0
  and SpaceCheck()>4
  and HasIDNotNegated(AIExtra(),95992081,true) -- Leviair
  and HasIDNotNegated(AIExtra(),58069384,true) -- Nova
  and HasIDNotNegated(AIExtra(),10443957,true) -- Infinity
  and CardsMatchingFilter(AIDeck(),FilterID,01274455)>1 -- Soartrooper
  and CardsMatchingFilter(AIDeck(),FilterID,56907986)>0 -- Strawman
  and CardsMatchingFilter(AIDeck(),FilterID,12408276)>0 -- Dark Lady
  and CardsMatchingFilter(AIDeck(),FilterID,67237709)>0 -- Kozmotown
  and CardsMatchingFilter(AIDeck(),FilterID,90452877)>0 -- Kozmojo
  and HasIDNotNegated(AIDeck(),94454495,true) -- Sliprider
  and HasIDNotNegated(AIDeck(),37679169,true) -- Delta Shuttle
  and AI.GetPlayerLP(1)>6000
  then
    print("Kozmo Combo 6 detected")
    GlobalKozmoCombo[Duel.GetTurnCount()]=combo
    return true
  end
 end
end
--[[function UseFieldNuke(source,exclude)
  local targets = SubGroup(OppField(),FieldNukeFilter,source)
  return DestroyCheck(targets,true)-DestroyCheck(AIField(),true)>0 
end]]
function KozmoInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if not GlobalKozmoCombo[Duel.GetTurnCount()] then
    KozmoComboCheck(6,1,2,3,4,5)
  end
  if HasIDNotNegated(Act,62709239,UseBreakSwordKozmo,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,76774528,UseScrapKozmo,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,76774528,UseScrapKozmo,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,62709239,UseBreakSwordKozmo,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,62709239,UseBreakSwordKozmo,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,85252081,UseGranpulseKozmo,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,85252081,UseGranpulseKozmo,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,56907986,UseStrawman,4) then
    return Activate()
  end
  if HasID(SpSum,73580471,UseFieldNuke,-1) then -- Black Rose
    return SynchroSummon()
  end
  if HasID(SpSum,10443957,SummonInfinity,1) then
    return XYZSummon()
  end
  if HasID(SpSum,58069384,SummonNovaKozmo,1) then
    return XYZSummon()
  end
  if HasID(Act,73628505) then -- Terraforming
    return Activate()
  end
  if HasID(Act,75500286,UseGoldSarcKozmo,1) then
    return Activate()
  end
  if HasID(Act,01475311,UseAllureKozmo,1) then -- Allure
    return Activate()
  end
  if HasIDNotNegated(Act,57554544,UseFireKingIsland,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,57554544,UseFireKingIsland,2) then
    return Activate()
  end
  if HasID(Act,37679169,UseDeltaShuttle,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,ActivateKozmotown,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,UseKozmotown,3) then
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
  if HasIDNotNegated(Act,56907986,UseStrawman,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,56907986,UseStrawman,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,01274455,UseSoartrooper,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,95992081,UseLeviairKozmo,1) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,95992081,SummonLeviairKozmo,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,01249315,UsePureHeraldKozmo,1) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,01249315,SummonPureHeraldKozmo,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SummonBreakSwordKozmo,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,85252081,SummonGranpulseKozmo,1) then
    return XYZSummon()
  end
  if HasID(Sum,54149433,SummonGarunix,2) then
    return Summon()
  end
  if HasIDNotNegated(Act,67237709,ActivateKozmotown,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,ActivateKozmotown,2) then
    return Activate()
  end
  if HasID(Act,37679169,UseDeltaShuttle,2) then
    return Activate()
  end
  if HasID(SpSum,09929398,SummonGofu,1) then
    return SpSummon()
  end
  if HasID(Sum,56907986,SummonStrawman,3) then
    return Summon()
  end
  if HasIDNotNegated(Act,25862681,UseAFD,1) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,25862681,SummonAFD,1) then
    return SynchroSummon()
  end
  if HasIDNotNegated(Act,95992081,UseLeviairKozmo,2) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,95992081,SummonLeviairKozmo,2) then
    return XYZSummon()
  end
  if HasID(SpSum,09929398,SummonGofu,2) then
    return SpSummon()
  end
  if HasID(SpSum,09929398,SummonGofu,3) then
    return SpSummon()
  end
  if HasID(Act,01475311,UseAllureKozmo,2) then -- Allure
    return Activate()
  end
  if HasID(Sum,31061682,SummonFarmgirl,1) then
    return Summon()
  end
  if HasID(Sum,56907986,SummonStrawman,1) then
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
  if HasID(Sum,64280356,SummonTincan,1) then
    return Summon()
  end
  if HasID(Sum,64280356,SummonTincan,2) then
    return Summon()
  end

  if HasIDNotNegated(Act,01274455,UseSoartrooper,1) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,76774528,SummonScrapKozmo,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SummonBreakSwordKozmo,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,85252081,SummonGranpulseKozmo,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,76774528,SummonScrapKozmo,2) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,62709239,SummonBreakSwordKozmo,3) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,67050396,false,67050396*16+1,UseGoodwitch,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,93302695,false,93302695*16+1,UseWickedwitch,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,56907986,UseStrawman,2) then
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
  if HasIDNotNegated(Act,01274455,UseSoartrooper,2) then
    OPTSet(01274455)
    return Activate()
  end
  if HasID(Act,31061682,false,UseFarmgirl,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,67723438,UseEtele,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,67723438,UseEtele,2) then
    return Activate()
  end
  if HasID(Act,75500286,UseGoldSarcKozmo,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,67237709,false,67237709*16+1,LOCATION_SZONE,UseKozmotown,2) then
    return Activate()
  end
  if HasID(Sum,54149433,SummonGarunix,1) then
    return Summon()
  end
  if HasID(Sum,66413481,SummonYaksha,1) then
    return Summon()
  end
  for mode=1,2 do
    for i,c in pairs(Sum) do
      if NormalSummonKozmo(c,mode)
      then
        return Summon(i)
      end
    end
  end
  if HasID(SpSum,09929398,SummonGofu,4) then
    return SpSummon()
  end
  if HasID(SetMon,66413481,SetYaksha,1) then
    return Set()
  end
  return nil
end
function DestroyerTarget(cards,c)
  if LocCheck(cards,LOCATION_DECK) then
    if KozmoComboCheck(3) 
    and not HasID(AIST(),57554544,true) -- Fire King Island
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,94454495) -- Sliprider
    end
    if KozmoComboCheck(5)  
    and not HasID(AIST(),57554544,true) -- Fire King Island
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,37679169) -- Delta Shuttle
    end
    if KozmoComboCheck(6) then
      if HasID(AIST(),57554544,true) -- Fire King Island
      then
        return Add(cards,PRIO_TOFIELD,1,FilterID,37679169) -- Delta Shuttle
      end
      if HasID(AIMon(),12408276,true) -- Dark Lady
      then
        return Add(cards,PRIO_TOFIELD,1,FilterID,94454495) -- Sliprider
      end
      return Add(cards,PRIO_TOFIELD,1,FilterID,01274455) -- Soartrooper
    end
    return Add(cards,PRIO_TOFIELD)
  end
  if KozmoComboCheck(3,6) then
    return BestTargets(cards,1,TARGET_PROTECT,FilterID,c.id)
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
    if KozmoComboCheck(5) then
      if HasID(AIST(),57554544,true) then -- Fire King Island
        return Add(cards,PRIO_TOFIELD,1,FilterID,56907986) -- Strawman
      end
      return Add(cards,PRIO_TOFIELD,1,FilterID,01274455) -- Soartrooper
    end
    return Add(cards,PRIO_TOFIELD)
  end
  if KozmoComboCheck(1) then
    return BestTargets(cards,1,TARGET_DESTROY,FilterID,57554544) -- Fire King Island
  end
  if KozmoComboCheck(5,6) then
    return BestTargets(cards,1,TARGET_DESTROY,FilterID,67237709) -- Kozmotown
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
    if KozmoComboCheck(1,2) 
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,94454495) -- Sliprider
    end
    if KozmoComboCheck(3,4,6) 
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,55885348) -- Dark Destroyer
    end
    return Add(cards,PRIO_TOFIELD)
  end
  if KozmoComboCheck(5) 
  and HasID(AIST(),57554544,true) -- Fire King Island
  then
    return Add(cards,PRIO_TOFIELD,1,FilterID,94454495) -- Sliprider
  end
  if KozmoComboCheck(4) then
    return Add(cards,PRIO_TOFIELD,1,FilterID,01274455) -- Soartrooper
  end
  if KozmoComboCheck(2) then
    if FieldCheck(5)==0 then
      return Add(cards,PRIO_TOFIELD,1,FilterID,37679169) -- Delta Shuttle
    end
    return Add(cards,PRIO_TOFIELD,1,FilterID,94454495) -- Sliprider
  end
  return Add(cards,PRIO_TOFIELD,1,KozmoShip)
end
function KozmotownTarget(cards,c,min,max)
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
    if KozmoComboCheck(3,4,5) then
      return Add(cards,PRIO_TOHAND,1,FilterID,55885348) -- Dark Destroyer
    end
    if KozmoComboCheck(6)
    then
      if HasID(AIHand(),55885348,true) then
        return Add(cards,PRIO_TOHAND,1,FilterID,90452877) -- Kozmojo
      end
      return Add(cards,PRIO_TOHAND,1,FilterID,c.id)
    end
    return Add(cards)
  end
  if KozmoComboCheck(3,4) then
    return Add(cards,PRIO_TOHAND,1,FilterID,37679169) -- Delta Shuttle
  end
  if KozmoComboCheck(5) then
    return Add(cards,PRIO_TOHAND,1,FilterID,94454495) -- SlipRider
  end
  if KozmoComboCheck(6) then
    return Add(cards,PRIO_TOHAND,1,FilterID,55885348) -- Dark Destroyer
  end
  return Add(cards)
end
GlobalEteleSummons={}
function Eteletarget(cards)
  local result = Add(cards,PRIO_TOFIELD)
  if GlobalEteleLevel then
    result = Add(cards,PRIO_TOFIELD,1,FilterLevel,GlobalEteleLevel)
    GlobalEteleLevel = nil
  end
  local c = cards[1]
  cards[1].summonturn=Duel.GetTurnCount()
  GlobalEteleSummons[#GlobalEteleSummons+1]=c
  return result
end
function TincanFilter(c)
  return KozmoShip(c)
  or FilterID(c,12408276) -- Dark Lady
end
function TincanTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,nil,nil,TincanFilter)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
end
function SoartrooperTarget(cards,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    if KozmoComboCheck(1,2,6)  
    and SpaceCheck()>1
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,56907986) --Strawman
    end
    if KozmoComboCheck(3)
    then
      if HasID(AIMon(),37679169,true) then -- Delta Shuttle
        return Add(cards,PRIO_TOFIELD,1,FilterID,56907986) -- Strawman
      else
        return Add(cards,PRIO_TOFIELD,1,FilterID,c.id) -- Soartrooper
      end
    end
    if KozmoComboCheck(4)
    then
      if CardsMatchingFilter(AIMon(),FilterID,c.id)<2 then
        return Add(cards,PRIO_TOFIELD,1,FilterID,c.id) -- Soartrooper
      end
      return Add(cards,PRIO_TOFIELD,1,FilterID,56907986) -- Strawman
    end
    --[[if SpaceCheck()>1
    and CardsMatchingFilter(AIGrave(),KozmoRider,c.id)>0
    and HasID(cards,c.id,true)
    and AI.GetPlayerLP(1)>3000
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,c.id)
    end]]
    return Add(cards,PRIO_TOFIELD)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
end
function DarkEclipserTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  return Add(cards)
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
function FireKingIslandTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    if KozmoComboCheck(1,2,3,4,5,6)    
    then
      return Add(cards,nil,nil,FilterLevel,3)
    end
    return Add(cards)
  end
  if KozmoComboCheck(1,3) then
    return Add(cards,PRIO_BANISH,1,function(c) 
      return ExcludeID(c,94454495) -- Sliprider
      and FilterLocation(c,LOCATION_HAND)
      and FilterLevelMin(c,6)
      and KozmoShip(c,64063868) -- Eclipser
    end)
  end
  if KozmoComboCheck(2,4) then
    return Add(cards,PRIO_BANISH,1,FilterID,37679169) -- Delta Shuttle
  end
  if KozmoComboCheck(5) then
    return Add(cards,PRIO_BANISH,1,FilterID,94454495) -- Sliprider
  end
  if KozmoComboCheck(6) then
    return Add(cards,PRIO_BANISH,1,FilterID,55885348) -- Dark Destroyer
  end
  if CardsMatchingFilter(AIHand(),KozmoShip)>0 then
    return Add(cards,PRIO_BANISH,1,function(c)
      return FilterLocation(c,LOCATION_HAND)
      and KozmoShip(c)
    end)
  end
  return Add(cards,PRIO_BANISH)
end
function AFDTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  return Add(cards,PRIO_TOFIELD)
end
function GoldSarcTarget(cards)
  local access = Merge(AICards(),AIBanish())
  if HasIDNotNegated(AICards(),67237709,true) -- Kozmotown
  and HasIDNotNegated(AICards(),01475311,true) -- Allure
  and CardsMatchingFilter(AIHand(),FilterAttribute,ATTRIBUTE_DARK)==0
  then
    return Add(cards,PRIO_TOHAND,1,FilterAttribute,ATTRIBUTE_DARK)
  end
  if HasIDNotNegated(AICards(),67237709,true) -- Kozmotown
  then
    if CardsMatchingFilter(access,KozmoShip)==0 then
      return Add(cards,PRIO_TOHAND,1,KozmoShip)
    end
    if CardsMatchingFilter(access,KozmoRider)==0 then
      return Add(cards,PRIO_TOHAND,1,KozmoRider,12408276) -- Dark Lady
    end
    return Add(cards,PRIO_TOHAND,1,KozmoMonsterFilter)
  end
  if CardsMatchingFilter(access,KozmoShip)==0 then
    return Add(cards,PRIO_BANISH,1,KozmoShip)
  end
  if CardsMatchingFilter(access,KozmoRider)==0 then
    return Add(cards,PRIO_BANISH,1,KozmoRider,12408276) -- Dark Lady
  end
  return Add(cards,PRIO_BANISH)
end
function AllureTarget(cards)
  if FireKingIslandCheck()
  and CardsMatchingFilter(AIHand(),KozmoShip)<2
  then
    return Add(cards,PRIO_BANISH,1,FilterInvert,KozmoMonsterFilter)
  end
  return Add(cards,PRIO_BANISH)
end
function DeltaShuttleTarget(cards,c)
  if LocCheck(cards,LOCATION_DECK) then
    if FilterLocation(c,LOCATION_MZONE)
    then
      if KozmoComboCheck(1) then
        return Add(cards,PRIO_TOGRAVE,1,FilterID,56907986) -- Strawman
      end
      if KozmoComboCheck(2) then
        if CardsMatchingFilter(AIMon(),FilterID,01274455)>1 -- Soartrooper
        then
          return Add(cards,PRIO_TOGRAVE,1,FilterID,12408276) -- Dark Lady
        end
        return Add(cards,PRIO_TOGRAVE,1,FilterID,56907986) -- Strawman
      end
      if KozmoComboCheck(3) then
        if HasID(AIST(),57554544,true) then -- Fire King Island
          return Add(cards,PRIO_TOGRAVE,1,FilterID,01274455) -- Soartrooper
        end
        return Add(cards,PRIO_TOGRAVE,1,FilterID,56907986) -- Strawman
      end
      if KozmoComboCheck(4) then
        return Add(cards,PRIO_TOGRAVE,1,FilterID,01274455) -- Soartrooper
      end
      if KozmoComboCheck(6) then
        if HasID(AIST(),57554544,true) then -- Fire King Island
          return Add(cards,PRIO_TOGRAVE,1,FilterID,56907986) -- Strawman
        end
        return Add(cards,PRIO_TOGRAVE,1,FilterID,12408276) -- Dark Lady
      end
      return Add(cards,PRIO_TOGRAVE)
    else
      if KozmoComboCheck(3,6) then
        return Add(cards,PRIO_TOGRAVE,1,FilterID,01274455) -- Soartrooper
      end
      if KozmoComboCheck(4) then
        if HasID(AIST(),57554544,true) then -- Fire King Island
          return Add(cards,PRIO_TOGRAVE,1,FilterID,56907986) -- Strawman
        end
        return Add(cards,PRIO_TOGRAVE,1,FilterID,01274455) -- Soartrooper
      end
      return Add(cards,PRIO_TOFIELD)
    end
  end
  return BestTargets(cards,1,TARGET_OTHER)
end
function LeviairTargetKozmo(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if KozmoComboCheck(1,4,5,6) then
    return Add(cards,PRIO_TOFIELD,1,FilterID,56907986) -- Strawman
  end
  return Add(cards,PRIO_TOFIELD)
end
function LandwalkerTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function PureHeraldTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    if KozmoComboCheck(2) then
      return Add(cards,PRIO_TOHAND,1,FilterID,01274455) -- Soartrooper
    end
    return Add(cards)
  end
  if LocCheck(cards,LOCATION_HAND) then
    if KozmoComboCheck(2) then
      return Add(cards,PRIO_TOHAND,1,FilterID,54149433) -- Garunix
    end
    return Add(cards,PRIO_TODECK)
  end
end
function GranpulseTargetKozmo(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if KozmoComboCheck(3) then
    return BestTargets(cards,1,TARGET_DESTROY,function(c) 
      return FilterID(c,67237709) -- Kozmotown
      and FilterController(c,1)
    end) 
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function KozmoDestroyFilter(c) -- cards to prefer destroying on your side of the field
  return (KozmoShip(c)
  or FilterID(c,67237709)) -- Kozmotown
  and MacroCheck()
  or FilterType(c,TYPE_TOKEN)
end
function BreakSwordTargetKozmo(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if FilterController(cards[1],1) 
  then
    if KozmoComboCheck(3) then
      return BestTargets(cards,1,TARGET_DESTROY,FilterID,67237709) -- Kozmotown
    end
    if CardsMatchingFilter(cards,FilterType,TYPE_TOKEN)>0 then
      return BestTargets(cards,1,TARGET_PROTECT,FilterType,TYPE_TOKEN)
    end
    return BestTargets(cards,1,TARGET_PROTECT,KozmoDestroyFilter)
  end
  if OppHasStrongestMonster() then
    return BestTargets(cards,1,TARGET_DESTROY,PKBreakSwordFilter)
  end
  return BestTargets(cards,1,TARGET_DESTROY,FilterBackrow)
end
function ScrapTargetKozmo(cards)
  if FilterController(cards[1],1) 
  then
    if CardsMatchingFilter(cards,FilterType,TYPE_TOKEN)>0 then
      return BestTargets(cards,1,TARGET_PROTECT,FilterType,TYPE_TOKEN)
    end
    return BestTargets(cards,1,TARGET_PROTECT,KozmoDestroyFilter)
  end
  if OppHasStrongestMonster() then
    return BestTargets(cards,1,TARGET_DESTROY,PKBreakSwordFilter)
  end
  return BestTargets(cards,1,TARGET_DESTROY,FilterBackrow)
end
function TerraformingTarget(cards)
  return Add(cards)
end
function YakshaTarget(cards)
  return Add(cards,PRIO_BANISH,1,function(c) 
    return FilterLocation(c,LOCATION_HAND)
    and KozmoShip(c)
  end)
end
KozmoTargetFunctions={
[64280356] = TincanTarget,
[01274455] = SoartrooperTarget,
[64063868] = DarkEclipserTarget,
[67723438] = Eteletarget,
[55885348] = DestroyerTarget,
[20849090] = ForerunnerTarget,
[29491334] = DogFighterTarget,
[94454495] = SlipriderTarget,
[93302695] = WickedwitchTarget,
[67050396] = GoodwitchTarget,
[31061682] = FarmgirlTarget,
[56907986] = StrawmanTarget,
[67237709] = KozmotownTarget,
[90452877] = KozmojoTarget,
[57554544] = FireKingIslandTarget,
[25862681] = AFDTarget,
[75500286] = GoldSarcTarget,
[01475311] = AllureTarget,
[37679169] = DeltaShuttleTarget,
[95992081] = LeviairTargetKozmo,
[59496924] = LandwalkerTarget,
[01249315] = PureHeraldTarget,
[85252081] = GranpulseTargetKozmo,
[73628505] = TerraformingTarget,
[62709239] = BreakSwordTargetKozmo,
[76774528] = ScrapTargetKozmo,
[66413481] = YakshaTarget,
}
function KozmoCard(cards,min,max,id,c)
   for i,v in pairs(KozmoTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
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
  if KozmoComboCheck(6)
  then
    return true
  end
  if KozmoComboCheck(3,5)
  and NotNegated(c)
  then
    return true
  end
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
  and HasIDNotNegated(AIDeck(),56907986,true) -- Strawman
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
  if KozmoComboCheck(1,2) 
  then
    return true
  end
  if KozmoComboCheck(5,6)
  and HasID(AIST(),67237709,true) -- Kozmotown
  then
    return true
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
    if not RemovalCheckCard(c,CATEGORY_DESTROY,nil,true) 
    and CardsMatchingFilter(AIHand(),KozmoShip)==0
    then
      return false
    end
    if RemovalCheckCard(c,nil,nil,nil,nil,FilterID,function(c)
      return FilterID(c,57554544) -- Fire King Island
      or FilterID(c,90452877) -- Kozmojo
    end)
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
    or HasIDNotNegated(AIHand(),55885348,true)) -- Dark Destroyer
    and Duel.GetTurnPlayer()==1-player_ai
    then
      OPTSet(c.id)
      return true
    end
    if Duel.GetTurnPlayer()==player_ai 
    and GlobalBPEnd and not aimon
    and (AvailableAttacks(c)==0 or #OppMon()>0 and not CanWinBattle(c,OppMon()))
    and(CardsMatchingFilter(AIHand(),CanWinBattle,OppMon())>0
    or #OppMon()==0)
    then
      OPTSet(c.id)
      return true
    end
  end
  if HasIDNotNegated(AIHand(),55885348,true) -- Dark Destroyer
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
    if IsBattlePhase()
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
  if IsBattlePhase()
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
  if IsBattlePhase()
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
function ChainLandwalker(c)
  return true
end
function ChainDeltaShuttle(c)
  return true
end
function ChainDarkLady(source)
  local e,c,id = EffectCheck(player_ai,Duel.GetCurrentChain())
  if KozmoComboCheck(6)
  and source.description==source.id*16+1
  and id == 55885348 -- Dark Destroyer
  and c:IsLocation(LOCATION_MZONE)
  then
    return true
  end
end
function ChainInfinityKozmo(source)
  local e,c,id = EffectCheck(player_ai,Duel.GetCurrentChain())
  if KozmoComboCheck(6)
  and id == 67237709 -- Kozmotown
  and e:IsHasCategory(CATEGORY_DRAW)
  then
    return true
  end
end
function ChainDarkEclipser(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
end
function ChainGofu(c)
  if GlobalGofuTokens then
    GlobalGofuTokens = nil
    return true
  end
end
function ChainYaksha(c)
  if FilterLocation(c,LOCATION_HAND) then
    return true
  end
  return CardsMatchingFilter(AIHand(),KozmoShip)>0
end
function KozmoChain(cards)
  if HasIDNotNegated(cards,64063868,ChainNegation,2) then
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
  if HasID(cards,59496924,ChainLandwalker) then
    return Chain()
  end
  if HasID(cards,37679169,ChainDeltaShuttle) then
    return Chain()
  end
  if HasID(cards,64063868,ChainDarkEclipser) then
    return Chain()
  end
  if HasID(cards,12408276,ChainDarkLady) then
    return Chain()
  end
  if HasID(cards,10443957,ChainInfinityKozmo) then
    return Chain()
  end
  if HasID(cards,09929398,ChainGofu) then
    return Chain()
  end
  if HasID(cards,66413481,ChainYaksha) then
    return Chain()
  end
  KozmoComboIntegrityCheck()
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
  if id == 59496924 and ChainLandwalker(card) then
    return 1
  end
  if id == 37679169 and ChainDeltaShuttle(card) then
    return 1
  end
  if id == 64063868 and ChainDarkEclipser(card) then
    return 1
  end
  if id == 09929398 and ChainGofu(card) then
    return 1
  end
  if id == 66413481 and ChainYaksha(card) then
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
64063868, -- Dark Eclipser
55885348, -- Dark Destroyer
20849090, -- Forerunner
94454495, -- Sliprider
67050396, -- Goodwitch
31061682, -- Farmgirl
59496924, -- Landwalker
12408276, -- Dark Lady
37679169, -- Delta Shuttle
66413481, -- Yaksha
44405066, -- Flare Metal
}
KozmoVary={
29491334, -- Dog Fighter
29491335, -- Dog Fighter token
93302695, -- Wickedwitch
01274455, -- Soartrooper
25862681, -- AFD
85252081, -- Granpulse
}
KozmoDef={
64280356, -- Tincan
56907986, -- Strawman
09929398, -- Gofu
09929399, -- Gofu token
54149433, -- Garunix
01249315, -- Herald of Pure Light
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
      if (BattlePhaseCheck() or IsBattlePhase())
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

