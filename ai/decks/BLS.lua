--[[
05405694, -- BLS Vanilla
72989439, -- BLS Envoy
07841921, -- Charging Gaia
61901281, -- Collapserpent
99234526, -- Wyverbuster
38695361, -- Envoy of Chaos
95492061, -- Manju
06628343, -- Beginning Knight
32013448, -- Evening Twilight Knight
54484652, -- BLSSS

01845204, -- Instant Fusion
32807846, -- RotA
35261759, -- Desires
38120068, -- Trade-In
70368879, -- Upstart
73628505, -- Terraforming
14094090, -- SSRitual
45948430, -- SSOrigin
43898403, -- Twin Twister
40089744, -- Gateway to Chaos

40605147, -- Strike
84749824, -- Warning
32360466, -- Universal Beginning

17412721, -- Norden
58820923, -- Dark Matter
39030163, -- Full Armor
31801517, -- Galaxy Prime
63767246, -- Titanic
56832966, -- Utopia Lightning
84013237, -- Utopia
21501505, -- Cairngorgon
94380860, -- Ragnazero
48739166, -- 101
63746411, -- Giant Hand
82633039, -- Castel
95169481, -- DDW
21044178, -- Dweller
12014404, -- Cowboy
]]

function BLSStartup(deck)
  deck.Init                 = BLSInit
  deck.Card                 = BLSCard
  deck.Chain                = BLSChain
  deck.EffectYesNo          = BLSEffectYesNo
  deck.Position             = BLSPosition
  deck.YesNo                = BLSYesNo
  deck.BattleCommand        = BLSBattleCommand
  deck.AttackTarget         = BLSAttackTarget
  deck.AttackBoost          = BLSAttackBoost
  deck.Tribute              = BLSTribute
  deck.Option               = BLSOption
  deck.ChainOrder           = BLSChainOrder
  deck.Sum                  = BLSSum
  --[[
  
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = BLSActivateBlacklist
  deck.SummonBlacklist      = BLSSummonBlacklist
  deck.RepositionBlacklist  = BLSRepoBlacklist
  deck.SetBlacklist         = BLSSetBlacklist
  deck.Unchainable          = BLSUnchainable
  --[[
  
  ]]
  deck.PriorityList         = BLSPriorityList
end
BLSIdentifier = 54484652 -- BLS Super Soldier
DECK_BLS = NewDeck("BLS",BLSIdentifier,BLSStartup) 
BLSActivateBlacklist={
05405694, -- BLS Vanilla
72989439, -- BLS Envoy
07841921, -- Charging Gaia
38695361, -- Envoy of Chaos
95492061, -- Manju
06628343, -- Beginning Knight
32013448, -- Evening Twilight Knight
54484652, -- BLSSS
04810828, -- Sauravis

01845204, -- Instant Fusion
35261759, -- Desires
14094090, -- SSRitual
45948430, -- SSOrigin
40089744, -- Gateway to Chaos

32360466, -- Universal Beginning

17412721, -- Norden
58820923, -- Dark Matter
39030163, -- Full Armor
31801517, -- Galaxy Prime
95169481, -- DDW
85115440, -- Zodiac Beast Bullhorn
48905153, -- Zodiac Beast Drancia
}
BLSSummonBlacklist={
72989439, -- BLS Envoy
07841921, -- Charging Gaia
61901281, -- Collapserpent
99234526, -- Wyverbuster
38695361, -- Envoy of Chaos
95492061, -- Manju
06628343, -- Beginning Knight
32013448, -- Evening Twilight Knight

58820923, -- Dark Matter
39030163, -- Full Armor
31801517, -- Galaxy Prime
63767246, -- Titanic
95169481, -- DDW
85115440, -- Zodiac Beast Bullhorn
48905153, -- Zodiac Beast Drancia
}
BLSSetBlacklist={
45948430, -- SSOrigin
}
BLSRepoBlacklist={
}
BLSUnchainable={
48905153, -- Drancia
}
function BLSFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0x10cf) and check
end
function GaiaFilter(c,exclude)
  local check = true
  if exclude then
    if type(exclude)=="table" then
      check = not CardsEqual(c,exclude)
    elseif type(exclude)=="number" then
      check = (c.id ~= exclude)
    end
  end
  return FilterSet(c,0xbd) and check
end
function BLSMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and BLSFilter(c,exclude)
end
function SummonBLSSS(c,mode)
  if mode == 1
  and NotNegated(c)
  and not HasIDNotNegated(AIMon(),c.id,true)
  then
    return true
  end
end
function UseSSOrigin(c,mode)
  if not MaxxCheck() then return false end
  if mode == 1 
  and HasID(AIGrave(),54484652,SummonBLSSS,1) -- BLSSS
  then
    return true
  end
  if mode == 2
  and HasID(AIHand(),54484652,SummonBLSSS,1) -- BLSSS
  then
    return true
  end
  if mode == 3
  and (#OppMon()>0 and (#AIMon()==0 or OppHasStrongestMonster()))
  then
    return true
  end
end
function BLSBanishFilter(c,source)
  return Affected(c,TYPE_MONSTER,source.level)
  and Targetable(c,TYPE_MONSTER)
end
function UseBLSSS(c,mode)
  if mode == 1
  and (c.description == 32013448*16
  or c.description == 06628343* 16)
  and CardsMatchingFilter(OppMon(),BLSBanishFilter,c)>0
  then
    return true
  end
  if mode == 2
  and c.description == 32013448*16+1
  then
    return true
  end
end
function UseChaosGateway(c,mode)
  if mode == 1 -- activate from hand
  and FilterLocation(c,LOCATION_HAND)
  and not HasIDNotNegated(AIST(),c.id,true)
  then
    return true
  end
  if mode == 2 -- activate on field
  and FilterLocation(c,LOCATION_ONFIELD) 
  and FilterPosition(c,POS_FACEUP)
  then
    return true
  end
  if mode == 3 -- activate face-down
  and FilterLocation(c,LOCATION_ONFIELD) 
  and FilterPosition(c,POS_FACEDOWN)
  then
    return true
  end
end
function SummonWyverbusterBLS(c,mode)
  if mode == 1
  and HasID(AIGrave(),32013448,true,FilterOPT,true) -- Twilight Knight
  and MaxxCheck()
  then
    return true
  end
  if mode == 2
  and PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_DARK)>3
  and MaxxCheck()
  then
    return true
  end
end
function SummonCollapserpentBLS(c,mode)
  if mode == 1
  and HasID(AIGrave(),06628343,true,FilterOPT,true) -- Beginning Knight
  and MaxxCheck()
  then
    return true
  end
  if mode == 2
  and PriorityCheck(AIGrave(),PRIO_BANISH,1,FilterAttribute,ATTRIBUTE_LIGHT)>3
  and MaxxCheck()
  then
    return true
  end
end
function UseTradeInBLS(c,mode)
  if mode == 1 then
    return HasID(AIHand(),54484652,true)
    or HasID(AIHand(),05405694,true)
  end
  if mode == 2 then
    return true
  end
end
function UseTerraformingBLS(c,mode)
  if mode == 1 then
    return true
  end
end
function SummonManjuBLS(c,mode)
  if mode == 1 then
    return true
  end
end
function SummonChargingGaia(c,mode)
  if mode == 1 then
    return true
  end
end
function SummonBLSKnight(c,mode)
  if mode == 1
  and FieldCheck(4)>0
  and c.level == 4
  and CardsMatchingFilter(AIExtra(),FilterRank,4)>0
  and CanSpecialSummon()
  then
    return true
  end
  if mode == 2
  and #AIMon()==0
  and c.attack>=1500
  and (#OppMon()==0 
  or CanWinBattle(c,OppMon()))
  then
    return true
  end
end
function SetBLSKnight(c,mode)
  if mode == 1
  and not HasID(AIGrave(),c.id,true)
  and TurnEndCheck()
  and #AIMon()==0
  and c.level<5
  then
    return true
  end
  if mode == 2
  and TurnEndCheck()
  and #AIMon()==0
  and c.level<5
  then
    return true
  end
end
function SummonBLSEnvoy(c,mode)
  if mode == 1
  and (#AIMon()==0 or OppHasStrongestMonster)
  and ChaosSummonCheck()>3
  and MaxxCheck()
  then
    return true
  end
  if mode == 2
  and (#OppMon()>0 and (#AIMon()==0 or OppHasStrongestMonster()))
  and MaxxCheck()
  then
    return true
  end
end
function UseTwinTwisterBLS(c,mode)
  local targets = DestroyCheck(OppST(),nil,true)
  if mode == 1
  and HasID(AIHand(),06628343,true,FilterOPT,true) -- Beginning Knight
  and CardsMatchingFilter(AIGrave(),FilterID,06628343)==0 -- Beginning Knight
  and CardsMatchingFilter(AICards(),FilterID,45948430)==0 -- SSOrigin
  and targets>0
  then
    return true
  end
  if mode == 2
  and HasID(AIHand(),32013448,true,FilterOPT,true) -- Twilight Knight
  and CardsMatchingFilter(AIGrave(),FilterID,32013448)==0 -- Twilight Knight
  and (not HasAccess(54484652) or HasIDNotNegated(AICards(),38120068,true)) -- BLSSS, Trade-in
  and targets>0
  then
    return true
  end
end
function SSRitualTributeCheck(source)
  source = source or FindID(54484652,AIHand())
  source = source or FindID(05405694,AIHand())
  local targets = {}
  for i,c in pairs(AICards()) do
    if FilterType(c,TYPE_MONSTER)
    and CardsNotEqual(c,source)
    and (FilterLevel(c,4) 
    or FilterLevel(c,8) 
    and (FilterLocation(c,LOCATION_HAND)
    or FilterCrippled(c)))
    then
      table.insert(targets,c)
    end
  end
  if CardsMatchingFilter(targets,FilterLevel,4)>1
  or CardsMatchingFilter(targets,FilterLevel,8)>0
  then
    return true
  end
end
function UseSSRitual(c,mode)
  if not MaxxCheck() then return false end
  if mode == 1
  and FilterLocation(c,LOCATION_GRAVE)
  and (#AIMon()==0 or OppHasStrongestMonster())
  and ChaosSummonCheck()>3
  then
    return true
  end
  if mode == 2
  and not FilterLocation(c,LOCATION_GRAVE)
  and (SSRitualTributeCheck(FindID(54484652,AIHand())) -- BLSSS
  or SSRitualTributeCheck(FindID(05405694,AIHand()))) -- BLS Vanilla
  and not HasID(AIMon(),54484652,true,FilterNotCrippled)
  then
    return true
  end
  if mode == 3
  and (#OppMon()>0 and (#AIMon()==0 or OppHasStrongestMonster()))
  then
    return true
  end
end
function UseBeginning(c,mode)
  if mode == 1
  then
    return true
  end
end

function DDWFilter(c,backrow)
  return Affected(c,TYPE_MONSTER,4)
  and Targetable(c,TYPE_MONSTER)
  and DestroyFilterIgnore(c)
  and (not backrow 
  or FilterType(c,TYPE_SPELL+TYPE_TRAP)
  and FilterPosition(c,POS_FACEDOWN))
end
function SummonDDWBLS(c,mode)
  if not MaxxCheck() then return false end
  if mode == 1
  and CardsMatchingFilter(OppField(),DDWFilter)>0
  and ChaosSummonCheck()<4
  and (HasID(AIHand(),72989439,true) -- BLS Envoy
  or HasID(AIGrave(),14094090,true)  -- SS Ritual
  and (HasID(AIHand(),05405694,true) -- BLS Vanilla
  or HasID(AIHand(),54484652,true))) -- BLSSS
  and not HasID(AIMon(),54484652,true,FilterNotCrippled) -- BLSSS
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(OppField(),DDWFilter,true)>0
  then
    return true
  end
  if mode == 3
  and MP2Check()
  and CardsMatchingFilter(OppField(),DDWFilter,true)>0
  then
    return true
  end
end
function UseDDWBLS(c,mode)
  if mode == 1
  and CardsMatchingFilter(OppField(),DDWFilter)>0
  and PriorityCheck(AIMon(),PRIO_TOGRAVE,1,FilterRace,RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST)>3
  then
    return true
  end
  if mode == 2
  and CardsMatchingFilter(OppField(),DDWFilter,true)>0
  then
    return true
  end
  if mode == 3
  and CardsMatchingFilter(OppField(),DDWFilter)>0
  and OppHasStrongestMonster()
  then
    return true
  end
  if mode == 4
  and MP2Check()
  and CardsMatchingFilter(OppField(),DDWFilter)>0
  then
    return true
  end
end
function UseIFBLS(c,mode)
  if not (WindaCheck() 
  and CanSpecialSummon()
  and AI.GetPlayerLP(1)>1000) 
  then 
    return false 
  end
  if mode == 1 
  and CardsMatchingFilter(AIGrave(),NodenFilter,4)>0 
  and HasIDNotNegated(AIExtra(),17412721,true) -- Norden
  and OppHasStrongestMonster()
  and SpaceCheck()>1
  and HasIDNotNegated(AICards(),14094090,true) -- SSRitual
  and (HasID(AIHand(),05405694,true)
  or HasID(AIHand(),54484652,true)) 
  and not SSRitualTributeCheck()
  then
    return true
  end
end
function BLSInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasIDNotNegated(Act,81439173) then -- test
    return Activate()
  end
  if HasIDNotNegated(Act,32360466,UseBeginning,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,32807846) then -- RotA
    return Activate()
  end
  if HasIDNotNegated(Act,43898403,UseTwinTwisterBLS,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,43898403,UseTwinTwisterBLS,2) then
    return Activate()
  end
  for mode=1,4 do
    if HasIDNotNegated(Act,95169481,UseDDWBLS,mode) then
      return Activate()
    end
  end
  if HasIDNotNegated(Act,73628505,UseTerraformingBLS,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,40089744,UseChaosGateway,2) then
    return Activate()
  end
  if HasIDNotNegated(Act,40089744,UseChaosGateway,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,40089744,UseChaosGateway,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,54484652,UseBLSSS,1) then -- banish monster on field
    return Activate()
  end   
  if HasIDNotNegated(Act,54484652,UseBLSSS,2) then -- banish from hand
    return Activate()
  end 
  if HasIDNotNegated(Act,05405694,UseBLSSS,1) then -- banish monster on field
    return Activate()
  end   
  if HasIDNotNegated(Act,05405694,UseBLSSS,2) then -- banish from hand
    return Activate()
  end 
  if HasIDNotNegated(Act,38120068,UseTradeInBLS,1) then
    return Activate()
  end
  
  if HasIDNotNegated(Act,45948430,UseSSOrigin,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,45948430,UseSSOrigin,2) then
    return Activate()
  end
  
  if HasID(SpSum,61901281,SummonCollapserpentBLS,1) then
    return SpSummon()
  end
  if HasID(SpSum,99234526,SummonWyverbusterBLS,1) then
    return SpSummon()
  end
  if HasIDNotNegated(Sum,95492061,SummonManjuBLS,1) then
    return Summon()
  end
  if HasID(SpSum,06628343,SummonBeginningKnight,1) then
    return SpSummon()
  end
  if HasID(SpSum,32013448,SummonTwilightKnight,1) then
    return SpSummon()
  end

  if HasIDNotNegated(Act,14094090,UseSSRitual,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,14094090,UseSSRitual,2) then
    return Activate()
  end
  
  if HasID(SpSum,72989439,SummonBLSEnvoy,1) then
    return SpSummon()
  end
  if HasID(SpSum,61901281,SummonCollapserpentBLS,2) then
    return SpSummon()
  end
  if HasID(SpSum,99234526,SummonWyverbusterBLS,2) then
    return SpSummon()
  end
  if HasIDNotNegated(Act,38120068,UseTradeInBLS,2) then
    return Activate()
  end
  local knights = {07841921,06628343,32013448,38695361} -- Beginning Knight, Twilight Knight, Envoy of Chaos
  for mode=1,2 do
    for i,id in pairs(knights) do
      if HasID(Sum,id,SummonBLSKnight,mode) then
        return Summon()
      end
    end
  end
  if HasIDNotNegated(SpSum,56832966,SummonUtopiaLightning,1) then
    return XYZSummon()
  end
  if HasID(SpSum,84013237,SummonUtopia,1) then
    return XYZSummon()
  end 
  if HasID(SpSum,94380860,SummonRagnaZero) then
    return XYZSummon()
  end 
  if HasID(SpSum,95169481,SummonDDWBLS,1) then
    return XYZSummon()
  end 
  if HasIDNotNegated(SpSum,63746411) and SummonGiantHand() then
    return XYZSummon()
  end
  if HasID(SpSum,21501505,SummonCairngorgon) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,48905153,SummonDrancia,1) then
    return SpSummon()
  end
  if HasIDNotNegated(SpSum,85115440,SummonBullhorn,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,85115440,SummonBullhorn,2) then
    return XYZSummon()
  end  
  if HasIDNotNegated(SpSum,21044178,SummonDweller,1) then
    return XYZSummon()
  end
  if HasIDNotNegated(SpSum,82633039) and SummonSkyblaster() then 
    return XYZSummon()
  end
  if HasID(SpSum,95169481,SummonDDWBLS,2) then
    return XYZSummon()
  end 
  if HasID(SpSum,84013237,SummonUtopia,2) then
    return XYZSummon()
  end 

  if HasIDNotNegated(SpSum,21044178,SummonDweller,2) then
    return XYZSummon()
  end


  if HasID(SpSum,95169481,SummonDDWBLS,3) then
    return XYZSummon()
  end 
  if HasID(SpSum,84013237,SummonUtopia,3) then
    return XYZSummon()
  end 
  if HasIDNotNegated(SpSum,21044178,SummonDweller,3) then
    return XYZSummon()
  end
  if HasID(SpSum,72989439,SummonBLSEnvoy,2) then
    return SpSummon()
  end
  if HasIDNotNegated(Act,45948430,UseSSOrigin,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,14094090,UseSSRitual,3) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseInstantFusion,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseInstantFusion,5) then
    return Activate()
  end
  if HasIDNotNegated(Act,01845204,UseIFBLS,1) then
    return Activate()
  end
  for mode=1,2 do
    for i,id in pairs(knights) do
      if HasID(SetMon,id,SetBLSKnight,mode) then
        return Set()
      end
    end
  end
  return nil
end
function SSOriginTarget(cards,c)
  if FilterType(cards[1],TYPE_RITUAL) then
    return Add(cards,PRIO_TOFIELD,1,FilterLocation,LOCATION_GRAVE)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function BLSSSTarget(cards,c)
  if GaiaFilter(cards[1]) and FilterController(c,1) then
    return Add(cards,PRIO_TOFIELD)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return RandomTargets(cards)
  end
  return BestTargets(cards,1,TARGET_BANISH,BLSBanishFilter,c)
end
function ChaosGatewayTarget(cards,c)
  return Add(cards)
end
function BeginningKnightTarget(cards,c)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    return BestTargets(cards,1,TARGET_BANISH,BLSBanishFilter,c)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return RandomTargets(cards)
  end
  return Add(cards)
end
function TwilightKnightTarget(cards,c)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    return BestTargets(cards,1,TARGET_BANISH,BLSBanishFilter,c)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return RandomTargets(cards)
  end
  return Add(cards)
end
function SSRitualTarget(cards,c,min)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH,min)
  end
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD,min)
  end
end
function EnvoyTarget(cards,c)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return GlobalTargetGet(cards,true)
  end
  return Add(cards)
end
function BeginningTarget(cards,c,min)
  if min>1 then GlobalBeginning = true end
  if min==1 and HasAccess(54484652) -- BLSSS
  and not HasIDNotNegated(AIHand(),38120068,true) -- Trade-In
  then 
    return Add(cards,PRIO_TOGRAVE,min,FilterID,07841921) -- Charging Gaia
  end
  local result = Add(cards,PRIO_TOGRAVE,min)
  GlobalBeginning = false
  return result
end
function DDWTarget(cards,c)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if FilterController(cards[1],1) then
    return BestTargets(cards,1,TARGET_DESTROY,FilterID,c.id)
  end
  return BestTargets(cards,1,TARGET_DESTROY,DDWFilter)
end

BLSTargetFunctions={
[45948430] = SSOriginTarget,
[54484652] = BLSSSTarget,
[40089744] = ChaosGatewayTarget,
[95492061] = ManjuTarget,
[06628343] = BeginningKnightTarget,
[32013448] = TwilightKnightTarget,
[14094090] = SSRitualTarget,
[38695361] = EnvoyTarget,
[32360466] = BeginningTarget,
[95169481] = DDWTarget,
[48905153] = DranciaTarget,
}
function BLSCard(cards,min,max,id,c)
  for i,v in pairs(BLSTargetFunctions) do
    if id == i then
      return v(cards,c,min,max)
    end
  end
end
function ChainBLSSS(c)
  return true
end
function ChainBeginningKnight(c)
  OPTSet(c.id)
  return true
end
function ChainTwilightKnight(c)
  OPTSet(c.id)
  return true
end
function ChainEnvoy(c)
  if FilterLocation(c,LOCATION_GRAVE)
  and ChaosSummonCheck()>3
  then
    local count = 1
    if HasID(AIGrave(),06628343,true,FilterOPT,true) then -- Beginning Knight
      count = count + 1
    end
    if HasID(AIGrave(),32013448,true,FilterOPT,true) then -- Twilight Knight
      count = count + 1
    end
    return Duel.GetTurnPlayer()~=player_ai
    or #AIHand()+count<7
  end
  if FilterLocation(c,LOCATION_HAND) 
  then
    local aimon,oppmon=GetBattlingMons()  
    if aimon and oppmon then
      local malus = oppmon:GetAttack()-oppmon:GetBaseAttack() 
      if (BLSFilter(aimon) or GaiaFilter(aimon))
      and (AttackBoostCheck(1500,malus) 
      or CanFinishGame(aimon,oppmon,nil,1500,malus))
      then
        GlobalCardMode = 1
        GlobalTargetSet(aimon)
        return true
      end
    end
  end
end
function ChainBeginning(c)
  if RemovalCheckCard(c) then
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai
  and Duel.CheckTiming(TIMING_END_PHASE)
  and Duel.GetCurrentChain()==0
  then
    return true
  end
end
function ChainManju(c)
  return true
end
BLSChainFunctions={
[54484652] = ChainBLSSS,
[06628343] = ChainBeginningKnight,
[32013448] = ChainTwilightKnight,
[38695361] = ChainEnvoy,
[32360466] = ChainBeginning,
[48905153] = ChainDrancia, 
[95492061] = ChainManju,
}
function BLSChain(cards)
  for id,v in pairs(BLSChainFunctions) do
    if HasID(cards,id,v) then
      return Chain()
    end
  end
end
function BLSEffectYesNo(id,card)
  for i,v in pairs(BLSChainFunctions) do
    if id == i then
      return v(card)
    end
  end
  if id==06628343 then -- Beginning Knight
    GlobalBLS = Duel.GetTurnCount()
    return 1
  end
  if id==72989439 then -- BLS Envoy
    GlobalBLS = Duel.GetTurnCount()
    return 1
  end
  return result
end
function BLSSum(cards,sum,card)
  local id = nil
  if card then
    id = card.id
  end
  if id == 14094090 then -- SSRitual
    local result = {}
    if CardsMatchingFilter(cards,FilterLevel,4)>1
    then
      result = Add(cards,PRIO_TOGRAVE,2,FilterLevel,4)
    end
    if CardsMatchingFilter(cards,FilterLevel,8)>0
    then
      result = Add(cards,PRIO_TOGRAVE,1,FilterLevel,8)
    end
    if #result>0 then
      return result
    end
  end
end
function BLSYesNo(desc)
end
function BLSTribute(cards,min, max)
end
function BLSBattleCommand(cards,targets,act)
  -- BLSSS
  if HasIDNotNegated(cards,54484652) 
  and (CanWinBattle(cards[CurrentIndex],targets) 
  or #OppMon()==0 and GlobalBLS==Duel.GetTurnCount())
  then 
    return Attack(CurrentIndex)
  end
  -- BLS Vanilla
  if HasIDNotNegated(cards,05405694) 
  and (CanWinBattle(cards[CurrentIndex],targets) 
  or #OppMon()==0 and GlobalBLS==Duel.GetTurnCount())
  then 
    return Attack(CurrentIndex)
  end
end
function BLSAttackTarget(cards,attacker)
end
function BLSAttackBoost(cards)
 -- Envoy of Chaos
  for i=1,CardsMatchingFilter(AIHand(),FilterID,38695361) do
    for j,c in pairs(cards) do
      if (BLSFilter(c) or GaiaFilter(c))
      and Affected(c,TYPE_MONSTER,4)
      and Targetable(c,TYPE_MONSTER)
      and CurrentOwner(c)==1
      then
        c.attack=c.attack+1500
        if c.bonus==nil then
          c.bonus=0
        end
        c.bonus=c.bonus+1500
      end
      if (CardsMatchingFilter(AIMon(),BLSFilter)>0
      or CardsMatchingFilter(AIMon(),GaiaFilter)>0)
      then
        if Affected(c,TYPE_MONSTER,4)
        and CurrentOwner(c)==2
        and c.attack-c.base_attack>1500
        then
          c.attack=c.base_attack
        end
      end
    end
  end
end
function BLSOption(options)
end
function BLSChainOrder(cards)
end
BLSAtt={
05405694, -- BLS Vanilla
72989439, -- BLS Envoy
07841921, -- Charging Gaia
61901281, -- Collapserpent
99234526, -- Wyverbuster
38695361, -- Envoy of Chaos
95492061, -- Manju
54484652, -- BLSSS
04810828, -- Sauravis
}
BLSVary={
}
BLSDef={
06628343, -- Beginning Knight
32013448, -- Evening Twilight Knight
}
function BLSPosition(id,available)
  result = nil
  for i=1,#BLSAtt do
    if BLSAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#BLSVary do
    if BLSVary[i]==id 
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
  for i=1,#BLSDef do
    if BLSDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  return result
end
function BLSVanillaCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOGRAVE then
    return true
  end
  return true
end
function BeginningKnightCond(loc,c) 
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id)
  end
  if loc == PRIO_TOGRAVE then
    if GetMultiple(c.id)>0 then
      return false
    end
    if CardsMatchingFilter(AIGrave(),FilterID,c.id)==0
    and CardsMatchingFilter(AICards(),FilterID,45948430)==0
    and FilterOPT(c,true)
    then
      return 10
    end
    return true
  end
  if loc == PRIO_BANISH then
    return FilterOPT(c,true)
  end
  return true
end
function TwilightKnightCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id)
  end
  if loc == PRIO_TOGRAVE then
    if GetMultiple(c.id)>0 then
      return false
    end
    if CardsMatchingFilter(AIGrave(),FilterID,c.id)==0
    and CardsMatchingFilter(Merge(AICards(),AIGrave()),FilterID,54484652)==0
    and FilterOPT(c,true)
    then
      return 9
    end
    return true
  end
  if loc == PRIO_BANISH then
    return FilterOPT(c,true)
  end
  return true
end
function BLSSSCond(loc,c)
  if loc == PRIO_TOHAND then
    if HasIDNotNegated(AICards(),38120068,true) 
    and not HasAccess(c.id)
    then
      return 12
    end
    if not HasAccess(c.id) then
      return true
    end
    if HasIDNotNegated(AICards(),38120068,true) then
      return 6
    end
    return false
  end
  if loc == PRIO_TOGRAVE then
    if GetMultiple(c.id)>0 
    or GlobalBeginning
    then
      return false
    end
    return FilterCrippled(c) or not FilterLocation(c,LOCATION_MZONE)
  end
  return true
end
function SSOriginCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AICards(),FilterID,c.id)==0 then
      return true
    end
    return false
  end
  return true
end
function EnvoyCond(loc,c)
  if loc == PRIO_TOGRAVE then
    if (HasID(AIGrave(),32013448,true)
    or HasID(AIGrave(),06628343,true)
    and GlobalBeginning)
    and FilterLocation(c,LOCATION_DECK)
    then
      return 10
    end
  end
  return true
end
function ChargingGaiaCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return not FilterLocation(c,LOCATION_DECK)
  end
  return true
end
BLSPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- BLS

[05405694] = {4,2,4,1,6,3,1,1,2,1,BLSVanillaCond},  -- BLS Vanilla
[72989439] = {1,1,1,1,2,1,1,1,4,1,BLSEnvoyCond},  -- BLS Envoy
[07841921] = {1,1,1,1,5,1,1,1,1,1,ChargingGaiaCond},  -- Charging Gaia
[38695361] = {5,1,1,1,4,1,1,1,1,1,EnvoyCond},  -- Envoy of Chaos

[06628343] = {7,1,1,1,8,1,1,1,9,1,BeginningKnightCond},  -- Beginning Knight
[32013448] = {6,1,1,1,7,1,1,1,8,1,TwilightKnightCond},  -- Evening Twilight Knight
[54484652] = {8,4,9,1,9,1,1,1,1,1,BLSSSCond},  -- BLSSS
[04810828] = {5,1,1,1,1,1,1,1,4,1,SauravisCond},  -- Sauravis

[14094090] = {5,1,1,1,4,1,1,1,1,1,SSRitualCond},  -- SSRitual
[45948430] = {9,5,1,1,1,1,1,1,1,1,SSOriginCond},  -- SSOrigin
[40089744] = {1,1,1,1,2,1,1,1,1,1,ChaosGatewayCond},  -- Gateway to Chaos

[32360466] = {1,1,1,1,1,1,1,1,1,1,UniversalBeginningCond},  -- Universal Beginning

[58820923] = {1,1,1,1,1,1,1,1,4,1,DarkMatterCond},  -- Dark Matter
[39030163] = {1,1,1,1,1,1,1,1,4,1,FullArmorCond},  -- Full Armor
[31801517] = {1,1,1,1,1,1,1,1,4,1,GalaxyPrimeCond},  -- Galaxy Prime
[63767246] = {1,1,1,1,1,1,1,1,4,1,TitanicGalaxyCond},  -- Titanic
[95169481] = {1,1,1,1,1,1,1,1,1,1},  -- DDW
[85115440] = {1,1,1,1,1,1,1,1,1,1},  -- Zodiac Beast Bullhorn
[48905153] = {1,1,1,1,1,1,1,1,1,1},  -- Zodiac Beast Drancia
[56832966] = {1,1,1,1,1,1,1,1,4,1,UtopiaLightningCond},  -- Utopia Lightning
[84013237] = {1,1,1,1,1,1,1,1,4,1,UtopiaCond},  -- Utopia

} 