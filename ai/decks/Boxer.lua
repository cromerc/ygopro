
function BoxerStartup(deck)
  deck.Init                 = BoxerInit
  deck.Card                 = BoxerCard
  deck.Chain                = BoxerChain
  deck.EffectYesNo          = BoxerEffectYesNo
  deck.Position             = BoxerPosition
  deck.YesNo                = BoxerYesNo
  deck.BattleCommand        = BoxerBattleCommand
  deck.AttackTarget         = BoxerAttackTarget
  deck.AttackBoost          = BoxerAttackBoost
  --[[
  deck.Option 
  deck.Sum 
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = BoxerActivateBlacklist
  deck.SummonBlacklist      = BoxerSummonBlacklist
  deck.RepositionBlacklist  = BoxerRepoBlacklist
  deck.Unchainable          = BoxerUnchainable
  --[[
  deck.SetBlacklist
  ]]
  deck.PriorityList         = BoxerPriorityList
end

BoxerIdentifier = 68144350 -- BB Switchitter

DECK_BOXER = NewDeck("Battlin' Boxers",BoxerIdentifier,BoxerStartup) 

BoxerActivateBlacklist={
05361647, -- BB Glassjaw
35537251, -- BB Shadow
53573406, -- Masked Chameleon
68144350, -- BB Switchitter
32750341, -- BB Sparrer
79867938, -- BB Headgeared
13313278, -- BB Veil
04549095, -- BB Counterpunch

32807846, -- RotA
36916401, -- BB Spirit

08316565, -- Jolt Counter

59627393, -- BB Star Cestus
71921856, -- BB Nova Caesar
23232295, -- BB Lead Yoke
34086406, -- Lavalval 
76774528, -- Scrap Dragon
}
BoxerSummonBlacklist={
65367484, -- Thrasher
05361647, -- BB Glassjaw
35537251, -- BB Shadow
53573406, -- Masked Chameleon
68144350, -- BB Switchitter
32750341, -- BB Sparrer
79867938, -- BB Headgeared
13313278, -- BB Veil
04549095, -- BB Counterpunch

59627393, -- BB Star Cestus
71921856, -- BB Nova Caesar
23232295, -- BB Lead Yoke
34086406, -- Lavalval 
76774528, -- Scrap Dragon
83994433, -- Stardust Spark
}
BoxerRepoBlacklist={
79867938, -- BB Headgeared
23232295, -- BB Lead Yoke
}
BoxerUnchainable={
04549095, -- BB Counterpunch
}
function ThrasherCondBoxer(loc,c)
  if loc == PRIO_TOHAND then
    return DualityCheck() and #AIMon()==0
    and (CardsMatchingFilter(AIHand(),BoxerMonsterFilter,04549095)>0
    and not NormalSummonCheck() 
    or BattlePhaseCheck() and OppHasStrongestMonster()
    and OppGetStrongestAttDef()<c.attack)
  end
  return true
end
function GlassjawFilter(c)
  return BoxerMonsterFilter(c,04549095) and not FilterID(c,05361647)
end
function GlassjawCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIGrave(),GlassjawFilter)>0
    or FilterLocation(c,LOCATION_DECK)
    and FieldCheck(4)<2
    and (HasID(AIHand(),68144350,true)
    or HasID(AICards(),32807846,true)
    or HasID(AIHand(),53573406,true) 
    and CardsMatchingFilter(AIGrave(),ChameleonFilter)==0)
    or FilterLocation(c,LOCATION_MZONE)
    --or FilterLocation(c,LOCATION_OVERLAY) and Duel.GetCurrentChain()>0
  end
  return true
end
function ShadowCond(loc,c)
  if loc == PRIO_TOHAND then  
    return HasID(AIMon(),23232295,true,HasMaterials)
    and DualityCheck()
  end
  return true
end
function ChameleonCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),53573406,true)
    and CardsMatchingFilter(UseLists(AIMaterials(),AIGrave()),ChameleonFilter)>0
  end
  return true
end
function SwitchitterCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),68144350,true)
    and not HasID(AIMon(),23232295,true)
    and (SummonSwitchitter(c)
    or FilterLocation(c,LOCATION_GRAVE))
  end
  if loc == PRIO_TOGRAVE then
    return not HasAccess(68144350)
    and (not HasID(AICards(),32807846,true))
    or FilterLocation(c,LOCATION_OVERLAY)
    or FieldCheck(4)==2 and CardsMatchingFilter(AIGrave(),GlassjawFilter)==0
  end
  return true
end
function SparrerCond(loc,c)
  return true
end
function HeadgearedCond(loc,c)
  if loc == PRIO_TOHAND then
    return HasID(AIHand(),65367484,true)
    and not NormalSummonCheck()
    and not SummonSwitchitter()
  end
  return true
end
function VeilCond(loc,c)
  return true
end
function CounterpunchCond(loc,c)
  if loc == PRIO_TOHAND then
    return not FilterLocation(c,LOCATION_GRAVE)
  end
  return true
end
function LeadYokeCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIExtra(),23232295,true)
  end
  return true
end
BoxerPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- Boxer
[65367484] = {5,1,1,1,1,1,1,1,1,1,ThrasherCondBoxer},  -- Thrasher
[05361647] = {4,1,7,1,9,2,1,1,1,1,GlassjawCond},  -- BB Glassjaw
[35537251] = {5,1,6,1,3,2,1,1,1,1,ShadowCond},  -- BB Shadow
[53573406] = {6,1,1,1,1,1,1,1,1,1,ChameleonCond},  -- Masked Chameleon
[53573406] = {5,1,1,1,1,1,1,1,1,1,KageCond},  -- Kagetokage
[68144350] = {7,3,3,1,7,3,1,1,1,1,SwitchitterCond},  -- BB Switchitter
[32750341] = {4,1,3,1,5,2,1,1,1,1,SparrerCond},  -- BB Sparrer
[79867938] = {8,1,5,1,2,2,1,1,1,1,HeadgearedCond},  -- BB Headgeared
[13313278] = {3,1,5,1,4,2,1,1,1,1,VeilCond},  -- BB Veil
[04549095] = {2,1,1,1,6,4,1,1,1,1,CounterpunchCond},  -- BB Counterpunch

[12580477] = {1,1,1,1,1,1,1,1,1,1},  -- Raigeki
[32807846] = {1,1,1,1,1,1,1,1,1,1},  -- RotA
[36916401] = {1,1,1,1,1,1,1,1,1,1},  -- BB Spirit
[54447022] = {1,1,1,1,1,1,1,1,1,1},  -- Soul Charge
[05318639] = {1,1,1,1,1,1,1,1,1,1},  -- MST
[14087893] = {1,1,1,1,1,1,1,1,1,1},  -- BoM
[27243130] = {1,1,1,1,1,1,1,1,1,1},  -- Lance

[53582587] = {1,1,1,1,1,1,1,1,1,1},  -- Torrential
[83555666] = {1,1,1,1,1,1,1,1,1,1},  -- RoD
[05851097] = {1,1,1,1,1,1,1,1,1,1},  -- Vanity
[50078509] = {1,1,1,1,1,1,1,1,1,1},  -- Fiendish
[08316565] = {1,1,1,1,1,1,1,1,1,1},  -- Jolt Counter
[84749824] = {1,1,1,1,1,1,1,1,1,1},  -- Solemn

[39765958] = {1,1,1,1,1,1,1,1,1,1},  -- Hot Red Dragon Archfiend
[76774528] = {1,1,1,1,1,1,1,1,1,1},  -- Scrap Dragon
[83994433] = {1,1,1,1,1,1,1,1,1,1},  -- Stardust Spark
[16195942] = {1,1,1,1,1,1,1,1,1,1},  -- Dark Rebellion
[59627393] = {1,1,1,1,1,1,1,1,1,1},  -- BB Star Cestus
[94380860] = {1,1,1,1,1,1,1,1,1,1},  -- Ragnazero
[71921856] = {1,1,1,1,1,1,1,1,1,1},  -- BB Nova Caesar
[23232295] = {9,2,1,1,1,1,1,1,1,1,LeadYokeCond},  -- BB Lead Yoke
[82633039] = {1,1,1,1,1,1,1,1,1,1},  -- Castel
[46772449] = {1,1,1,1,1,1,1,1,1,1},  -- Exciton
[34086406] = {1,1,1,1,1,1,1,1,1,1},  -- Lavalval 
[12014404] = {1,1,1,1,1,1,1,1,1,1},  -- Cowboy
[93568288] = {1,1,1,1,1,1,1,1,1,1},  -- Rhapsody
} 
function BoxerFilter(c,exclude)
  return IsSetCode(c.setcode,0x84) and (exclude == nil or c.id~=exclude)
end
function BoxerMonsterFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) and BoxerFilter(c,exclude)
end

function SummonThrasherBoxer(c,sum)
  if #AIMon()>0 or not DualityCheck() then
    return false
  end
  if HasIDNotNegated(sum,68144350,true,SummonSwitchitter) then
    return false
  end
  if HasIDNotNegated(sum,53573406,true,SummonChameleonBoxer) then
    return false
  end
  return true
end
function SummonSwitchitter(c,sum)
  if CardsMatchingFilter(AIGrave(),BoxerMonsterFilter,04549095)>0
  and OverExtendCheck()
  and DualityCheck()
  and not (HasID(AIMon(),23232295,true) 
  and HasIDNotNegated(sum,53573406,true,SummonChameleonBoxer))
  then
    return true
  end
  return false
end
function SummonHeadgeared(c)
  if not HasAccess(05361647)
  and HasID(AIDeck(),05361647,true)
  and MacroCheck()
  then
    return true
  end
  if HasID(AIGrave(),68144350)
  and HasID(AIDeck(),05361647,true)
  and MacroCheck()
  then
    return true
  end
  if HasID(AIDeck(),04549095)
  then
    return true
  end
  return false
end
function ChameleonFilter(c)
  return c.defense==0 and c.level==4 
  and FilterRevivable(c)
end
function SummonChameleonBoxer(c)
  if CardsMatchingFilter(AIGrave(),ChameleonFilter)>0
  and DualityCheck()
  and not SpecialSummonCheck()
  and CardsMatchingFilter(AIMon(),FilterLevelMin,5)==0
  then
    return true
  end
  return false
end
function SummonChainBoxer(c)
  return (not HasAccess(05361647)
  or HasID(AIMon(),05361647,true) 
  and not HasAccess(68144350)
  or HasID(AIGrave(),68144350,true)
  and HasID(AIDeck(),05361647,true))
  and MacroCheck()
  and HasID(AIExtra(),34086406,true)
  and (not OppHasStrongestMonster()
  or OppGetStrongestAttack()<1800)
  and MP2Check(c)
end
function UseChainBoxer(c,mode)
  local cards = UseLists(AIGrave(),c.xyz_materials)
  if mode == 1 
  and HasID(AIDeck(),05361647,true) 
  and (HasAccess(68144350) or not HasAccess(05361647))
  and CardsMatchingFilter(cards,GlassjawFilter)>0
  then
    return true
  end
  if mode == 2
  and TurnEndCheck()
  then
    GlobalCardMode = 2
    return true
  end
  return false
end
function SummonLeadYoke(c)
  return NotNegated(c) 
  and not HasID(AIMon(),23232295,true)
  and MP2Check(c)
end
function SummonStarCestus(c)
  return NotNegated(c)
  and OppHasStrongestMonster()
end
function UseNovaCaesar(c)
  local cards = SubGroup(AIGrave(),FilterLevel,4)
  return NotNegated(c) 
  and CardsMatchingFilter(cards,BoxerMonsterFilter,04549095)>0
  and MP2Check(c)
  and c.xyz_material_count<4
end
function SummonNovaCaesar(c)
  local cards = UseLists(SubGroup(AIMon(),FilterLevel,4),AIGrave())
  return NotNegated(c) 
  and CardsMatchingFilter(cards,BoxerMonsterFilter,04549095)>2
  and MP2Check(c)
end
function SummonBoxer(c,mode)
  if mode == 1 
  and (FieldCheck(4)==1 
  or OverExtendCheck()
  and (HasIDNotNegated(AICards(),36916401,true,UseBoxerSpirit,true)
  or c.id~=32750341 and HasID(AIHand(),32750341,true) and MP2Check()
  or c.id == 32750341 and CardsMatchingFilter(AIHand(),FilterID,32750341)>1 and MP2Check()))
  and DualityCheck()
  then
    return true
  end
  if mode == 2 
  and OppHasStrongestMonster()
  and c.attack>OppGetStrongestAttack()
  then
    return true
  end
  if mode == 3 
  and #AIMon() == 0
  and c.attack > 1500
  then
    return true
  end
  return false
end
function UseBoxerSpirit(c,skip)
  if (skip or FieldCheck(4)==1)
  and DualityCheck()
  and OPTCheck(36916401)
  then
    return true
  end
  return false
end
function ShadowFilter(c)
  return BoxerMonsterFilter(c) 
  and FilterType(c,TYPE_XYZ)
  and HasID(c.xyz_materials,05361647,true)
  and CardsMatchingFilter(AIGrave(),BoxerMonsterFilter,05361647)>0
  or OppHasStrongestMonster()
  and HasIDNotNegated(AIMon(),23232295,true,HasMaterials)--YokeBuffCheck)
end
function SummonShadow(c)
  return CardsMatchingFilter(AIMon(),ShadowFilter)>0
  and DualityCheck()
end
function SummonSparrer(c,mode)
  return FieldCheck(4) == 1 
  and ((mode == 1) and TurnEndCheck() 
  or (mode == 2) and MP2Check()
  and not HasID(AIMon(),23232295,true,HasMaterials))
end
function UseRotaBoxer(c,cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  if NeedsCard(35537251,AIDeck(),AIHand(),true,SummonShadow)
  then
    return true
  end
  if FieldCheck(4)==2 
  or NormalSummonCheck() 
  --or OverExtendCheck(2,6) 
  then
    return false
  end
  if HasIDNotNegated(Sum,53573406,true,SummonChameleonBoxer) then
    return false
  end
  if HasIDNotNegated(Sum,68144350,true,SummonSwitchitter,Sum) then
    return false
  end
  if not NormalSummonCheck() and #Sum==0 then
    return true
  end
  if NeedsCard(68144350,AIDeck(),AIHand(),true,SummonSwitchitter) 
  and not (FieldCheck(4)==1 and HasID(UseLists(Sum,AIMon()),05361647)
  and HasAccess(68144350))
  then
    return true
  end
  if CardsMatchingFilter(Sum,BoxerMonsterFilter,04549095)>0
  and NeedsCard(65367484,AIDeck(),AIHand(),true,SummonThrasherBoxer)
  then
    return true
  end
  if HasID(SpSum,65367484,true,SummonThrasherBoxer) 
  and NeedsCard(79867938,AIDeck(),AIHand(),true)
  and not NormalSummonCheck()
  then
    return true
  end
  if CardsMatchingFilter(Sum,BoxerMonsterFilter,04549095)==0
  and HasID(Act,36916401,true,UseBoxerSpirit,true)
  then
    return true
  end
  return false
end
function SummonScrapBoxer(c,mode)
  if mode == 1 and NotNegated(c) and DestroyCheck(OppField())>0
  and (HasIDNotNegated(AIMon(),23232295,true,HasMaterials)
  or HasIDNotNegated(AIMon(),83994433,true,FilterOPT))
  then
    return true
  end
  if mode == 2 and Negated(c) and OppHasStrongestMonster()
  and OppGetStrongestAttDef()<c.attack
  then
    return true
  end
  return false
end
function UseScrapBoxer(c)
  return DeckCheck(AI_BOXER)
  and DestroyCheck(OppField())>0 
  and (HasID(AIMon(),83994433,true,FilterOPT) 
  or HasIDNotNegated(AIMon(),23232295,true,HasMaterials)
  or HasID(AIMon(),71921856,true,HasMaterials)
  or (PriorityCheck(AIField(),PRIO_TOGRAVE)>4 
  and (MP2Check() or HasPriorityTarget(OppField(),true))))
end
function SummonSparkBoxer(c,mode)
  if mode == 1 and HasID(AICards(),05851097,true) 
  and (not OppHasStrongestMonster() or OppGetStrongestAttDef()<2500)
  then
    return true
  end
  if mode == 2 and NotNegated(c) and MP2Check(c) 
  or Negated(c) and OppGetStrongestAttDef()<2500
  then
    return true
  end
  return false
end
--[[
65367484, -- Thrasher
05361647, -- BB Glassjaw
35537251, -- BB Shadow
53573406, -- Masked Chameleon
68144350, -- BB Switchitter
32750341, -- BB Sparrer
79867938, -- BB Headgeared
13313278, -- BB Veil
04549095, -- BB Counterpunch

59627393, -- BB Star Cestus
71921856, -- BB Nova Caesar
23232295, -- BB Lead Yoke
34086406, -- Lavalval 
]]
Boxers = {
05361647, -- BB Glassjaw
35537251, -- BB Shadow
68144350, -- BB Switchitter
32750341, -- BB Sparrer
79867938, -- BB Headgeared
13313278, -- BB Veil
}
function BoxerInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  GlobalYokeOverride = nil
  if HasID(Act,32807846,UseRotaBoxer,cards) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,39765958,SummonJeweledRDA) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,83994433,SummonSparkBoxer,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,76774528,SummonScrapBoxer,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,34086406,SummonChainBoxer) then
    return XYZSummon()
  end
  if HasID(Act,34086406,nil,545382497,UseChainBoxer,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,71921856,UseNovaCaesar) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,76774528,UseScrapBoxer) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,65367484,SummonThrasherBoxer,Sum) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(Sum,68144350,SummonSwitchitter,Sum) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,79867938,SummonHeadgeared) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Sum,53573406,SummonChameleonBoxer) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Act,35537251,SummonShadow) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,32750341,SummonSparrer,1) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  for i=1,#Boxers do
    if HasID(Sum,Boxers[i],SummonBoxer,1) then
      return COMMAND_SUMMON,CurrentIndex
    end
  end
  if HasID(Act,36916401,UseBoxerSpirit) then
    OPTSet(36916401)
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SpSum,32750341,SummonSparrer,2) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,23232295,SummonLeadYoke) then
    return XYZSummon()
  end
  if HasID(SpSum,59627393,SummonStarCestus) then
    return XYZSummon()
  end
  if HasID(SpSum,71921856,SummonNovaCaesar) then
    return XYZSummon()
  end
  if HasID(SpSum,11398095,SummonImpKing,1) then
    return XYZSummon()
  end
  for i=1,#Boxers do
    if HasID(Sum,Boxers[i],SummonBoxer,2) then
      return COMMAND_SUMMON,CurrentIndex
    end
  end
  for i=1,#Boxers do
    if HasID(Sum,Boxers[i],SummonBoxer,3) then
      return COMMAND_SUMMON,CurrentIndex
    end
  end
  if HasID(SpSum,83994433,SummonSparkBoxer,2) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(SpSum,76774528,SummonScrapBoxer,2) then
    return COMMAND_SPECIAL_SUMMON,CurrentIndex
  end
  if HasID(Act,34086406,nil,545382498,UseChainBoxer,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  return nil
end
--[[
65367484, -- Thrasher
05361647, -- BB Glassjaw
35537251, -- BB Shadow
53573406, -- Masked Chameleon
68144350, -- BB Switchitter
32750341, -- BB Sparrer
79867938, -- BB Headgeared
13313278, -- BB Veil
04549095, -- BB Counterpunch

59627393, -- BB Star Cestus
71921856, -- BB Nova Caesar
23232295, -- BB Lead Yoke
34086406, -- Lavalval ]]
function GlassjawTarget(cards)
  return Add(cards)
end
function ChameleonTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function SwitchitterTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function HeadgearedTarget(cards)
  return Add(cards,PRIO_TOGRAVE)
end
function ShadowTarget(cards)
  if HasID(cards,05361647) 
  and CardsMatchingFilter(AIGrave(),GlassjawFilter)>0
  then
    return {CurrentIndex}
  end
  return Add(cards,PRIO_TOGRAVE)
end
function LeadYokeTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    if HasID(cards,05361647) 
    and CardsMatchingFilter(AIGrave(),GlassjawFilter)>0
    then
      return {CurrentIndex}
    end
    return Add(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    return BestTargets(cards,1,TARGET_PROTECT)
  end
  --return BestTargets(cards)
end
function NovaCaesarTarget(cards,count)
  return Add(cards,PRIO_TOFIELD,count,FilterLocation,LOCATION_GRAVE)
end
function ScrapDragonTarget(cards)
  if CurrentOwner(cards[1])==1
  and HasIDNotNegated(AIMon(),23232295,true,HasMaterials)
  then
    return BestTargets(cards,1,TARGET_DESTROY,BoxerMonsterFilter)
  end
  if CurrentOwner(cards[1])==1
  and HasID(AIMon(),71921856,true,HasMaterials)
  then
    return BestTargets(cards,1,TARGET_DESTROY,FilterID,71921856)
  end
  if CurrentOwner(cards[1])==2 
  and Duel.GetCurrentPhase() == PHASE_MAIN1 
  and not (OppHasStrongestMonster() 
  or HasPriorityTarget(OppMon(),true))
  and DestroyCheck(OppST())>0
  then
    return BestTargets(cards,1,TARGET_DESTROY,FilterLocation,LOCATION_SZONE)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function BoxerCard(cards,min,max,id,c)
  if id == 05361647 then
    return GlassjawTarget(cards)
  end
  if id == 53573406 then
    return ChameleonTarget(cards)
  end
  if id == 68144350 then
    return SwitchitterTarget(cards)
  end
  if id == 79867938 then
    return HeadgearedTarget(cards)
  end
  if id == 35537251 then
    return ShadowTarget(cards)
  end
  if GlobalYokeOverride then
    return LeadYokeTarget(cards)
  end
  if id == 71921856 then
    return NovaCaesarTarget(cards,max)
  end
  return nil
end
function YokeCheck(aimon,oppmon)
  if oppmon == nil then
    return true
  end
  if aimon.GetCode then
    aimon=GetCardFromScript(aimon)
  end
  if oppmon.GetCode then
    oppmon=GetCardFromScript(oppmon)
  end
  if BoxerMonsterFilter(aimon) 
  and HasIDNotNegated(AIMon(),23232295,true,HasMaterials)
  and (oppmon.attack==aimon.attack 
  or AI.GetPlayerLP(1)-oppmon.attack+aimon.attack>800)
  then
    return false
  end
  return true
end
function ChainCounterpunch(c)
  local aimon,oppmon=GetBattlingMons() 
  if aimon and (AttackBoostCheck(1000) 
  or CanFinishGame(aimon,oppmon,aimon:GetAttack()+1000))
  and UnchainableCheck(04549095)
  and YokeCheck(aimon,oppmon)
  then
    return true
  end
  return false
end
function ChainVeil(c)
  return (Duel.GetTurnPlayer() == player_ai
  and FieldCheck(4) == 1
  or DamageTaken()>=2000
  or Duel.GetTurnPlayer() ~= player_ai and AI.GetPlayerLP(1)-ExpectedDamage()<=800)
  and DualityCheck()
end
function BoxerChain(cards)
  GlobalYokeOverride = nil
  if HasIDNotNegated(cards,08316565,ChainNegation,2) then -- Jolt Counter
    return 1,CurrentIndex
  end
  if HasID(cards,05361647) then
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,68144350) then
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,79867938) then
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,53573406) then
    return 1,CurrentIndex
  end
  if HasID(cards,04549095,nil,nil,LOCATION_GRAVE,ChainCounterpunch) then
    return 1,CurrentIndex
  end
  if HasID(cards,04549095,ChainCounterpunch) then
    return 1,CurrentIndex
  end
  if HasID(cards,13313278,ChainVeil) then
    return 1,CurrentIndex
  end
  if HasID(cards,71921856) then
    return 1,CurrentIndex
  end
  if HasID(cards,59627393) then
    return 1,CurrentIndex
  end
  return nil
end
function BoxerEffectYesNo(id,card)
  if id == 05361647 then 
    return 1
  end
  if id == 68144350
  and NotNegated(card)
  then 
    return 1
  end
  if id == 79867938
  and NotNegated(card)
  then 
    return 1
  end
  if id == 53573406
  and NotNegated(card)
  then 
    return 1
  end
  if id == 71921856 then
    return 1
  end
  if id == 59627393 then
    return 1
  end
  return nil
end
GlobalYokeOverride = nil
function BoxerYesNo(desc)
  if desc == 371716721 then -- Lead Yoke protection
    GlobalYokeOverride = true
    return 1
  end
  return nil
end
function YokeBuffCheck(c)
  return NotNegated(c) and HasMaterials(c) 
  and c.attack+800*c.xyz_material_count>=OppGetStrongestAttDef()
end
function YokeFilter(c,source)
  local atk=source.attack
  return BattleTargetCheck(c,source)
  and FilterPosition(c,POS_FACEUP_ATTACK)
  and FilterAttackMin(c,atk)
  and AI.GetPlayerLP(1)-c.attack+atk>800
end
function VeilFilter(c,source)
  local atk=source.attack
  return BattleTargetCheck(c,source)
  and (FilterPosition(c,POS_FACEUP_ATTACK)
  and FilterAttackMin(c,atk)
  and AI.GetPlayerLP(1)-c.attack+atk>0
  or FilterPosition(c,POS_DEFENCE)
  and FilterPublic(c)
  and FilterDefenseMin(c,atk)
  and AI.GetPlayerLP(1)-c.defense+atk>0
  or FilterPosition(c,POS_DEFENCE)
  and FilterPrivate(c)
  and AI.GetPlayerLP(1)>1000)
end
function BoxerBattleCommand(cards,targets,act)
  SortByATK(cards)
  if OppHasStrongestMonster() 
  and HasIDNotNegated(cards,23232295,true,YokeBuffCheck)
  then
    for i=1,#cards do
      local c = cards[i]
      if BoxerMonsterFilter(c,23232295)
      and c.id~=79867938
      and CardsMatchingFilter(targets,YokeFilter,c)>0
      then
        return Attack(i)
      end
    end
  end
  if HasIDNotNegated(cards,79867938)
  and HasID(AIHand(),13313278,true,ChainVeil)
  and CardsMatchingFilter(targets,VeilFilter,cards[CurrentIndex])>0
  then
    return Attack(CurrentIndex)
  end
end
function BoxerAttackTarget(cards,attacker)
  if OppHasStrongestMonster() 
  and HasIDNotNegated(cards,23232295,true,YokeBuffCheck)
  then
    if BoxerMonsterFilter(attacker,23232295)
    and attacker.id~=79867938
    and CardsMatchingFilter(cards,YokeFilter,attacker)>0
    then
      return BestAttackTarget(cards,attacker,false,YokeFilter,attacker)
    end
  end
  if attacker.id == 79867938
  and HasID(AIHand(),13313278,true,ChainVeil)
  and CardsMatchingFilter(cards,VeilFilter,attacker)>0
  then
    return BestAttackTarget(cards,attacker,false,VeilFilter,attacker)
  end
end
function BoxerAttackBoost(cards)
  if HasID(UseLists(AIHand(),AIGrave()),04549095,true) then
    for i=1,#cards do
      local c = cards[i]
      if BoxerMonsterFilter(c) then
        c.attack = c.attack + 1000
        c.bonus=c.bonus or 0
        c.bonus=c.bonus+1000
      end
    end
  end
end

BoxerAtt={
65367484, -- Thrasher
05361647, -- BB Glassjaw
35537251, -- BB Shadow
53573406, -- Masked Chameleon
68144350, -- BB Switchitter
79867938, -- BB Headgeared
71921856, -- BB Nova Caesar
23232295, -- BB Lead Yoke
}
BoxerDef={
32750341, -- BB Sparrer
13313278, -- BB Veil
04549095, -- BB Counterpunch
}
function BoxerPosition(id,available)
  result = nil
  for i=1,#BoxerAtt do
    if BoxerAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#BoxerDef do
    if BoxerDef[i]==id 
    then 
      result=POS_FACEUP_DEFENCE 
    end
  end
  -- add OnSelectPosition logic here
  return result
end

