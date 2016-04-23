
BujinPrio = {}
-- {hand,hand+,field,field+,grave,grave+,banished}
--  "+" == has one already
BujinPrio[32339440] = {9,2,9,5,1,1,2} -- Yamato
BujinPrio[53678698] = {5,1,5,4,2,1,2} -- Mikazuchi
BujinPrio[23979249] = {3,1,3,3,2,1,2} -- Arasuda
BujinPrio[09418365] = {4,1,4,3,2,1,2} -- Hirume
BujinPrio[68601507] = {7,3,0,0,0,0,2} -- Crane
BujinPrio[59251766] = {3,1,2,2,9,5,0} -- Hare
BujinPrio[05818294] = {3,1,2,2,8,4,0} -- Turtle
BujinPrio[69723159] = {2,1,1,1,7,3,0} -- Quilin
BujinPrio[88940154] = {2,1,1,1,6,3,0} -- Centipede
BujinPrio[50474354] = {2,1,0,0,2,2,5} -- Peacock
BujinPrio[56574543] = {3,1,0,0,10,6,0}-- Sinyou
BujinPrio[37742478] = {8,2,0,0,0,0,0} -- Honest

BujinPrio[73906480] = {4,2,0,0,0,0,0} -- Bujincarnation
BujinPrio[30338466] = {3,1,0,0,0,0,0} -- Bujin Regalia - The Sword
BujinPrio[57103969] = {8,1,0,0,0,0,0} -- Fire Formation - Tenki
BujinPrio[98645731] = {1,0,0,0,4,3,0} -- Pot of Duality
BujinPrio[81439173] = {1,0,0,0,3,2,0} -- Foolish Burial
BujinPrio[05318639] = {2,1,0,0,2,1,0} -- Mystical Space Typhoon
BujinPrio[27243130] = {2,1,0,0,2,1,0} -- Forbidden Lance
BujinPrio[78474168] = {1,1,0,0,3,3,0} -- Breakthrough Skill
BujinPrio[94192409] = {2,1,0,0,2,1,0} -- Compulsory Evacuation Device
BujinPrio[53582587] = {2,1,0,0,2,1,0} -- Torrential Tribute
BujinPrio[84749824] = {3,1,0,0,2,1,0} -- Solemn Warning
BujinPrio[29401950] = {2,1,0,0,2,1,0} -- Bottomless Trap Hole

BujinPrio[75840616] = {0,0,8,6,1,1,1} -- Bujintei Susanowo
BujinPrio[01855932] = {0,0,6,3,1,1,1} -- Bujintei Kagutsuchi
BujinPrio[73289035] = {0,0,5,4,1,1,1} -- Bujintei Tsukuyomi
BujinPrio[68618157] = {0,0,7,6,1,1,1} -- Bujintei Amaterasu
function BujinFilter(c,exclude)
  return IsSetCode(c.setcode,0x88) and (exclude == nil or c.id~=exclude)
end
function BujinMonsterFilter(c,exclude)
  return BujinFilter(c,exclude) and FilterType(c,TYPE_MONSTER)
end
function BujinGetPriority(id,loc)
  local index = 0
  local checklist = nil
  local result = 0
  if loc == LOCATION_HAND then
    index = 1
    checklist = AIHand()
    if id==32339440 or id==53678698 then checklist = UseLists({AIHand(),AIMon()}) end
  elseif loc == LOCATION_ONFIELD then
    index = 3
    checklist = AIMon()
  elseif loc == LOCATION_GRAVE then
    index = 5
    checklist = AIGrave()
  elseif loc == LOCATION_REMOVED then
    index = 7
  else
  end
  if checklist and HasID(checklist,id,true) then index=index+1 end
  checklist = BujinPrio[id]
  if checklist and checklist[index] then result = checklist[index] end
  return result
end
function BujinAssignPriority(cards,loc,filter,opt)
  local index = 0
  for i=1,#cards do
    cards[i].index=i
    cards[i].prio=BujinGetPriority(cards[i].id,loc)
    if filter and (opt==nil and not filter(cards[i]) 
    or opt and not filter(cards[i],opt)) 
    then
      cards[i].prio=-1
    end
  end
end
function BujinPriorityCheck(cards,loc,count,filter,opt)
  if count == nil then count = 1 end
  if loc==nil then loc=LOCATION_HAND end
  if #cards==0 then return -1 end
  BujinAssignPriority(cards,loc,filter,opt)
  table.sort(cards,function(a,b) return a.prio>b.prio end)
  return cards[count].prio
end
function BujinAdd(cards,loc,count,filter,opt)
  local result={}
  if count==nil then count=1 end
  if loc==nil then loc=LOCATION_HAND end
  local compare = function(a,b) return a.prio>b.prio end
  BujinAssignPriority(cards,loc,filter,opt)
  table.sort(cards,compare)
  for i=1,count do
    result[i]=cards[i].index
  end
  return result
end
function SummonMikazuchi()
  return OverExtendCheck()
end
function SummonArasuda()
  return OverExtendCheck()
end
function SummonSusanowo()
  local cards=OppMon()
  return #cards>2 or not HasID(UseLists({AIMon(),AIHand()}),32339440,true)
  or OppHasStrongestMonster() and OppGetStrongestAttack()<4800
  or OppHasStrongestMonster(true) and OppGetStrongestAttack()<2400
end
function KagutsuchiFilter(c)
  return bit32.band(c.race,RACE_BEASTWARRIOR)>0 and not c.id==32339440
end
function SummonKagutsuchi()
  return CardsMatchingFilter(AIMon(),KagutsuchiFilter)>1 and MP2Check(2500)
end
function SummonTsukuyomi()
  return UseTsukuyomi(AIHand())
end
function UseTsukuyomi(cards)
  return #cards==1 and BujinPriorityCheck(cards,LOCATION_GRAVE)>3 
  or #cards==2 and BujinPriorityCheck(cards,LOCATION_GRAVE,2)>4
end
function AmaterasuFilter(card)
  return card and card.level==4 and bit32.band(card.setcode,0x88)>0
end
function SummonAmaterasuBujin()
  return CardsMatchingFilter(AIBanish(),AmaterasuFilter)>3
  and DeckCheck(DECK_BUJIN)
end
function SummonHirume()
  return OverExtendCheck() and BujinPriorityCheck(AIGrave(),LOCATION_REMOVED)>0
end
function UseBujincarnation()
  return true
end
function UseQuilin()
  local cards=OppST()
  local result = 0
  for i=1,#cards do
    if bit32.band(cards[i].position,POS_FACEUP)>0
    and cards[i]:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
    and cards[i]:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
    and cards[i]:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
    then
      result = result +1
    end
  end
  cards=OppMon()
  for i=1,#cards do
    if bit32.band(cards[i].position,POS_FACEUP)>0
    and cards[i]:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
    and cards[i]:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
    and cards[i]:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)>0
    then
      result = result +1
    end
  end
  return OppHasStrongestMonster() or result>0
end
function UseCentipede()
  return true
end
function UseRegaliaGrave()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==73906480 and e:GetHandlerPlayer()==player_ai  then
      return false
    end
  end
  if RemovalCheck(30338466) then
    if BujinPriorityCheck(AIGrave())>2 
    and (BujinPriorityCheck(AIBanish(),LOCATION_GRAVE) < BujinPriorityCheck(AIGrave()) 
    or BujinPriorityCheck(UseLists({AIHand(),AIField()}),LOCATION_ONFIELD)<3 )
    then
      GlobalCardMode=1
      return true 
    end
  end	
  if Duel.GetTurnPlayer()==player_ai and BujinPriorityCheck(AIHand(),LOCATION_ONFIELD)<2 
  and BujinPriorityCheck(AIGrave(),LOCATION_ONFIELD)>4 and OverExtendCheck() 
  and not NormalSummonCheck(player_ai)
  then
    GlobalCardMode=2
    return true
  end
  if Duel.GetCurrentPhase() == PHASE_BATTLE and HasID(AIGrave(),68601507,true) 
  and not HasID(AIHand(),68601507,true) and not HasID(AIHand(),37742478,true)
  then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
      and (source:GetAttack() >= target:GetAttack() 
      and source:GetAttack() <= target:GetBaseAttack()*2
      and source:IsPosition(POS_FACEUP_ATTACK) 
      or source:GetDefence() >= target:GetAttack()  
      and source:GetDefence() < target:GetBaseAttack()*2
      and source:IsPosition(POS_FACEUP_DEFENCE))
      and target:IsPosition(POS_FACEUP_ATTACK)
      and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      and not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
      and target:IsSetCard(0x88)
      and target:IsRace(RACE_BEASTWARRIOR)
      then
        GlobalCardMode=3
        return true
      end
    end
  end
  return
end
function UseRegaliaBanish()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==73906480 and e:GetHandlerPlayer()==player_ai  then
      return false
    end
  end
  if RemovalCheck(30338466) then
    return BujinPriorityCheck(AIBanish(),LOCATION_GRAVE)>3 and BujinPriorityCheck(AIBanish(),LOCATION_GRAVE) >= BujinPriorityCheck(AIGrave())
  end	
  return
end
function BujinXYZCheck()
  return DeckCheck(DECK_BUJIN) and (not HasID(AIMon(),32339440) or OppHasStrongestMonster())
end
function SummonTigerKingBujin()
  return DeckCheck(DECK_BUJIN) and not HasID(UseLists({AIMon(),AIHand()}),32339440) 
  and HasID(AIDeck(),32339440) and HasID(AIDeck(),57103969) and MP2Check(2200)
end
function SharkKnightFilterBujin(c)
  return bit32.band(c.position,POS_FACEUP_ATTACK)>0 
  and bit32.band(c.type,TYPE_TOKEN)==0
  and bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)>0 
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)>0
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)>0 
  and c.id~=22110647
end
function SummonSharkKnightBujin(cards)
  local targets=SubGroup(OppMon(),SharkKnightFilterBujin)
  if #targets > 0 and OPTCheck(48739166) then
    return true
  end
  return false
end
function CastelFilterBujin(c)
  return bit32.band(c.type,TYPE_TOKEN)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)>0 
  and c.id~=22110647
end
function SummonCastelBujin(cards)
  local targets=SubGroup(OppMon(),CastelFilterBujin)
  if #targets > 0 and OPTCheck(82633039) then
    return true
  end
  return false
end
function UseDualityBujin()
  return DeckCheck(DECK_BUJIN)
end
function BujinOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  local SetableST = cards.st_setable_cards
  --
  if HasID(Activatable,30338466,false,485415456) and UseRegaliaGrave() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,30338466,false,485415457) and UseRegaliaBanish() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,73906480) and UseBujincarnation() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,57103969) then -- Tenki
    OPTSet(57103969)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,69723159) and UseQuilin() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,88940154) and UseCentipede() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,81439173) and not DeckCheck(DECK_BA) then -- Foolish Burial
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,73289035) and UseTsukuyomi(AIHand()) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,98645731) and UseDualityBujin() then -- Duality
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,50474354) then -- Peacock
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,75840616) then -- Susanowo
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,68618157) and DeckCheck(DECK_BUJIN) then -- Amaterasu
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,94380860) then  -- Ragna Zero
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,48739166) then  -- SHArk Knight
    OPTSet(48739166)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,82633039,false,1322128625) and UseSkyblaster() then
    OPTSet(82633039)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,96381979) and UseTigerKing() then  
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  --
if DeckCheck(DECK_BUJIN) then
  BujinAssignPriority(Summonable,LOCATION_ONFIELD)
  table.sort(Summonable,function(a,b) return a.prio>b.prio end)
  if Summonable and Summonable[1] and (Summonable[1].prio>0 
  or HasID(AIMon(),32339440) and Summonable[1].prio>3)
  and OverExtendCheck() 
  then
    return {COMMAND_SUMMON,Summonable[1].index}
  end
  --
  if HasID(SpSummonable,09418365) and SummonHirume() then
    GlobalActivatedCardID=09418365
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  
  GlobalBujinSS=true
  if HasID(SpSummonable,12014404) and SummonCowboyDef() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,48739166) and SummonSharkKnightBujin() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,48739166)}
  end
  if HasID(SpSummonable,82633039) and SummonCastelBujin() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,75840616) and SummonSusanowo() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end

  if HasID(SpSummonable,46772449) and DeckCheck(DECK_BUJIN) and SummonBelzebuth() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,46772449)}
  end
  if HasID(SpSummonable,01855932) and SummonKagutsuchi() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,73289035) and SummonTsukuyomi() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,68618157) and SummonAmaterasuBujin() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,96381979) and SummonTigerKingBujin() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,94380860,SummonRagnaZero) and BujinXYZCheck() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,94380860)}
  end  
  if HasID(SpSummonable,61344030) and BujinXYZCheck() and SummonPaladynamo() and Chance(50) then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,61344030)}
  end
  if HasID(SpSummonable,48739166) and BujinXYZCheck() and SummonSharkKnight() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,48739166)}
  end
  if HasID(SpSummonable,12014404) and BujinXYZCheck() and SummonCowboyAtt() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,12014404)}
  end
end
  GlobalBujinSS=nil
  return nil
end
function YamatoTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode = nil
    if BujinPriorityCheck(AIHand(),LOCATION_GRAVE)>4 then
      return BujinAdd(cards)
    end
  end
  return BujinAdd(cards,LOCATION_GRAVE)
end
function TsukuyomiTarget(cards)
  return BujinAdd(cards,LOCATION_GRAVE)
end
function KagutsuchiTarget(cards)
  return BujinAdd(cards,LOCATION_GRAVE)
end
function SusanowoTarget(cards)
  local result = nil
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return BujinAdd(cards,LOCATION_GRAVE)
  else
    if not (HasID(AIHand(),68601507) or HasID(AIHand(),37742478)) 
    and OppHasStrongestMonster() 
    then
      result = {IndexByID(cards,68601507)}
    end
    if result == nil or #result==0 then
      result=BujinAdd(cards)
    end
    return result
  end
end
function AmaterasuTargetBujin(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return BujinAdd(cards,LOCATION_GRAVE)
  else
    if Duel.GetTurnPlayer()==player_ai then
      return BujinAdd(cards,LOCATION_GRAVE)
    else
      return BujinAdd(cards)
    end
  end
end
function HareTarget(cards)
  return GlobalTargetGet(cards,true)
end
function QuilinTarget(cards)
  return BestTargets(cards,1,TARGET_DESTROY)
end
function CentipedeTarget(cards)
  return BestTargets(cards,1,TARGET_DESTROY)
end
function HirumeTarget(cards)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return BujinAdd(cards,LOCATION_GRAVE)
  end
  return BujinAdd(cards,LOCATION_REMOVED)
end
function BujincarnationFilter(c,exclude)
  return BujinMonsterFilter(c,exclude)
  and FilterRevivable(c,true)
end
GlobalBujincarnationID = nil
function BujincarnationTarget(cards)
  local grave = SubGroup(AIGrave(),BujinMonsterFilter)
  local banish = SubGroup(AIBanish(),BujinMonsterFilter)
  local check = nil
  for i=1,#banish do
    local c = banish[i]
    if check~=nil and c.id ~= check 
    or not FilterRace(c,RACE_BEASTWARRIOR)
    then
      check = false
    else
      check = c.id
    end
  end
  if LocCheck(cards,LOCATION_GRAVE) then
    BujinAdd(cards,LOCATION_ONFIELD,1,ExcludeID,check)
    GlobalBujincarnationID=cards[1].id
    return {cards[1].index}
  end
  if LocCheck(cards,LOCATION_REMOVED) then
    return BujinAdd(cards,LOCATION_GRAVE,1,ExcludeID,GlobalBujincarnationID)
  end
  return BujinAdd(cards,LOCATION_ONFIELD)
end
function RegaliaTarget(cards)
  local result=nil
  if GlobalCardMode==1 then
    result=BujinAdd(cards)
  elseif GlobalCardMode==2 then
    result=BujinAdd(cards,LOCATION_ONFIELD)
  elseif GlobalCardMode==3 then
    result={IndexByID(cards,68601507)}
  else
    result=BujinAdd(cards,LOCATION_GRAVE)
  end
  if result == nil or #result == 0 then
    result = BujinAdd(cards)
  end
  GlobalCardMode=nil
  return result
end
function ArasudaTarget(cards)
  return BujinAdd(cards,LOCATION_GRAVE)
end
function BujinXYZTarget(cards,count)
  GlobalBujinSS=nil
  result={}
  BujinAssignPriority(cards,LOCATION_ONFIELD)
  table.sort(cards,function(a,b) return a.prio<b.prio end)
  for i=1,count do
    result[i]=cards[i].index
  end
  return result
end
function BujinOnSelectCard(cards, minTargets, maxTargets,ID,triggeringCard)
  if ID == 98645731 and DeckCheck(DECK_BUJIN) then -- Duality
    return BujinAdd(cards)
  end
  if ID == 50474354  -- Peacock
  or ID == 53678698 then -- Mikazuchi
    return BujinAdd(cards)
  end
  if ID == 30338466 then
    return RegaliaTarget(cards)
  end
  if ID == 32339440 then
    return YamatoTarget(cards)
  end
  if ID == 23979249 then
    return ArasudaTarget(cards)
  end
  if GlobalActivatedCardID == 09418365 then
    GlobalActivatedCardID=nil
    return HirumeTarget(cards)
  end
  if ID == 09418365 then
    GlobalCardMode=1
    return HirumeTarget(cards)
  end
  if ID == 73289035 then
    return TsukuyomiTarget(cards)
  end
  if ID == 01855932 then
    return KagutsuchiTarget(cards)
  end
  if ID == 75840616 then
    return SusanowoTarget(cards)
  end
  if ID == 68618157 and DeckCheck(DECK_BUJIN) then
    return AmaterasuTargetBujin(cards)
  end
  if ID == 59251766 then
    return HareTarget(cards)
  end
  if ID == 69723159 then
    return QuilinTarget(cards)
  end
  if ID == 88940154 then
    return CentipedeTarget(cards)
  end
  if ID == 73906480 then
    return BujincarnationTarget(cards)
  end
  if GlobalBujinSS then
    return BujinXYZTarget(cards,minTargets)
  end
  return nil
end
function ChainArasuda()
  if HasID(AIHand(),23979249,true) then
    return Duel.GetTurnPlayer()==player_ai and OverExtendCheck()
  else
    return BujinPriorityCheck(AIHand(),LOCATION_GRAVE)>4
  end
end
function HareFilterEffect(card)
  return card:IsControler(player_ai) and card:IsPosition(POS_FACEUP) 
  and card:IsSetCard(0x88) and card:IsRace(RACE_BEASTWARRIOR)
  and not card:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT) 
  and not card:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)
  and not card:IsHasEffect(EFFECT_IMMUNE_EFFECT)   
end
function HareFilterBattle(card)
  return card:IsControler(player_ai) and card:IsPosition(POS_FACEUP) 
  and card:IsSetCard(0x88) and card:IsRace(RACE_BEASTWARRIOR)
  and not card:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
  and not card:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET) 
  --and not card:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
end
function ChainHare()
  local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_DESTROY)
  local tg = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TARGET_CARDS)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if e and e:GetHandler():GetCode()==30338466 and e:GetHandlerPlayer()==player_ai then
    return false
  end
  if ex then
    local g
    if tg then
      g = tg:Filter(HareFilterEffect, nil)
    else
      g = cg:Filter(HareFilterEffect, nil)
    end
    if g and g:GetCount()>0 then
      local c=g:GetFirst()
      local p,hp,a,ha=0,0,0,0
      while c do
        p=BujinGetPriority(c:GetCode(),LOCATION_ONFIELD)
        a=c:GetAttack()
        if hp<p or hp==p and ha<a then
          hp=p
          ha=a
          GlobalTargetSet(c,AIMon())
        end
        c=g:GetNext()
      end
      return true
    end
  end
  if Duel.GetCurrentPhase() == PHASE_BATTLE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if source:GetAttack() >= target:GetAttack() 
      and HareFilterBattle(target)
      and source:IsPosition(POS_FACEUP_ATTACK)
      and target:IsPosition(POS_FACEUP)
      and (not (HasID(AIHand(),68601507,true) and target:GetBaseAttack()*2>source:GetAttack() 
      or HasID(AIHand(),37742478,true) or HasID(AIGrave(),56574543,true) 
      or HasID(AIHand(),27243130,true) and Duel.GetTurnPlayer()==player_ai
      or HasIDNotNegated(AIST(),27243130,true))
      or source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE))
      and UnchainableCheck(59251766)
      then
        GlobalTargetSet(target,AIMon())
        return true
      end
    end
  end
  return false
end
function ChainCrane()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==68601507 and e:GetHandlerPlayer()==player_ai  then
      return false
    end
  end
  if Duel.GetCurrentPhase() == PHASE_DAMAGE_CAL then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
      and (source:GetAttack() >= target:GetAttack() 
      and source:GetAttack() <= target:GetBaseAttack()*2
      and source:IsPosition(POS_FACEUP_ATTACK) 
      or source:GetDefence() >= target:GetAttack()  
      and source:GetDefence() < target:GetBaseAttack()*2
      and source:IsPosition(POS_FACEUP_DEFENCE))
      and target:IsPosition(POS_FACEUP_ATTACK)
      and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      --and not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
      then
        return true
      end
    end
  end
  return false
end
function ChainHonest()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==56574543 and e:GetHandlerPlayer()==player_ai  then
      return false
    end
  end
  if Duel.GetCurrentPhase() == PHASE_DAMAGE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
      and (source:GetAttack() >= target:GetAttack() 
      and source:IsPosition(POS_FACEUP_ATTACK) 
      or source:GetDefence() >= target:GetAttack() 
      and source:GetDefence() < target:GetAttack()+source:GetAttack()
      and source:IsPosition(POS_FACEUP_DEFENCE))
      and target:IsPosition(POS_FACEUP_ATTACK)
      and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      --and not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
      then
        return UnchainableCheck(37742478)
      end
    end
  end
  return false
end
function ChainSinyou()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==68601507 and e:GetHandlerPlayer()==player_ai  then
      return false
    end
  end
  if Duel.GetCurrentPhase() == PHASE_DAMAGE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if target:IsControler(player_ai)
      and (source:GetAttack() >= target:GetAttack() 
      and source:IsPosition(POS_FACEUP_ATTACK) 
      or source:GetDefence() >= target:GetAttack() 
      and source:GetDefence() < target:GetAttack()+source:GetAttack()
      and source:IsPosition(POS_FACEUP_DEFENCE))
      and target:IsPosition(POS_FACEUP_ATTACK)
      and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) 
      --and not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
      then
        return UnchainableCheck(56574543)
      end
    end
  end
  return false
end
function ChainTurtle()
  local player = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_PLAYER)
  return player and player ~= player_ai
end
function ChainHirume()
  return BujinPriorityCheck(AIHand(),LOCATION_GRAVE)>4
end
function BujinOnSelectChain(cards,only_chains_by_player)
  if HasID(cards,30338466,false,485415456) and UseRegaliaGrave() then
    return {1,CurrentIndex}
  end
  if HasID(cards,30338466,false,485415457) and UseRegaliaBanish() then
    return {1,CurrentIndex}
  end
  if HasID(cards,68601507) and ChainCrane() then
    return {1,CurrentIndex}
  end
  if HasID(cards,56574543) and ChainSinyou() then
    return {1,CurrentIndex}
  end
  if HasID(cards,37742478) and ChainHonest() then
    return {1,CurrentIndex}
  end
  if HasID(cards,59251766) and ChainHare() then
    return {1,CurrentIndex}
  end
  if HasID(cards,05818294) and ChainTurtle() then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,94380860) then  -- Ragna Zero
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,68618157) and DeckCheck(DECK_BUJIN) then -- Amaterasu
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,23979249) and ChainArasuda() then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,53678698) then -- Mikazuchi
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,32339440) then -- Yamato
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  return nil
end
function BujinOnSelectEffectYesNo(id)
  local result = nil
  if id == 09418365 then --Hirume
    if ChainHirume() then
      result = 1
    else
      result = 0
    end
  end
  if id == 53678698 then -- Mikazuchi
    result = 1
  end
  if id == 32339440 then -- Yamato
    GlobalCardMode = 1
    result = 1
  end
  return result
end
BujinAtt={
  32339440,53678698,09418365, -- Yamato, Mika, Hirume
  75840616,01855932,68618157 -- Susan, Kagu, Amaterasu
}
BujinDef={
  23979249,73289035 -- Arasuda, Tsukuyomi
}
function BujinOnSelectPosition(id, available)
  result = nil
  for i=1,#BujinAtt do
    if BujinAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#BujinDef do
    if BujinDef[i]==id then result=POS_FACEUP_DEFENCE end
  end
  return result
end
