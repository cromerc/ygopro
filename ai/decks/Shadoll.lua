function ShadollFusionCond(loc)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),44394295,true)
  end
  return true
end
function FalconCond(loc)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(37445295) and GetMultiple(37445295)==0 and not HasID(AIMon(),37445295,true)
  end
  return true
end
function HedgehogCond(loc)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(04939890) and NeedsCard(37445295,AIDeck(),UseLists({AIHand(),AIMon()}),true) and GetMultiple(04939890)==0
  end
  return true
end
function ShadollFilter(c)
  return IsSetCode(c.setcode,0x9d) and bit32.band(c.type,TYPE_MONSTER)>0
end
function LizardCond(loc)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(30328508) and (HasID(AIGrave(),44394295,true) and HasID(AIDeck(),04904633,true)
    or CardsMatchingFilter(AIGrave(),ShadollFilter)<6) and GetMultiple(30328508)==0
  end
  return true
end
function DragonFilter(c)
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
end
function DragonCond(loc)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(77723643) and CardsMatchingFilter(OppST(),DragonFilter)>0 and GetMultiple(77723643)==0
  end
  return true
end
function BeastCond(loc)
  if loc == PRIO_TOGRAVE then
    return OPTCheck(03717252) and GetMultiple(03717252)==0
  end
  return true
end
function ConstructFilter(c)
  return bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)>0
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 
  and Affected(c,TYPE_MONSTER,8)
end
function ConstructCond(loc)
  if loc == PRIO_TOFIELD then
    return OppGetStrongestAttack() < 2800 or HasID(AIMon(),94977269,true)
    or CardsMatchingFilter(OppMon(),ConstructFilter)>0
    and not HasID(AIMon(),20366274,true)
  end
  return true
end
function WindaCond(loc)
  if loc == PRIO_TOFIELD then
    return OppGetStrongestAttack() < 2200 or HasID(AIMon(),20366274,true)
    and ShadollPriorityCheck(UseLists({AIHand(),AIMon()}),PRIO_TOGRAVE,2,ShadollFilter)>2
    and not HasID(AIMon(),94977269,true)
  end
  return true
end
function RootsCond(loc)
  if loc == PRIO_TOGRAVE then
    return NeedsCard(44394295,AIGrave(),AIHand(),true) or HasID(AIMon(),04904633,true)
  end
  return true
end
function FelisCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return true
  end
  return true
end
function MathCond(loc,c)
  return true
end
function ShekinagaCond(loc,c)
  return true
end
function EgrystalCond(loc,c)
  return true
end
function ShadollGetPriority(c,loc)
  local checklist = nil
  local result = 0
  local id = c.id
  if loc == nil then
    loc = PRIO_TOHAND
  end
  checklist = Prio[id]
  if checklist then
    if checklist[11] and not(checklist[11](loc,c)) then
      loc = loc + 1
    end
    result = checklist[loc]
  end
  return result
end
function ShadollAssignPriority(cards,loc,filter)
  local index = 0
  Multiple = nil
  for i=1,#cards do
    cards[i].index=i
    cards[i].prio=ShadollGetPriority(cards[i],loc)
    if filter and not filter(cards[i]) then
      cards[i].prio=-1
    end
    if loc==PRIO_GRAVE and FilterLocation(cards[i],LOCATION_DECK) then
      cards[i].prio=cards[i].prio+2
    end
     if loc==PRIO_GRAVE and FilterLocation(cards[i],LOCATION_ONFIELD) then
      cards[i].prio=cards[i].prio-1
    end
    SetMultiple(cards[i].id)
  end
end
function ShadollPriorityCheck(cards,loc,count,filter)
  if count == nil then count = 1 end
  if loc==nil then loc=PRIO_TOHAND end
  if cards==nil or #cards<count then return -1 end
  ShadollAssignPriority(cards,loc,filter)
  table.sort(cards,function(a,b) return a.prio>b.prio end)
  return cards[count].prio
end
function ShadollAdd(cards,loc,count,filter)
  local result={}
  if count==nil then count=1 end
  if loc==nil then loc=PRIO_TOHAND end
  local compare = function(a,b) return a.prio>b.prio end
  ShadollAssignPriority(cards,loc,filter)
  table.sort(cards,compare)
  --print("priority list:")
  for i=1,#cards do
    --print(cards[i].original_id..", prio:"..cards[i].prio)
  end
  for i=1,count do
    result[i]=cards[i].index
    --ShadollTargets[#ShadollTargets+1]=cards[i].cardid
  end
  return result
end
function WindaCheck()
  -- returns true, if there is no Winda on the field
  return not HasIDNotNegated(UseLists({AIMon(),OppMon()}),94977269,true)
end
function FalconFilter(c)
  return IsSetCode(c.setcode,0x9d) and c.id~= 37445295
end
function UseFalcon()
  return OPTCheck(37445295) and ShadollPriorityCheck(AIGrave(),PRIO_TOFIELD,1,FalconFilter)>1
end
function UseHedgehog()
  return OPTCheck(04939890) and HasID(AIDeck(),44394295,true)
end
function LizardFilter(c)
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseLizard()
  return CardsMatchingFilter(OppMon(),LizardFilter)>0-- and OPTCheck(37445295)
end
function DragonFilter2(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 and (c.level>4 
  or bit32.band(c.type,TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ)>0) 
end
function UseDragon()
  return OPTCheck(37445295) and CardsMatchingFilter(OppMon(),DragonFilter2)>0
end
function DragonFilter3(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseDragon2()
  return OPTCheck(37445295) and CardsMatchingFilter(OppMon(),DragonFilter3)>0
end
function UseBeast()
  return OPTCheck(03717252) --and ShadollPriorityCheck(AIHand(),PRIO_TOGRAVE)>3
end
function ShadollFusionFilter(c)
  return c and c.summon_type and c.previous_location
  and bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
  and bit32.band(c.previous_location,LOCATION_EXTRA)==LOCATION_EXTRA
end
function ArtifactFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_LIGHT)>0 and bit32.band(c.type,TYPE_MONSTER)>0
end
function UseShadollFusion()
  if HasID(AIMon(),94977269,true) and HasID(AIMon(),20366274,true) then return false end
  return OverExtendCheck()
  and (ShadollPriorityCheck(UseLists({AIHand(),AIMon()}),PRIO_TOGRAVE,2,ShadollFilter)>2
  and not HasID(AIMon(),94977269,true)
  or ShadollPriorityCheck(UseLists({AIHand(),AIMon()}),PRIO_TOGRAVE,1,ShadollFilter)>2
  and ShadollPriorityCheck(UseLists({AIHand(),AIMon()}),PRIO_TOGRAVE,1,ArtifactFilter)>2
  and not HasID(AIMon(),20366274,true)
  or CardsMatchingFilter(OppMon(),ShadollFusionFilter)>0)
end
function UseRoots()
  return HasID(AIHand(),44394295,true) and WindaCheck()
  and not Duel.IsExistingMatchingCard(ShadollFusionFilter,1-player_ai,LOCATION_MZONE,0,1,nil)
end
function DruFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_DARK)>0 and c.level==4 and (c.attack==0 or c.defense==0)
end
function SummonDru()
  return CardsMatchingFilter(AIGrave(),DruFilter)>0 and WindaCheck() 
  and (SummonSkyblaster() or SummonEmeral())
end
function SetArtifacts()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  and #AIST()<4
end

function MichaelFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function SummonMichael(c)
  return c and (CardsMatchingFilter(UseLists({OppMon(),OppST()}),MichaelFilter)>0 
  and AI.GetPlayerLP(1)>1000 and NotNegated(c)  
  or Negated (c) and OppGetStrongestAttDef()<2600)
  and MP2Check() and HasID(AIExtra(),04779823,true)
end
function UseMichael()
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),MichaelFilter)>0
end
function ArcaniteFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
end
function SummonArcanite()
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),ArcaniteFilter)>1 
  and MP2Check() and HasID(AIExtra(),31924889,true)
end
function UseArcanite()
  return CardsMatchingFilter(UseLists({OppMon(),OppST()}),ArcaniteFilter)>0
end
function FalconFilter2(c)
  return bit32.band(c.attribute,ATTRIBUTE_LIGHT)>0 and c.level==5 and bit32.band(c.position,POS_FACEUP)>0
end
function FalconFilter3(c)
  return bit32.band(c.race,RACE_SPELLCASTER)>0 and c.level==5 and bit32.band(c.position,POS_FACEUP)>0
end
function SummonFalcon()
  return (SummonMichael(FindID(04779823,AIExtra())) and CardsMatchingFilter(AIMon(),FalconFilter2)>0 
  or SummonArcanite() and CardsMatchingFilter(AIMon(),FalconFilter3)>0 
  or SummonArmades() and FieldCheck(3)>0)
  and (WindaCheck() or not SpecialSummonCheck(player_ai))
end
function SetFalcon()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2) 
  and CardsMatchingFilter(AIGrave(),FalconFilter)>0 and not HasID(AIMon(),37445295,true)
end
function SummonDragon()
  return Duel.GetTurnCount()>1 and not OppHasStrongestMonster() and OverExtendCheck() 
  or FieldCheck(4) == 1 and (SummonSkyblaster() or SummonEmeral())
end
function SetDragon()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2) 
  and not HasID(AIMon(),37445295,true) and OverExtendCheck()
end
function SummonHedgehog()
  return HasID(AIMon(),37445295,true,nil,nil,POS_FACEUP) and SummonArmades()
end
function SetHedgehog()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2) 
  and not HasID(AIMon(),04939890,true) and not HasID(AIHand(),44394295,true) 
end
function SummonLizard()
  return Duel.GetTurnCount()>1 and not OppHasStrongestMonster() and OverExtendCheck() 
  or FieldCheck(4) == 1 and (SummonSkyblaster() or SummonEmeral())
end
function SetLizard()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  and not HasID(AIMon(),37445295,true) and OverExtendCheck()
end
function SummonBeast()
  return false
end
function SetBeast()
  return false
end
function SetFacingTheShadows()
  return Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2 
  and not HasIDNotNegated(AIST(),77505534,true)
end
function UseSoulCharge()
  return #AIMon()==0 and AI.GetPlayerLP(1)>1000 
  and CardsMatchingFilter (AIGrave(),function(c) return bit32.band(c.type,TYPE_MONSTER)>2 end)
end
function UseFelis()
  return Duel.GetCurrentPhase()==PHASE_MAIN2 and DestroyCheck(OppMon())
end
function SummonMath()
  return true
end

function ShadollOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  local SetableST = cards.st_setable_cards
  if HasID(Activatable,04904633) and UseRoots() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,00581014,false,9296225) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,44394295) and UseShadollFusion() then
    GlobalCardMode=1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  
  if HasID(Repositionable,37445295,false,nil,nil,POS_FACEDOWN_DEFENCE) and UseFalcon() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Repositionable,04939890,false,nil,nil,POS_FACEDOWN_DEFENCE) and UseHedgehog() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Repositionable,30328508,false,nil,nil,POS_FACEDOWN_DEFENCE) and UseLizard() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Repositionable,77723643,false,nil,nil,POS_FACEDOWN_DEFENCE) and UseDragon() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Repositionable,03717252,false,nil,nil,POS_FACEDOWN_DEFENCE) and UseBeast() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Repositionable,03717252,false,nil,nil,POS_FACEDOWN_DEFENCE) and UseBeast() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
    if HasID(Repositionable,20366274,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
    if HasID(Repositionable,94977269,false,nil,nil,POS_FACEDOWN_DEFENCE) then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end

  if HasID(Summonable,41386308) and SummonMath() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,24062258) and SummonDru() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,37445295) and SummonFalcon() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,04939890) and SummonHedgehog() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,30328508) and SummonLizard() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,77723643) and SummonDragon() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,03717252) and SummonBeast() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,41386308) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  
  if HasID(Activatable,73176465) and UseFelis() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  if HasID(SetableMon,37445295) and SetFalcon() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,04939890) and SetHedgehog() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,30328508) and SetLizard() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end  
  if HasID(SetableMon,77723643) and SetDragon() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,03717252) and SetBeast() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  
  if HasID(SetableST,77505534) and SetFacingTheShadows() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  return nil
end
function SanctumTargetField(cards)
  return ShadollAdd(cards,PRIO_TOFIELD)
end
function SanctumTargetGrave(cards)
  return BestTargets(cards,1,true)
end
function BeagalltachTarget(cards)
  local result={}
  local targets=CardsMatchingFilter(UseLists({OppMon(),OppST()}),MoralltachFilter)
  local Scythe=false
  for i=1,#cards do
    if cards[i].id == 20292186 and ScytheCheck()
    and #result<math.min(targets,2) and not Scythe
    then
      Scythe = true
      result[#result+1]=i
    end
    if cards[i].id == 85103922 and #result<math.min(targets,2) then
      result[#result+1]=i
    end
  end
  if #result==0 then result=BestTargets(cards,1,TARGET_DESTROY) end
  return result
end
function FalconTarget(cards)
  return ShadollAdd(cards,PRIO_TOFIELD)
end
function HedgehogTarget(cards)
  return ShadollAdd(cards)
end
function LizardTarget(cards,onField)
  if onField then
    return BestTargets(cards,1,true)
  else
    return ShadollAdd(cards,PRIO_TOGRAVE)
  end
end
function DragonTarget(cards)
  return BestTargets(cards,1,TARGET_DESTROY)
end
function BeastTarget(cards)
  return ShadollAdd(cards,PRIO_TOGRAVE)
end
function ShadollFusionTarget(cards)
  local result=nil
  if GlobalCardMode == 1 then
    result = ShadollAdd(cards,PRIO_TOFIELD)
  else
    result = ShadollAdd(cards,PRIO_TOGRAVE)
  end
  GlobalCardMode = nil
  if result == nil then result = {math.random(#cards)} end
  OPTSet(cards[1].id)
  return result
end
function ConstructTarget(cards,inGrave)
  if inGrave then
    return ShadollAdd(cards)
  else
    return ShadollAdd(cards,PRIO_TOGRAVE)
  end
end
function WindaTarget(cards)
  return ShadollAdd(cards)
end
function RootsTarget(cards)
  return ShadollAdd(cards)
end
function FacingTheShadowsTarget(cards,min,max)
  local result = nil
  if GlobalCardMode == nil then
    result = ShadollAdd(cards,PRIO_TOGRAVE)
  else
    result={}
    for i=1,#cards do
      local id=cards[i].id
      if id==37445295 and UseFalcon()
      or id==04939890 and UseHedgehog()
      or id==30328508 and UseLizard()
      or id==77723643 and UseDragon2()
      or id==03717252 and UseBeast()
      then
        result[#result+1]=i
      end
    end
  end
  GlobalCardMode=nil
  if result == nil then result = {math.random(#cards)} end
  if #result>max then result = ShadollAdd(cards,PRIO_TOGRAVE) end
  OPTSet(cards[result[1]].id)
  return result
end
function EmeralTarget(cards,count)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if count>0 then
    return Add(cards,PRIO_EXTRA,count)
  end
  return Add(cards,PRIO_TOFIELD)
end
function SkyblasterTarget(cards,count)
  return BestTargets(cards,count)
end
function VolcasaurusTarget(cards)
  return BestTargets(cards,1,true)
end
function MichaelTarget(cards,onField)
  local result = {}
  if onField then
    result = BestTargets(cards)
  else
    for i=1,#cards do
      result[i]=i
    end
  end
  return result
end
function ArcaniteTarget(cards)
  return BestTargets(cards,1,true)
end
function PanzerDragonTarget(cards)
  return BestTargets(cards,1,true)
end
function CompulseTarget(cards)
  local result = nil
  if GlobalCardMode == 1 then
    result=GlobalTargetGet(cards,true)
  end
  GlobalCardMode = nil
  if result == nil then result = BestTargets(cards,1,TARGET_TOHAND) end
  return result
end
function IgnitionTarget(cards)
  local result = {}
  if GlobalCardMode == 2 then
    result=GlobalTargetGet(cards,true)
  elseif GlobalCardMode == 1 then
    result = BestTargets(cards,1,true)
  else
    for i=1,#cards do
      if cards[i].id == 85103922 and #result<1 then
        result[#result+1]=i
      end
    end
  end 
  GlobalCardMode=nil
  if #result == 0 then result = {math.random(#cards)} end
  if cards[1].prio then TargetSet(cards[1]) else TargetSet(cards[result[1]]) end
  return result
end
function MSTTarget(cards)
  result = nil
  if GlobalCardMode == 1 then
    result=GlobalTargetGet(cards,true)
  end
  GlobalCardMode=nil
  if result==nil then result=BestTargets(cards,1,TARGET_DESTROY,TargetCheck) end
  if cards[1].prio then TargetSet(cards[1]) else TargetSet(cards[result[1]]) end
  return result
end
function SoulChargeTarget(cards,min,max)
  local result={}
  local count = max
  if AI.GetPlayerLP(1)>=7000 then
    count = math.min(3,max)
  elseif AI.GetPlayerLP(1)>=4000 then
    count = math.min(2,max)
  else
    count = 1
  end
  if DeckCheck(DECK_TELLARKNIGHT) or DeckCheck(DECK_HAT) then
    result = Add(cards,PRIO_TOFIELD,count)
  else
    for i=1,#cards do
      cards[i].index=i
    end
    table.sort(cards,function(a,b) return a.attack>b.attack end)
    for i=1,count do
      result[i]=cards[i].index
    end
  end
  return result
end
function MathTarget(cards)
  return Add(cards,PRIO_TOGRAVE)
end
function ShadollOnSelectCard(cards, minTargets, maxTargets,triggeringID,triggeringCard)
  local ID 
  local result=nil
  if triggeringCard then
    ID = triggeringCard.id
  else
    ID = triggeringID
  end
  if ID == 54447022 then
    return SoulChargeTarget(cards,minTargets,maxTargets)
  end
  if ID == 05318639 then
    return MSTTarget(cards)
  end
  if ID == 94192409 then
    return CompulseTarget(cards)
  end
  if ID == 12697630 then
    return BeagalltachTarget(cards)
  end
  if ID == 12444060 and bit32.band(triggeringCard.location,LOCATION_ONFIELD)>0 then
    return SanctumTargetField(cards)
  end
  if ID == 12444060 and bit32.band(triggeringCard.location,LOCATION_GRAVE)>0 then
    return SanctumTargetGrave(cards)
  end
  if ID == 85103922 then
    return BestTargets(cards,1,true)
  end
  if ID == 29223325 then
    return IgnitionTarget(cards)
  end
  if ID == 37445295 then
    return FalconTarget(cards)
  end
  if ID == 04939890 then
    return HedgehogTarget(cards)
  end
  if ID == 30328508 then
    return LizardTarget(cards,bit32.band(triggeringCard.location,LOCATION_ONFIELD)>0)
  end
  if ID == 77723643 then
    return DragonTarget(cards)
  end
  if ID == 03717252 then
    return BeastTarget(cards)
  end
  if ID == 44394295 then
    return ShadollFusionTarget(cards)
  end
  if ID == 20366274 then
    return ConstructTarget(cards,bit32.band(triggeringCard.location,LOCATION_GRAVE)>0)
  end
  if ID == 20366274 then
    return WindaTarget(cards)
  end
  if ID == 04904633 then
    return RootsTarget(cards)
  end
  if ID == 77505534 then
    return FacingTheShadowsTarget(cards,minTargets,maxTargets)
  end
  if ID == 00581014 then
    return EmeralTarget(cards,minTargets)
  end
  if ID == 82633039 then
    return SkyblasterTarget(cards,minTargets)
  end
  if ID == 29669359 then
    return VolcasaurusTarget(cards)
  end
  if ID == 04779823 then
    return MichaelTarget(cards,bit32.band(triggeringCard.location,LOCATION_ONFIELD)>0)
  end
  if ID == 31924889 then
    return ArcaniteTarget(cards)
  end
  if ID == 72959823 then
    return PanzerDragonTarget(cards)
  end
  if ID == 73176465 then
    return BestTargets(cards,1,TARGET_DESTROY)
  end
  if ID == 41386308 then
    return MathTarget(cards)
  end
  return nil
end
function ChainWireTap()
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if e then
    local c = e:GetHandler()
    return c and c:IsControler(1-player_ai)
  end
  return false 
end
function ChainBookOfMoon() 
  return false
end
function SanctumFilter(c)
  return PriorityTarget(c,true,nil,FilterPosition,POS_FACEUP)
end
function ChainSanctum()
  if RemovalCheck(12444060) and (HasID(AIDeck(),85103922,true) or HasID(AIDeck(),12697630,true) and HasID(AIST(),85103922,true) and WindaCheck())then
    GlobalCardMode = 1
    return true
  end
  if not UnchainableCheck(12444060) then
    return false
  end
  local targets = CardsMatchingFilter(UseLists({OppMon(),OppST()}),SanctumFilter)
  local targets2=CardsMatchingFilter(UseLists({OppMon(),OppST()}),MoralltachFilter)
  local check = HasID(AIDeck(),85103922,true) or HasID(AIDeck(),12697630,true) 
  and HasID(AIST(),85103922,true) and WindaCheck()
  if Duel.GetTurnPlayer()==1-player_ai and targets>0 and check
  then
    GlobalCardMode = 1
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai and targets2>0 and check then
    if Duel.GetCurrentPhase()==PHASE_BATTLE then
      local source = Duel.GetAttacker()
      if source and source:IsControler(1-player_ai) then
        GlobalCardMode = 1
        return true
      end
    end
    if Duel.GetCurrentPhase()==PHASE_END and targets2>0 and check then
      GlobalCardMode = 1
      return true
    end
  end
  local check = HasID(AIDeck(),20292186,true) or HasID(AIDeck(),12697630,true) 
  and HasID(AIST(),20292186,true) and WindaCheck()
  if ScytheCheck() and check then
    GlobalCardMode = 1
    return true
  end
  return nil
end

function ChainFacingTheShadows()
  local result = false
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if RemovalCheck(77505534) then 
    result = true
  end
  if RemovalCheck(37445295) and UseFalcon() then
    OPTSet(37445295)
    result = true
  end
  if RemovalCheck(04939890) and UseHedgehog() then
    OPTSet(04939890)
    result = true
  end
  if RemovalCheck(30328508) and UseLizard() then
    OPTSet(30328508)
    result = true
  end
  if RemovalCheck(77723643) and UseDragon2() then
    OPTSet(77723643)
    result = true
  end
  if RemovalCheck(03717252) and UseBeast() then
    OPTSet(03717252)
    result = true
  end
  if Duel.GetCurrentPhase()==PHASE_END 
  and (HasID(AIDeck(),77723643,true) and DragonCond(PRIO_TOGRAVE) 
  or HasID(AIDeck(),04939890,true) and HedgehogCond(PRIO_TOGRAVE) ) then
    result = true
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and target then
      if target:IsSetCard(0x9d) and target:IsPosition(POS_FACEDOWN_DEFENCE) 
      and source:GetAttack()>target:GetDefence() and target:IsControler(player_ai)
      and (target:IsCode(77723643) and UseDragon2() or target:IsCode(30328508) and UseLizard())
      then
        OPTSet(target:GetCode())
        result = true
      end
    end
  end
  if result and e then
    c = e:GetHandler()
    result = (c and c:GetCode()~=12697630)
  end
  return result
end
function ChainRoots()
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    local source=Duel.GetAttacker()
    return source and source:IsControler(1-player_ai) and source:GetAttack()<=1950 and #AIMon()==0 
  end
end

function CompulseFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and c:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
end
function CompulseFilter2(c)
  return CompulseFilter(c) and not ToHandBlacklist(c.id) 
  and (c.level>4 or bit32.band(c.type,TYPE_FUSION+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ)>0)
end
function ChainCompulse()
  local targets = CardsMatchingFilter(OppMon(),CompulseFilter)
  local targets2 = CardsMatchingFilter(OppMon(),CompulseFilter2)
  if RemovalCheck(94192409) and targets>0 then
    return true
  end
  if not UnchainableCheck(94192409) then
    return false
  end
  if targets2 > 0 then
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE and targets>0 then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(1-player_ai) and target:IsControler(player_ai) 
      and (target:IsPosition(POS_DEFENCE) and source:GetAttack()>target:GetDefence() 
      or target:IsPosition(POS_ATTACK) and source:GetAttack()>=target:GetAttack())
      and not source:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)
      and not source:IsHasEffect(EFFECT_IMMUNE_EFFECT)
      then
        GlobalCardMode = 1
        GlobalTargetSet(source,OppMon())
        return true
      end
    end
  end
  return false
end
function ArtifactCheck(sanctum,scythe)
  local MoralltachCheck = HasID(AIST(),85103922,true) and Duel.GetTurnPlayer()==1-player_ai
  local BeagalltachCheck = HasID(AIST(),12697630,true) and (HasID(AIST(),85103922,true) 
  or sanctum and HasID(AIDeck(),85103922,true))
  and WindaCheck() and Duel.GetTurnPlayer()==1-player_ai
  local BeagalltachCheckScythe = HasID(AIST(),12697630,true) and (HasID(AIST(),20292186,true) 
  or sanctum and HasID(AIDeck(),20292186,true))
  and WindaCheck() and Duel.GetTurnPlayer()==1-player_ai
  local CheckScythe = HasID(AIST(),20292186,true) and Duel.GetTurnPlayer()==1-player_ai
  if scythe then
    if BeagalltachCheckScythe then
      if sanctum then
        GlobalCardMode = 2
      else 
        GlobalCardMode = 1
      end
      GlobalTargetSet(FindID(12697630,AIST()),AIST())
      return true
    end
    if CheckScythe then
      if sanctum then
        GlobalCardMode = 2
      else 
        GlobalCardMode = 1
      end
      GlobalTargetSet(FindID(20292186,AIST()),AIST())
      return true
    end
  else
    if BeagalltachCheck then
      if sanctum then
        GlobalCardMode = 2
      else 
        GlobalCardMode = 1
      end
      GlobalTargetSet(FindID(12697630,AIST()),AIST())
      return true
    end
    if MoralltachCheck then
      if sanctum then
        GlobalCardMode = 2
      else 
        GlobalCardMode = 1
      end
      GlobalTargetSet(FindID(85103922,AIST()),AIST())
      return true
    end
  end
  return false
end
function MSTFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 
  and not (DestroyBlacklist(c)
  and (bit32.band(c.position, POS_FACEUP)>0 
  or bit32.band(c.status,STATUS_IS_PUBLIC)>0))
end
function MSTEndPhaseFilter(c)
  return MSTFilter(c) and bit32.band(c.status,STATUS_SET_TURN)>0
end
function ChainMST(c)
  local targets=CardsMatchingFilter(OppST(),MSTFilter)
  local targets2=CardsMatchingFilter(UseLists({OppMon(),OppST()}),MoralltachFilter)
  local targets3=CardsMatchingFilter(UseLists({OppMon(),OppST()}),SanctumFilter)
  local targets4=CardsMatchingFilter(OppST(),MSTEndPhaseFilter)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
  if RemovalCheckCard(c) then
    if e and e:GetHandler():IsCode(12697630) then
      return false
    end
    if SignCheck(AIST()) and not RemovalCheck(19337371) then
      GlobalCardMode = 1
      GlobalTargetSet(FindID(19337371,AIST()))
      return true
    end
    if targets2 > 0 and ArtifactCheck()
    then
      return true
    end
    if targets > 0 then
      return true
    end
  end
  if not UnchainableCheck(05318639) then
    return false
  end
  if targets3 > 0 and ArtifactCheck() then
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and source:IsControler(1-player_ai) then
      if targets2 > 0 and ArtifactCheck() then
        return true
      end
    end
  end
  if Duel.GetCurrentPhase()==PHASE_END and Duel.GetTurnPlayer()==1-player_ai 
  and #AIST()>0 and SignCheck(AIST()) and LadyCount(AIHand())<2 
  then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(19337371,AIST()))
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_END then
    if targets2 > 0 and ArtifactCheck() then
      return true
    end
    if targets4 > 0 then
      local cards = SubGroup(OppST(),MSTEndPhaseFilter)
      GlobalCardMode = 1
      GlobalTargetSet(cards[math.random(#cards)],OppST())
      return true
    end
  end
  if e then
    local c = e:GetHandler()
    if (c:IsType(TYPE_CONTINUOUS+TYPE_EQUIP+TYPE_FIELD) 
    or (c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_SPELL) 
    and (ScaleCheck(2)==true or not e:IsHasType(EFFECT_TYPE_ACTIVATE))))
    and c:IsControler(1-player_ai)
    and targets>0
    and c:IsLocation(LOCATION_ONFIELD)
    and not c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)
    and not c:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT)
    and not c:IsHasEffect(EFFECT_IMMUNE_EFFECT)
    and (not DestroyBlacklist(c) or c:GetCode()==19337371 
    or c:GetCode()==05851097 and Duel.GetCurrentChain()>1)
    then
      GlobalCardMode = 1
      GlobalTargetSet(c,OppST())
      return true
    end
  end
  if HasPriorityTarget(OppST(),true) and Duel.GetCurrentChain()==0 then
    return true
  end
  if ScytheCheck() and ArtifactCheck(nil,true) then
    return true
  end
  return false
end
function ChainIgnition(c)
  local targets=CardsMatchingFilter(OppST(),MSTFilter)
  local targets2=CardsMatchingFilter(UseLists({OppMon(),OppST()}),MoralltachFilter)
  local targets3=CardsMatchingFilter(UseLists({OppMon(),OppST()}),SanctumFilter)
  local targets4=CardsMatchingFilter(OppST(),MSTEndPhaseFilter)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
  local loc = 0
  if FilterLocation(c,LOCATION_HAND) then loc = 1 end
  if RemovalCheck(12444060) then
    if e and e:GetHandler():IsCode(12697630) then
      return false
    end
    if targets2 > 0 and ArtifactCheck(true)
    then
      return true
    end
    if targets > 0 and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>loc then
      return true
    end
  end
  if not UnchainableCheck(12444060) then
    return false
  end
  if targets3 > 0 and ArtifactCheck(true) then
    return true
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and source:IsControler(1-player_ai) then
      if targets2 > 0 and ArtifactCheck(true) then
        return true
      end
    end
  end
  if Duel.GetCurrentPhase()==PHASE_END then
    if targets2 > 0 and ArtifactCheck(true) then
      return true
    end
    if targets4 > 0 and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>loc then
      local cards = SubGroup(OppST(),MSTEndPhaseFilter)
      GlobalTargetSet(cards[math.random(#cards)],OppST())
      GlobalCardMode = 2
      return true
    end
  end
  if e then
    local c = e:GetHandler()
    if (c:IsType(TYPE_CONTINUOUS+TYPE_EQUIP+TYPE_FIELD) 
    or (c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_SPELL) 
    and (ScaleCheck(2)==true or not e:IsHasType(EFFECT_TYPE_ACTIVATE))))
    and c:IsControler(1-player_ai)
    and targets>0
    and c:IsLocation(LOCATION_ONFIELD)
    and not c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)
    and not c:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT)
    and not c:IsHasEffect(EFFECT_IMMUNE_EFFECT)
    and (not DestroyBlacklist(c) or c:GetCode()==19337371 
    or c:GetCode()==05851097 and Duel.GetCurrentChain()>1)
    and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>loc
    then
      GlobalTargetSet(c,OppST())
      GlobalCardMode = 2
      return true
    end
  end
  if HasPriorityTarget(OppST(),true) 
  and Duel.GetLocationCount(player_ai,LOCATION_SZONE)>loc
  and Duel.GetCurrentChain()
  then
    return true
  end
  if ScytheCheck() and ArtifactCheck(true,true) then
    return true
  end
  return false
end
function ChainPanzerDragon(c)
  return DestroyCheck(OppField())>0
end
function ShadollOnSelectChain(cards,only_chains_by_player)
  if HasID(cards,05318639,false,nil,nil,nil,ChainMST) then
    return {1,CurrentIndex}
  end
  if HasID(cards,94192409) and ChainCompulse() then
    return {1,CurrentIndex}
  end
  if HasID(cards,77505534) and ChainFacingTheShadows() then
    return {1,CurrentIndex}
  end
  --if HasID(cards,34507039) and ChainWireTap() then
    --return {1,CurrentIndex}
  --end
  if HasID(cards,14087893) and ChainBookOfMoon() then
    return {1,CurrentIndex}
  end
  if HasID(cards,12444060,false,nil,LOCATION_ONFIELD) and ChainSanctum() then
    return {1,CurrentIndex}
  end
  if HasID(cards,12444060,false,nil,LOCATION_GRAVE) and SanctumYesNo() then
    return {1,CurrentIndex}
  end
  if HasID(cards,29223325) and ChainIgnition(cards[CurrentIndex]) then
    return {1,CurrentIndex}
  end
  if HasID(cards,37445295,false,nil,LOCATION_ONFIELD) and UseFalcon() then
    OPTSet(37445295)
    return {1,CurrentIndex}
  end
  if HasID(cards,04939890,false,nil,LOCATION_ONFIELD) and UseHedgehog() then
    OPTSet(04939890)
    return {1,CurrentIndex}
  end
  if HasID(cards,30328508,false,nil,LOCATION_ONFIELD) and UseLizard() then
    OPTSet(30328508)
    return {1,CurrentIndex}
  end
  if HasID(cards,77723643,false,nil,LOCATION_ONFIELD) then
    OPTSet(77723643)
    return {1,CurrentIndex}
  end
  if HasID(cards,03717252,false,nil,LOCATION_ONFIELD) and UseBeast() then
    OPTSet(03717252)
    return {1,CurrentIndex}
  end
  if HasID(cards,37445295,false,nil,LOCATION_GRAVE) then
    OPTSet(37445295)
    return {1,CurrentIndex}
  end
  if HasID(cards,04939890,false,nil,LOCATION_GRAVE) then
    OPTSet(04939890)
    return {1,CurrentIndex}
  end
  if HasID(cards,30328508,false,nil,LOCATION_GRAVE) then
    OPTSet(30328508)
    return {1,CurrentIndex}
  end
  if HasID(cards,77723643,false,nil,LOCATION_GRAVE) and CardsMatchingFilter(OppST(),DragonFilter)>0 then
    OPTSet(77723643)
    return {1,CurrentIndex}
  end
  if HasID(cards,03717252,false,nil,LOCATION_GRAVE) then
    OPTSet(03717252)
    return {1,CurrentIndex}
  end
  if HasID(cards,20366274) then
    return {1,CurrentIndex}
  end
  if HasID(cards,94977269) then
    return {1,CurrentIndex}
  end
  if HasID(cards,04904633,false,nil,LOCATION_GRAVE) then
    return {1,CurrentIndex}
  end
  if HasID(cards,33698022) then
    return {1,CurrentIndex}
  end
  if HasID(cards,24062258) then
    return {1,CurrentIndex}
  end
  if HasID(cards,04904633) and ChainRoots() then
    return {1,CurrentIndex}
  end
  if HasID(cards,73176465,false,nil,LOCATION_GRAVE) then -- Felis
    return {1,CurrentIndex}
  end
  if HasID(cards,72959823,false,nil,nil,nil,ChainPanzerDragon) then
    return {1,CurrentIndex}
  end
  return nil
end
function SanctumYesNo()
  return DestroyCheck(OppField())>0
end
function ShadollOnSelectEffectYesNo(id,triggeringCard)
  local result = nil
  local field = bit32.band(triggeringCard.location,LOCATION_ONFIELD)>0
  local grave = bit32.band(triggeringCard.location,LOCATION_GRAVE)>0
  if id == 85103922 then
    result = 1
  end
  if id == 12444060 and SanctumYesNo() then
    result = 1
  end
  if id == 37445295 and field and UseFalcon() then
    OPTSet(37445295)
    result = 1
  end
  if id == 04939890 and field and UseHedgehog() then
    OPTSet(04939890)
    result = 1
  end
  if id == 30328508 and field and UseLizard() then
    OPTSet(30328508)
    result = 1
  end
  if id == 77723643 and field then
    OPTSet(77723643)
    result = 1
  end
  if id == 03717252 and field and UseBeast() then
    OPTSet(03717252)
    result = 1
  end
  if id == 37445295 and grave then
    OPTSet(37445295)
    result = 1
  end
  if id == 04939890 and grave then
    OPTSet(04939890)
    result = 1
  end
  if id == 30328508 and grave then
    OPTSet(30328508)
    result = 1
  end
  if id == 77723643 and grave and CardsMatchingFilter(OppST(),DragonFilter)>0 then
    OPTSet(77723643)
    result = 1
  end
  if id == 03717252 and grave then
    OPTSet(03717252)
    result = 1
  end
  if id == 20366274 or id == 94977269 or id == 04904633 
  or id == 33698022 or id == 24062258 
  then
    result = 1
  end
  if id == 77505534 then
    GlobalCardMode=1
    result = 1
  end
  if id == 73176465 and grave then
    result = 1
  end
  if id == 72959823 and ChainPanzerDragon(triggeringCard) then
    result = 1
  end
  return result
end
ShadollAtt={
  85103922,94977269,48424886 -- Moralltach,Winda,Egrystal
}
ShadollDef={
  12697630,31924889,04904633, -- Beagalltach,Arcanite Magician,Shadoll Roots
  73176465,74822425, -- Felis, Shekinaga
}
function ShadollOnSelectPosition(id, available)
  result = nil
  for i=1,#ShadollAtt do
    if ShadollAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#ShadollDef do
    if ShadollDef[i]==id then result=POS_FACEUP_DEFENCE end
  end
  return result
end