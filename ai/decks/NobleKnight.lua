function NobleFilter(c,exclude)
  return IsSetCode(c.setcode,0x107a) and (exclude == nil or c.id~=exclude)
end
function NobleMonsterFilter(c,exclude)
  return bit32.band(c.type,TYPE_MONSTER)>0 and NobleFilter(c,exclude)
end
function ArmsFilter(c,exclude)
  return IsSetCode(c.setcode,0x207a) and (exclude == nil or c.id~=exclude)
end
function UseableArmsFilter(c,exclude)
  return ArmsFilter(c,exclude) and (bit32.band(c.location,LOCATION_SZONE)==0 
  or bit32.band(c.position,POS_FACEDOWN)>0)
end
function NobleOrArmsFilter(c,exclude)
  return NobleFilter(c,exclude) or ArmsFilter(c,exclude)
end
function RequipCheck(id)
  return id == 07452945 and OPTCheck(07452945)
      or id == 14745409 and OPTCheck(14745409)
      or id == 23562407 and OPTCheck(23562407)
      or id == 83438826 and OPTCheck(83438826)
end
function ArmsCount(cards,requip,skipgwen,raw)
  local result = 0
  if requip then
    for i=1,#cards do
      if RequipCheck(cards[i].id)
      and (bit32.band(cards[i].location,LOCATION_SZONE)==0 
      or bit32.band(cards[i].position,POS_FACEDOWN)>0 or raw)
      then
        result = result + 1
      end
    end
  else
    result = CardsMatchingFilter(cards,UseableArmsFilter,19748583)
    if not skipgwen and OPTCheck(19748583) 
    and HasID(UseLists({AIHand(),AIGrave()}),19748583,true)
    then
      result = result+1
    end
    if raw then
      if skipgwen then
        result = CardsMatchingFilter(cards,ArmsFilter,19748583)
      else
        result = CardsMatchingFilter(cards,ArmsFilter)
      end
    end
  end
  return result
end
function ArmsAvailable(requip,skipgwen,raw,grave)
  local cards = UseLists({AIHand(),AIST()})
  if grave then
    cards = UseLists({AIHand(),AIST(),AIGrave()})
  end
  result = ArmsCount(cards,requip,skipgwen,raw)
  return result
end
function ArmsRequip()
  return ArmsCount(AIST(),true,false,true)>0
end
function KnightCount(cards)
  return CardsMatchingFilter(cards,NobleFilter)
end
function EquipCheck(c)
  return c.equip_count and c.equip_count>0 
  and CardsMatchingFilter(c:get_equipped_cards(),ArmsFilter)>0
end
function DarkCheck(id)
  return id==95772051 or id==93085839 or id==59057152 
  or id==47120245 or id==73359475 or id==83519853 
end
function GwenCheck()
  return HasID(UseLists({AIHand(),AIGrave()}),19748583,true) and OPTCheck(19748583)
end
function NobleATKBoost(mode)
  -- calculates the maximum ATK boost for available arms
  local result = 0
  local cards = AIHand()
  local gallatin = false
  local caliburn = false
  local destiny = false
  if mode then
    if mode == 1 or mode == 3 then
      -- for High Sally
      local cards2 = AIDeck()
      if mode == 3 then
        cards2 = AIGrave() --for Chapter
      end
      if HasID(cards2,14745409,true) then
        result = result + 1000
      elseif HasID(cards2,23562407,true) then
        result = result + 500
      elseif HasID(cards2,07452945,true) then
        result = result + 1
      end
      if HasID(cards,07452945,true) and result ~= 1 then
        result = result + 1
      end
      if HasID(cards,23562407,true) and result ~= 500 and result ~= 501 then
        result = result + 500
      end
      if HasID(cards,14745409,true) and result<1000 then
        result = result + 1000
      end
      if GwenCheck() then
        result = result + 300
      end
      return result
    elseif mode == 2 then
      -- for a King
      cards = UseLists({AIHand(),AIGrave()})
    end
  end
  if HasID(cards,07452945,true) then
    result = result + 1
  end
  if HasID(cards,23562407,true) then
    result = result + 500
  end
  if HasID(cards,14745409,true) then
    result = result + 1000
  end
end
function ArmsByAtk(cards,baseatk)
  local atk=OppGetStrongestAttDef()
  if GwenCheck() then
    baseatk = baseatk + 300
  end
  if GetMultiple(14745409)>0 then
    baseatk = baseatk + 1000
  end
  if GetMultiple(23562407)>0 then
    baseatk = baseatk + 500
  end
  if GetMultiple(07452945)>0 then
    baseatk = baseatk + 1
  end
  if atk==baseatk and HasID(cards,07452945,true) and GetMultiple(07452945)==0 then
    SetMultiple(07452945)
    return {IndexByID(cards,07452945)}
  elseif atk>=baseatk and atk<baseatk+500 and HasID(cards,23562407,true) and GetMultiple(23562407)==0 then
    SetMultiple(23562407)
    return {IndexByID(cards,23562407)}
  elseif atk>=baseatk and HasID(cards,14745409,true) and GetMultiple(14745409)==0 then
    SetMultiple(14745409)
    return {IndexByID(cards,14745409)}
  elseif atk>=baseatk and HasID(cards,23562407,true) and GetMultiple(23562407)==0 then
    SetMultiple(23562407)
    return {IndexByID(cards,23562407)}
  elseif atk>=baseatk and HasID(cards,07452945,true) and GetMultiple(07452945)==0 then
    SetMultiple(07452945)
    return {IndexByID(cards,07452945)}
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function TableCount()
  local cards = UseLists({AIField(),AIGrave()})
  local result = 0
  local check = {}
  for i=1,#cards do
    if NobleFilter(cards[i]) and not check[cards[i].id] then
      result = result +1
      check[cards[i].id]=true
    end
  end
  return result
end
function KingArmsCount()
  local cards = AIGrave()
  local result = 0
  local check = {}
  for i=1,#cards do
    if ArmsFilter(cards[i],19748583) and not check[cards[i].id] then
      result = result +1
      check[cards[i].id]=true
    end
  end
  return result
end
function EquipFilter(c)
  if (c.id == 59057152 and UseMedraut()
  or c.id == 47120245 and ArmsCount(AIDeck())>2
  or c.id == 13391185 and UseChad()
  or c.id == 53550467 and OPTCheck(53550467)
  and DestroyCheck(OppField(),false,false,false,FilterPosition,POS_FACEUP)>0
  or c.id == 73359475)
  and not EquipCheck(c) then
    return true
  end
  return false
end
function NobleSSCheck()
  return GlobalNobleSS ~= Duel.GetTurnCount()
end
function BlackCheck(c)
  return NotNegated(c) and (c.id == 59057152 or c.id == 47120245 or c.id == 73359475)
end
function Lvl5Check(c)
  return HasID(UseLists({AIHand(),AIGrave()}),95772051,true) 
  and PriorityCheck(AIGrave(),2,PRIO_TOGRAVE,NobleMonsterFilter)>1
  and NormalCheck(c) or BlackCheck(c) and ArmsAvailable()>0
end
function NormalCheck(c)
  if FilterLocation(c,LOCATION_MZONE) then
    return BlackSallyFilter(c)
  else
    return c.id==59057152 or c.id==47120245 
    or c.id==13391185
  end
end
function DualUseArmsCheck()
  return ArmsAvailable(true)>0 or ArmsAvailable()>1
end
function PlayCheck()
  return (HasID(AIHand(),59057152,true) and UseMedraut(true,true) 
  and (DualUseArmsCheck() or HasID(AIHand(),46008667,true) and HasID(AIHand(),19680539,true))
  or HasID(AIHand(),47120245,true) and UseBorz(true) and (ArmsAvailable()>0 
  or CardsMatchingFilter(AIHand(),FilterID,19680539)>1)
  or HasID(AIHand(),03580032,true) --and (ArmsAvailable()>0
  or HasID(AIHand(),19680539,true) and CardsMatchingFilter(AIHand(),NormalCheck)>0 
  and ArmsAvailable(false,false,true)==0 and not HasID(AIHand(),47120245,true))
  or NormalSummonCheck(player_ai)
end
GlobalGallatinTurn={}
GlobalTableDump=0
GlobalNobleSS = 0
GlobalNobleExtra = nil
function MedrautCond(loc,c)
  if loc == PRIO_TOHAND then
    return SummonMedraut() and not HasID(AIHand(),59057152,true) 
    and (ArmsAvailable(true)>0 or ArmsAvailable()>1 or CardsMatchingFilter(AIDeck(),ArmsFilter)<2)
  end
  if loc == PRIO_TOFIELD then
    return (not FilterLocation(c,LOCATION_REMOVED) and (SummonMedraut(true) 
    or CardsMatchingFilter(AIDeck(),ArmsFilter)<2) and Duel.GetCurrentPhase()~=PHASE_END)
    and #AIMon()==0
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_DECK) then
      return not HasID(AIGrave(),59057152,true) 
    end
    if FilterLocation(c,LOCATION_MZONE) then
      return not UseMedraut()
    end
    return false
  end
  if loc == PRIO_BANISH then
    if HasID(AIMon(),68618157,true) then
      return true
    end
    return false
  end
  return true
end
function BorzCond(loc,c)
  if loc == PRIO_TOHAND then
    return SummonBorz() and not HasID(AIHand(),47120245,true) 
    and Duel.GetCurrentPhase()~=PHASE_END and not (OTKCheck() 
    and HasID(AIHand(),59057152,true) and DualUseArmsCheck())
    and not FilterLocation(c,LOCATION_REMOVED)
  end
  if loc == PRIO_TOFIELD then
    return ArmsCount(AIDeck(),false,false,true)>3 
    and Duel.GetCurrentPhase()~=PHASE_END
    and not OTKCheck()
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_DECK) then
      return not HasID(AIGrave(),47120245,true) 
    end
    if FilterLocation(c,LOCATION_MZONE) then
      return not UseBorz(true)
    end
    return false
  end
  return true
end
function ChadCond(loc,c)
  if loc == PRIO_TOHAND then
    if FilterLocation(c,LOCATION_REMOVED) then  
      return not AmaterasuCheck()
    else
      return UseChad(true) and not HasID(AIHand(),13391185,true) 
      and not OTKCheck()
    end
  end
  if loc == PRIO_TOFIELD then
    return FilterLocation(c,LOCATION_REMOVED) or SummonChad(true)
    and Duel.GetCurrentPhase()~=PHASE_END or OTKCheck() and FieldCheck(4)==1
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_DECK) then
      return not HasID(AIGrave(),13391185,true) 
    end
    return false
  end
  if loc == PRIO_BANISH then
    return HasID(AIMon(),68618157,true)
  end
  return true
end
function BedwyrCond(loc,c)
  if loc == PRIO_TOHAND then
    return true
  end
  if loc == PRIO_TOFIELD then
    return (ArmsAvailable(false,false,false,true)==0 and not ArmsRequip()
    and not (HasID(AIMon(),59057152,true) and SummonChainNoble()
    or HasID(AIHand(),19680539,true) and NobleSSCheck()))
    and Duel.GetCurrentPhase()~=PHASE_END and not OTKCheck()
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_DECK) then
      return not HasID(AIGrave(),30575681,true) 
    end
    return false
  end
  if loc == PRIO_BANISH then
    return HasID(AIMon(),68618157,true)
  end
  return true
end
function DrystanCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),53550467,true)
  end
  if loc == PRIO_TOFIELD then
    return SummonDrystan(true) or Duel.GetCurrentPhase()==PHASE_END
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_DECK) then
      return not HasID(AIGrave(),53550467,true) 
    end
    return false
  end
end
function PeredurCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),73359475,true)
  end
  if loc == PRIO_TOFIELD then
    return bit32.band(c.location,LOCATION_HAND)>0 or Duel.GetCurrentPhase()==PHASE_END
  end
  if loc == PRIO_TOGRAVE then
    if bit32.band(c.location,LOCATION_DECK)>0 then
      return not HasID(AIGrave(),73359475,true) 
    end
    if bit32.band(c.location,LOCATION_MZONE)>0 and EquipCheck(c) then
      return true
    end
    return false
  end
end
function GawaynCond(loc,c)
  if loc == PRIO_TOHAND then
    return (not HasID(AIHand(),19680539,true) 
    or FilterLocation(c,LOCATION_REMOVED)
    or OTKCheck() 
    or (HasID(AIHand(),47120245,true) and ArmsAvailable()==0
    or HasID(AIHand(),59057152,true) and UseMedraut(true) 
    and ArmsAvailable()==1 and HasID(AIHand(),46008667,true))
    and not (NormalSummonCheck(player_ai) and UseBorz(true)))
    and Duel.GetCurrentPhase()~=PHASE_END
  end
  if loc == PRIO_TOFIELD then
    return Duel.GetCurrentPhase()~=PHASE_END
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_DECK) then
      return not HasID(AIGrave(),19680539,true) 
    end
    if FilterLocation(c,LOCATION_MZONE) then
      return true
    end
    if FilterLocation(c,LOCATION_OVERLAY) then
      return true
    end
    return false
  end
  if loc == PRIO_BANISH then
    return HasID(AIMon(),68618157,true)
  end
end
function BlackSallyCond(loc,c)
  if loc == PRIO_TOHAND then
    return bit32.band(c.location,LOCATION_REMOVED)>0
  end
  if loc == PRIO_TOFIELD then
    return bit32.band(c.location,LOCATION_HAND+LOCATION_REMOVED)>0 
    or (ArmsAvailable(false,false,false,true)==0 and not ArmsRequip()
    and not (HasID(AIMon(),59057152,true) and SummonChainNoble()
    or HasID(AIHand(),19680539,true) and NobleSSCheck()))
    or ArmsAvailable()==0 and HasID(AIMon(),59057152,true) 
    and ArmsCount(AIST(),false,false,true)==1 and not ArmsRequip()
    and ArmsCount(AIGrave(),false,true,true)<2
    and not (HasID(AIHand(),19680539,true) or #AIMon()>1)
    or Duel.GetCurrentPhase()==PHASE_END
  end
  if loc == PRIO_TOGRAVE and bit32.band(c.location,LOCATION_DECK)>0 then
    return not HasID(AIGrave(),95772051,true) 
  end
  return true
end
function EachtarCond(loc,c)
  if loc == PRIO_TOHAND then
    return bit32.band(c.location,LOCATION_REMOVED)>0
  end
  if loc == PRIO_TOFIELD then
    return bit32.band(c.location,LOCATION_REMOVED)>0 
    or bit32.band(c.location,LOCATION_HAND)>0 
    and (Duel.GetCurrentPhase()==PHASE_END or 
    not (HasID(AIHand(),47120245,true) and HasID(AIHand(),93085839,true)))
  end
  if loc == PRIO_TOGRAVE and bit32.band(c.location,LOCATION_DECK)>0 then
    return not HasID(AIGrave(),93085839,true) 
  end
  return true
end
function ArtorigusCond(loc,c)
  if loc == PRIO_TOFIELD then
    return bit32.band(c.location,LOCATION_HAND+LOCATION_REMOVED)>0
  end
  if loc == PRIO_TOGRAVE then
    if bit32.band(c.location,LOCATION_DECK)>0 then
      return not HasID(AIGrave(),92125819,true) 
    end
    if bit32.band(c.location,LOCATION_MZONE)>0 then
      return true
    end
  end
  return true
end
function BrothersCond(loc,c)
  if loc == PRIO_TOHAND then
    return SummonBrothers() or bit32.band(c.location,LOCATION_REMOVED)>0 or Duel.GetCurrentPhase()==PHASE_END
  end
  if loc == PRIO_TOFIELD then
    return SummonBrothers(ss) and not OTKCheck()
    or Duel.GetCurrentPhase()==PHASE_END
  end
  if loc == PRIO_TOGRAVE and bit32.band(c.location,LOCATION_DECK)>0 then
    return not HasID(AIGrave(),57690191,true) 
  end
  return true
end
function ExcaliburnCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id) and GetMultiple(c.id)==0
    and (bit32.band(c.location,LOCATION_REMOVED)==0 or ArmsAvailable()==0)
  end
  return true
end
function GwenCond(loc,c)
  if loc == PRIO_TOHAND then
    local cards=UseLists({AIHand(),AIMon()})
    return not HasAccess(c.id) and GetMultiple(c.id)==0 and OPTCheck(19748583)
    and not ((HasID(cards,59057152,true) or HasID(AIHand(),03580032,true)or HasID(AIHand(),32807846,true)) 
    and not HasID(AIMon(),47120245,true))
    and not FilterLocation(c,LOCATION_GRAVE)
    and (bit32.band(c.location,LOCATION_REMOVED)==0 or ArmsAvailable()==0)
  end
  if loc == PRIO_TOGRAVE then
    if bit32.band(c.location,LOCATION_SZONE)==0 then 
      return ArmsAvailable()==0 and OPTCheck(19748583)
      --and not (HasID(AIHand(),66970385,true) and ArmsAvailable(true,false,true,true)==0)
    else
      return not ArmsRequip() or OPTCheck(19748583)
    end
  end
  return true
end
function RequipArmsCond(loc,c)
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_SZONE) then
      return OPTCheck(c.id)
    end
    if FilterLocation(c,LOCATION_DECK) then
      return HasID(AIHand(),66970385,true) and ArmsAvailable(true,false,true,true)==0
    end
    return false
  end
  if loc == PRIO_TOFIELD then
    return GetMultiple(c.id)==0
  end
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id) and GetMultiple(c.id)==0
    and (bit32.band(c.location,LOCATION_REMOVED)==0 or ArmsAvailable()==0)
  end
  return true
end
function ArfFilter(c)
  return bit32.band(c.position,POS_FACEDOWN)>0 and DestroyFilter(c)
end
function ArfCond(loc,c)
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_SZONE) then
      return OPTCheck(c.id) and CardsMatchingFilter(OppField(),ArfFilter)>0
    end
    return false
  end
  if loc == PRIO_TOFIELD then
    return GetMultiple(c.id)==0
  end
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id) and GetMultiple(c.id)==0
  end
  return true
end
function LadyCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return (FieldCheck(5,NobleFilter)>0 or CardsMatchingFilter(AIMon(),Lvl5Check)>0
    or EachtarCheck()) and SummonHighSally() and NobleSSCheck()
  end
  if loc == PRIO_TOHAND then
    return HasID(AIGrave(),92125819,true)
  end
end
function R5torigusCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return c.xyz_material_count==0 and PriorityCheck(AIGrave(),PRIO_TOFIELD,1,NobleMonsterFilter)>4
  end
end
function TableCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(UseLists({AIHand(),AIST()}),55742055,true)
  end
end

function GawaynCheck()
  return HasID(AIHand(),19680539,true) and DualityCheck() and Duel.GetCurrentPhase()~=PHASE_END and not UseMedraut()
end
function EachtarCheck()
  return HasID(UseLists({AIHand(),AIGrave()}),93085839,true) 
  and PriorityCheck(AIGrave(),PRIO_BANISH,2,NobleMonsterFilter)>1
  and DualityCheck()
end

function SummonBorz(ss)
  return (((ArmsAvailable()>0 or ArmsRequip()) and OPTCheck(47120245) 
  and ArmsCount(AIDeck(),false,false,true)>3 or GawaynCheck() and not ss
  or ArmsAvailable()>0 and FieldCheck(5,NobleMonsterFilter,95772051)==1 and SummonR5torigus()
  or HasID(UseLists({AIHand(),AIGrave()}),95772051,true) and not HasID(AIHand(),57690191,true))
  and (ss or not NormalSummonCheck(player_ai))) and not UseMedraut()
end
function SummonMedraut(ss)
  return ((ArmsAvailable(true)>0 or ArmsAvailable()>1 or (ArmsAvailable()>0 and not ss 
  and not HasID(AIHand(),47120245,true) and not HasID(AIHand(),03580032,true)))
  and #AIMon()==0 and OPTCheck(59057152) and DualityCheck()
  and (ss or not NormalSummonCheck(player_ai))) or GawaynCheck() and not ss and not HasID(AIHand(),47120245,true)
  or ArmsAvailable()>0 and FieldCheck(5,NobleMonsterFilter,95772051)==1 and SummonR5torigus()
end
function SummonChad(ss)
  return (((OPTCheck(13391185) and (ss or not NormalSummonCheck(player_ai)))
  and ArmsAvailable()>0 and PriorityCheck(AIGrave(),PRIO_TOHAND,1,NobleMonsterFilter)>2) 
  or GawaynCheck()) and not UseMedraut()
end
function SummonBedwyr(ss)
  return (OPTCheck(30575681) and (ss or not NormalSummonCheck(player_ai)))
  and ArmsAvailable()==0 and not UseMedraut()
end
function SummonPeredur(ss)
  return (ArmsAvailable()>0 and (ss or not NormalSummonCheck(player_ai))
  or FieldCheck(5,NobleMonsterFilter,83519853)==1 and SummonR5torigus())
  and not UseMedraut() and not UseChad()
end
function BlackSallyFilter(c)
  return NobleMonsterFilter(c) and bit32.band(c.type,TYPE_NORMAL)>0
end
function UseBlackSally()
  return MP2Check(2000) and (ArmsAvailable()==0 or PriorityCheck(AIMon(),PRIO_TOGRAVE,1,NobleMonsterFilter)>2)
end
function SummonBlackSally()
  return (HasID(AIGrave(),10736540,true) and SummonHighSally() 
  and FieldCheck(5,NobleMonsterFilter)==0 and not (HasID(AIMon(),47120245,true) and UseBorz()
  or HasID(AIMon(),73359475,true) and ArmsAvailable>0 and ArmsCount(AIGrave,false,true,true)>0)
  or FieldCheck(5,NobleMonsterFilter,83519853)==1 and SummonR5torigus()
  --or ArmsAvailable()==0 and not ArmsRequip() and OPTCheck(19748583)
  or ArmsAvailable()==0 and HasID(AIMon(),47120245,true)
  and UseBorz(true) and CardsMatchingFilter(AIMon(),NormalCheck)>1
  and not (FieldCheck(4,NobleMonsterFilter)==2 and (SummonR4torigus() or SummonChainNoble())))
  and not UseMedraut() and not AmaterasuCheck()
  and not UseChad()
  and not (HighSallyCheck(4) and HasID(AIHand(),19680539,true))
end
function UseBrothers()
  return PriorityCheck(AIGrave(),PRIO_TODECK,3,NobleFilter)>1 and OPTCheck(57690191)
end
function ChainBrothers()
  return HasID(AIHand(),95772051,true) or HasID(AIHand(),93085839,true) 
  or CardsMatchingFilter(AIHand(),LevelFilter,4)>1 and SummonR4torigus()
end
function SummonBrothers(ss)
  return OPTCheck(57690191) and (PriorityCheck(AIGrave(),PRIO_TODECK,6,NobleFilter)>1
  or PriorityCheck(AIGrave(),PRIO_TODECK,3,NobleFilter)>4 or ChainBrothers() and not ss)
  and (ss or not NormalSummonCheck(player_ai))
  and not UseMedraut()
end
function SetBrothers()
  return ((Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed))
  and (not HasID(AIST(),55742055,true) or TableCount()<6)
end
function UseArfDestroy()
  return CardsMatchingFilter(OppField(),ArfFilter)>0
end
function SummonEachtar()
  return ( HasID(AIMon(),68618157,true) 
  or (PriorityCheck(AIGrave(),PRIO_BANISH,2,NobleMonsterFilter)>1
  and (FieldCheck(5,NobleFilter)==1 and not HasID(AIMon(),83519853,true) or FieldCheck(5,NobleFilter)==2) 
  and SummonR5torigus() or HasID(AIGrave(),10736540,true) and SummonHighSally() 
  or #AIMon()==0)) and not UseMedraut() and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>0
end

function UseCaliburn(facedown)
  return (EquipTargetCheck(AIMon(),true) or ArmsCount(AIHand(),false,true)>1
  or OppHasStrongestMonster() or facedown) and not AmaterasuCheck()
  and CardsMatchingFilter(AIMon(),FilterRace,RACE_WARRIOR)>0 
end
function UseArf(facedown)
  return UseArfDestroy() and not AmaterasuCheck()
  or (EquipTargetCheck(AIMon(),true) and ArmsCount(AIHand(),true,true)==1)
end
function UseDestiny(facedown)
  return CardsMatchingFilter(AIMon(),FilterRace,RACE_WARRIOR)>0
  and not AmaterasuCheck()
  --and (ArmsCount(AIHand(),false,true)>1 or EquipTargetCheck(AIMon(),true)
  --or #AIMon()==1 or facedown)
end
function UseGallatin(facedown)
  return (ArmsCount(AIHand(),false,true)>1 or EquipTargetCheck(AIMon(),true)
  or OppHasStrongestMonster() or facedown)
  and CardsMatchingFilter(AIMon(),FilterRace,RACE_WARRIOR)>0
  and not AmaterasuCheck()
end
function UseGwen()
  return not AmaterasuCheck()
end
function UseExcaliburn(facedown)
  return  CardsMatchingFilter(AIMon(),NobleMonsterFilter)>0 and not AmaterasuCheck()
  --and (facedown or ArmsCount(AIHand(),false,true)>1 or EquipTargetCheck(AIMon(),true))
end
function ExcaliburnFilter(c)
  return NobleMonsterFilter(c) and FilterType(c,TYPE_XYZ) 
  and (c.xyz_material_count==0 or c.equip_count<2
  and ArmsCount(AIGrave(),false,true,true)>1)
end
function UseExcaliburnGrave()
  return CardsMatchingFilter(AIMon(),ExcaliburnFilter)>0
end
function BorzFilter(c)
  return c.id == 47120245 and c.equip_count>0 
  and CardsMatchingFilter(c:get_equipped_cards(),ArmsFilter)>0
end
function UseBorz(skiparms)
  return OPTCheck(47120245) and (HasID(AIMon(),47120245,true,nil,nil,nil,BorzFilter) 
  or ArmsAvailable()>0 or skiparms) and CardsMatchingFilter(AIDeck(),ArmsFilter)>2
end
function ChadFilter(c)
  return NobleMonsterFilter(c) 
  and c.id~=95772051 and c.id~=93085839
  and c.id~=83519853 and c.id~=21223277
  and c.id~=10613952
end
function ChadFilter2(c)
  return c.id == 13391185 and c.equip_count>0 
  and CardsMatchingFilter(c:get_equipped_cards(),ArmsFilter)>0
end
function UseChad(skiparms)
  return OPTCheck(13391185) and (HasID(AIMon(),13391185,true,nil,nil,nil,ChadFilter2)
  or HasID(AIMon(),13391185,true) and ArmsAvailable()>0 or skiparms)
  and CardsMatchingFilter(AIGrave(),ChadFilter)>0 
  and not (OTKCheck() and not HasID(AIGrave(),19680539,true))
end
function UseBedwyr()
  return false
end
GlobalBedwyrID = 0
function ChainBedwyr()
  local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if e and e:GetHandler():IsType(TYPE_EQUIP) then
    return false
  end
  if not UnchainableCheck(30575681) then
    return false
  end
  if HasID(AIST(),07452945,true,FilterPosition,POS_FACEUP) then
    local destiny = FindID(07452945,AIST())
    local eq = destiny:get_equip_target()[1]
    local targets = {}
    for i=1,#AIMon() do
      local c=AIMon()[i]
      if RemovalCheckCard(c,CATEGORY_DESTROY) 
      and not RemovalCheckCard(eq,CATEGORY_DESTROY)
      and not CardsEqual(c,eq)
      and not (HasID(c:get_equipped_cards(),19748583,true) and FilterAttribute(c,ATTRIBUTE_LIGHT))
      then
        targets[#targets+1]=c
      end
    end
    if #targets>0 then
      BestTargets(targets,1,TARGET_PROTECT)
      GlobalBedwyrID = 07452945
      GlobalTargetSet(targets[1])
      return true
    end
  end
  if HasID(AIST(),19748583,true,FilterPosition,POS_FACEUP) then
    local gwen = FindID(19748583,AIST())
    local eq = gwen:get_equip_target()[1]
    local targets = {}
    for i=1,#AIMon() do
      local c=AIMon()[i]
      if RemovalCheckCard(c,CATEGORY_DESTROY)
      and FilterAttribute(c,ATTRIBUTE_LIGHT)
      and not DarkCheck(c.id)
      and not RemovalCheckCard(eq,CATEGORY_DESTROY)
      and not CardsEqual(c,eq)
      and not (HasID(c:get_equipped_cards(),19748583,true) and FilterAttribute(c,ATTRIBUTE_LIGHT))
      then
        targets[#targets+1]=c
      end
    end
    if #targets>0 then
      BestTargets(targets,1,TARGET_PROTECT)
      GlobalBedwyrID = 19748583
      GlobalTargetSet(targets[1])
      return true
    end
    local aimon,oppmon=GetBattlingMons()
    if Duel.GetTurnPlayer()==1-player_ai 
    and WinsBattle(oppmon,aimon)
    and aimon:GetEquipGroup():FilterCount(function(c)return c:GetCode()==19748583 end,nil)==0
    and (DarkCheck(aimon:GetCode())
    and Affected(oppmon,TYPE_SPELL)
    and DestroyFilterIgnore(oppmon,true)
    or AttackBoostCheck(300))
    then
      GlobalBedwyrID = 19748583
      GlobalTargetSet(aimon)
      return true
    end
  end
  if HasID(AIST(),23562407,true,FilterPosition,POS_FACEUP) then
    local aimon,oppmon=GetBattlingMons()
    if Duel.GetTurnPlayer()==1-player_ai 
    and WinsBattle(oppmon,aimon)
    and aimon:GetEquipGroup():FilterCount(function(c)return c:GetCode()==23562407 end,nil)==0
    and AttackBoostCheck(500)
    then
      GlobalBedwyrID = 23562407
      GlobalTargetSet(aimon)
      return true
    end
  end
  if HasID(AIST(),14745409,true,FilterPosition,POS_FACEUP) then
    local gallatin=FindID(14745409,AIST())
    local drop = 0
    local turn = GlobalGallatinTurn[gallatin.cardid]
    if turn then
      drop = Duel.GetTurnCount()-turn*200
    end
    local atk = 1000-drop
    local aimon,oppmon=GetBattlingMons()
    if atk>0
    and Duel.GetTurnPlayer()==1-player_ai 
    and WinsBattle(oppmon,aimon)
    and aimon:GetEquipGroup():FilterCount(function(c)return c:GetCode()==14745409 end,nil)==0
    and AttackBoostCheck(atk)
    then
      GlobalBedwyrID = 14745409
      GlobalTargetSet(aimon)
      return true
    end
  end
  if HasID(AIST(),07452945,true,FilterPosition,POS_FACEUP) then
    local aimon,oppmon=GetBattlingMons()
    if Duel.GetTurnPlayer()==1-player_ai 
    and WinsBattle(oppmon,aimon)
    and aimon:GetEquipGroup():FilterCount(function(c)return c:GetCode()==07452945 end,nil)==0
    and not (aimon:GetEquipGroup():FilterCount(function(c)return c:GetCode()==19748583 end,nil)>0
    and DarkCheck(aimon:GetCode())
    and Affected(oppmon,TYPE_SPELL)
    and DestroyFilterIgnore(oppmon,true))
    then
      GlobalBedwyrID = 07452945
      GlobalTargetSet(aimon)
      return true
    end
  end
  return false
  --return Duel.GetCurrentPhase()==PHASE_MAIN1 and Duel.GetTurnPlayer()==1-player_ai
end
function SummonMerlin()
  return DualityCheck() and OPTCheck(03580032) and not UseMedraut()
  and not (HasID(AIHand(),59057152,true) and SummonMedraut())
  and not (HasID(AIHand(),47120245,true) and SummonBorz() and not SummonMedraut(true))
end
function SummonDrystan()
  return ArmsAvailable()>0 and OPTCheck(53550467) 
  and DestroyCheck(OppField(),false,false,false,FilterPosition,POS_FACEUP)>0
  and not UseMedraut()
end
function HighSallyFilter(c)
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0
  and DestroyCountCheck(c,TYPE_MONSTER,true)
  and FilterPendulum(c)
  and not ((c.id == 48739166 or c.id == 78156759
  or c.id == 10002346) and c.xyz_material_count>0)
end
function HighSallySummonFilter(c,mode)
  return HighSallyFilter(c) and c.attack<2100+NobleATKBoost(mode)
end
function UseHighSally(mode)
  if mode == nil then mode = 1 end
  ApplyATKBoosts(OppMon())
  return Duel.GetCurrentPhase()== PHASE_MAIN1 and GlobalBPAllowed 
  and CardsMatchingFilter(OppMon(),HighSallySummonFilter,mode)>0
end
function SummonHighSally()
  return DualityCheck() and HasID(AIExtra(),83519853,true) and UseHighSally()
end
function SummonLady()
  return (FieldCheck(4,NobleKnightFilter)==1 or HasID(AIGrave(),92125819,true))
  and SummonHighSally() and not UseMedraut() and not UseChad()
end
function UseLady()
  return FieldCheck(5,NobleKnightFilter)>0 and not UseMedraut() 
end
function UseMedraut(skiparms,skipmon)
  return DualityCheck() and OPTCheck(59057152)
  and (skipmon or  #AIMon()==1 and HasID(AIMon(),59057152,true)
  and (skiparms or ArmsAvailable()>0 or #AIMon()==1 and EquipCheck(AIMon()[1])))  
end
function SummonGawayn()
  return ((SummonR4torigus() or SummonChainNoble() or SummonTsukuyomiNK()) and (FieldCheck(4,NobleFilter)==1 
  or FieldCheck(4,NobleFilter)==2 and HasID(AIMon(),47120245,true,nil,nil,nil,HasEquips,0) and UseBorz(true))
  or SummonAmaterasu() and FieldCheck(4,NobleFilter)==2
  or HighSallyCheck(4) or OTKCheck())
  and not UseMedraut()
end
function SummonR4torigus()
  return HasID(AIExtra(),21223277,true) and ArmsCount(UseLists({AIST(),AIGrave()}),false,true,true)>1
  and (OppHasStrongestMonster() or #OppST()>1)
  and not (HasID(AIMon(),13391185,true) and ArmsAvailable()>0 and UseChad())
end
function UseR4torigus()
  return DestroyCheck(OppST())>0
  and not (HasID(AIMon(),13391185,true) and UseChad() and ArmsAvailable()>0)
end
function SummonR5torigus()
  return HasID(AIExtra(),10613952,true) and ArmsCount(UseLists({AIST(),AIGrave()}),false,true,true)>1
  and (OppHasStrongestMonster() or Duel.GetCurrentPhase()==PHASE_MAIN2
  or ArmsCount(AIGrave(),false,true,true)>2 and ArmsCount(AIST(),false,true,true)<2) and DestroyCheck(OppMon())>0
end
function UseR5torigus()
  return DestroyCheck(OppMon())>0
end
function UseTable()
  return not HasID(AIST(),55742055,true) and CardsMatchingFilter(UseLists({AIField(),AIGrave()}),NobleFilter)>1
  and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
end
function SummonChainNoble()
  return HasID(AIExtra(),34086406,true) and NobleSSCheck() 
  and ((SummonHighSally() and HasID(AIDeck(),10736540,true) 
  and (FieldCheck(5,NobleFilter)>0 or (FieldCheck(4,NobleFilter)>2 and CardsMatchingFilter(AIMon(),Lvl5Check)>0)))
  or HasID(AIDeck(),19748583,true) and OPTCheck(19748583) and ArmsAvailable(false,false,true,true)==0
  or HasID(AIMon(),47120245,true) and (FieldCheck(4,NobleFilter)>=2 
  or FieldCheck(4,NobleFilter)==1 and CardsMatchingFilter(AIHand(),FilterID,19680539)>1)
  and ArmsAvailable()==0 and OPTCheck(19748583) and UseBorz(true))
  and not (ArmsAvailable()==0 and HasID(AIMon(),47120245,true) 
  and UseBorz(true) and CardsMatchingFilter(AIMon(),NormalCheck)>1
  and HasID(UseLists({AIHand(),AIMon()}),95772051,true))
  and not ( UseChad() or UseBorz()
  or SummonAmaterasu() or OTKCheck()) 
end
function UseChapter()
  return HasID(AIGrave(),83519853,true)
  or HasID(AIGrave(),59057152,true) and UseMedraut(true,true)
  or HasID(AIGrave(),13391185,true) and UseChad(true)
  or HasID(AIGrave(),47120245,true) and ArmsCount(AIDeck(),false,false,true)>3
end
function SetAdvice()
  return CardsMatchingFilter(AIST(),FilterPosition,POS_FACEDOWN)==0
  and (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed)
  and AI.GetPlayerLP(1)>3000
end
function HighSallyCheck(level)
  return SummonHighSally() and (HasID(AIDeck(),10736540,true) and HasID(AIExtra(),34086406,true)
  or HasID(AIHand(),10736540,true) and HasID(AIExtra(),73289035,true))
  and (level == 4 and FieldCheck(4,NobleFilter) == 1 and FieldCheck(5,NobleFilter) == 1
  or level == 5 and FieldCheck(4,NobleFilter)>1)
end
function AmaterasuCheck()
  return SummonAmaterasu() and HasID(UseLists({AIGrave(),AIBanish()}),19680539,true) 
  and FieldCheck(4,NobleMonsterFilter)>=2
end
function AmaterasuFilterNK(c)
  return NobleMonsterFilter(c) and c.level<5
end
function SummonAmaterasu()
  return HasID(AIExtra(),68618157,true) and (CardsMatchingFilter(AIBanish(),AmaterasuFilterNK)>1
  or HasID(AIMon(),93085839,true) and CardsMatchingFilter(AIBanish(),AmaterasuFilterNK)>0
  or EachtarCheck()) and (FieldCheck(4)>2 or HasID(AIHand(),19680539,true) 
  or HasID(AIMon(),13391185,true,nil,nil,nil,HasEquips) and HasID(AIGrave(),19680539,true) )
  and DualityCheck() and NobleSSCheck() and not (UseChad())
end
function SummonExcalibur()
  return OTKCheck() and (FieldCheck(4)==3 and (HasID(AIMon(),19680539,true) 
  and HasID(AIMon(),13391185,true,nil,nil,nil,HasEquips)
   or HasID(AIHand(),19680539,true)) or FieldCheck(4)>3) or HasID(OppMon(),27279764,true) 
  and not (HasAccess(14745409) and HasAccess(23562407))
end
function UseExcalibur()
  return Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
end
function SummonBladeArmor()
  return OTKCheck() and HasID(AIMon(),60645181,true)
end
function UseBladeArmor()
  return Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
end
function TsukuyomiHandCheck()
  local AdviceCheck=false
  local result = 0
  local setable = 0
  for i=1,#AIHand() do
    local c = AIHand()[i]
    if c.id == 92512625 then
      if not AdviceCheck and not HasID(AIST(),92512625,true) then
        AdviceCheck = true
      else
        return false
      end
    end
    if FilterType(c,TYPE_SPELL+TYPE_TRAP) then
      setable = setable + 1
    else
      result = result + 1
    end
  end
  return setable <= Duel.GetLocationCount(player_ai,LOCATION_SZONE) 
  and result < 3 and PriorityCheck(AIHand(),PRIO_TOGRAVE,math.max(1,result-1),FilterType,TYPE_MONSTER)>4
end
function SummonTsukuyomiNK()
  return DeckCheck(DECK_NOBLEKNIGHT) and HasID(AIExtra(),73289035,true) 
  and HasID(AIHand(),10736540,true) and SummonHighSally()
  and TsukuyomiHandCheck() and (FieldCheck(5,NobleMonsterFilter)>0 or EachtarCheck())
  and not UseChad() and not AmaterasuCheck() 
  and DualityCheck() and NobleSSCheck() and not SummonAmaterasu()
end
function UseTsukuyomiNK()
  return DeckCheck(DECK_NOBLEKNIGHT) and (#AIHand()<4 and PriorityCheck(AIHand(),PRIO_TOGRAVE,math.max(#AIHand()-1,1),FilterType,TYPE_MONSTER)>4
  or #AIHand()==1)
end
function TsukuyomiFilter(c)
  return HasMaterials(c) and NotNegated(c) and OPTCheck(c.cardid)
end
function OTKCheck()
  local cards=UseLists({AIMon(),AIExtra()})
  return Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
  and DualityCheck() and NobleSSCheck() and AI.GetPlayerLP(2)<=8400 and AI.GetPlayerLP(2)>3000
  and #OppField()==0 and HasID(cards,60645181,true) and HasID(cards,82944432,true)
end
function UseRotA()
  if DeckCheck(DECK_NOBLEKNIGHT) then
    local cards = UseLists({AIMon(),AIHand()})
    return (not PlayCheck() or (OTKCheck() or SummonHighSally()) 
    and not HasAccess(19680539)) 
    and #AIMon()<2
    and (HasID(AIHand(),19680539,true) 
    or CardsMatchingFilter(cards,NormalCheck)>0 
    or ArmsAvailable()>0)
    or CardsMatchingFilter(AIHand(),NobleMonsterFilter)==0 
    and not NormalSummonCheck(player_ai)
    and not HasID(AIHand(),03580032,true)
  end
  if DeckCheck(DECK_HERO) then
    return false
  end
  return true
end
function CastelNKFilter(c)
  return c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)>0
  and (c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)>0 
  or c.attack>=4000)
end
function SummonCastelNK()
  local targets=SubGroup(OppMon(),CastelNKFilter)
  if #targets > 0 and OPTCheck(82633039) then
    return true
  end
  return false
end
function UseChainNK()
  return DeckCheck(DECK_NOBLEKNIGHT)
end
function NobleInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  if HasID(AIMon(),73289035,true,nil,nil,nil,TsukuyomiFilter) 
  and #SetST>0 and #AIHand()>1 and TsukuyomiHandCheck() then
    return {COMMAND_SET_ST,1}
  end
  if HasIDNotNegated(Act,73289035) and UseTsukuyomiNK() then
    OPTSet(Act[CurrentIndex].cardid)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,68618157) then -- Amaterasu
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,23562407,false,nil,LOCATION_SZONE,POS_FACEUP) then -- Caliburn LP Recovery
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,83438826,false,nil,LOCATION_SZONE,POS_FACEUP) and UseArfDestroy() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,66970385) and UseChapter() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,82944432) and UseExcalibur() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,60645181) and UseBladeArmor() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,32807846) and UseRotA() then 
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,34086406,false,545382497) and UseChainNK() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,10736540) and UseLady() then 
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,10736540) and SummonLady() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,19748583,false,nil,LOCATION_GRAVE) and HasID(AIMon(),21223277,true) then
    OPTSet(19748583)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,21223277) and UseR4torigus() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,10613952) and UseR5torigus() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,03580032,false,nil,LOCATION_MZONE) then -- Merlin
    OPTSet(03580032)
    GlobalNobleSS = Duel.GetTurnCount()
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,59057152) and UseMedraut() then -- Medraut
    GlobalMedraut = 1
    OPTSet(59057152)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,47120245) then -- Borz
    OPTSet(47120245)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,13391185) and UseChad() then
    OPTSet(13391185)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,30575681) and UseBedwyr() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Act,57690191) and UseBrothers() then
    OPTSet(57690191)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,03580032) and SummonMerlin() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,59057152) and SummonMedraut() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,47120245) and SummonBorz() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,13391185) and SummonChad() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,30575681) and SummonBedwyr() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,53550467) and SummonDrystan() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,48739166) and SummonSharkKnightBujin() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,82633039) and SummonCastelNK() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,60645181) and SummonExcalibur() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,82944432) and SummonBladeArmor() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,19680539) and SummonGawayn() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Act,93085839) and SummonEachtar() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,83519853) and SummonHighSally() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,34086406) and SummonChainNoble() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,73289035) and SummonTsukuyomiNK() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,68618157) and SummonAmaterasu() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Act,95772051,false,nil,LOCATION_HAND+LOCATION_GRAVE) and SummonBlackSally() then
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSum,21223277) and SummonR4torigus() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSum,10613952) and SummonR5torigus() then
    GlobalNobleExtra = 1
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Act,46008667,false,nil,LOCATION_GRAVE) and UseExcaliburnGrave() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,57690191) and SummonBrothers() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,73359475) and SummonPeredur() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
    if HasID(Act,95772051,false,nil,LOCATION_MZONE) and UseBlackSally() then
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,83438826,false,nil,LOCATION_SZONE,POS_FACEDOWN) and UseArf(true) then
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,83438826,false,nil,LOCATION_HAND) and UseArf() then
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,23562407,false,nil,LOCATION_SZONE,POS_FACEDOWN) and UseCaliburn(true) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,23562407,false,nil,LOCATION_HAND) and UseCaliburn() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,07452945,false,nil,LOCATION_SZONE,POS_FACEDOWN) and UseDestiny(true) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,07452945,false,nil,LOCATION_HAND) and UseDestiny() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,14745409,false,nil,LOCATION_SZONE,POS_FACEDOWN) and UseGallatin(true) then
    GlobalGallatinTurn[Act[CurrentIndex].cardid]=Duel.GetTurnCount()
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,14745409,false,nil,LOCATION_HAND) and UseGallatin() then
    GlobalGallatinTurn[Act[CurrentIndex].cardid]=Duel.GetTurnCount()
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,46008667,false,nil,LOCATION_SZONE,POS_FACEDOWN) and UseExcaliburn(true) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,46008667,false,nil,LOCATION_HAND) and UseExcaliburn() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,19748583,false,nil,LOCATION_GRAVE) and UseGwen() then
    OPTSet(19748583)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Act,19748583,false,nil,LOCATION_HAND) and UseGwen() then
    OPTSet(19748583)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,73359475) and OverExtendCheck() then -- Peredur
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,92125819) and OverExtendCheck() then -- Artorigus
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,53550467) and OverExtendCheck() then -- Drystan
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,47120245) and OverExtendCheck() then -- Borz
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,59057152) and OverExtendCheck() then -- Medraut
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,13391185) and OverExtendCheck() then -- Chad
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Sum,30575681) and OverExtendCheck() then -- Bedwyr
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,66970385) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Sum,19680539) and #AIMon() == 0 then -- Gawayn
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Act,55742055) and UseTable() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SetMon,57690191) and SetBrothers() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,10736540) and SetMonster() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetMon,19748583) and SetMonster() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetST,92512625) and SetAdvice() then
    return {COMMAND_SET_ST,CurrentIndex}
  end
  return nil
end
function MedrautTarget(cards)
  if GlobalMedraut == 1 then
    GlobalMedraut = nil
    return Add(cards,PRIO_TOFIELD)
  else
    return Add(cards,PRIO_TOGRAVE)
  end
end
function EquipTargetCheckFunc(cards,id,func,opt,skipeqcheck,skipmultiple)
  for i=1,#cards do
    if (((id== nil or cards[i].id == id and (opt==nil and func() or opt and func(opt))) and GetMultiple(cards[i].cardid)==0) 
    and (skipeqcheck or not EquipCheck(cards[i])))
    and CurrentMonOwner(cards[i].cardid) == 1
    then
      if skipmultiple~=true then SetMultiple(cards[i].cardid) end
      return {i}
    end
  end
  return nil
end
function EquipTargetCheck(cards,skipmultiple)
  local result = nil
  result = EquipTargetCheckFunc(cards,59057152,UseMedraut,true,false,skipmultiple)
  if result then return result end
  result = EquipTargetCheckFunc(cards,47120245,function() return ArmsCount(AIDeck(),false,false,true)>2 end,nil,false,skipmultiple) 
  if result then return result end
  result = EquipTargetCheckFunc(cards,13391185,UseChad,true,false,skipmultiple) 
  if result then return result end
  result = EquipTargetCheckFunc(cards,53550467,function() return DestroyCheck(OppField(),false,false,false,FilterPosition,POS_FACEUP)>0 and OPTCheck(53550467) end,nil,true,skipmultiple) 
  if result then return result end
  result = EquipTargetCheckFunc(cards,73359475,function() return true end,nil,false,skipmultiple) 
  if result then return result end
  if OppHasStrongestMonster() then
    
  end
  return nil
end
function EquipTarget(cards,id)
  result = EquipTargetCheck(cards) 
  if result then return result end
  result = EquipTargetCheckFunc(cards) 
  if result then return result end
  local count = 999
  for i=1,#cards do
    local c = cards[i]
    if CurrentMonOwner(c.cardid) == 1 and c.equip_count<count then
      count = c.equip_count
      result = i
    end
  end
  if result then return {result} end
  return {math.random(#cards)}
end
function BorzTarget(cards,min)
  if min == 3 then
    return Add(cards,PRIO_TOHAND,3)
  else
    return {math.random(#cards)}
  end
end
function ArfTarget(cards,c)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return EquipTarget(cards)
  else
    return BestTargets(cards)
  end
end
function ExcaliburnTarget(cards,c)
  if FilterLocation(cards[1],LOCATION_MZONE) then
    return EquipTarget(cards)
  end
  return Add(cards,PRIO_TOFIELD)
end
function MerlinTarget(cards,min)
  if FilterLocation(cards[1],LOCATION_MZONE) then
    result = {}
    if GlobalMerlinID and #GlobalMerlinID>0 then
      for i=1,#cards do
        for j=1,#GlobalMerlinID do
          if cards[i].id == GlobalMerlinID[j] then
            result[j]=i
          end
        end
      end
    else
      result = Add(cards,PRIO_TOGRAVE,min)
    end
    for i=1,#cards do
      if result[#result]~=i and #result<min then
        result[#result+1]=i
      end
    end
    return result
  end
  return Add(cards,PRIO_TOFIELD,min)
end
function LadyTarget(cards)
  return {math.random(#cards)}
end


function HighSallyTarget(cards)
  if IsBattlePhase() then
    return Add(cards)
  else
    local result = ArmsByAtk(cards,2100)
    if result then
      return result
    end
    return Add(cards,PRIO_TOFIELD)
  end
  return {math.random(#cards)}
end
function DrystanTarget(cards)
  OPTSet(53550467)
  return BestTargets(cards,1,TARGET_DESTROY)
end
function BrothersTarget(cards,min)
  if min == 3 then
    return Add(cards,PRIO_TODECK,3)
  else
    if HasID(cards,47120245,true) and HasID(AIHand(),95772051,true) then
      return Add(cards,PRIO_TOFIELD,2)
    end
    return Add(cards,PRIO_TOFIELD,math.min(min,2))
  end
end
function ArmsTargets(cards,max)
  local result = {}
  for i=1,#cards do
    local c = cards[i]
    if c.owner == 1 and ArmsFilter(c) and c:get_equip_target()
    and (c.id == 23562407 and OPTCheck(23562407) 
    or c.id == 14745409 and OPTCheck(14745409) 
    and GlobalGallatinTurn[c.cardid] 
    and GlobalGallatinTurn[c.cardid]<Duel.GetTurnCount() 
    or CurrentOwner(c:get_equip_target()[1])==2)
    then
      result[#result+1]=i
      if #result >= max then break end
    end
  end
  return result
end 

function R4torigusTarget(cards,max)
  if ArmsFilter(cards[1]) and FilterLocation(cards[1],LOCATION_GRAVE) then
    local result = ArmsByAtk(cards,2000)
    if result ~= nil then
      return result
    end 
    return Add(cards,PRIO_TOFIELD)
  end
  if FilterLocation(cards[1],LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  local count = DestroyCheck(OppST(),true)
  local targets = {} 
  if count >= max then
    count = max
  end
  if count < max then
    targets = ArmsTargets(cards,max-count)
  end
  return UseLists({BestTargets(cards,count,TARGET_DESTROY),targets})
end
function R5torigusTarget(cards,c)
  if ArmsFilter(cards[1]) and FilterLocation(cards[1],LOCATION_GRAVE) then
    local result = ArmsByAtk(cards,2000)
    if result ~= nil then
      return result
    end 
    return Add(cards,PRIO_TOFIELD)
  end
  if FilterLocation(cards[1],LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if NobleMonsterFilter(cards[1]) and FilterLocation(cards[1],LOCATION_GRAVE) then
    return Add(cards,PRIO_TOFIELD)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function TableTarget(cards)
  if FilterLocation(cards[1],LOCATION_DECK) then
    return Add(cards,PRIO_TOGRAVE)
  elseif FilterLocation(cards[1],LOCATION_GRAVE) then
    return Add(cards)
  elseif FilterLocation(cards[1],LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  if result == nil then result = {math.random(#cards)} end
  return result
end
function ChadTarget(cards)
  if FilterLocation(cards[1],LOCATION_GRAVE) then
    return Add(cards,PRIO_TOHAND)
  end
  return Add(cards,PRIO_TOGRAVE)
end
function BedwyrTarget(cards)
  if FilterLocation(cards[1],LOCATION_DECK) then
    return Add(cards)
  elseif FilterLocation(cards[1],LOCATION_MZONE) then
    return GlobalTargetGet(cards,true)
  elseif FilterLocation(cards[1],LOCATION_SZONE) then
    return BestTargets(cards,1,TARGET_PROTECT,FilterID,GlobalBedwyrID)
  end
  return BestTargets(cards,1,TARGET_PROTECT)
end
function BlackSallyTarget(cards,c)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards,PRIO_TOHAND)
end
function ChapterTarget(cards)
  if NobleMonsterFilter(cards[1]) then
    if HasID(cards,83519853,true) and UseHighSally() then
      return {IndexByID(cards,83519853)}
    end
    if HasID(cards,59057152,true) and UseMedraut(true,true) then
      return {IndexByID(cards,59057152)}
    end
    if HasID(cards,13391185,true) and UseChad(true) then
      return {IndexByID(cards,13391185)}
    end
    if HasID(cards,47120245,true) and ArmsCount(AIDeck(),false,false,true)>3 then
      return {IndexByID(cards,47120245)}
    end
    return Add(cards,PRIO_TOFIELD)
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function EachtarTarget(cards)
  return Add(cards,PRIO_BANISH,2)
end
function PeredurTarget(cards)
  Add(cards,PRIO_TOHAND)
end
function AmaterasuTarget(cards)
  if FilterLocation(cards[1],LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  if Duel.GetTurnPlayer()==player_ai then
    return Add(cards,PRIO_TOFIELD)
  else
    return Add(cards,PRIO_TOHAND)
  end
end
function NobleCard(cards,min,max,id,c)
  if GlobalNobleExtra and GlobalNobleExtra>0 then
    GlobalNobleExtra = GlobalNobleExtra - 1
    if GlobalNobleExtra <=0 then GlobalNobleExtra = nil end
    return Add(cards,PRIO_TOGRAVE,min)
  end
  if c then
    id = c.id
  end
  if id == 47120245 then -- Borz
    return BorzTarget(cards,min)
  end
  if id == 59057152 then 
    return MedrautTarget(cards)
  end
  if id == 23562407 or id == 19748583 or id == 07452945 
  or id == 14745409 
  then
    return EquipTarget(cards,id)
  end
  if id == 83438826 then
    return ArfTarget(cards,c)
  end
  if id == 46008667 then
    return ExcaliburnTarget(cards,c)
  end
  if id == 03580032 then
    return MerlinTarget(cards,min)
  end
  if id == 10736540 then
    return LadyTarget(cards)
  end
  if id == 83519853 then
    return HighSallyTarget(cards)
  end
  if id == 53550467 then
    return DrystanTarget(cards)
  end
  if id == 57690191 then
    return BrothersTarget(cards,min)
  end
  if id == 21223277 then
    return R4torigusTarget(cards,max)
  end
  if id == 10613952 then
    return R5torigusTarget(cards,c)
  end
  if id == 55742055 then
    return TableTarget(cards)
  end
  if id == 13391185 then
    return ChadTarget(cards)
  end
  if id == 30575681 then
    return BedwyrTarget(cards)
  end
  if id == 95772051 then
    return BlackSallyTarget(cards,c)
  end
  if id == 66970385 then
    return ChapterTarget(cards)
  end
  if id == 93085839 then
    return EachtarTarget(cards)
  end
  if id == 73359475 then
    return PeredurTarget(cards)
  end
  if id == 68618157 then
    return AmaterasuTarget(cards)
  end
  return nil
end
function ChainCaliburn()
  OPTSet(23562407)
  SetMultiple(23562407)
  return true
end
function ChainArf()
  OPTSet(83438826)
  SetMultiple(83438826)
  return true
end
function ChainDestiny()
  OPTSet(07452945)
  SetMultiple(07452945)
  return true
end
function ChainGallatin(c)
  OPTSet(14745409)
  SetMultiple(14745409)
  GlobalGallatinTurn[c.cardid]=Duel.GetTurnCount()
  return true
end
function TableSummon()
  return OverExtendCheck() or HasID(AIHand(),95772051,true) or HasID(AIHand(),93085839,true)
  or HasID(AIHand(),57690191,true) or HasID(AIHand(),92125819,true)
end
function ChainAmaterasu()
  if RemovalCheck(68618157) then
    return true
  end
  if NegateCheck(68618157) then
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai then
    return Duel.GetCurrentPhase()==PHASE_END
  end
end
function MerlinFilter(c)
  return c:IsSetCard(0x107a) and c:IsType(TYPE_MONSTER) 
  and c:IsPosition(POS_FACEUP) and FilterLocation(c,LOCATION_MZONE)
  and c:IsControler(player_ai) and (FieldCheck(c:GetLevel(),NobleMonsterFilter)>0
  or c:GetLevel()==4 and HasID(AIMon(),10736540,true,nil,nil,POS_FACEUP))
end
function UseMerlinBP()
  if Duel.GetTurnPlayer() == player_ai and ExpectedDamage(2)==0 then
    return true
  end 
end
function ChainMerlin()
  local cg = RemovalCheck()
  local tg = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TARGET_CARDS)
  if cg and EffectCheck(1-player_ai) then 
    if tg and tg:GetCount()>0 then
      GlobalMerlinID ={}
      for i=1,tg:GetCount() do
        tg=tg:Filter(MerlinFilter,nil)
        if tg then
          tg=tg:GetMaxGroup(Card.GetAttack)
        end
        local c=nil
        if tg then
          c=tg:GetFirst()
        end
        if c then
          GlobalMerlinID[i]=c:GetCode()
          tg:RemoveCard(c)
        end
      end
      return #GlobalMerlinID>0
    elseif cg and cg:GetCount()==1 then
      GlobalMerlinID ={}
      for i=1,cg:GetCount() do
        local c=cg:Filter(MerlinFilter,nil):GetMaxGroup(Card.GetAttack):GetFirst()
        if c then
          GlobalMerlinID[i]=c:GetCode()
          cg:RemoveCard(c)
        end
      end
      return #GlobalMerlinID>0
    end
  end
  if IsBattlePhase() then
    if Duel.GetTurnPlayer() == player_ai then
      if ExpectedDamage(2)==0 then
        --return true
      end
    else
      local source = Duel.GetAttacker()
      local target = Duel.GetAttackTarget()
      if WinsBattle(source,target) then
        GlobalMerlinID = {target:GetCode()}
        return true
      end
    end
  end
  return false
end
function NobleChain(cards)
  if HasID(cards,03580032) and ChainMerlin() then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,68618157) and ChainAmaterasu() then
    return {1,CurrentIndex}
  end
  if HasID(cards,23562407) and ChainCaliburn() then
    return {1,CurrentIndex}
  end
  if HasID(cards,83438826) and ChainArf() then
    return {1,CurrentIndex}
  end
  if HasID(cards,07452945) and ChainDestiny() then
    return {1,CurrentIndex}
  end
  if HasID(cards,14745409) and ChainGallatin(cards[CurrentIndex]) then
    return {1,CurrentIndex}
  end
  if HasID(cards,10736540) then -- Lady
    return {1,CurrentIndex}
  end 
  if HasIDNotNegated(cards,83519853) then -- High Sally
    return {1,CurrentIndex}
  end 
  if HasID(cards,21223277) then -- R4torigus
    return {1,CurrentIndex}
  end
  if HasID(cards,10613952) then -- R5torigus
    return {1,CurrentIndex}
  end
  if HasID(cards,55742055,false,891872883) then -- Table draw
    return {1,CurrentIndex}
  end
  if HasID(cards,55742055,false,891872880) then -- Table dump
    return {1,CurrentIndex}
  end
  if HasID(cards,55742055,false,891872882) then -- Table recover
    return {1,CurrentIndex}
  end
  if HasID(cards,55742055,false,891872881) and TableSummon() then -- Table summon
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,57690191) and ChainBrothers() then
    GlobalNobleSS = Duel.GetTurnCount()
    return {1,CurrentIndex}
  end
  if HasID(cards,19748583) and ChainGwen() then
    return {1,CurrentIndex}
  end
  if HasID(cards,30575681) and ChainBedwyr() then
    return {1,CurrentIndex}
  end
  return nil
end
function HasGwen(c)
  return NobleMonsterFilter(c) and FilterAttribute(c,ATTRIBUTE_DARK)
  and HasID(c:get_equipped_cards(),19748583,true)
end
function GwenFilter(c,atk) -- for attack boosts
  return Affected(c,TYPE_SPELL) and DestroyFilter(c,true)
  and DestroyCountCheck(c,TYPE_SPELL,false) 
  and atk<c.attack
end
function ChainGwen()
  local source = Duel.GetAttacker()
	local target = Duel.GetAttackTarget()
  if source and target then
    if source:IsControler(player_ai) then
      target = Duel.GetAttacker()
      source = Duel.GetAttackTarget()
    else
    end
    if (target:IsPosition(POS_ATTACK) and source:IsPosition(POS_ATTACK) and (source:GetAttack() > target:GetAttack()
    or source:GetAttack() == target:GetAttack() and not target:IsHasEffect(EFFECT_INDESTRUCTIBLE_COUNT))
    or target:IsPosition(POS_ATTACK) and source:IsPosition(POS_DEFENSE) and source:GetDefense() >= target:GetAttack()
    or target:IsPosition(POS_DEFENSE) and source:IsPosition(POS_ATTACK) and source:GetAttack() >= target:GetDefense()
    or source:IsPosition(POS_FACEDOWN) and not target:IsCode(83519853)
    or source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
    or source:IsHasEffect(EFFECT_INDESTRUCTABLE_COUNT))
    and not source:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
    and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT)
    then
      return true
    end
  end
  return false
end
function NobleEffectYesNo(id,card)
  local result = nil
  if id==23562407 and ChainCaliburn() then
    result = 1
  end
  if id==83438826 and ChainArf() then
    result = 1
  end
  if id==07452945 and ChainDestiny() then
    result = 1
  end
  if id==14745409 and ChainGallatin(card) then
    result = 1
  end
  if id == 10736540 or id == 83519853 -- Lady, High Sally
  then 
    result = 1
  end
  if id == 21223277 or id == 10613952 then -- R4torigus, R5torigus
    result = 1
  end
  if id == 55742055 and card.description == 891872883 then -- Table Draw
    result = 1
  end
  if id == 55742055 and card.description == 891872880 then -- Table Dump
    result = 1
  end
  if id == 55742055 and card.description == 891872882 then -- Table Recover
    result = 1
  end
  if id == 55742055 and card.description == 891872881 and TableSummon() then -- Table Summon
    result = 1
  end
  if id == 57690191 and ChainBrothers() then
    result = 1
  end
  if id == 19748583 and ChainGwen() then
    result = 1
  end
  if id == 30575681 then -- Bedwyr Dump
    result = 1
  end
  return result
end
NobleAtt={
95772051, -- Black Sally
19680539, -- Gawayn
53550467, -- Drystan
59057152, -- Medraut
47120245, -- Borz

92125819, -- Artorigus
73359475, -- Peredur
03580032, -- Merlin
30575681, -- Bedwyr

48009503, -- Gandiva
82944432, -- Blade Armor Ninja
60645181, -- Excalibur
21223277, -- R4torigus
10613952, -- R5torigus
83519853, -- High Sally
}
NobleDef={
93085839, -- Eachtar
13391185, -- Chad
57690191, -- Brothers
19748583, -- Gwen
10736540, -- Lady
}
function NoblePosition(id,available)
  result = nil
  for i=1,#NobleAtt do
    if NobleAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#NobleDef do
    if NobleDef[i]==id then result=POS_FACEUP_DEFENSE end
  end
  if id == 93085839 and Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
  and (GwenCheck() or OppGetStrongestAttDef()<1600)
  then
    result=POS_FACEUP_ATTACK
  end
  return result
end
