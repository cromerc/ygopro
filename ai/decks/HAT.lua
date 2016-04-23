function TrapHoleFilter(c)
  return bit32.band(c.type,TYPE_TRAP)>0 
  and (IsSetCode(c.setcode,0x4c) or IsSetCode(c.setcode,0x89))
end
function TraptrixFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and IsSetCode(c.setcode,0x108a)
end
function ArtifactFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_LIGHT)>0 and bit32.band(c.type,TYPE_MONSTER)>0
end
function SetArtifacts()
  return (Duel.GetTurnCount()==1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  and #AIST()<4
end
function HandCount(cards)
  local result = 0
  for i=1,#cards do
    if cards[i].id == 68535320 or cards[i].id == 95929069 then
      result = result+1
    end
  end
  return result
end
function MyrmeleoCond(loc,c)
  if loc == PRIO_HAND then
    return CardsMatchingFilter(AIDeck(),TrapholeFilter)>0
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(OppST(),DestroyFilter)>0
  end
  return true
end
function DionaeaCond(loc,c)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AIGrave(),TraptrixFilter)>0
    or HasID(AIHand(),91812341,true)
  end
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(AIGrave(),TrapHoleFilter)>0
  end
  return true
end
function FireHandCond(loc,c)
  if loc == PRIO_TOHAND then
    return HandCount(AICards())==0 and HasID(AIDeck(),95929069,true)
  end
  return true
end
function IceHandCond(loc,c)
  if loc == PRIO_TOHAND then
    return HandCount(AICards())==0 and HasID(AIDeck(),68535320,true)
  end
  return true
end
function MoralltachFilter(c)
  return bit32.band(c.position,POS_FACEUP)>0 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
  and bit32.band(c.status,STATUS_LEAVE_CONFIRMED)==0
  and not DestroyBlacklist(c)
end
function MoralltachCond(loc)
  if loc == PRIO_TOHAND then
    local cards = UseLists({AIHand(),AIST()})
    return HasID(cards,12444060,true) and HasID(AIDeck(),12697630,true)
    or HasID(card,29223325,true)
  end
  if loc == PRIO_TOFIELD then 
    return CardsMatchingFilter(UseLists({OppMon(),OppST()}),MoralltachFilter)>0 
    and Duel.GetTurnPlayer()==1-player_ai
    and not ScytheCheck()
  end
  return true
end
function BeagalltachCond(loc)
  if loc == PRIO_TOHAND then
    local cards = UseLists({AIHand(),AIST()})
    return HasID(card,29223325,true) and HasID(AIDeck(),85103922,true)
  end
  if loc == PRIO_TOFIELD then 
    return WindaCheck() and (HasID(AIST(),85103922,true) and MoralltachCond(PRIO_TOFIELD)
    or HasID(AIST(),20292186,true) and ScytheCond(PRIO_TOFIELD))
    and Duel.GetTurnPlayer()==1-player_ai
  end
  return true
end
function ScytheCond(loc)
  if loc == PRIO_TOHAND then
    local cards = UseLists({AIHand(),AIST()})
    return HasID(cards,12444060,true) and HasID(AIDeck(),12697630,true)
    or HasID(card,29223325,true)
  end
  if loc == PRIO_TOFIELD then 
    return ScytheCheck()
    and Duel.GetTurnPlayer()==1-player_ai
  end
  return true
end
function SanctumCond(loc,c)
  if loc == PRIO_TOHAND then
    local cards = UseLists({AIHand(),AIST()})
    return (HasID(AIDeck(),85103922,true)
    or HasID(AIDeck(),20292186,true)    
    or (HasID(UseLists({AIHand(),AIST()}),85103922,true) 
    or HasID(UseLists({AIHand(),AIST()}),20292186,true) )
    and HasID(AIDeck(),12697630,true) )
    and not HasID(cards,12444060,true)
  end
  return true
end
function IgnitionCond(loc,c)
  if loc == PRIO_TOHAND then
    local cards = UseLists({AIHand(),AIST()})
    return (HasID(cards,85103922,true) 
    or HasID(cards,20292186,true) 
    or HasID(cards,12697630,true) 
    and (HasID(AIDeck(),85103922,true)
    or HasID(AIDeck(),20292186,true)) )
    and not HasID(cards,29223325,true)
  end
  return true
end
function SoulChargeCond()
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AIGrave(),CotHFilter)>2 and AI.GetPlayerLP(1)>2000
  end
  return true
end
function CanUseHand()
  return ((HasID(AIMon(),68535320,true) or HasID(AIHand(),68535320,true) 
  and not NormalSummonCheck(player_ai)) and FireHandCheck() 
  or (HasID(AIMon(),95929069,true) or HasID(AIHand(),95929069,true) 
  and not NormalSummonCheck(player_ai)) and IceHandCheck())
  and Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
end

function UseDualityHAT()
  return DeckCheck(DECK_HAT) and (not (CanUseHand() or FieldCheck(4)>1 or FieldCheck(5)>1
  or HandCheck(4)>0 and FieldCheck(4)>0 and not NormalSummonCheck(player_ai) 
  or HasID(AIHand(),45803070,true) and SummonDionaea() and not NormalSummonCheck(player_ai))) 
end
function SummonDionaea()
  return DualityCheck() and OverExtendCheck() 
  and (CardsMatchingFilter(AIGrave(),TraptrixFilter)>0
  or FieldCheck(4)==1 and not HasID(AIHand(),91812341,true))
end
function SummonMyrmeleo()
  return OverExtendCheck() and (MyrmeleoCond(PRIO_TOHAND) or DualityCheck() and FieldCheck(4)==1)
end
function HandFilter(c,atk)
  return bit32.band(c.position,POS_FACEUP_ATTACK)>0 
  and c.attack >= atk and AI.GetPlayerLP(1)+atk-c.attack>800
  and c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0
end
-- function to determine the lowest attack monster the hands can attack to get their effects
function HandAtt(cards,att)
  local lowest = 999999
  for j=1,#cards do
    if HandFilter(cards[j],att) and cards[j].attack < lowest and lowest > att then
      lowest = cards[j].attack
    end
  end
  return lowest+1
end
function FireHandCheck()
  return DualityCheck() and MacroCheck() and (CardsMatchingFilter(OppMon(),HandFilter,1600)>0 
  and CardsMatchingFilter(OppMon(),DestroyFilter)>0 and HasID(AIDeck(),95929069,true))
end
function IceHandCheck()
  return DualityCheck() and MacroCheck() and (CardsMatchingFilter(OppMon(),HandFilter,1400)>0 
  and CardsMatchingFilter(OppST(),DestroyFilter)>0 and HasID(AIDeck(),68535320,true))
end
function SummonFireHand()
  return OverExtendCheck() and DualityCheck() 
  and (FireHandCheck() or FieldCheck(4)==1)
end
function SummonIceHand()
  return OverExtendCheck() and DualityCheck() 
  and (IceHandCheck() or FieldCheck(4)==1)
end
function SetFireHand()
  return OverExtendCheck() --and #OppMon()>0 
  and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
end
function SetIceHand()
  return OverExtendCheck() ---and #OppMon()>0 
  and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
end
function UseCotH()
  if Duel.GetTurnPlayer()==player_ai then
    if FieldCheck(4)==1 and GraveCheck(4)>0 and ExtraDeckCheck(TYPE_XYZ,4)>0 and OverExtendCheck() then
      GlobalCardMode = 4
      return true
    end
    if FieldCheck(5)==1 and GraveCheck(5)>0 and ExtraDeckCheck(TYPE_XYZ,5)>0 and OverExtendCheck() then
      GlobalCardMode = 5
      return true
    end
    if Duel.GetCurrentPhase() == PHASE_MAIN1 and GlobalBPAllowed and OverExtendCheck() then
      if HasID(AIGrave(),68535320,true) and FireHandCheck() then
        GlobalCardMode = 1
        GlobalTargetSet(FindID(68535320,AIGrave()))
        return true
      end
      if HasID(AIGrave(),95929069,true) and FireHandCheck() then
        GlobalCardMode = 1
        GlobalTargetSet(FindID(95929069,AIGrave()))
        return true
      end
    end
    if OverExtendCheck() and PriorityCheck(AIGrave(),PRIO_TOFIELD,1,CotHFilter)>3 then
      return true
    end
  end
end
function SummonMonster(atk)
  return OppGetStrongestAttDef()<=atk and #AIMon()==0 and Duel.GetTurnCount()>1
end
function SetMonster()
  return #AIMon()==0 and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
end
function SetDionaea()
  return #AIMon()==0 and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
  and CardsMatchingFilter(AIGrave(),TraptrixFilter)==0
end
function ScytheCheck()
  local tuners = 0
  local nontuners = 0
  local level = {}
  local lvlcount = 0
  for i=1,#OppMon() do
    local c = OppMon()[i]
    if FilterPosition(c,POS_FACEUP) then
      if FilterType(c,TYPE_TUNER) then
        tuners = tuners + 1
      end
      if not FilterType(c,TYPE_TUNER) then
        nontuners = nontuners + 1
      end
      if level[c.level] then
        level[c.level]=level[c.level]+1
        lvlcount = math.max(level[c.level],lvlcount)
      else
        level[c.level]=1
        lvlcount=math.max(lvlcount,1)
      end
    end
  end
  return (tuners>0 and nontuners>0 or lvlcount>1)
  and Duel.GetTurnPlayer()==1-player_ai
  and DualityCheck()
  and not SkillDrainCheck()
  and (Duel.GetCurrentPhase()==PHASE_MAIN1
  or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function HATInit(cards)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  local SetableST = cards.st_setable_cards
  if HasID(Activatable,97077563) and UseCotH() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,98645731) and UseDualityHAT() then
    GlobalDuality = Duel.GetTurnCount()
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Summonable,68535320) and SummonFireHand() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,95929069) and SummonIceHand() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,45803070) and SummonDionaea() then
    GlobalCardMode = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,91812341) and SummonMyrmeleo() then
    GlobalCardMode = 1
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SetableMon,68535320) and SetFireHand() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,95929069) and SetIceHand() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(Summonable,45803070) and SummonMonster(Summonable[CurrentIndex].attack) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,91812341) and SummonMonster(Summonable[CurrentIndex].attack) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Repositionable,68535320,false,nil,nil,POS_FACEDOWN_DEFENCE) and SummonFireHand() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(Repositionable,95929069,false,nil,nil,POS_FACEDOWN_DEFENCE) and SummonIceHand() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasID(SetableMon,45803070) and SetDionaea() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,91812341) and SetMonster() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableST,85103922) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,20292186) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,12697630) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,12444060) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  if HasID(SetableST,29223325) and SetArtifacts() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  return nil
end

function SanctumTargetField(cards)
  return Add(cards,PRIO_TOFIELD)
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

function MyrmeleoTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards)
  else
    return BestTargets(cards,TARGET_DESTROY)
  end
end
function DionaeaTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOFIELD)
  else
    return Add(cards,PRIO_TOHAND)
  end
end
function CothCheck(c)
  return c.id==97077563 and FilterPosition(c,POS_FACEUP)
  and CardTargetCheck(c)==0
end

function CotHTarget(cards,c)
  local result = nil
  if GlobalCardMode and GlobalCardMode>2 then
    local level = GlobalCardMode
    GlobalCardMode = nil
    result = Add(cards,PRIO_TOFIELD,1,FilterLevel,level)
  elseif GlobalCardMode == 2 then
    GlobalCardMode = nil
    result = Add(cards,PRIO_TOFIELD,1,FilterAttackMin,AI.GetPlayerLP(2)-ExpectedDamage(2))
  elseif GlobalCardMode == 1 then
    result = GlobalTargetGet(cards,true)
  end
  if result == nil then
    result = Add(cards,PRIO_TOFIELD,1,TargetCheck)
  end
  if cards[1].prio then 
    TargetSet(cards[1]) 
  else 
    TargetSet(cards[result[1]]) 
  end
  return result
end
function BoMTarget(cards)
  if GlobalCardMode == 1 then
    return GlobalTargetGet(cards,true)
  end
  return BestTargets(cards,1,TARGET_FACEDOWN)
end
function PleiadesTarget(cards)
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    return BestTargets(cards,1,TARGET_TOGRAVE)
  elseif GlobalCardMode == 1 then
    return GlobalTargetGet(cards,true)
  else
  return BestTargets(cards,1,TARGET_TOHAND)
  end
end
function GiantHandTarget(cards,min)
  if min>1 then
    return {1,2}
  else
    return GlobalTargetGet(cards,true)
  end
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
function HATCard(cards,min,max,id,c)
  if c then
    id = c.id
  end
  if id == 68535320 or id == 95929069 then -- Fire Hand, Ice Hand
    return BestTargets(cards,1,TARGET_DESTROY)
  end
  if id == 91812341 then
    return MyrmeleoTarget(cards)
  end
  if id == 45803070 then
    return DionaeaTarget(cards)
  end
  if id == 97077563 then
    return CotHTarget(cards,c)
  end
  if id == 98645731 then -- Duality
    return Add(cards)
  end
  if id == 14087893 then -- Book of Moon
    return BoMTarget(cards)
  end
  if id == 63746411 then 
    return GiantHandTarget(cards,min)
  end
  if id == 73964868 then 
    return PleiadesTarget(cards)
  end
  if id == 12697630 then
    return BeagalltachTarget(cards)
  end
  if id == 12444060 and bit32.band(c.location,LOCATION_ONFIELD)>0 then
    return SanctumTargetField(cards)
  end
  if id == 12444060 and bit32.band(c.location,LOCATION_GRAVE)>0 then
    return SanctumTargetGrave(cards)
  end
  if id == 85103922 then -- Moralltach
    return BestTargets(cards,1,TARGET_DESTROY)
  end
  if id == 29223325 then
    return IgnitionTarget(cards)
  end
  return nil
end
function CotHFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and c:is_affected_by(EFFECT_SPSUMMON_CONDITION)==0 
end
function FinishFilter(c)
  return CotHFilter(c) and c.attack>=AI.GetPlayerLP(2)
end
function ArtifactCheckGrave(sanctum)
  local MoralltachCheck = HasID(AIGrave(),85103922,true) and Duel.GetTurnPlayer()==1-player_ai
  local BeagalltachCheck = HasID(AIGrave(),12697630,true) and HasID(AIST(),85103922,true) 
  and Duel.GetTurnPlayer()==1-player_ai and WindaCheck()
  if BeagalltachCheck then
    GlobalTargetSet(FindID(12697630),AIGrave())
    return true
  end
  if MoralltachCheck then
    GlobalTargetSet(FindID(85103922),AIGrave())
    return true
  end
  return false
end
function UseCotHBP()
  if Duel.GetTurnPlayer() == player_ai and #OppMon()==0 
  and CardsMatchingFilter(AIGrave(),FinishFilter)>0 
  and ExpectedDamage(2)<AI.GetPlayerLP(2)
  then
    GlobalCardMode = 2
    return true
  end
end
function ChainCotH(card)
  local targets=CardsMatchingFilter(OppST(),DestroyFilter)
  local targets2=CardsMatchingFilter(OppField(),MoralltachFilter)
  local targets3=CardsMatchingFilter(OppField(),SanctumFilter)
  local targets4=CardsMatchingFilter(OppST(),MSTEndPhaseFilter)
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TRIGGERING_EFFECT)
  local c = nil
  if e then
    c = e:GetHandler()
  end
  local MyrmeleoCheck = DestroyCheck(OppST())>0 and HasID(AIGrave(),91812341,true) 
  --local DionaeaCheck = CardsMatchingFilter(AIGrave(),TrapHoleFilter)>0 and Duel.GetCurrentChain()==0
  if RemovalCheckCard(card) and not c:IsCode(12697630) then
    if targets2 > 0 and ArtifactCheckGrave()
    then
      return true
    end
    if MyrmeleoCheck then
      GlobalCardMode = 1
      GlobalTargetSet(FindID(91812341),AIGrave())
      return true
    end
    return true -- return true anyways to avoid destruction effects that only destroy face-down cards
  end
  if not UnchainableCheck(97077563) then
    return false
  end
  if CardsMatchingFilter(OppField(),SanctumFilter)>0 then
    if targets3 > 0 and ArtifactCheckGrave()
    then
      return true
    end
  end
  if Duel.GetCurrentPhase()==PHASE_BATTLE then
    local source=Duel.GetAttacker()
    local target=Duel.GetAttackTarget()
    if source and source:IsControler(1-player_ai) then
      if targets2 > 0 and ArtifactCheckGrave() then
        return true
      end
    end
    if source and source:IsControler(1-player_ai) 
    and CanFinishGame(source) and #AIMon()==0
    then
      return true
    end
  end
  if Duel.GetCurrentPhase()==PHASE_END and Duel.CheckTiming(TIMING_END_PHASE) and Duel.GetTurnPlayer() == 1-player_ai then
    if targets2 > 0 and ArtifactCheckGrave() then
      return true
    end
    if MyrmeleoCheck and CardsMatchingFilter(OppST(),MSTEndPhaseFilter)>0 then
      GlobalCardMode = 1
      GlobalTargetSet(FindID(91812341),AIGrave())
      return true
    end
  end
  if ScytheCheck() and HasID(AIGrave(),20292186,true) then
    GlobalCardMode = 1
    GlobalTargetSet(FindID(20292186),AIGrave())
    return true
  end
  return false
end

function MoonWhitelist(c) -- cards to use Book of Moon on as soon as they hit the field, to prevent them from activating their effects
  return c.id == 48739166 and c.xyz_material_count>=2 --SHArk
  or c.id == 92633039 and c.xyz_material_count>=2 --Castel
  or c.id == 57774843 or c.id == 72989439 or c.id == 65192027 --JD,BLS,DAD
end
function MoonWhitelist2(id) -- cards to chain Book of Moon to to save your monsters
  return id == 29401950 or id == 44095762 -- Bottomless, Mirrorforce
  or id == 70342110 -- DPrison
end
function MoonFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and bit32.band(c.position,POS_FACEUP)>0 
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 and c:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
end
function MoonFilter2(c,p)
  return c:IsType(TYPE_MONSTER) and c:IsPosition(POS_FACEUP) and c:IsControler(p)
  and not c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET) and not c:IsHasEffect(EFFECT_IMMUNE_EFFECT)
  and not FilterType(c,TYPE_TOKEN)
end
function MoonFilter3(c)
  return MoonFilter(c) and ShaddollFusionFilter(c)
end
function MoonOppFilter(c)
  return MoonFilter(c) and bit32.band(c.type,TYPE_FLIP)==0
end
function MoonPriorityFilter(c)
  return MoonFilter(c) and MoonWhitelist(c)
end
function ChainBoM(card)
  local targets1 = CardsMatchingFilter(OppMon(),MoonOppFilter)
  local targets2 = CardsMatchingFilter(OppMon(),MoonPriorityFilter)
  local e=Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  local c = nil
  if e then
    c = e:GetHandler()
  end
  if RemovalCheckCard(card) and not c:IsCode(12697630) and targets1>0 then
    return true
  end
  if not UnchainableCheck(14087893) then
    return false
  end
  cg = NegateCheck()
  if cg and Duel.GetCurrentChain()>1 and not DeckCheck(DECK_BA) then
    if c and c:GetCode() == 29616929 then
      return false
    end
		if cg:IsExists(function(c) return c:IsControler(player_ai) end, 1, nil) 
    then
      local g=cg:Filter(MoonFilter2,nil,player_ai):GetMaxGroup(Card.GetAttack)
      if g then
        GlobalCardMode = 1
        GlobalTargetSet(g:GetFirst(),AIMon())
        return true
      end
    end	
  end
  cg = RemovalCheck()
  if cg and not DeckCheck(DECK_BA) then
    if cg:IsExists(function(c) return c:IsControler(player_ai) end, 1, nil) then
      local g=cg:Filter(MoonFilter2,nil,player_ai):GetMaxGroup(Card.GetAttack)
      if g and e and MoonWhitelist2(e:GetHandler():GetCode()) then
        GlobalCardMode = 1
        GlobalTargetSet(g:GetFirst(),AIMon())
        return true
      end
    end
  end
  if targets2>0 then
    for i=1,#OppMon() do
      if MoonPriorityFilter(OppMon()[i]) then
        GlobalCardMode = 1
        GlobalTargetSet(OppMon()[i],OppMon())
        return true
      end
    end
  end
  if Duel.GetCurrentPhase() == PHASE_BATTLE and Duel.GetTurnPlayer()==1-player_ai then
    local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if WinsBattle(source,target) and MoonFilter2(source,1-player_ai) 
    and not (target:GetCode()==68535320 and CardsMatchingFilter(OppMon(),DestroyFilter)>0)
    and not (target:GetCode()==95929069 and CardsMatchingFilter(OppST(),DestroyFilter)>0)
    then
      GlobalCardMode = 1
      GlobalTargetSet(source,OppMon())
      return true
    end
    if CanFinishGame(source) and #AIMon()==0 
    and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
    and UnchainableCheck(14087893)
    then
      GlobalCardMode = 1
      GlobalTargetSet(source)
      return true
    end
  end
  if e and e:GetHandler():GetCode() == 44394295 
  and e:GetHandler():IsControler(1-player_ai)
  and CardsMatchingFilter(AIMon(),MoonFilter3)==1
  and UnchainableCheck(14087893)
  then
    for i=1,#AIMon() do
      if MoonFilter3(AIMon()[i]) then
        GlobalCardMode = 1
        GlobalTargetSet(AIMon()[i],AIMon())
        return true
      end
    end
  end
end
function MirrorForceFilter(c)
  return bit32.band(c.position,POS_FACEUP_ATTACK)>0 and DestroyFilter(c,true)
end
function ChainMirrorForce()
  if not UnchainableCheck(44095762) then
    return false
  end
  local source = Duel.GetAttacker()
  if source and (CardsMatchingFilter(OppMon(),MirrorForceFilter)>1
  or not source:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT) and (WinsBattle(source,target)
  or source:IsType(TYPE_XYZ+TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO) or source:GetLevel()>4
  or source:GetAttack()>2000 or source:GetAttack()>=AI.GetPlayerLP(1)))
  then
    return true
  end
  if CanFinishGame(source) and #AIMon()==0 
  and Targetable(source,TYPE_TRAP) and Affected(source,TYPE_TRAP)
  and UnchainableCheck(50078509)
  then
    return true
  end
  return false
end
function ChainDPrison()
  if not UnchainableCheck(70342110) then
    return false
  end
  local source = Duel.GetAttacker()
  local target = Duel.GetAttackTarget()
  if WinsBattle(source,target) or source:GetCode()==68535320 or source:GetCode()==95929069 
  or source:IsType(TYPE_XYZ+TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO) or source:GetLevel()>4
  or source:GetAttack()>2000 or source:GetAttack()>=AI.GetPlayerLP(1)
  then
    return true
  end
  return false
end
function BottomlessFilter(c,type)
  return DestroyFilter(c,true,true)
  and Affected(c,type,4)
  and (type~=TYPE_TRAP or not TraptrixFilter(c))
  and c.attack>=1500
  and CurrentOwner(c)==2
end
function ChainBottomless()
  local targets = SubGroup(AI.GetLastSummonedCards(),BottomlessFilter,TYPE_TRAP)
  if UnchainableCheck(29401950) 
  and #targets>0
  then
    return true
  end
  return false
end
function ChainTTHN()
  if not UnchainableCheck(29616929) then
    return false
  end
  return true
end
function ChainTrapHole()
  if not UnchainableCheck(04206964) then
    return false
  end
  return true
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
function SanctumYesNo()
  return DestroyCheck(OppField())>0
end
function HATChain(cards)
  if HasID(cards,12444060,false,nil,LOCATION_ONFIELD) and ChainSanctum() then
    return {1,CurrentIndex}
  end
  if HasID(cards,12444060,false,nil,LOCATION_GRAVE) and SanctumYesNo() then
    return {1,CurrentIndex}
  end
  if HasID(cards,29223325) and ChainIgnition(cards[CurrentIndex]) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,73964868,ChainPleiades) then
    return {1,CurrentIndex}
  end
  if HasID(cards,91812341) then -- Traptrix Myrmeleo
    return {1,CurrentIndex}
  end
  if HasID(cards,45803070) then -- Traptrix Dionaea
    return {1,CurrentIndex}
  end
  if HasID(cards,68535320) then -- Fire Hand
    return {1,CurrentIndex}
  end
  if HasID(cards,95929069) then -- Ice Hand
    return {1,CurrentIndex}
  end
  if HasID(cards,29616929) then -- Traptrix Trap Hole Nightmare
    return {1,CurrentIndex}
  end
  if HasID(cards,44095762) and ChainMirrorForce() then
    return {1,CurrentIndex}
  end
  if HasID(cards,70342110) and ChainDPrison() then
    return {1,CurrentIndex}
  end
  if HasID(cards,29401950) and ChainBottomless() then
    return {1,CurrentIndex}
  end
  if HasID(cards,29616929) and ChainTTHN() then
    --return {1,CurrentIndex}
  end
  if HasID(cards,04206964) and ChainTrapHole() then
    return {1,CurrentIndex}
  end

  if HasID(cards,97077563,ChainCotH) then
    return {1,CurrentIndex}
  end
  if HasID(cards,14087893,ChainBoM) then
    return {1,CurrentIndex}
  end
  return nil
end
function HATEffectYesNo(id,card)
  local result = nil
  if id == 68535320 or id == 95929069 -- Fire Hand, Ice Hand
  or id == 91812341 or id == 45803070 -- Traptrix Myrmeleo, Dionaea
  or id == 29616929 -- Traptrix Trap Hole Nightmare
  then
    result = 1
  end
  if id == 63746411 and ChainGiantHand() then
    result = 1
  end
  if id == 12444060 and SanctumYesNo() then
    result = 1
  end
  if id == 85103922 then -- Moralltach
    result = 1
  end
  return result
end
HATAtt={
  91812341,45803070,91499077, -- Traptrix Myrmeleo, Dionaea, Gagaga Samurai
  2029218, 85103922, -- Artifact Scythe, Moralltach
}
HATDef={
  12697630, -- Beagalltach
}
function HATPosition(id,available)
  result = nil
  for i=1,#HATAtt do
    if HATAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#HATDef do
    if HATDef[i]==id then result=POS_FACEUP_DEFENCE end
  end
  if id == 68535320 or id == 95929069 -- Fire Hand, Ice Hand 
  or id == 63746411 -- Giant Hand
  then
    if Duel.GetTurnPlayer()==player_ai and (Duel.GetCurrentPhase()==PHASE_MAIN1
    and GlobalBPAllowed or bit32.band(Duel.GetCurrentPhase(),PHASE_BATTLE+PHASE_DAMAGE)>0)
    then
      result = POS_FACEUP_ATTACK 
    else
      result = POS_FACEUP_DEFENCE
    end
  end
  return result
end