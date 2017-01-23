--[[
07573135 -- Augustus
78868776 -- Laquari
89312388 -- Prisma
25924653 -- Darius
57731460 -- Equeste
41470137 -- Bestiari
00612115 -- Retiari
92373006 -- Test Tiger

01845204 -- Instant Fusion
08949584 -- AHL
12580477 -- Raigeki
14087893 -- BoM

29401950 -- Bottomless
40838625 -- Sandstorm Mirror Force
53567095 -- Icarus
05851097 -- Vanity
97077563 -- CotH
40605147 -- Solemn Strike
84749824 -- Solemn Warning
96216229 -- War Chariot

27346636 -- Heraklinos
29357956 -- Nerokius
48156348 -- Gyzarus
17412721 -- Norden
63519819 -- TER
63767246 -- Titanic Galaxy
01639384 -- Felgrand
56832966 -- Utopia Lightning
84013237 -- Utopia
86848580 -- Zerofyne
63746411 -- Giant Hand
82633039 -- Castel
95169481 -- DDW
22653490 -- Chidori
]]

function GladBeastStartup(deck)
  deck.Init                 = GladBeastInit
  deck.Card                 = GladBeastCard
  deck.Chain                = GladBeastChain
  deck.EffectYesNo          = GladBeastEffectYesNo
  deck.Position             = GladBeastPosition
  deck.YesNo                = GladBeastYesNo
  deck.BattleCommand        = GladBeastBattleCommand
  deck.AttackTarget         = GladBeastAttackTarget
  deck.AttackBoost          = GladBeastAttackBoost
  deck.Tribute              = GladBeastTribute
  deck.Option               = GladBeastOption
  deck.ChainOrder           = GladBeastChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = GladBeastActivateBlacklist
  deck.SummonBlacklist      = GladBeastSummonBlacklist
  deck.RepositionBlacklist  = GladBeastRepoBlacklist
  deck.SetBlacklist         = GladBeastSetBlacklist
  deck.Unchainable          = GladBeastUnchainable
  --[[
  
  ]]
  deck.PriorityList         = GladBeastPriorityList
  
  
end


GladBeastIdentifier = 41470137 -- Bestiari

DECK_GLADBEAST = NewDeck("Gladiator Beast",GladBeastIdentifier,GladBeastStartup) 


GladBeastActivateBlacklist={
07573135, -- Augustus
78868776, -- Laquari
89312388, -- Prisma
25924653, -- Darius
57731460, -- Equeste
41470137, -- Bestiari
00612115, -- Retiari
92373006, -- Test Tiger

01845204, -- Instant Fusion
08949584, -- AHL
--12580477, -- Raigeki
--14087893, -- BoM

40838625, -- Sandstorm Mirror Force
53567095, -- Icarus
97077563, -- CotH
--96216229, -- War Chariot

--27346636, -- Heraklinos
29357956, -- Nerokius
48156348, -- Gyzarus
--63767246, -- Titanic Galaxy
--01639384, -- Felgrand
95169481, -- DDW
}
GladBeastSummonBlacklist={
07573135, -- Augustus
78868776, -- Laquari
89312388, -- Prisma
25924653, -- Darius
57731460, -- Equeste
41470137, -- Bestiari
00612115, -- Retiari
92373006, -- Test Tiger

27346636, -- Heraklinos
29357956, -- Nerokius
48156348, -- Gyzarus
63767246, -- Titanic Galaxy
01639384, -- Felgrand
84013237, -- Utopia
86848580, -- Zerofyne
63746411, -- Giant Hand
82633039, -- Castel
95169481, -- DDW
22653490, -- Chidori
}
GladBeastSetBlacklist={
}
GladBeastRepoBlacklist={
}
GladBeastUnchainable={
40838625, -- Sandstorm Mirror Force
}
function GladBeastFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return (FilterSet(c,0x19)
  or c.original_id == 89312388 
  and (c.id == 41470137 or c.id == 78868776))
  and check
end
function GladBeastMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and GladBeastFilter(c,exclude)
end
function GladBeastFusion(c,exclude)
  return GladBeastMonsterFilter(c,exclude)
  and FilterType(c,TYPE_FUSION)
end
function GladBeastNonFusion(c,exclude)
  return GladBeastMonsterFilter(c,exclude)
  and not FilterType(c,TYPE_FUSION)
end
function AugustusCond(loc,c)
  if loc == PRIO_TOFIELD then
    if HasIDNotNegated(AIHand(),41470137,true,UseBestiari,2) -- Bestiari
    and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
    and not HasID(AIMon(),41470137,true) -- Bestiari
    then
      return true
    end
    return false
  end
  return true
end
function LaquariCond(loc,c)
  if loc == PRIO_TOFIELD then
    return true
  end
  return true
end
function PrismaCond(loc,c)
  if loc == PRIO_TOFIELD then
    return true
  end
  return true
end
function DariusCond(loc,c)
  if loc == PRIO_TOFIELD then
    if HasID(AIGrave(),41470137,true) -- Bestiari
    and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
    --and not HasID(AIMon(),41470137,true) -- Bestiari
    and GetMultiple(c.id)==0
    then
      return true
    end
    if CardsMatchingFilter(AIGrave(),GladBeastNonFusion)>GetMultiple(c.id) 
    then
      return 3.2
    end
    return false
  end
  return true
end
function EquesteCond(loc,c)
  if loc == PRIO_TOFIELD then
    if CardsMatchingFilter(AIGrave(),FilterID,96216229)>GetMultiple(c.id) -- War Chariot
    then
      return true
    end
    if HasID(AICards(),53567095,true) -- Icarus
    then
      return 3.5
    end
    if CardsMatchingFilter(AIGrave(),FilterID,96216229) -- War Chariot
    +CardsMatchingFilter(AIGrave(),GladBeastNonFusion,07573135) -- Augustus
    >GetMultiple(c.id)
    and CardsMatchingFilter(AIHand(),GladBeastFilter)==0
    then
      return true
    end
    if NeedsCard(48156348,AIGrave(),AIExtra(),true) -- Gyzarus
    then
      return 9
    end
    return false
  end
  return true
end
function BestiariCond(loc,c)
  if loc == PRIO_TOFIELD then
    if (UseBestiari(c,2) or GlobalSummonNegated)
    and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
    and CardsMatchingFilter(AIMon(),GladBeastNonFusion)>0
    and not HasID(AIMon(),c.id,true)
    and Duel.GetTurnPlayer()==player_ai
    then
      return true
    end
    if UseBestiari(c,1) and not GlobalSummonNegated
    then
      return 4.5
    end
    return false
  end
  return true
end
function RetiariCond(loc,c)
  if loc == PRIO_TOFIELD then
    return true
  end
  return true
end
function TestTigerCond(loc,c)
  return true
end
function ChariotCond(loc,c)
  return true
end
function HeraklinosCond(loc,c)
  return true
end
function NerokiusCond(loc,c)
  return true
end
function GyzarusCond(loc,c)
  if loc == PRIO_TOFIELD then
    if FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIExtra(),c.id)
    then
      return true
    end
    if FilterLocation(c,LOCATION_GRAVE)
    and not FilterRevivable(c)
    then
      return 4.5
    end
    return false
  end
  if loc == PRIO_TOFIELD then
    if CardsMatchingFilter(OppField(),GyzarusFilter)>0
    and Duel.GetCurrentChain()<=1
    and FilterLocation(c,LOCATION_GRAVE)
    and NotNegated(c)
    then
      return true
    end
    return false
  end 
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_MZONE)
    and HasIDNotNegated(AIST(),97077563,true)
    then
      return true
    end
    return false
  end
  return true
end

GladBeastPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- GladBeast

[07573135] = {0,0,7,4,4,1,1,1,1,1,AugustusCond},  -- Augustus
[78868776] = {2,1,2,1,1,1,1,1,1,1,LaquariCond},  -- Laquari
[89312388] = {1,1,1,1,5,1,1,1,1,1,PrismaCond},  -- Prisma
[25924653] = {2,1,8,1,1,1,1,1,1,1,DariusCond},  -- Darius
[57731460] = {3,1,5,1,3,1,1,1,1,1,EquesteCond},  -- Equeste
[41470137] = {4,0,6,1,6,1,1,1,1,1,BestiariCond},  -- Bestiari
[00612115] = {2,1,3,1,1,1,1,1,1,1,RetiariCond},  -- Retiari
[92373006] = {1,1,1,1,1,1,1,1,1,1,TestTigerCond},  -- Test Tiger

[40838625] = {1,1,1,1,1,1,1,1,1,1,},  -- Sandstorm Mirror Force
[96216229] = {5,1,1,1,1,1,1,1,1,1,ChariotCond},  -- War Chariot

[27346636] = {1,1,9,1,1,1,1,1,1,1,HeraklinosCond},  -- Heraklinos
[29357956] = {1,1,9,1,1,1,1,1,1,1,NerokiusCond},  -- Nerokius
[48156348] = {9,1,10,1,8,1,1,1,1,1,GyzarusCond},  -- Gyzarus
[63767246] = {1,1,1,1,1,1,1,1,1,1,},  -- Titanic Galaxy
[01639384] = {1,1,1,1,1,1,1,1,1,1,},  -- Felgrand
[56832966] = {1,1,1,1,1,1,1,1,1,1,},  -- Utopia Lightning
[84013237] = {1,1,1,1,1,1,1,1,1,1,},  -- Utopia
[86848580] = {1,1,1,1,1,1,1,1,1,1,},  -- Zerofyne
[63746411] = {1,1,1,1,1,1,1,1,1,1,},  -- Giant Hand
[82633039] = {1,1,1,1,2,1,1,1,1,1,},  -- Castel
[95169481] = {1,1,1,1,1,1,1,1,1,1,},  -- DDW
[22653490] = {1,1,1,1,1,1,1,1,1,1,},  -- Chidori

} 
function UsePrisma(c,mode)
  if mode == 1
  and CardsMatchingFilter(AIDeck(),FilterID,41470137)>0 -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true) -- Gyzarus
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(AIDeck(),FilterID,78868776)>0 -- Laquari
  and HasIDNotNegated(AIExtra(),27346636,true) -- Heraklinos
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(27346636,AIExtra()))
    return true
  end
end
function SummonPrisma(c,mode)
  local mats = CardsMatchingFilter(AIMon(),GladBeastNonFusion,c)
  if mode == 1
  and CardsMatchingFilter(AIDeck(),FilterID,41470137)>0 -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and (mats>0 and(mats<2 or not HasID(AIMon(),41470137,true)) -- Bestiari
  or HasIDNotNegated(AICards(),92373006,true) -- Test Tiger
  and HasIDNotNegated(AIDeck(),25924653,true) -- Darius
  or HasIDNotNegated(AICards(),01845204,true,UseIFGlad)-- Instant Fusion
  or HasIDNotNegated(AICards(),97077563,true,UseCotHGlad)) -- Call of the Haunted
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(AIDeck(),FilterID,78868776)>0 -- Laquari
  and HasID(AIExtra(),27346636,true) -- Heraklinos
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and HasID(AIMon(),41470137,true)
  and mats<2
  then
    return true
  end
  if mode == 3
  and #AIMon()==0
  --and TurnEndCheck()
  then
    return true
  end
end
function SummonGyzarus(c,mode)
  local targets = SubGroup(OppField(),GyzarusFilter)
  local prio = SubGroup(targets,FilterPriorityTarget)
  local mats = SubGroup(AIMon(),GladBeastNonFusion)
  if not mode then
    return DualityCheck()
    and #targets>0
  end
  if mode == 1 
  and (#targets>1 or #prio>0)
  and #mats>1
  then
    return true
  end
  if mode == 2
  and #targets>0
  and #mats>1
  then
    return true
  end
  if mode == 3
  --and --TODO: add check for temporary summons
  then
    return true
  end
end
function UseAHLGlad(c,mode)
  if mode == 1
  and SummonGyzarus()
  and HasIDNotNegated(AIDeck(),89312388,true,UsePrisma,1) -- Prisma
  and CardsMatchingFilter(AIHand(),GladBeastFilter,07573135)>0 -- Augustus
  then
    return true
  end
  if mode == 2
  and SummonGyzarus()
  and HasIDNotNegated(AIDeck(),89312388,true,UsePrisma,1) -- Prisma
  and HasIDNotNegated(AIHand(),92373006,true) -- Test Tiger
  then
    return true
  end
  if mode == 3
  and SummonGyzarus()
  and HasIDNotNegated(AIDeck(),89312388,true,UsePrisma,1) -- Prisma
  and (HasIDNotNegated(AICards(),01845204,true,UseIFGlad) -- Instant Fusion
  or HasIDNotNegated(AICards(),97077563,true,UseCotHGlad)) -- Call of the Haunted
  then
    return true
  end
end
function UseIFGlad(c,mode)
  local mats = CardsMatchingFilter(AIMon(),GladBeastNonFusion,c)
  if AI.GetPlayerLP(1)<=1000 
  or not DualityCheck()
  then 
    return false 
  end
  if not mode
  and HasIDNotNegated(AIExtra(),17412721,true) -- Norden
  and SpaceCheck()>2
  then
    return true
  end
  if mode == 1
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and HasIDNotNegated(AIExtra(),17412721,true) -- Norden
  and HasID(AIGrave(),41470137,true) -- Bestiari
  and mats>0
  and (not HasID(AIMon(),41470137,true) or mats==1) -- Bestiari
  and SpaceCheck()>1
  then
    GlobalIFTarget = 17412721 -- Norden
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and HasIDNotNegated(AIExtra(),17412721,true) -- Norden
  and HasID(AIMon(),41470137,true) -- Bestiari
  and CardsMatchingFilter(AIGrave(),GladBeastNonFusion)>0
  and mats==1
  and SpaceCheck()>1
  then
    GlobalIFTarget = 17412721 -- Norden
    return true
  end
end
function SummonGladBeast(c,mode)
  if mode == 1
  and HasIDNotNegated(AICards(),92373006,true) -- Test Tiger
  and HasID(AIGrave(),41470137,true) -- Bestiari
  and HasIDNotNegated(AIDeck(),25924653,true) -- Darius
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AICards(),92373006,true) -- Test Tiger
  and HasID(AIHand(),41470137,true,ExcludeCard,c) -- Bestiari
  and HasIDNotNegated(AIDeck(),07573135,true) -- Augustus
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  then
    return true
  end
  if mode == 3
  and BattlePhaseCheck()
  and CanAttackSafely(c,nil,0.8)
  and OverExtendCheck()
  then
    return true
  end
  if mode == 4
  --and TurnEndCheck()
  and CardsMatchingFilter(AIMon(),GladBeastFilter)==0
  and HasBackrow()
  then
    return true
  end
end
function SetGladBeast(c,mode)
  local mats = CardsMatchingFilter(AIMon(),GladBeastNonFusion)
  if mode == 1 
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and HasID(AIMon(),41470137,true) -- Bestiari
  and mats<2
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and HasID(AIMon(),41470137,true) -- Bestiari
  and mats<2
  then
    return true
  end
end
function BestiariFilter(c,forced)
  local result
  if forced then
    result = (DestroyFilter(c) and Targetable(c,TYPE_MONSTER) and CurrentOwner(c)==2)
    or (CurrentOwner(c)==1 and c.id == 97077563 and CardTargetCheck(c)==0 and FilterPosition(c,POS_FACEUP))
  else
    result = DestroyFilterIgnore(c) and Affected(c,TYPE_MONSTER,4) and Targetable(c,TYPE_MONSTER)
  end
  return result
end
function UseBestiari(c,mode)
  if mode == 1 
  and CardsMatchingFilter(OppST(),BestiariFilter)>0
  then
    return true
  end
  if mode == 2
  and (CardsMatchingFilter(AllST(),BestiariFilter,true)>0
  or Negated(c) or GlobalSummonNegated)
  then
    return true
  end
end
function SetBestiari(c,mode)
  local mats = CardsMatchingFilter(AIMon(),GladBeastNonFusion)
  if mode == 1 
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and mats>0
  and not HasIDNotNegated(AIMon(),c.id,true)
  then
    return true
  end
end
function SummonTestTiger(c,mode)
  return UseTestTiger(c,mode)
  and not HasIDNotNegated(AIMon(),c.id,true)
end
function UseTestTiger(c,mode)
  if mode == 1
  and HasIDNotNegated(AIDeck(),25924653,true) -- Darius
  and HasID(AIGrave(),41470137,true) -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and (CardsMatchingFilter(AIMon(),GladBeastNonFusion)==1 or not HasID(AIMon(),41470137,true)) -- Bestiari
  then
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIDeck(),07573135,true) -- Augustus
  and HasID(AIHand(),41470137,true,UseBestiari,2) -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and (CardsMatchingFilter(AIMon(),GladBeastNonFusion)==1 or not HasID(AIMon(),41470137,true)) -- Bestiari
  then
    return true
  end
end
function UseCotHGlad(c,mode)
  if not mode 
  and DualityCheck()
  and SpaceCheck()>0
  then
    return true
  end
  if mode == 1
  and HasIDNotNegated(AIGrave(),48156348,true,FilterRevivable) -- Gyzarus
  and SummonGyzarus()
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(48156348,AIGrave())) -- Gyzarus
    return true
  end
  if mode == 2
  and HasIDNotNegated(AIGrave(),17412721,true,FilterRevivable) -- Norden
  and HasID(AIGrave(),41470137,true) -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and SpaceCheck()>1
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(17412721,AIGrave())) -- Norden
    return true
  end
  if mode == 3
  and HasID(AIGrave(),41470137,true) -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and CardsMatchingFilter(AIMon(),GladBeastNonFusion)==1
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(41470137,AIGrave())) -- Bestiari
    return true
  end
  if mode == 4 
  and HasID(AIMon(),41470137,true) -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and CardsMatchingFilter(AIGrave(),GladBeastNonFusion)>0
  and CardsMatchingFilter(AIMon(),GladBeastNonFusion)==1
  then
    return true
  end
  if mode == 5
  and HasID(AIGrave(),29357956,true,FilterRevivable) -- Nerokius
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(29357956,AIGrave())) -- Nerokius
    return true
  end
end
function ContactFusion(index,id)
  if index == nil then
    index = CurrentIndex
  end
  GlobalFusionMaterial = true
  if id then
    GlobalSSCardID = id
  end
  return {COMMAND_SPECIAL_SUMMON,index}
end
function NerokiusFilter(c,source)
  return BattleTargetCheck(c,source)
  and (FilterPosition(c,POS_FACEDOWN)
  or not SelectAttackConditions(c) 
  and SelectAttackConditions(c,source))
end
function SummonNerokius(c,mode)
  local mats = SubGroup(AIMon(),GladBeastNonFusion)
  if #mats<3 then return false end
  if mode == 1
  and MatchupCheck(c.id) 
  and CanWinBattle(c,OppMon())
  then
    return true
  end
  if mode == 2
  and BattlePhaseCheck()
  and CanWinBattle(c,OppMon(),nil,nil,NerokiusFilter,c)
  then
    return true
  end
  if mode == 3
  and OppHasStrongestMonster()
  and CanWinBattle(c,OppMon())
  then
    return true
  end
  if mode == 4
  and MP2Check()
  then
    return true
  end
end
function SummonHeraklinos(c,mode)
  local mats = SubGroup(AIMon(),GladBeastNonFusion)
  if #mats<3 then return false end
  if mode == 1
  and MatchupCheck(c.id)
  and OppGetStrongestAttack()<c.attack
  and MP2Check()
  and #AIHand()>0
  then
    return true
  end
  if mode == 2 
  and OppGetStrongestAttack()<c.attack
  and MP2Check()
  and #AIHand()>2
  then
    return true
  end
  if mode == 3
  and OppHasStrongestMonster()
  and CanWinBattle(c,OppMon())
  then
    return true
  end
end
function GladBeastXYZMaterialCheck(c) -- only XYZ summon, if AI has no backrow, 
  if not HasBackrow() then           -- or leaves a Gladbeast on the field for Chariot
    return MP2Check()
  end
  local cards = SubGroup(AIMon(),GladBeastNonFusion)
  if c and not FilterLocation(c,LOCATION_MZONE) 
  then
    table.insert(cards,c)
  end
  return #cards>2
end
--[[
63767246 -- Titanic Galaxy
01639384 -- Felgrand
56832966 -- Utopia Lightning
84013237 -- Utopia
86848580 -- Zerofyne
63746411 -- Giant Hand
82633039 -- Castel
95169481 -- DDW
22653490 -- Chidori
function SummonFelgrandGladbeast(c,mode)
end
function SummonTitanicGalaxyGladbeast(c,mode)
end
function SummonUtopiaGladbeast(c,mode)
end
function SummonChidoriGladbeast(c,mode)
end
function SummonZerofyneGladbeast(c,mode)
end
]]

function UseBomGladbeast(card)
  local result = true
  if #AIMon() == 0 then
    result = false
  end
  for i,c in pairs(AIMon()) do
    if CanAttackSafely(c,OppMon(),true) then
      result = false
    end
  end
  local targets = SubGroup(OppMon(),MoonFilter)
  if result and #targets>0 then
    targets = SubGroup(targets,FilterDefenseMax,AIGetStrongestAttack(true,GladBeastFilter))
    if #targets>0 then
      GlobalCardMode = 1
      GlobalTargetSet(targets[1])
    end
    return true
  end
end
function GladBeastInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,97077563,UseCotHGlad,1) then
    return Activate()
  end
  if HasID(Act,89312388,UsePrisma,1) then
    return Activate()
  end
  if HasID(SpSum,48156348,SummonGyzarus,1) then
    return ContactFusion()
  end
  if HasID(SpSum,48156348,SummonGyzarus,2) then
    return ContactFusion()
  end
  if HasID(Act,89312388,UsePrisma,2) then
    return Activate()
  end
 
  if HasID(Act,08949584,UseAHLGlad,1) then
    return Activate()
  end
  if HasID(Sum,89312388,SummonPrisma,1) then
    return Summon()
  end
  if HasID(Sum,89312388,SummonPrisma,2) then
    return Summon()
  end
  if HasID(Act,08949584,UseAHLGlad,2) then
    return Activate()
  end
  if HasID(Act,08949584,UseAHLGlad,3) then
    return Activate()
  end
  if HasID(SetMon,41470137,SetBestiari,1) then
    return Set()
  end
  local gladbeasts = { -- order of setting/summoning, if just needed as material
  00612115, -- Retiari
  25924653, -- Darius
  57731460, -- Equeste
  78868776, -- Laquari
  41470137, -- Bestiari
  }
  for i,id in pairs(gladbeasts) do
    if HasID(SetMon,id,SetGladBeast,1) then
      return Set()
    end
  end
  for i,id in pairs(gladbeasts) do
    if HasID(Sum,id,SummonGladBeast,1) then
      return Summon()
    end
    if HasID(Sum,id,SummonGladBeast,2) then
      return Summon()
    end
  end
  
  if HasID(Act,92373006,UseTestTiger,1) then
    return Activate()
  end
  if HasID(SpSum,92373006,SummonTestTiger,1) then
    return SpSummon()
  end
  if HasID(Act,92373006,UseTestTiger,2) then
    return Activate()
  end
  if HasID(SpSum,92373006,SummonTestTiger,2) then
    return SpSummon()
  end
  
  if HasIDNotNegated(Act,01845204,UseIFGlad,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseIFGlad,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,97077563,UseCotHGlad,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,97077563,UseCotHGlad,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,97077563,UseCotHGlad,4) then
    return Activate()
  end
  if HasIDNotNegated(Act,97077563,UseCotHGlad,5) then
    return Activate()
  end
  gladbeasts = { -- order of summoning, if attacking
  78868776, -- Laquari
  25924653, -- Darius
  57731460, -- Equeste
  00612115, -- Retiari
  41470137, -- Bestiari
  }
  for i,id in pairs(gladbeasts) do
    if HasID(Sum,id,SummonGladBeast,3) then
      return Summon()
    end
  end
  gladbeasts = { -- order of summoning, if just summoning for Chariot
  78868776, -- Laquari
  25924653, -- Darius
  57731460, -- Equeste
  00612115, -- Retiari
  41470137, -- Bestiari
  }
  for i,id in pairs(gladbeasts) do
    if HasID(Sum,id,SummonGladBeast,4) then
      return Summon()
    end
  end
  if HasID(Sum,89312388,SummonPrisma,3) then
    return Summon()
  end
  
  if #AIMon()>1 and GladBeastXYZMaterialCheck() then
    if HasID(SpSum,63767246,SummonTitanicGalaxy,1) then
      return XYZSummon()
    end
    if HasID(SpSum,01639384,SummonFelgrand,1) then
      return XYZSummon()
    end
    if HasID(SpSum,22653490,SummonChidori,1) then
      return XYZSummon()
    end
    if HasID(SpSum,84013237,SummonUtopia,1) then
      return XYZSummon()
    end
    if HasID(SpSum,84013237,SummonUtopia,2) then
      return XYZSummon()
    end
    if HasID(SpSum,86848580,SummonZerofyne) then
      return XYZSummon()
    end
    if HasID(SpSum,82633039,SummonSkyblaster) then
      return XYZSummon()
    end
    if HasID(SpSum,22653490,SummonChidori,2) then
      return XYZSummon()
    end
    if HasID(SpSum,01639384,SummonFelgrand,2) then
      return XYZSummon()
    end
    if HasID(SpSum,63767246,SummonTitanicGalaxy,2) then
      return XYZSummon()
    end
    if HasID(SpSum,84013237,SummonUtopia,3) then
      return XYZSummon()
    end
  end
  
  if HasID(SpSum,27346636,SummonHeraklinos,1) then
    return ContactFusion()
  end
  if HasID(SpSum,29357956,SummonNerokius,1) then
    return ContactFusion()
  end
  if HasID(SpSum,29357956,SummonNerokius,2) then
    return ContactFusion()
  end
  if HasID(SpSum,27346636,SummonHeraklinos,2) then
    return ContactFusion()
  end
  if HasID(SpSum,29357956,SummonNerokius,3) then
    return ContactFusion()
  end
  if HasID(SpSum,29357956,SummonNerokius,4) then
    return ContactFusion()
  end
  if HasID(SpSum,27346636,SummonHeraklinos,3) then
    return ContactFusion()
  end
  
  if HasIDNotNegated(Act,14087893,UseBomGladbeast) then
    return Activate()
  end
  return nil
end
function AugustusTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards,PRIO_TOFIELD)
end
function LaquariTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
end
function PrismaTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOFIELD,1,FilterGlobalTarget,cards)
  end
  if LocCheck(cards,LOCATION_EXTRA) then
    if CardsMatchingFilter(AIDeck(),FilterID,41470137)>0 -- Bestiari
    then
      return Add(cards,PRIO_TOFIELD,1,FilterID,48156348) -- Gyzarus
    else
      return Add(cards,PRIO_TOFIELD,1,FilterID,27346636) -- Heraklinos
    end
  end
  return Add(cards,PRIO_TOGRAVE)
end
function DariusTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  GlobalSummonNegated=true
  local result = Add(cards,PRIO_TOFIELD,1,TargetCheck)
  TargetSet(cards[1])
  return result
end
function EquesteTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  local result = Add(cards,PRIO_TOHAND,1,TargetCheck)
  TargetSet(cards[1])
  return result
end
function BestiariTarget(cards,c)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  if NotNegated(c) then
    return BestTargets(cards,1,TARGET_DESTROY,TargetCheck)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function RetiariTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function TestTigerTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function HeraklinosTarget(cards,c,min,max)
  return Add(cards,PRIO_TOGRAVE)
end
function NerokiusTarget(cards,c,min,max)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD,max)
  end
end
function GyzarusFilter(c,ignore)
  local check
  if ignore then
    check = DestroyFilterIgnore(c)
  else
    check = DestroyFilter(c)
  end
  return Affected(c,TYPE_MONSTER,6)
  and Targetable(c,TYPE_MONSTER)
  and check
end
function GyzarusTarget(cards,c,min,max)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD,max)
  end
  local targets = CardsMatchingFilter(OppField(),GyzarusFilter,false)
  targets = math.max(min,math.min(max,targets))
  return BestTargets(cards,targets,TARGET_DESTROY)
end
GladBeastTargetFunctions = {
[07573135] = AugustusTarget,       -- Augustus
[78868776] = LaquariTarget,        -- Laquari
[89312388] = PrismaTarget,         -- Prisma
[25924653] = DariusTarget,         -- Darius
[57731460] = EquesteTarget,        -- Equeste
[41470137] = BestiariTarget,       -- Bestiari
[00612115] = RetiariTarget,        -- Retiari
[92373006] = TestTigerTarget,      -- Test Tiger
[27346636] = HeraklinosTarget,     -- Heraklinos
[29357956] = NerokiusTarget,       -- Nerokius
[48156348] = GyzarusTarget,        -- Gyzarus
}
function GladBeastCard(cards,min,max,id,c)
  for i,v in pairs(GladBeastTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
  end
  return nil
end
function ChainCothGlad(c)
  if RemovalCheckCard(c) then
    return true -- no minion can profit from that, do it anyway?
  end
  if not UnchainableCheck(c) then
    return false
  end
  local gyz = HasIDNotNegated(AIGrave(),48156348,true,FilterRevivable) and SummonGyzarus() -- Gyzarus
  if gyz then gyz = FindID(48156348,AIGrave()) end -- Gyzarus
  local targets = SubGroup(OppField(),GyzarusFilter)
  local prio = HasPriorityTarget(targets,true)
  if Duel.GetTurnPlayer()==1-player_ai
  and Duel.GetCurrentChain()==0
  and gyz
  then
    if #targets>1
    and prio
    then
      GlobalCardMode = 1
      GlobalTargetSet(gyz)
      return true
    end
    if Duel.GetCurrentPhase()==PHASE_END
    and Duel.GetCurrentChain()==0
    and #targets>1
    then
      GlobalCardMode = 1
      GlobalTargetSet(gyz)
      return true
    end
    local aimon,oppmon=GetBattlingMons()
    if IsBattlePhase()
    and aimon and oppmon
    and WinsBattle(oppmon,aimon)
    and GyzarusFilter(oppmon)
    and Duel.GetCurrentChain()==0
    then
      GlobalCardMode = 1
      GlobalTargetSet(gyz)
      return true
    end
    if IsBattlePhase()
    and oppmon
    and GyzarusFilter(oppmon)
    and #AIMon()==0
    and Duel.GetCurrentChain()==0
    then
      GlobalCardMode = 1
      GlobalTargetSet(gyz) -- Gyzarus
      return true
    end
  end
end
function SandstormMirrorFilter(c)
  return FilterPosition(c,POS_FACEUP_ATTACK)
  and Affected(c,TYPE_TRAP)
end
function ChainSandstormMirror(c)
  local targets = SubGroup(OppMon(),SandstormMirrorFilter)
  if RemovalCheckCard(c) then
    return true
  end
  if not UnchainableCheck(c) then
    return false
  end
  if ExpectedDamage()>=AI.GetPlayerLP(1) then
    return true
  end
  if ExpectedDamage()>=0.8*AI.GetPlayerLP(1) and #targets>0 then
    return true
  end
  local aimon,oppmon=GetBattlingMons()
  if aimon and oppmon 
  and WinsBattle(oppmon,aimon)
  and SandstormMirrorFilter(oppmon)
  then
    return true
  end
end
function IcarusTribute(c)
  if HasIDNotNegated(AIST(),97077563,true) -- CotH
  and c.id == 48156348 -- Gyzarus
  then 
    return true
  end
  return FilterRace(c,RACE_WINDBEAST)
  and GladBeastNonFusion(c)
end
function ChainIcarusGlad(c)
  local targets = SubGroup(OppField(),IcarusFilter)
  local prio = HasPriorityTarget(targets,true)
  local tributes = SubGroup(AIMon(),IcarusTribute)
  if Duel.GetTurnPlayer()==1-player_ai
  and Duel.GetCurrentPhase()==PHASE_END
  and Duel.GetCurrentChain()==0
  and (#targets>1 and #tributes>0
  or #targets>2 and HasIDNotNegated(tributes,48156348,true)) -- Gyzarus
  and UnchainableCheck(c)
  then
    return true
  end
  if ChainIcarus(c) then
    return true
  end
end
GladBeastTag = {
07573135, -- Augustus
78868776, -- Laquari
89312388, -- Prisma
25924653, -- Darius
57731460, -- Equeste
41470137, -- Bestiari
00612115, -- Retiari
29357956, -- Nerokius
48156348, -- Gyzarus
}
function TagGladBeast(c)
  local check = false
  for i,id in pairs(GladBeastTag) do
    if id == c.id then
      check = true
    end
  end
  if not check then return false end
  local desc = 0
  if c.id==78868776
  then
    desc=c.id*16
  else
    desc=c.id*16+1
  end
  return c.description==desc
end
function GladBeastChain(cards)
  for i,c in pairs(cards) do
    if GladBeastFilter(c) and TagGladBeast(c) then
      return Chain(i)
    end
  end
  if HasIDNotNegated(cards,97077563,ChainCothGlad) then
    return Chain()
  end
  if HasIDNotNegated(cards,40838625,ChainSandstormMirror) then
    return Chain()
  end
  if HasIDNotNegated(cards,53567095,ChainIcarusGlad) then
    return Chain()
  end
  return nil
end
function ChainGyzarus(c)
  return CardsMatchingFilter(OppField(),GyzarusFilter)>0
end
function ChainDarius(c)
  return true
end
function ChainAugustus(c)
  if HasID(AIHand(),41470137,true,UseBestiari,2) -- Bestiari
  and HasIDNotNegated(AIExtra(),48156348,true,SummonGyzarus) -- Gyzarus
  and not HasID(AIMon(),41470137,true) -- Bestiari
  then
    return true
  end
end
function ChainRetiari(c)
  return true
end
function GladBeastEffectYesNo(id,c)
  if TagGladBeast(c) then
    return true
  end
  if id == 48156348 and ChainGyzarus(c) then
    return true
  end
  if id == 25924653 and ChainDarius(c) then
    return true
  end
  if id == 07573135 and ChainAugustus(c) then
    return true
  end
  if id == 00612115 and ChainRetiari(c) then
    return true
  end
  return nil
end
function GladBeastYesNo(desc)
end
function GladBeastTribute(cards,min, max)
end
function GladBeastBattleCommand(cards,targets,act)
  SortByATK(cards)
  for i,c in pairs(cards) do
    if GladBeastFilter(c)
    and NotNegated(c)
    and CanAttackSafely(c,targets,0.8)
    then
      return Attack(i)
    end
  end
end
function GladBeastAttackTarget(cards,attacker)
end
function GladBeastAttackBoost(cards)
end
function GladBeastOption(options)
end
function GladBeastChainOrder(cards)
end
GladBeastAtt={
07573135, -- Augustus
78868776, -- Laquari
89312388, -- Prisma
25924653, -- Darius
57731460, -- Equeste
41470137, -- Bestiari
27346636, -- Heraklinos
29357956, -- Nerokius
48156348, -- Gyzarus
}
GladBeastVary={
00612115, -- Retiari
}
GladBeastDef={
92373006, -- Test Tiger
}
function GladBeastPosition(id,available)
  result = nil
  for i=1,#GladBeastAtt do
    if GladBeastAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#GladBeastVary do
    if GladBeastVary[i]==id 
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
  for i=1,#GladBeastDef do
    if GladBeastDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end