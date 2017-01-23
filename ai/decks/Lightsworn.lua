--[[
57774843, -- JD
58996430, -- Wulf
59019082, -- Garoth
96235275, -- Jain
77558536, -- Raiden
22624373, -- Lyla
44178886, -- Ehren
73176465, -- Felis
34710660, -- Electromagnetic Turtle
95503687, -- Lumina
40164421, -- Minerva
69764158, -- Peropero
02830693, -- Rainbow Kuriboh
67441435, -- Glow-Up Bulb
00691925, -- Solar Recharge
01845204, -- Instant Fusion
05133471, -- Galaxy Cyclone
32807846, -- Rota
81439173, -- Foolish
94886282, -- Charge
66194206, -- Judgment

17412721, -- Norden
52687916, -- Trishula
74586817, -- Omega
04779823, -- Michael
80696379, -- Meteorburst
82044279, -- Clear Wing
73580471, -- Black Rose
56832966, -- Utopia Lightning
84013237, -- Utopia
21501505, -- Cairngorgon
82633039, -- Castel
30100551, -- Minerva
00581014, -- Emeral
21044178, -- Dweller
80666118, -- Scarlight
]]
function LightswornStartup(deck)
  deck.Init                 = LightswornInit
  deck.Card                 = LightswornCard
  deck.Chain                = LightswornChain
  deck.EffectYesNo          = LightswornEffectYesNo
  deck.Position             = LightswornPosition
  deck.YesNo                = LightswornYesNo
  deck.BattleCommand        = LightswornBattleCommand
  deck.AttackTarget         = LightswornAttackTarget
  deck.AttackBoost          = LightswornAttackBoost
  deck.Tribute              = LightswornTribute
  deck.Option               = LightswornOption
  deck.ChainOrder           = LightswornChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = LightswornActivateBlacklist
  deck.SummonBlacklist      = LightswornSummonBlacklist
  deck.RepositionBlacklist  = LightswornRepoBlacklist
  deck.SetBlacklist         = LightswornSetBlacklist
  deck.Unchainable          = LightswornUnchainable
  --[[
  
  ]]
  deck.PriorityList         = LightswornPriorityList
  
end

LightswornIdentifier = 57774843 -- Judgment Dragon

DECK_LIGHTSWORN = NewDeck("Lightsworn",LightswornIdentifier,LightswornStartup) 


LightswornActivateBlacklist={
57774843, -- JD
77558536, -- Raiden
22624373, -- Lyla
73176465, -- Felis
34710660, -- Electromagnetic Turtle
95503687, -- Lumina
40164421, -- Minerva
69764158, -- Peropero
02830693, -- Rainbow Kuriboh
67441435, -- Glow-Up Bulb
00691925, -- Solar Recharge
01845204, -- Instant Fusion
32807846, -- Rota
81439173, -- Foolish
94886282, -- Charge
66194206, -- Judgment

74586817, -- Omega
80666118, -- Scarlight
70902743, -- RDA (Scarlight name change)
}
LightswornSummonBlacklist={
57774843, -- JD
58996430, -- Wulf
59019082, -- Garoth
96235275, -- Jain
77558536, -- Raiden
22624373, -- Lyla
44178886, -- Ehren
73176465, -- Felis
34710660, -- Electromagnetic Turtle
95503687, -- Lumina
40164421, -- Minerva
69764158, -- Peropero
02830693, -- Rainbow Kuriboh
67441435, -- Glow-Up Bulb

17412721, -- Norden
52687916, -- Trishula
74586817, -- Omega
04779823, -- Michael
80696379, -- Meteorburst
82633039, -- Castel
30100551, -- Minerva
00581014, -- Emeral
80666118, -- Scarlight
}
LightswornSetBlacklist={
}
LightswornRepoBlacklist={
}
LightswornUnchainable={
34710660, -- Electromagnetic Turtle
69764158, -- Peropero
02830693, -- Rainbow Kuriboh
30100551, -- Minerva
}
function LightswornFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0x38) and check
end
function LightswornMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and LightswornFilter(c,exclude)
end

function LightswornNameCheck(cards)
  local names = {}
  for i=1,#cards do
    local c = cards[i]
    local check = true
    for j=1,#names do
      if c.id == names[j] then
        check = false
      end
    end
    if LightswornMonsterFilter(c) 
    and check
    then
      names[#names+1]=c.id
    end
  end
  return #names
end

function MinervaCond(loc,c)
  if loc == PRIO_TOHAND then
    return HasIDNotNegated(AICards(),00691925,true,UseRecharge)
  end
  return true
end                     
LightswornPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Lightsworn

[57774843] = {8,1,8,1,1,1,5,1,1,1,JDCond},  -- JD
[58996430] = {1,1,1,1,6,1,3,1,1,1,WulfCond},  -- Wulf
[59019082] = {3,1,1,1,3,1,2,1,1,1,GarothCond},  -- Garoth
[96235275] = {3,1,1,1,3,1,2,1,1,1,JainCond},  -- Jain
[77558536] = {6,1,6,1,2,1,1,1,1,1,RaidenCond},  -- Raiden
[22624373] = {5,1,5,1,2,1,1,1,1,1,LylaCond},  -- Lyla
[44178886] = {4,1,1,1,3,1,2,1,1,1,EhrenCond},  -- Ehren
[73176465] = {1,1,1,1,5,1,3,1,1,1,FelisCond},  -- Felis
[34710660] = {1,1,1,1,7,1,1,1,1,1,TurtleCond},  -- Electromagnetic Turtle
[95503687] = {7,1,7,1,1,1,1,1,1,1,LuminaCond},  -- Lumina
[40164421] = {8,1,1,1,4,1,2,1,1,1,MinervaCond},  -- Minerva
[69764158] = {1,1,1,1,7,1,1,1,1,1,PeroCond},  -- Peropero
[02830693] = {1,1,1,1,4,1,1,1,1,1,RainbohCond},  -- Rainbow Kuriboh
[67441435] = {1,1,1,1,5,1,1,1,1,1,BulbCond},  -- Glow-Up Bulb
[08691925] = {1,1,1,1,2,1,1,1,1,1,RechargeCond},  -- Solar Recharge
[01845204] = {1,1,1,1,1,1,1,1,1,1,IFCond},  -- Instant Fusion
[05133471] = {1,1,1,1,3,1,1,1,1,1,CycloneCond},  -- Galaxy Cyclone
[32807846] = {1,1,1,1,2,1,1,1,1,1,RotaCond},  -- Rota
[81439173] = {1,1,1,1,2,1,1,1,1,1,FoolishCond},  -- Foolish
[94886282] = {1,1,1,1,2,1,1,1,1,1,ChargeCond},  -- Charge
[66194206] = {1,1,1,1,4,1,1,1,1,1,JudgmentCond},  -- Judgment

[17412721] = {1,1,1,1,1,1,1,1,1,1,NordenCond},  -- Norden
[52687916] = {1,1,1,1,1,1,1,1,1,1,TrishulaCond},  -- Trishula
[74586817] = {1,1,1,1,1,1,1,1,1,1,OmegaCond},  -- Omega
[04779823] = {1,1,1,1,1,1,1,1,1,1,MichaelCond},  -- Michael
[80696379] = {1,1,1,1,1,1,1,1,1,1,MeteorburstCond},  -- Meteorburst
[82044279] = {1,1,1,1,1,1,1,1,1,1,ClearWingCond},  -- Clear Wing
[73580471] = {1,1,1,1,1,1,1,1,1,1,BlackroseCond},  -- Black Rose
[56832966] = {1,1,1,1,1,1,1,1,1,1},  -- Utopia Lightning
[84013237] = {1,1,1,1,1,1,1,1,1,1},  -- Utopia
[21501505] = {1,1,1,1,1,1,1,1,1,1,CairngorgonCond},  -- Cairngorgon
[82633039] = {1,1,1,1,1,1,1,1,1,1,CastelCond},  -- Castel
[30100551] = {1,1,1,1,1,1,4,1,1,1},  -- Minerva
[00581014] = {1,1,1,1,1,1,1,1,1,1,EmeralCond},  -- Emeral
[21044178] = {1,1,1,1,1,1,1,1,1,1,DwellerCond},  -- Dweller

} 
function SummonBlackRose(c)
  return UseFieldNuke(c,-1)
end
function SummonWulf(c)
  return MacroCheck()
  and DualityCheck()
end
function SummonLightsworn(c,mode)
  if mode == 1 
  and c.level == 4 
  and (FieldCheck(4)==1 
  or HasID(AICards(),81439173,true) and HasID(AIDeck(),58996430,true,SummonWulf))
  and (OverExtendCheck() or BattlePhaseCheck())
  then
    return true
  end
  if mode == 2
  and LightswornFilter(c,59019082)
  and c.level<5
  and #AIMon()==0
  and #AIDeck()>20
  and TurnEndCheck()
  then
    return true
  end
  if c.id == 96235275 then c.attack = 2100 end
  if mode == 3
  and (#OppMon()>0
  and OppHasStrongestMonster()
  and (c.attack>=OppGetStrongestAttDef()
  and c.attack>1000
  or #AIMon()==0 and CanWinBattle(c,OppMon())
  and c.attack>1000) 
  or c.attack>=1500 and #OppMon()==0)
  then
    return true
  end
  return false
end

function UseRecharge(c)
  return #AIDeck()>10
end
GlobalFoolishID = nil
function UseFoolishLS(c,mode)
  if mode == 1 
  and FieldCheck(4)==1
  and HasID(AIDeck(),58996430,true)
  and DualityCheck()
  and MacroCheck()
  then
    GlobalFoolishID = 58996430
    return true
  end
  return false
end
function UseCharge(c)
  return true
end
function TrishFilter2(c,params)
  local c2,c3=params[1],params[2]
  return not CardsEqual(c,c2) 
  and not CardsEqual(c,c3)
  and not CardsEqual(c2,c3)
  and c.level+c2.level+c3.level == 9 
  and CardsMatchingFilter({c,c2,c3},FilterType,TYPE_TUNER)==1
end
function TrishFilter(c,c2)
  return CardsMatchingFilter(AIMon(),TrishFilter2,{c,c2})>0
end
function SummonBulb(c,mode)
  if mode == 1
  and CardsMatchingFilter(AIMon(),TrishFilter,c)>0 
  and HasID(AIExtra(),52687916,true,SummonSyncTrishula)
  then
    return true
  end
  if mode == 2
  and HasID(AIExtra(),80666118,true,SummonScarlight,1)
  and CheckSum(AIMon(),7,FilterNotType,TYPE_TUNER)
  then
    return true
  end
  if mode == 3
  and HasID(AIExtra(),80666118,true,SummonScarlight,2)
  and CheckSum(AIMon(),7,FilterNotType,TYPE_TUNER)
  then
    return true
  end
  return false
end
function LSXYZSummon()
  return true -- TODO
end
function UseIFLS(c,mode)
  if AI.GetPlayerLP(1)<=1000
  or not WindaCheck()
  or not DualityCheck()
  or Duel.GetLocationCount(player_ai,LOCATION_MZONE)<2
  or Negated(c)
  then
    return false
  end
  if mode == 1 then
    if TrishulaCheck() then
      GlobalIFTarget=17412721
      local lvl = 4
      local tuner = false
      if GlobalNordenMatch then
        lvl = GlobalNordenMatch.lvl
        tuner = GlobalNordenMatch.tuner
      end
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
    and LSXYZSummon()
    then
      GlobalIFTarget=17412721
      GlobalNordenFilter=function(c)return FilterLevel(c,4) end
      return true
    end
  end
  if mode == 3 
  and #AIMon()==1
  and FieldCheck(4)==1
  and HasIDNotNegated(AIExtra(),30100551,true,SummonMinerva,1)
  and #AIDeck()>20
  and TurnEndCheck()
  then
    return true
  end
  if mode == 4
  and HasID(AIExtra(),74586817,true,SummonOmega)
  and CardsMatchingFilter(AIGrave(),FilterTuner,4)>0
  then
    GlobalIFTarget=17412721
    GlobalNordenFilter=function(c)return FilterTuner(c,4) end
    return true
  end
  if mode == 5
  and HasID(AIExtra(),80666118,true,SummonScarlight,1)
  and CardsMatchingFilter(AIGrave(),FilterTuner,4)>0
  then
    GlobalIFTarget=17412721
    GlobalNordenFilter=function(c)return FilterTuner(c,4) end
    return true
  end
  if mode == 6
  and HasID(AIExtra(),80666118,true,SummonScarlight,2)
  and CardsMatchingFilter(AIGrave(),FilterTuner,4)>0
  then
    GlobalIFTarget=17412721
    GlobalNordenFilter=function(c)return FilterTuner(c,4) end
    return true
  end
end
function SummonOmega(c,mode)
  if (mode == nil or 1) 
  and NotNegated(c)
  and (HasID(AIBanish(),69764158,true)
  or HasID(AIBanish(),02830693,true))
  then
    return true
  end
  if (mode == nil or 2)
  and OppHasStrongestMonster()
  and BattlePhaseCheck()
  and CanWinBattle(c,OppMon())
  then
    return true
  end
  if mode == 3
  and MP2Check(c)
  then
    return true
  end
  if mode == 4
  and (HasIDNotNegated(AIMon(),57774843,true)
  or HasIDNotNegated(AIHand(),57774843,true,SummonJD,1) 
  and LightswornNameCheck(Merge(AIGrave(),AIMon()))>3)
  and DestroyCheck(OppField())>1
  and #OppHand()>0
  and NotNegated(c)
  then
    return true
  end
end
function UseOmega(c)
  return FilterLocation(c,LOCATION_GRAVE)
end
function SummonJD(c,mode)
  local NukeModifier = -1
  if HasIDNotNegated(AIMon(),74586817,true) and #OppHand()>0 
  then
    NukeModifier = NukeModifier+1
  end
  if DestroyCheck(OppField())>3 then
    NukeModifier = NukeModifier+1
  end
  if DestroyCheck(OppField())>5 then
    NukeModifier = NukeModifier+1
  end
  if mode == 1 
  and UseFieldNuke(c,NukeModifier)
  and not HasID(AIMon(),57774843,true) 
  and NotNegated(c)
  then
    return true
  end
  if mode == 2
  and #OppMon()==0 
  and BattlePhaseCheck()
  and ExpectedDamage()<=AI.GetPlayerLP(2)
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
function UseJD(c)
  local NukeModifier = 1
  if AI.GetPlayerLP(1)<=1000 then
    return false
  end
  if HasIDNotNegated(AIMon(),74586817,true) and #OppHand()>0 
  then
    NukeModifier = NukeModifier+1
  end
  if DestroyCheck(OppField())>3 then
    NukeModifier = NukeModifier+1
  end
  if DestroyCheck(OppField())>5 then
    NukeModifier = NukeModifier+1
  end
  return UseFieldNuke(c,NukeModifier)
end
function SummonEmeralLS(c)
  return SummonEmeral(c) 
  or CardsMatchingFilter(AIGrave(),FilterID,57774843)>1
  and MP2Check(1800) 
  and (OppGetStrongestAttDef()<1800 
  or not OppHasStrongestMonster())
end
function SummonMeteorburst(c,mode)
  if mode == 1 
  and BattlePhaseCheck()
  and NotNegated(c)
  and #OppMon()==0 
  and ExpectedDamage()<AI.GetPlayerLP(2)
  and not HasID(AIMon(),80696379,true)
  then
    return true
  end
  if mode == 2 
  and BattlePhaseCheck()
  and NotNegated(c)
  and CardsMatchingFilter(OppMon(),FilterPosition,POS_FACEDOWN_DEFENSE)>0
  and not HasID(AIMon(),80696379,true)
  then
    return true
  end
  if mode == 3
  and OppHasStrongestMonster()
  and OppGetStrongestAttDef()<=c.attack
  then
    return true
  end
end
function EhrenFilter(c,prio)
  return (PriorityTarget(c) or FilterPrivate(c) or not prio)
  and FilterPosition(c,POS_DEFENSE)
  and Affected(c,TYPE_MONSTER,4)
  and not FilterAffected(c,EFFECT_CANNOT_BE_BATTLE_TARGET)
end
function SummonEhren(c)
  return CardsMatchingFilter(OppMon(),EhrenFilter,true)>0
end
function ScarlightFilter(c,source)
  return not CardsEqual(c,source)
  and FilterSummon(c,SUMMON_TYPE_SPECIAL)
  and FilterAttackMax(c,source.attack)
  and DestroyCheck(c)
  and Affected(c,TYPE_MONSTER,8)
end
function UseScarlight(c,mode)
  local opptargets = CardsMatchingFilter(OppMon(),ScarlightFilter,c)
  local aitargets = CardsMatchingFilter(AIMon(),ScarlightFilter,c)
  local targets = aitargets+opptargets
  if mode == 1 
  and targets*500>AI.GetPlayerLP(2)
  then
    return true
  end
  if mode == 1
  and opptargets == #OppMon()
  and BattlePhaseCheck()
  and targets*500+c.attack>AI.GetPlayerLP(2)
  then
    return true
  end
  if mode == 2
  and (opptargets-aitargets>1 or aitargets==0)
  then
    return true
  end
end
function SummonScarlight(c,mode)
  local opptargets = CardsMatchingFilter(OppMon(),ScarlightFilter,c)
  local aitargets = CardsMatchingFilter(AIMon(),ScarlightFilter,c)
  if FilterLocation(c,LOCATION_EXTRA) then aitargets = math.max(0,aitargets-2) end
  local targets = aitargets+opptargets
  if mode == 1 
  and targets*500>AI.GetPlayerLP(2)
  and NotNegated(c)
  then
    return true
  end
  if mode == 1
  and opptargets == #OppMon()
  and BattlePhaseCheck()
  and targets*500+c.attack>AI.GetPlayerLP(2)
  and NotNegated(c)
  then
    return true
  end
  if mode == 2
  and (opptargets-aitargets>2 or opptargets>1 and aitargets ==0)
  and NotNegated(c)
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
function LightswornInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,80666118,UseScarlight,1) then
    return Activate()
  end
  if HasID(SpSum,80666118,SummonScarlight,1) then
    return SynchroSummon()
  end
  if HasID(Act,01845204,UseIFLS,5) then
    return Activate()
  end
  if HasID(Act,67441435,SummonBulb,2) then
    OPDSet(67441435)
    return Activate()
  end
  if HasID(Sum,67441435,SummonBulb,2) then
    return Summon()
  end
  
  if HasIDNotNegated(Act,77558536,UseRaiden) then
    return Activate()
  end
  if HasIDNotNegated(Act,30100551,UseMinerva) then
    return Activate()
  end
  if HasIDNotNegated(Act,22624373,UseLyla) then
    return Activate()
  end
  
  if HasIDNotNegated(Act,80666118,UseScarlight,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,57774843,UseJD) then
    return Activate()
  end
  if HasID(SpSum,80666118,SummonScarlight,2) then
    return SynchroSummon()
  end
  if HasID(Act,01845204,UseIFLS,6) then
    return Activate()
  end
  if HasID(Act,67441435,SummonBulb,3) then
    OPDSet(67441435)
    return Activate()
  end
  if HasID(Sum,67441435,SummonBulb,3) then
    return Summon()
  end
  
  if HasID(SpSum,74586817,SummonOmega,4) then
    return SynchroSummon()
  end
  if HasID(SpSum,57774843,SummonJD,1) then
    return SpSummon()
  end
  if HasID(SpSum,73580471,SummonBlackRose) then
    return SpSummon()
  end
  if HasID(SpSum,52687916,SummonSyncTrishula) then
    return SpSummon()
  end
  
  -- Trishula enabling
  for i=1,#Sum do
    if TrishulaCheck(Sum[i]) then
      return Summon(i)
    end
  end
  if HasID(Act,01845204,UseIFLS,1) then
    return Activate()
  end
  if HasID(Act,67441435,SummonBulb,1) then
    OPDSet(67441435)
    return Activate()
  end
  
  if HasIDNotNegated(Act,74586817,UseOmega) then
    return Activate()
  end
  if HasIDNotNegated(Act,32807846) then
    return Activate()
  end
  if HasIDNotNegated(Act,94886282,UseCharge) then
    return Activate()
  end
  if HasIDNotNegated(Act,00691925,UseRecharge) then
    return Activate()
  end
  if HasIDNotNegated(Act,95503687,UseLumina) then
    return Activate()
  end
  
  if HasID(SpSum,4779823,SummonMichael,1) then
    return SynchroSummon()
  end
  if HasID(SpSum,74586817,SummonOmega,1) then
    return SynchroSummon()
  end
  if HasID(Act,01845204,UseIFLS,4) then
    return Activate()
  end
  if HasID(SpSum,80696379,SummonMeteorburst,2) then
    return SynchroSummon()
  end
  if HasIDNotNegated(SpSum,56832966,SummonUtopiaLightning,1) then
    return XYZSummon()
  end
  if HasID(SpSum,84013237,SummonUtopia,1) then
    return XYZSummon()
  end 
  if HasID(SpSum,74586817,SummonOmega,2) then
    return SynchroSummon()
  end
  if HasIDNotNegated(SpSum,82633039) and SummonSkyblaster() then 
    return XYZSummon()
  end
  if HasID(SpSum,30100551,SummonMinerva,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(Act,00581014,false,9296225,UseEmeral) then
    return Activate()
  end
  if HasIDNotNegated(SpSum,00581014,SummonEmeralLS) then
    return XYZSummon()
  end
  if HasID(SpSum,74586817,SummonOmega,3) then
    return SynchroSummon()
  end
  if HasID(SpSum,80696379,SummonMeteorburst,3) then
    return SynchroSummon()
  end
  
  if HasID(SpSum,57774843,SummonJD,2) then
    return SpSummon()
  end
  
  if HasID(Sum,95503687,SummonLumina) then
    return Summon()
  end
  if HasID(Sum,77558536,SummonRaiden) then
    return Summon()
  end
  if HasID(Sum,22624373,SummonLyla) then
    return Summon()
  end
  if HasID(Sum,44178886,SummonEhren) then
    return Summon()
  end
  if HasID(Sum,59019082,SummonGaroth) then
    return Summon()
  end
  for i=1,#Sum do
    if SummonLightsworn(Sum[i],1) then
      return Summon(i)
    end
  end
  for i=1,#Sum do
    if SummonLightsworn(Sum[i],3) then
      return Summon(i)
    end
  end
  if HasID(Act,81439173,UseFoolishLS,1) then
    return Activate()
  end
  if HasID(Act,1845204,UseIFLS,2) then
    return Activate()
  end
  for i=1,#Sum do
    if SummonLightsworn(Sum[i],2) then
      return Summon(i)
    end
  end
  if HasID(SpSum,57774843,SummonJD,3) then
    return SpSummon()
  end
  if HasID(Act,1845204,UseIFLS,3) then
    return Activate()
  end
  if HasID(SetMon,69764158,SetMonster) then
    return Set()
  end
  if HasID(SetMon,34710660,SetMonster) then
    return Set()
  end
  if HasID(SetMon,67441435,SetMonster) then
    return Set()
  end
  return nil
end
function FelisTarget(cards)
  return BestTargets(cards,1,TARGET_DESTROY)
end
function FilterPero(card)
  local result = true
  for i,c in pairs(GlobalPeroTargets) do
    if CardsEqual(c,card) then
      result = false
    end
  end
  return result
end
GlobalPeroTargets={}
function PeroperoTarget(cards)
  BestTargets(cards,1,TARGET_DESTROY,FilterPero)
  table.insert(GlobalPeroTargets,1,cards[1])
  return {cards[1].index}
end
function MichaelTarget(cards,c)
  local result = {}
  if FilterLocation(c,LOCATION_MZONE) then
    result = BestTargets(cards,1,TARGET_BANISH)
  else
    result = CopyTable(cards)
    Add(result,PRIO_TODECK)
    table.sort(result,function(a,b) return a.prio<b.prio end)
    local lastname = nil
    local delete ={}
    for i,c in pairs(result) do
      if lastname~=c.id and #delete<3 then
        delete[#delete+1]=i
        lastname=c.id
      end
    end
    for i=#delete,1,-1 do
      table.remove(result,delete[i])
    end
    for i,c in pairs(result) do
      result[i]=c.index
    end
  end
  return result
end
function OmegaTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_TODECK)
  end
  return Add(cards,PRIO_TOGRAVE,1,FilterOwner)
end
function LightswornCard(cards,min,max,id,c)
  if id == 73176465 then
    return FelisTarget(cards)
  end
  if id == 69764158 then
    return PeroperoTarget(cards)
  end
  if id == 74586817 then
    return OmegaTarget(cards)
  end
  return nil
end
function ChainLSJudgment(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  e,card,id=EffectCheck(player_ai)
  if e and e:IsHasCategory(CATEGORY_DECKDES) 
  and HasID(AIDeck(),57774843,true)
  and LightswornMonsterFilter(card)
  and FilterLocation(c,LOCATION_SZONE)
  then
    return true
  end
  return false
end
GlobalPero=0
function ChainPero(c)
  if not UnchainableCheck(c.id) then
    --return false
  end
  if DestroyCheck(OppField())>GlobalPero
  then
    GlobalPero=GlobalPero+1
    return true
  else  
    GlobalPero=0
    return false
  end
end
function ChainRainboh(c)
  if not UnchainableCheck(c.id) then
    return false
  end
  local aimon,oppmon=GetBattlingMons()
  if FilterLocation(c,LOCATION_HAND) then
    if WinsBattle(oppmon,aimon) then
      return true
    end
    if BattleDamage(aimon,oppmon)>=.8*AI.GetPlayerLP(1) 
    then
      return true
    end
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    if BattleDamage(nil,oppmon)>.8*AI.GetPlayerLP(1) then
      return true
    end
  end
end
function ChainETurtle(c) 
  if not UnchainableCheck(c.id) then
    return false
  end
  if #AIMon()==0 and ExpectedDamage()>=0.8*AI.GetPlayerLP(1) then
    return true
  end
  if OppHasStrongestMonster() and #AIMon()>0 then
    return true
  end
end
function ChainMichael(c)
  return CardsMatchingFilter(AIGrave(),LighswornMonsterFilter)>4
  and LightswornNameCheck(AIGrave())>=4
end
function ChainOmega(c)
  if Duel.GetCurrentPhase()==PHASE_STANDBY then
    return #AIBanish()>0
  end
  if RemovalCheckCard(c) or NegateCheckCard(c) then
    return true
  end
  if Duel.CheckTiming(TIMING_MAIN_END) 
  and BattlePhaseCheck()
  and OppHasStrongestMonster()
  then
    return true
  end
end
function LightswornChain(cards)
  if Duel.GetCurrentChain()<=GlobalChain then
    GlobalPero=0
    GlobalPeroTargets={}
  end
  if HasID(cards,69764158,ChainPero) then
    return Chain()
  end
  if HasID(cards,02830693,ChainRainboh) then
    return Chain()
  end
  if HasID(cards,34710660,ChainETurtle) then
    return Chain()
  end
  if HasID(cards,66194206,ChainLSJudgment) then
    return Chain()
  end
  if HasID(cards,04779823,ChainMichael) then
    return Chain()
  end
  if HasID(cards,74586817,ChainOmega) then
    return Chain()
  end
  return nil
end
function LightswornEffectYesNo(id,card)
  if id == 69764158 and ChainPero(card) then
    return true
  end
  if id == 02830693 and ChainRainboh(card) then
    return true
  end
  if id == 34710660 and ChainETurtle(card) then
    return true
  end
  if id == 66194206 and ChainLSJudgment(card) then
    return true
  end
  if id == 04779823 and ChainMichael(card) then
    return true
  end
  if id == 74586817 and ChainOmega(card) then
    return true
  end
  return nil
end
function LightswornYesNo(desc)
end
function LightswornTribute(cards,min, max)
end
function LightswornBattleCommand(cards,targets,act)
  SortByATK(cards)
  if HasIDNotNegated(cards,44178886) 
  and CardsMatchingFilter(OppMon(),EhrenFilter)>0 
  then
    return Attack(CurrentIndex)
  end
end
function LightswornAttackTarget(cards,attacker)
  if attacker.id == 44178886 then
    return BestTargets(cards,1,TARGET_TODECK,EhrenFilter)
  end
end
function JainBoost(c)
  return FilterID(c,96235275)
  and FilterController(c,1)
  and NotNegated(c)
end
function LightswornAttackBoost(cards)
  for i,c in pairs(cards) do
    if JainBoost(c) then 
      c.attack=c.attack+300
    end
  end
end
function LightswornOption(options)
end
function LightswornChainOrder(cards)
end
LightswornAtt={
57774843, -- JD
58996430, -- Wulf
59019082, -- Garoth
96235275, -- Jain
77558536, -- Raiden
22624373, -- Lyla
44178886, -- Ehren

52687916, -- Trishula
74586817, -- Omega
04779823, -- Michael
80696379, -- Meteorburst
82044279, -- Clear Wing
73580471, -- Black Rose
56832966, -- Utopia Lightning
84013237, -- Utopia
21501505, -- Cairngorgon
82633039, -- Castel
30100551, -- Minerva
00581014, -- Emeral
21044178, -- Dweller
}
LightswornVary={
95503687, -- Lumina
}
LightswornDef={
73176465, -- Felis
34710660, -- Electromagnetic Turtle

40164421, -- Minerva
69764158, -- Peropero
02830693, -- Rainbow Kuriboh
67441435, -- Glow-Up Bulb
}
function LightswornPosition(id,available)
  result = nil
  for i=1,#LightswornAtt do
    if LightswornAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#LightswornVary do
    if LightswornVary[i]==id 
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
  for i=1,#LightswornDef do
    if LightswornDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end

