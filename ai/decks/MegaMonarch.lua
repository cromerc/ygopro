
function MegaMonarchStartup(deck)
  deck.Init                 = MegaMonarchInit
  deck.Card                 = MegaMonarchCard
  deck.Chain                = MegaMonarchChain
  deck.EffectYesNo          = MegaMonarchEffectYesNo
  deck.Position             = MegaMonarchPosition
  deck.YesNo                = MegaMonarchYesNo
  deck.BattleCommand        = MegaMonarchBattleCommand
  deck.AttackTarget         = MegaMonarchAttackTarget
  deck.AttackBoost          = MegaMonarchAttackBoost
  deck.Tribute				      = MegaMonarchTribute
  deck.Option               = MegaMonarchOption
  deck.ChainOrder           = MegaMonarchChainOrder
  --[[
  deck.Sum 
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
  deck.ActivateBlacklist    = MegaMonarchActivateBlacklist
  deck.SummonBlacklist      = MegaMonarchSummonBlacklist
  deck.RepositionBlacklist  = MegaMonarchRepoBlacklist
  deck.SetBlacklist		      = MegaMonarchSetBlacklist
  deck.Unchainable          = MegaMonarchUnchainable
  --[[
  
  ]]
  deck.PriorityList         = MegaMonarchPriorityList
  
end

MegaMonarchIdentifier = 84171830 -- Dominion

DECK_MEGAMONARCH = NewDeck("Mega Monarchs",MegaMonarchIdentifier,MegaMonarchStartup) 

MegaMonarchActivateBlacklist={
96570609, -- Aither
23064604, -- Erebus
69230391, -- Mega Thestalos
87288189, -- Mega Caius
09748752, -- Caius
57666212, -- Kuraz

95993388, -- Landrobe
22382087, -- Garum
59463312, -- Eidos
95457011, -- Idea

22842126, -- Pandeity
02295440, -- One for one
32807846, -- RotA
33609262, -- Tenacity
81439173, -- Foolish
--05318639, -- MST
79844764, -- Stormforth
19870120, -- March
61466310, -- Return
84171830, -- Dominion
99940363, -- Frost Blast

54241725, -- Original
18235309, -- Escalation
}
MegaMonarchSummonBlacklist={
96570609, -- Aither
23064604, -- Erebus
69230391, -- Mega Thestalos
87288189, -- Mega Caius
09748752, -- Caius
57666212, -- Kuraz

95993388, -- Landrobe
22382087, -- Garum
59463312, -- Eidos
95457011, -- Idea
}
MegaMonarchSetBlacklist={
22842126, -- Pandeity
02295440, -- One for one
32807846, -- RotA
33609262, -- Tenacity
81439173, -- Foolish
79844764, -- Stormforth
19870120, -- March
61466310, -- Return
84171830, -- Dominion
99940363, -- Frost Blast

54241725, -- Original
18235309, -- Escalation
}
MegaMonarchRepoBlacklist={
}
MegaMonarchUnchainable={
96570609, -- Aither
}

function VassalFilter(c,exclude)
  return FilterType(c,TYPE_MONSTER) 
  and FilterAttack(c,800)
  and FilterDefense(c,1000)
  and (exclude == nil or c.id~=exclude)
end


function AitherCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id)
  end
  if loc == PRIO_TOFIELD then -- for Dominion
    return SummonAither(c,1,true)
  end
  return true
end
function ErebusCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasAccess(c.id)
  end
  if loc == PRIO_TOFIELD then -- for Dominion
    return SummonErebus(c,1,true)
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_MZONE) then
      return 4
    end
    return not HasAccess(c.id)
  end
  return true
end
function MegaThestalosCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and #OppHand()>0
  end
  if loc == PRIO_TOFIELD then -- for Dominion
    return SummonMegaThestalos(c,1,true)
  end
  return true
end
function MegaCaiusCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),c.id,true)
    and CardsMatchingFilter(OppField(),MegaCaiusFilter)>1
  end
  if loc == PRIO_TOFIELD then -- for Dominion
    return SummonMegaCaius(c,1,true)
  end
  return true
end
function IdeaCond(loc,c)
  if loc == PRIO_TOFIELD then
    return OPTCheck(c.id) and DualityCheck()
    and CardsMatchingFilter(AIDeck(),VassalFilter)>0
    and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1
  end
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIBanish(),MonarchFilter)>0
    and OPTCheck(c.id)
    and (FilterLocation(c,LOCATION_MZONE) or not HasID(AIMon(),c.id,true))
  end
  return true
end
function EidosCond(loc,c)
  if loc == PRIO_TOFIELD then
    return FilterLocation(c,LOCATION_DECK) 
    and (NormalSummonCheck() or TributeSummonsM(0,1)>1 or HasIDNotNegated(AIST(),61466310,true))
  end
  if loc == PRIO_TOGRAVE then
    return not FilterLocation(c,LOCATION_DECK) 
  end
  return true
end
function LandrobeCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_ONFIELD)
    and CardsMatchingFilter(AIGrave(),FilterID,95457011)>0
  end
  return true
end
function GarumCond(loc,c)
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_ONFIELD)
    and CardsMatchingFilter(AIDeck(),VassalFilter)>0
  end
  return true
end
function PandeityCond(loc,c)
  if loc == PRIO_TOHAND then
    if CardsMatchingFilter(AIHand(),MonarchFilter)>0 then
      if not CanTributeSummon() then
        return 8
      else
        return true
      end
    end
  end
  return true
end
function TenacityFilter(c)
  return FilterAttack(c,2400) or FilterAttack(c,2800)
end
function TenacityCond(loc,c)
  if loc == PRIO_TOHAND then  
    return CardsMatchingFilter(AIHand(),TenacityFilter)>0
    and OPTCheck(c.id)
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function StormforthCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (HasID(AIHand(),96570609,true)
    or CardsMatchingFilter(OppMon(),StormforthFilter)>0)
    and TributeSummonsM(0,1)>0
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function MarchCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (TributeSummonsM(0,1)>0
    or CardsMatchingFilter(AIMon(),FilterSummon,SUMMON_TYPE_ADVANCE)>0)
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function ReturnCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and TributeSummonsM(0,1)>0
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function DominionCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and (TributeSummonsM(2,1)>0 and TributesAvailable()==1
    or CanTributeSummon()
    or CardsMatchingFilter(AIMon(),FilterSummon,SUMMON_TYPE_ADVANCE)>0)
  end
  if loc == PRIO_BANISH then
    return FilterLocation(c,LOCATION_GRAVE)
    and not HasID(AIBanish(),c.id,true)
  end
  return true
end
function OriginalCond(loc,c)
  local cards
  if loc == PRIO_TOHAND then
    if HasIDNotNegated(AIHand(),22842126,true)
    and not HasAccess(c.id) 
    then
      return 8.5
    end
    return not HasID(AIHand(),c.id,true) 
    or FilterLocation(c,LOCATION_REMOVED)
  end
  if loc == PRIO_TOGRAVE then
    if FilterLocation(c,LOCATION_MZONE) then
      return 5
    end
    cards = UseLists(AIGrave(),AIMon())
    return not HasID(cards,c.id,true)
  end
  if loc == PRIO_TODECK then
    cards = UseLists(AIGrave(),AIMon())
    return CardsMatchingFilter(cards,FilterID,c.id)-GetMultiple(c.id)>1
  end
  if loc == PRIO_BANISH then
    cards = UseLists(AIGrave(),AIMon())
    return FilterLocation(c,LOCATION_GRAVE)
    and CardsMatchingFilter(cards,FilterID,c.id)>1
    and not HasID(AIBanish(),c.id,true) 
  end
  return true
end
function ThestalosCond(loc,c)
  return true
end
function FrostBlastFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
  and Affected(c,TYPE_SPELL)
  and Targetable(c,TYPE_SPELL)
  and ShouldRemove(c)
end
function FrostBlastCond(loc,c)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AIMon(),MonarchMonsterFilter)>0
    and CardsMatchingFilter(OppField(),FrostBlastFilter)>0
    and NotNegated(c)
  end
  if loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(AIGrave(),MonarchFilter)>0
    and CardsMatchingFilter(OppField(),FrostBlastFilter)>0
  end
  return true
end
function EscalationCond(loc,c)
  if loc == PRIO_TOHAND then
    return not HasID(AICards(),c.id,true)
    and TributesAvailable(true)>0
    and (CardsMatchingFilter(AIHand(),MonarchMonsterFilter,96570609)>0 -- Aither
    or HasID(AIMon(),96570609,true) and CardsMatchingFilter(AIMon(),MonarchMonsterFilter)>1)
  end
  return true
end
function KurazFilter(c,prio) -- destroy opponent's cards
  return Affected(c)
  and Targetable(c)
  and DestroyFilterIgnore(c)
  and ShouldRemove(c)
  and (not prio or FilterPriorityTarget(c))
end
function KurazFilter2(c) -- destroy own cards
  return Affected(c)
  and Targetable(c)
  and (CardsMatchingFilter(AIField(),MonarchMonsterFilter,c)>0
  and not MonarchMonsterFilter(c,57666212) -- Kuraz
  or not MonarchMonsterFilter(c))
  and (c.id~=84171830 or HasID(AIHand(),84171830,true)) -- Dominion
end
function KurazCond(loc,c)
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(OppField(),KurazFilter,true)>0
    or CardsMatchingFilter(AIField(),KurazFilter2)>0
  end
  if loc == PRIO_TOGRAVE then
    return FilterLocation(c,LOCATION_MZONE)
  end
  return true
end
MegaMonarchPriorityList={                      
--[12345678] = {1,1,1,1,1,1,1,1,1,1,XXXCond},  -- Format

-- MegaMonarch


[96570609] = {8,4,8,2,1,1,1,1,1,1,AitherCond},          -- Aither
[23064604] = {7,2,7,3,8,5,1,1,1,1,ErebusCond},          -- Erebus
[69230391] = {5,2,5,1,1,1,1,1,1,1,MegaThestalosCond},   -- Mega Thestalos
[87288189] = {6,3,6,1,1,1,1,1,1,1,MegaCaiusCond},       -- Mega Caius
[09748752] = {1,1,4,1,1,1,1,1,1,1,CaiusCond},           -- Caius
[26205777] = {1,1,3,1,1,1,1,1,1,1,ThestalosCond},       -- Thestalos
[57666212] = {1,1,9,1,7,1,1,1,1,1,KurazCond},           -- Kuraz

[95993388] = {6,1,5,1,7,4,1,1,1,1,LandrobeCond},        -- Landrobe
[22382087] = {5,1,6,1,8,3,1,1,1,1,GarumCond},           -- Garum
[59463312] = {3,1,7,1,5,1,1,1,1,1,EidosCond},           -- Eidos
[95457011] = {7,1,8,1,6,2,1,1,1,1,IdeaCond},            -- Idea

[22842126] = {4,1,1,1,8,1,3,1,1,1,PandeityCond},        -- Pandeity
[02295440] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- One for one
[32807846] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- RotA
[33609262] = {10,2,1,1,6,1,8,1,8,2,TenacityCond},       -- Tenacity
[81439173] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- Foolish
[05318639] = {1,1,1,1,1,1,1,1,1,1,nil},                 -- MST
[79844764] = {5,2,1,1,5,1,5,1,6,2,StormforthCond},      -- Stormforth
[19870120] = {7,1,1,1,1,1,6,1,6,2,MarchCond},           -- March
[61466310] = {3,1,1,1,3,1,6,1,6,2,ReturnCond},          -- Return
[84171830] = {9,1,1,1,2,1,7,1,7,2,DominionCond},        -- Dominion
[99940363] = {4,1,1,1,5,1,1,1,0,0,FrostBlastCond},      -- Frost Blast

[54241725] = {6,1,1,1,9,1,4,1,9,1,OriginalCond},        -- Original
[48716527] = {3,1,1,1,4,1,6,1,6,2,nil},                 -- Erupt
[18235309] = {8,1,1,1,1,1,1,1,7,1,EscalationCond},      -- Escalation
} 

function TributeCountM(mega)
  local result = 0
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if not FilterAffected(c,EFFECT_UNRELEASABLE_SUM) then
      if mega and FilterSummon(c,SUMMON_TYPE_ADVANCE) then
        result=result+2
      else
        result=result+1
      end
    end
  end
  if GlobalStormforth == Duel.GetTurnCount() 
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    result=result+1
  end
  return result
end
function TributeFodder()
  local result = 0
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if not FilterAffected(c,EFFECT_UNRELEASABLE_SUM) 
    and not FilterSummon(c,SUMMON_TYPE_ADVANCE) 
    then
      result=result+1
    end
  end
  if CardsMatchingFilter(OppMon(),StormforthFilter)>0
  and GlobalStormforth == Duel.GetTurnCount() 
  then
    result=result+1
  end
  return result
end
function TributesAvailable(oppturn)
  local result = TributeFodder()
  local stormforthcheck = false
  if HasIDNotNegated(AIHand(),95457011,true)
  and HasIDNotNegated(AIDeck(),59463312,true)
  and not NormalSummonCheck()
  and DualityCheck()
  and not oppturn
  then
    result = result + 2
  elseif HasIDNotNegated(AIHand(),59463312,true)
  and not NormalSummonCheck()
  and not oppturn
  then
    result = result + 1
  end
  if HasID(AIGrave(),59463312,true) 
  and CardsMatchingFilter(AIGrave(),VassalFilter)>0
  and DualityCheck()
  and not oppturn
  then
    if HasIDNotNegated(AIGrave(),95457011,true)
    and CardsMatchingFilter(AIDeck(),VassalFilter)>0
    then
      result = result + 2
    else
      result = result + 1
    end
  end
  if CardsMatchingFilter(OppMon(),StormforthFilter)>0
  and GlobalStormforth==Duel.GetTurnCount()
  then
    result = result + 1
  end
  if HasIDNotNegated(AICards(),79844764,true)
  and OPTCheck(79844764)
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  and not oppturn
  then
    result = result + 1
  end
  if HasIDNotNegated(AIST(),79844764,true)
  and OPTCheck(79844764)
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    stormforthcheck = true
    result = result + 1
  end
  if HasID(AIGrave(),54241725,true)
  and OPTCheck(54241725)
  and DualityCheck()
  and (CardsMatchingFilter(AIGrave(),MonarchFilter)>1 and not oppturn
  or CardsMatchingFilter(AIGrave(),MonarchFilter)>2
  or stormforthcheck
  or GlobalTenacity)
  then
    result = result + 1
  end
  if HasID(AIHand(),95993388,true)
  and OPTCheck(95993388)
  and DualityCheck()
  and CardsMatchingFilter(OppMon(),LandrobeFilter)>0
  and not oppturn
  then
    result = result + 1
  end
  if HasID(AIHand(),22382087,true)
  and OPTCheck(22382087)
  and DualityCheck()
  and CardsMatchingFilter(AIMon(),GarumFilter)>0
  and not oppturn
  then
    result = result + 1
  end
  return result
end
function TributeSummonsM(tributes,mode)
  local result = 0
  if not tributes then tributes = 0 end
  if not mode then mode = 1 end
  for i=1,#AIHand() do
    local c = AIHand()[i]
    if (tributes == 2 or tributes == 0)
    and (c.id==23064604 and SummonErebus(c,mode,true)
    or c.id==96570609 and SummonAither(c,mode,true)
    or c.id==69230391 and SummonMegaThestalos(c,mode,true)
    or c.id==87288189 and SummonMegaCaius(c,mode,true))
    and c.level>6
    then
      result=result+1
    end
    if (tributes == 1 or tributes == 0)
    and (c.id==09748752 and SummonCaius(c,mode)
    or c.id==26205777 and SummonThestalos(c,mode)
    or c.id==57666212 and SummonKuraz(c,mode)
    or (c.level==6 or HasIDNotNegated(AICards(),84171830,true,FilterOPT))
    and (c.id==23064604 and SummonErebus(c,mode,true)
    or c.id==96570609 and SummonAither(c,mode,true)
    or c.id==69230391 and SummonMegaThestalos(c,mode,true)
    or c.id==87288189 and SummonMegaCaius(c,mode,true)))
    then
      result=result+1
    end
  end
  return result
end
function CanTributeSummon(summoncheck)
  return (TributeSummonsM(1,1)>0
  and TributesAvailable()>0
  or TributeSummonsM(2,1)>0
  and TributesAvailable()>1)
  and (not summoncheck 
  or not NormalSummonCheck()
  or not OPTCheck(594633121) and NormalSummonCount()<2)
end
GlobalSummonedCard = nil
--[[
96570609 -- Aither
23064604 -- Erebus
69230391 -- Mega Thestalos
87288189 -- Mega Caius
09748752 -- Caius

95993388 -- Landrobe
22382087 -- Garum
59463312 -- Eidos
95457011 -- Idea

22842126 -- Pandeity
02295440 -- One for one
32807846 -- RotA
33609262 -- Tenacity
81439173 -- Foolish
05318639 -- MST
79844764 -- Stormforth
19870120 -- March
61466310 -- Return
84171830 -- Dominion

54241725 -- Original
]]
function GarumFilter(c)
  return FilterSummon(c,SUMMON_TYPE_ADVANCE)
end
function LandrobeFilter(c)
  return Targetable(c,TYPE_MONSTER)
  and Affected(c,TYPE_MONSTER,3)
  and not FilterType(c,TYPE_TOKEN)
end
function SummonIdea(c,mode)
  if mode == 1 then
    return TributeSummonsM(0,1)>0 
    and HasIDNotNegated(AIDeck(),59463312,true,FilterOPT,true)
    and (TributeFodder()==0
    or TributeFodder()<2 and TributeSummonsM(1,1)==0) 
    and DualityCheck()
  end
  if mode == 2 then
    return #AIMon()==0
    and CardsMatchingFilter(AIDeck(),VassalFilter,c.id)>0
    and DualityCheck()
  end
end
function SummonEidos(c,mode)
  if mode == 1 then
    return TributeSummonsM(2,1)>0
    and TributeSummonsM(1,1)==0
    and TributeFodder()==1
    or TributeSummonsM(1,1)>0
    and TributeFodder()==0
  end
end
function UseEidos(c,mode)
  if mode == 1 
  and (TributeSummonsM(1,1)>0
  and TributeFodder()==0
  or TributeSummonsM(2,1)>0
  and HasIDNotNegated(AIGrave(),95457011,true)
  and CardsMatchingFilter(AIDeck(),VassalFilter,95457011)>0
  and OPTCheck(95457011)
  and TributeFodder()<2)
  and (NormalSummonCount()<2 and HasID(AIDeck(),59463312,true,FilterOPT,594633121) or not NormalSummonCheck())
  then
    OPTSet(59463312)
    return true
  end
end
function PlayDominion(c)
  return (FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN))
  and CardsMatchingFilter(AIST(),FilterType,TYPE_FIELD)==0
  and (CanTributeSummon(true) or CardsMatchingFilter(AIMon(),FilterSummon,SUMMON_TYPE_ADVANCE)>0)
end
function UseDominion(c)
  if FilterLocation(c,LOCATION_SZONE) 
  and TributesAvailable()>0
  and not NormalSummonCheck()
  then
    OPTSet(c)
    return true
  end
  return false
end
function UsePandeityGrave(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return true
  end
  return false
end
function UsePandeity(c,mode)
  if FilterLocation(c,LOCATION_HAND) then
    if mode == 1 then
      return not CanTributeSummon()
      and not NormalSummonCheck()
      or HasID(AIHand(),54241725,true)
      and not HasID(UseLists(AIMon(),AIGrave()),54241725,true)
    end
    if mode == 2 then
      return true
    end
  end
  return false
end
function UseOriginalGrave(c,mode)
  if FilterLocation(c,LOCATION_GRAVE) then
    if mode == 1 
    and not NormalSummonCheck() 
    and (TributeSummonsM(1,1)>0
    and TributeFodder()==0
    or TributeSummonsM(2,1)>0
    and TributeSummonsM(1,1)==0
    and TributeFodder()<2)
    then
      OPTSet(54241725)
      return true
    end
    if mode == 2 
    and TurnEndCheck()
    and CardsMatchingFilter(AIGrave(),MonarchFilter)>3
    and #AIMon()<3
    then
      OPTSet(54241725)
      return true
    end
  end
end
function UseOriginal(c)
  if FilterLocation(c,LOCATION_SZONE) then
    return CardsMatchingFilter(AIGrave(),MonarchFilter)>3 
    and #AIHand()<6
  end
end
function SetVassal(c)
  return TurnEndCheck()
  and #AIMon()==0
end
function SummonErebus(c,mode,check)
  if mode == 1 then
    if (TributeFodder()>0 and c.level == 6
    or TributeFodder()>1 or check)
    or OppHasStrongestMonster()
    then
      if not check then
        GlobalSummonedCard = c
      end
      return true
    end
  end
  return false
end
function SummonAither(c,mode,check)
  if mode == 1 then
    if (TributeFodder()>0 and c.level == 6
    or TributeFodder()>1 or check)
    or OppHasStrongestMonster()
    then
      if not check then
        GlobalSummonedCard = c
      end
      return true
    end
  end
  return false
end
function SummonMegaThestalos(c,mode,check)
  if mode == 1 then
    if (TributeFodder()>0 and c.level == 6
    or TributeFodder()>1 or check)
    and #OppHand()>0
    then
      if not check then
        GlobalSummonedCard = c
      end
      return true
    end
  end
  return false
end
function UseTenacityM(c)
  OPTSet(33609262)
  return true
end
function UseLandrobe(c)
  return CardsMatchingFilter(OppMon(),LandrobeFilter)>0
  and not NormalSummonCheck()
  and (TributeSummonsM(1,1)>0 and TributeFodder()==0
  or TributeSummonsM(1,1)==0 and TributeSummonsM(2,1)>0 and TributeFodder()==1)
end
function UseGarum(c)
  return TributeSummonsM(0,1)==0
  and not NormalSummonCheck()
end
function UseErebus(c)
  if FilterLocation(c,LOCATION_GRAVE) then
    return TributeSummonsM(0,1)==0
    and not NormalSummonCheck()
    or HasID(AIHand(),54241725,true)
    and not HasID(UseLists(AIMon(),AIGrave()),54241725,true)
  end
end
function UseMarch(c)
  return (FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN))
  and (CanTributeSummon(true) or CardsMatchingFilter(AIMon(),FilterSummon,SUMMON_TYPE_ADVANCE)>0)
end
function UseReturn(c)
  return (FilterLocation(c,LOCATION_HAND) or FilterPosition(c,POS_FACEDOWN))
  and CanTributeSummon(true)
end
function UseStormforthM(c,mode)
  if mode == 1 
  and not NormalSummonCheck() 
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  and (TributeSummonsM(1,1)>0
  and TributeFodder()<1
  or TributeSummonsM(2,1)>0
  and TributeFodder()<2)
  then
    OPTSet(79844764)
    GlobalStormforth=Duel.GetTurnCount()
    return true
  end
end
function SummonThestalos(c,mode,check)
  if mode == 1 then
    if (TributeFodder()>0 or check)
    and #OppHand()>0
    then
      if not check then
        GlobalSummonedCard = c
      end
      return true
    end
  end
  return false
end
function OneforoneFilter(c)
  return c.level<5
  or CardsMatchingFilter(AIHand(),FilterLevelMin,6)>1
  or c.id == 23064604 and CardsMatchingFilter(AIHand(),MonarchST)>0
end
function UseOneforone(c,mode)
  if mode == 1 
  and (TributeSummonsM(1,1)>0
  and TributeFodder()==0
  or TributeSummonsM(2,1)>0
  and HasIDNotNegated(AIDeck(),95457011,true)
  and CardsMatchingFilter(AIDeck(),VassalFilter,95457011)>0
  and OPTCheck(95457011)
  and TributeFodder()<2)
  and (NormalSummonCount()<2 and HasID(AIDeck(),59463312,true,FilterOPT,594633121) or not NormalSummonCheck())
  and CardsMatchingFilter(AIHand(),OneforoneFilter)>0
  then
    return true
  end
  return false
end
function SummonKuraz(c,mode)
  if mode == 1 
  and NotNegated(c)
  --and (CardsMatchingFilter(OppField(),KurazFilter,true)>0
  --or CardsMatchingFilter(AIField(),KurazFilter2)>0
  then
    return true
  end
  if mode == 2
  and (CardsMatchingFilter(OppField(),StormforthFilter,KurazFilter)>0
  or CardsMatchingFilter(AIField(),KurazFilter2)>0)
  then
    return true
  end
  if mode == 3
  and NotNegated(c)
  and (CardsMatchingFilter(OppField(),KurazFilter,true)>0
  or CardsMatchingFilter(AIField(),KurazFilter2)>1)
  then
    return true
  end
end
function UseFrostBlast(c,mode)
  if mode == 1 -- regular use
  and (FilterLocation(c,LOCATION_HAND) or FilterLocation(c,LOCATION_SZONE))
  and CardsMatchingFilter(OppField(),FrostBlastFilter)>0
  then
    return true
  end
  if mode == 2 -- from grave
  and FilterLocation(c,LOCATION_GRAVE)
  and CardsMatchingFilter(OppField(),FrostBlastFilter)>0
  then
    return true
  end
end
function SetOriginal(c,sum)
  if HasID(sum,57666212,true,SummonKuraz,1)
  and CardsMatchingFilter(AIField(),KurazFilter2)<3
  and not HasID(UseLists(AIST(),AIGrave()),c.id,true)
  then
    return true
  end
end
function MegaMonarchInit(cards)
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  GlobalSummonedCard = nil 
  GlobalTenacity = nil
  GlobalAither = nil
  if HasID(Act,99940363,UseFrostBlast,2) then
    return Activate()
  end
  if HasID(Act,99940363,UseFrostBlast,1) then
    return Activate()
  end
  if HasIDNotNegated(Act,32807846) then -- RotA
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,81439173) then -- Foolish
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,33609262,UseTenacityM) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,22842126,UsePandeityGrave) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,22382087,UseGarum) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,84171830,PlayDominion) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,84171830,UseDominion) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,54241725,UseOriginal) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,22842126,UsePandeity,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,02295440,UseOneforone,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,59463312,UseEidos,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,95993388,UseLandrobe) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(Act,79844764,UseStormforthM,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,54241725,UseOriginalGrave,1) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Sum,95457011,SummonIdea,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,59463312,SummonEidos,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Act,19870120,UseMarch) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Act,61466310,UseReturn) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Sum,23064604,SummonErebus,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,96570609,SummonAither,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,87288189,SummonMegaCaius,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,09748752,SummonCaius,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,69230391,SummonMegaThestalos,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,26205777,SummonThestalos,1) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(Act,23064604,UseErebus) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasID(SetST,54241725,SetOriginal,Sum) then
    return SetSpell()
  end
  if HasIDNotNegated(Sum,57666212,SummonKuraz,1) then
    GlobalSummonedCard=Sum[CurrentIndex]
    return Summon()
  end
  if HasIDNotNegated(Act,22842126,UsePandeity,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if HasIDNotNegated(Sum,95457011,SummonIdea,2) then
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasID(SetMon,22382087,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,95993388,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,59463312,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasID(SetMon,95457011,SetVassal) then
    return COMMAND_SET_MONSTER,CurrentIndex
  end
  if HasIDNotNegated(Act,54241725,UseOriginalGrave,2) then
    return COMMAND_ACTIVATE,CurrentIndex
  end
  if TurnEndCheck() and #SetST>0 
  and CardsMatchingFilter(AIST(),FilterPosition,POS_FACEDOWN)<2
  and #AIST()<4
  then
    local result={}
    local MonarchST=CardsMatchingFilter(AIHand(),MonarchFilter)
    for i=1,#SetST do 
      local c = SetST[i]
      if c.id == 79844764 and not HasID(AIST(),79844764,true) 
      and (MonarchST>1 or HasID(AIHand(),96570609,true) 
      or HasID(AICards(),18235309,true))
      or c.id == 54241725 and not HasID(AIST(),54241725,true) 
      and (MonarchST>1 or CardsMatchingFilter(AIGrave(),MonarchFilter)>2)
      or c.id == 18235309 and not HasID(AIST(),18235309,true) -- Escalation
      or c.id == 05318639 -- MST
      or c.id == 32807846 -- RotA
      then
        result[#result+1]=i
      end
    end
    if #result + CardsMatchingFilter(AIST(),FilterPosition,POS_FACEDOWN)<2
    and #AIST()<4
    then
      for i=1,#SetST do 
        local c = SetST[i]
        if c.id == 22842126 and not HasID(AIST(),22842126,true) and MonarchST>1
        or c.id == 33609262 and not HasID(AIST(),33609262,true) and MonarchST>1
        or c.id == 19870120 and not HasID(AIST(),19870120,true) and MonarchST>1
        or c.id == 61466310 and not HasID(AIST(),61466310,true) and MonarchST>1
        or c.id == 02295440
        or c.id == 81439173
        then
          result[#result+1]=i
        end
      end
    end
    if result and #result>0 then
      Shuffle(result)
      return COMMAND_SET_ST,result[1]
    end
  end
  return nil
end
--[[
96570609 -- Aither
23064604 -- Erebus
69230391 -- Mega Thestalos
87288189 -- Mega Caius
09748752 -- Caius

95993388 -- Landrobe
22382087 -- Garum
59463312 -- Eidos
95457011 -- Idea

22842126 -- Pandeity
02295440 -- One for one
32807846 -- RotA
33609262 -- Tenacity
81439173 -- Foolish
05318639 -- MST
79844764 -- Stormforth
19870120 -- March
61466310 -- Return
84171830 -- Dominion

54241725 -- Original
]]
function ErebusTarget(cards,c)
  if FilterLocation(c,LOCATION_GRAVE) then
    if LocCheck(cards,LOCATION_HAND) then
      return Add(cards,PRIO_TOGRAVE)
    end
    if LocCheck(cards,LOCATION_GRAVE) then
      return Add(cards,PRIO_TOHAND)
    end
  end
  if LocCheck(cards,LOCATION_DECK) 
  or LocCheck(cards,LOCATION_HAND)
  and cards[1].owner==1
  then
    return Add(cards,PRIO_TOGRAVE,1,FilterLocation,LOCATION_DECK)
  end
  if LocCheck(cards,LOCATION_HAND) 
  and cards[1].owner==2
  then
    return RandomTargets(cards,1,FilterLocation,LOCATION_HAND)
  end
  if LocCheck(cards,LOCATION_GRAVE)
  and cards[1].owner==2
  then
    return BestTargets(cards,1,TARGET_TODECK)
  end
  if LocCheck(cards,LOCATION_ONFIELD)
  and CurrentOwner(cards[1])==2 
  then
    return BestTargets(cards,1,TARGET_TODECK)
  end
  return BestTargets(cards,1,TARGET_TODECK)
end
function AitherTarget(cards,c)
  if FilterLocation(c,LOCATION_HAND) then
    if LocCheck(cards,LOCATION_GRAVE) then
      return Add(cards,PRIO_BANISH)
    end
    if LocCheck(cards,LOCATION_DECK) then
      if HasIDNotNegated(cards,57666212,SummonKuraz,3) then
        return Add(cards,PRIO_TOFIELD,1,FilterID,57666212)
      end
      return Add(cards)
    end
  end
  if LocCheck(cards,LOCATION_DECK) then
    if FilterType(cards[1],TYPE_SPELL+TYPE_TRAP) then
      return Add(cards,PRIO_TOGRAVE,1,FilterLocation,LOCATION_DECK)
    else
      if HasIDNotNegated(cards,57666212,SummonKuraz,3) then
        return Add(cards,PRIO_TOFIELD,1,FilterID,57666212)
      end
      return Add(cards)
    end
  end
  return Add(cards)
end
function IdeaTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
function EidosTarget(cards)
  return Add(cards,PRIO_TOFIELD)
end
function ReturnTarget(cards)
  return Add(cards)
end
function PandeityTarget(cards,min)
  if LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOGRAVE,min)
  end
  return Add(cards,PRIO_TOHAND,min)
end
function LandrobeTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards)
  end
  return BestTargets(cards,1,TARGET_FACEDOWN)
end
function GarumTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    return Add(cards)
  end
  return Add(cards)
end
GlobalTenacity = nil
function TenacityTarget(cards)
  if LocCheck(cards,LOCATION_DECK) then
    GlobalTenacity = true
    return Add(cards)
  elseif LocCheck(cards,LOCATION_HAND) then
    return Add(cards,PRIO_TOFIELD)
  end
  return Add(cards)
end
function DominionTarget(cards)
  return Add(cards,PRIO_TOFIELD) -- WIP
end
GlobalOriginalTargets = {}
function OriginalFilter(c)
  local check = true
  if ChainCheck(54241725) then
    for i=1,#GlobalOriginalTargets do
      if CardsEqual(GlobalOriginalTargets[i],c) then
        check=false
      end
    end
  end
  return check
end
function OriginalTarget(cards,c,min)
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    local result = Add(cards,PRIO_TODECK,min,FilterID,c.id)
    GlobalOriginalTargets = {cards[1],cards[2]}
    return result
  end
  --[[if FilterLocation(c,LOCATION_ONFIELD) -- TODO: not working at the moment
  and CardsMatchingFilter(AIGrave(),MonarchFilter)>2
  and HasID(AIGrave(),c.id,true,FilterOPT)
  and not HasID(AIMon(),c.id,true)
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>0
  and DualityCheck()
  then
    local result = Add(cards,PRIO_TODECK,min,FilterID,c.id)
    GlobalOriginalTargets = {cards[1],cards[2]}
    return result
  end]]
  if FilterLocation(c,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH,min,OriginalFilter)
  end
  local result = Add(cards,PRIO_TODECK,min)
  GlobalOriginalTargets = {cards[1],cards[2]}
  return result
end
function FoolishTargetM(cards)
  return Add(cards,PRIO_TOGRAVE) --for now
end
function MegaThestalosFilter(c)
  return c.level*200>=AI.GetPlayerLP(2)
end
function MegaThestalosTarget(cards)
  return BestTargets(cards,1,TARGET_TOGRAVE,MegaThestalosFilter)
end
function OneforoneTarget(cards)
  if LocCheck(cards,LOCATION_HAND,true) then
    return Add(cards,PRIO_TOGRAVE,1,OneforoneFilter)
  end
  return Add(cards,PRIO_TOFIELD)
end
function KurazTarget(cards,min,max,c)
  local targets = SubGroup(OppField(),KurazFilter,true)
  local targets2 = SubGroup(AIField(),KurazFilter2)
  local result = {}
  if #targets>1 then
    return BestTargets(cards,max,TARGET_DESTROY)
  end
  if #targets==1 then
    if #targets2>0 and max == 2 then
      BestTargets(cards,1,TARGET_DESTROY)
      result[1]=cards[1].index
      BestTargets(cards,1,TARGET_DESTROY,FilterController,1)
      result[2]=cards[1].index
      return result
    else
      return BestTargets(cards,1,TARGET_DESTROY)
    end
  end
  if #targets==0 and #targets2>0 then
    if CardsMatchingFilter(AIMon(),MonarchMonsterFilter,c)==0 then
      return BestTargets(cards,math.min(#targets2,max),TARGET_DESTROY,ExcludeID,c.id)
    end
    return BestTargets(cards,math.min(#targets2,max))
  end
  return BestTargets(cards,min,TARGET_DESTROY)
end
function EscalationTarget(cards,min)
  if LocCheck(cards,LOCATION_HAND) then
    local mode = 1
    if GlobalStormforth == Duel.GetTurnCount() then
      mode=2
    end
    if HasID(cards,87288189,SummonMegaCaius,mode) then
      return {CurrentIndex}
    end
    if HasID(cards,23064604,SummonErebus,1) then
      return {CurrentIndex}
    end
    if HasID(cards,69230391,SummonMegaThestalos,1) then
      return {CurrentIndex}
    end
    if HasID(cards,09748752,SummonCaius,mode) then
      return {CurrentIndex}
    end
    if HasID(cards,26205777,SummonThestalos,1) then
      return {CurrentIndex}
    end
    if HasID(cards,96570609,SummonAither,1) then
      return {CurrentIndex}
    end
    if HasID(cards,57666212,SummonKuraz,mode) then
      return {CurrentIndex}
    end
    return Add(cards,PRIO_TOFIELD,min)
  end
  return Add(cards,PRIO_TOGRAVE,min,FilterController,2)
end
function FrostBlastTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    return Add(cards,PRIO_BANISH)
  end
  return BestTargets(cards,1,TARGET_DESTROY)
end
function MegaMonarchCard(cards,min,max,id,c)
  if not c and GlobalStormforth==Duel.GetTurnCount()
  and min==1 and max==1 and Duel.GetTurnPlayer()==player_ai
  and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
  then
    return StormforthTarget(cards)
  end
  if id == 99940363 then
    return FrostBlastTarget(cards)
  end
  if id == 18235309 then
    return EscalationTarget(cards,min)
  end
  if id == 57666212 then
    return KurazTarget(cards,min,max,c)
  end
  if id == 96570609 then
    return AitherTarget(cards,c)
  end
  if id == 23064604 then
    return ErebusTarget(cards,c)
  end
  if id == 69230391 then
    return MegaThestalosTarget(cards)
  end
  if id == 95993388 then
    return LandrobeTarget(cards)
  end
  if id == 22382087 then
    return GarumTarget(cards)
  end
  if id == 59463312 then
    return EidosTarget(cards)
  end
  if id == 95457011 then
    return IdeaTarget(cards)
  end
  if id == 22842126 then
    return PandeityTarget(cards,min)
  end
  if id == 33609262 then
    return TenacityTarget(cards)
  end
  if id == 19870120 then
    return MarchTarget(cards)
  end
  if id == 61466310 then
    return ReturnTarget(cards)
  end
  if id == 84171830 then
    return DominionTarget(cards)
  end
  if id == 87288189 then
    return MegaCaiusTarget(cards,max)
  end
  if id == 09748752 then
    return CaiusTarget(cards)
  end
  if id == 81439173 then
    return FoolishTargetM(cards)
  end
  if id == 54241725 then
    return OriginalTarget(cards,c,min)
  end
  return nil
end
GlobalAither = nil
function ChainAither(c)
  if FilterLocation(c,LOCATION_MZONE) and NotNegated(c) then
    return true
  end
  if FilterLocation(c,LOCATION_HAND) then
    if (((Duel.CheckTiming(TIMING_MAIN_END)
    and Duel.GetCurrentPhase(PHASE_MAIN1)
    and HasIDNotNegated(AIST(),79844764,true,FilterOPT,true)
    or GlobalStormforth==Duel.GetTurnCount())
    and CardsMatchingFilter(OppMon(),StormforthFilter)>0
    and TributesAvailable(true)>1)
    or TributeFodder()>1)
    and UnchainableCheck(96570609)
    then
      GlobalSummonedCard=c
      return true
    end
    local cards = RemovalCheckList(AIMon(),nil,nil,true)
    if cards and UnchainableCheck(96570609) then 
      GlobalSummonedCard=c
      GlobalAither=cards
      return true
    end
    if CardsMatchingFilter(OppMon(),KurazFilter,true)>0
    and HasIDNotNegated(AIDeck(),57666212,true)
    then
      GlobalSummonedCard=c
      return true
    end
    if Duel.CheckTiming(TIMING_MAIN_END)
    and Duel.GetCurrentPhase(PHASE_MAIN2)
    and HasIDNotNegated(AIDeck(),57666212,true,SummonKuraz,3)
    then
      GlobalSummonedCard=c
      return true
    end
  end
  return false
end
function ChainErebus(c)
  if FilterLocation(c,LOCATION_GRAVE) and RemovalCheckCard(c) then
    return true
  end
  if FilterLocation(c,LOCATION_MZONE) and NotNegated(c) then
    return true
  end
  return false
end
function ChainOriginal(c)
  if FilterLocation(c,LOCATION_SZONE) then
    if RemovalCheckCard(c) then
      if (RemovalCheckCard(c,CATEGORY_TOGRAVE)
      or RemovalCheckCard(c,CATEGORY_DESTROY))
      and CardsMatchingFilter(AIGrave(),FilterID,c.id)>0
      then
        GlobalCardMode = 1
      end
      return true
    end
    if Duel.CheckTiming(TIMING_END_PHASE) 
    and Duel.GetTurnPlayer() == 1-player_ai
    and CardsMatchingFilter(AIGrave(),MonarchFilter)>2
    and #AIHand()<7
    then
      return true
    end
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    if RemovalCheckCard(c) 
    and not ChainCheck(54241725)
    then
      OPTSet(54241725)
      return true
    end
    if HasIDNotNegated(AIST(),18235309,true,ChainEscalation)
    then
      OPTSet(54241725)
      return true
    end
    if RemovalCheckList(AIMon(),{CATEGORY_DESTROY,CATEGORY_TOGRAVE},nil,nil,nil,FilterID,95457011)
    and CardsMatchingFilter(AIBanish(),MonarchFilter)==0
    and not ChainCheck(96570609,player_ai)
    and OPTCheck(954570111)
    then
      OPTSet(54241725)
      return true
    end
    if IsBattlePhase() then
      local aimon,oppmon = GetBattlingMons()
      if #AIMon()==0 and oppmon 
      and (oppmon:GetAttack()<=2400
      or oppmon:GetAttack()>=0.7*AI.GetPlayerLP(1))
      then
        OPTSet(54241725)
        return true
      end
      if aimon and aimon:GetCode()==95457011 
      and WinsBattle(oppmon,aimon)
      and CardsMatchingFilter(AIBanish(),MonarchFilter)==0
      then
        OPTSet(54241725)
        return true
      end
    end
    if Duel.GetTurnPlayer()==1-player_ai
    and Duel.CheckTiming(TIMING_MAIN_END)
    and Duel.GetCurrentPhase(PHASE_MAIN1)
    and HasIDNotNegated(AIHand(),96570609,true)
    then
      if TributesAvailable(true)==2
      and TributeFodder()<2
      and TributeCountM(true)<2
      and (Duel.GetCurrentChain()==0
      or ChainCheck(79844764,player_ai))
      then
        OPTSet(54241725)
        return true
      end
      if ChainCheck(96570609,player_ai)
      and TributesAvailable(true)>1
      then
        OPTSet(54241725)
        return true
      end
    end
  end
  return false
end
function ChainStormforth(c)
  if RemovalCheckCard(c) then
    GlobalStormforth=Duel.GetTurnCount()
    return true
  end
  if HasIDNotNegated(AIST(),18235309,true,ChainEscalation)
  then
    GlobalStormforth=Duel.GetTurnCount()
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai
  and (Duel.CheckTiming(TIMING_MAIN_END)
  and Duel.GetCurrentPhase(PHASE_MAIN1)
  or ChainCheck(54241725,player_ai,nil,FilterLocation,LOCATION_GRAVE)
  or ChainCheck(96570609,player_ai,nil,FilterLocation,LOCATION_HAND))
  and (HasIDNotNegated(AIHand(),96570609,true)
  or HasIDNotNegated(AIST(),18235309,true,FilterOPT))
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    if TributesAvailable(true)==2
    and TributeFodder()<2
    and TributeCountM(true)<2
    and Duel.GetCurrentChain()==0
    or ChainCheck(54241725,player_ai,nil,FilterLocation,LOCATION_GRAVE)
    then
      GlobalStormforth=Duel.GetTurnCount()
      return true
    end
  end
  if (ChainCheck(96570609,player_ai) -- Aither
  or ChainCheck(18235309,player_ai)) -- Escalation
  and TributesAvailable(true)>0
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    GlobalStormforth=Duel.GetTurnCount()
    return true
  end
  return false
end
function ChainGarum(c)
  if CardsMatchingFilter(AIDeck(),VassalFilter,59463312)>0 then
    OPTSet(22382087)
    return true
  end
end
function ChainLandrobe(c)
  if true then
    OPTSet(95993388)
    return true
  end
end
function ChainIdea(c)
  if FilterLocation(c,LOCATION_MZONE) then
    OPTSet(95457011)
    return true
  end
  if FilterLocation(c,LOCATION_GRAVE) then
    OPTSet(954570111)
    return true
  end
  return false
end
function ChainEidos(c)
  if true then
    OPTSet(594633121)
    return true
  end
end
function ChainKuraz(c)
  local targets = SubGroup(OppField(),KurazFilter,true)
  local targets2 = SubGroup(AIField(),KurazFilter2)
  return #targets+#targets2>0
end
function ChainEscalation(c,mode)
  if RemovalCheckCard(c)
  and CanTributeSummon() 
  then
    OPTSet(c)
    return true
  end
  if Duel.GetTurnPlayer()==player_ai then
    return false
  end
  if ChainCheck(79844764,player_ai) then --Stormforth
    return false
  end
  if GlobalStormforth==Duel.GetTurnCount() 
  and CanTributeSummon()
  and CardsMatchingFilter(OppMon(),StormforthFilter)>0
  then
    return true
  end
  local targets = RemovalCheckList(AIMon())
  if targets and #targets>0
  and CanTributeSummon() 
  then
    GlobalCardMode = 1
    GlobalTragetSet(targets[1])
    OPTSet(c)
    return true
  end
  if HasPriorityTarget(OppField())
  and CanTributeSummon()
  then
    OPTSet(c)
    return true
  end
  if Duel.CheckTiming(TIMING_MAIN_END)
  and CanTributeSummon()
  then
    OPTSet(c)
    return true
  end
end
function MegaMonarchChain(cards)
  if HasID(cards,79844764,ChainStormforth) then
    return 1,CurrentIndex
  end
  if HasID(cards,18235309,ChainEscalation) then
    return Chain()
  end
  if HasID(cards,57666212,ChainKuraz) then
    return Chain()
  end
  if HasID(cards,96570609,ChainAither) then
    return 1,CurrentIndex
  end
  if HasID(cards,23064604,ChainErebus) then
    return 1,CurrentIndex
  end
  if HasID(cards,95993388,ChainLandrobe) then
    return 1,CurrentIndex
  end
  if HasID(cards,22382087,ChainGarum) then
    return 1,CurrentIndex
  end
  if HasID(cards,59463312,ChainEidos) then
    return 1,CurrentIndex
  end
  if HasID(cards,95457011,ChainIdea) then
    return 1,CurrentIndex
  end
  if HasID(cards,54241725,ChainOriginal) then
    return 1,CurrentIndex
  end

  return nil
end
function MegaMonarchEffectYesNo(id,card)
  if id == 57666212 and ChainKuraz(card) then
    return 1
  end
  if id == 96570609 and ChainAither(card) then
    return 1
  end
  if id == 23064604 and ChainErebus(card) then
    return 1
  end
  if id == 95993388 and ChainLandrobe(card) then
    return 1
  end
  if id == 22382087 and ChainGarum(card) then
    return 1
  end
  if id == 59463312 and ChainEidos(card) then
    return 1
  end
  if id == 95457011 and ChainIdea(card) then
    return 1
  end
  if id == 54241725 and ChainOriginal(card) then
    return 1
  end
  if id == 61466310 then -- March
    return 1
  end
  if id == 95993388 then -- Landrobe
    --return 1
  end
  if id == 22382087 then -- Garum
    --return 1
  end
  return nil
end

function MegaMonarchYesNo(desc)
  if desc == 92 then -- Stormforth tribute enemy
    return 1
  end
  return nil
end
function AitherTributeFilter(c,cards)
  return ListHasCard(cards,c)
end
function MegaMonarchTribute(cards,min, max)
  if GlobalSummonedCard then
    GlobalSummonedCard = nil
    if GlobalAither then
      local result = Add(cards,PRIO_TOGRAVE,min,AitherTributeFilter,GlobalAither)
      GlobalAither = nil
      return result
    end
    return Add(cards,PRIO_TOGRAVE,min,VassalFilter)
  end
end
function MegaMonarchBattleCommand(cards,targets,act)
end
function MegaMonarchAttackTarget(cards,attacker)
end
function MegaMonarchAttackBoost(cards)
  if HasIDNotNegated(AIST(),84171830,true) 
  and Duel.GetTurnPlayer()==player_ai 
  then  
    for i=1,#cards do
      local c=cards[i]
      if FilterSummon(c,SUMMON_TYPE_ADVANCE) then
        c.attack=c.attack+800
      end
    end
  end
end
--[[
96570609 -- Aither
23064604 -- Erebus
69230391 -- Mega Thestalos
87288189 -- Mega Caius
]]
function MegaMonarchOption(options)
  for i=1,#options do
    if options[i]==23064604*16+3 -- Erebus
    and not HasPriorityTarget(OppField(),false)
    and not OppHasStrongestMonster()
    then
      return i
    end
    if options[i]==23064604*16+4 
    and (HasPriorityTarget(OppField(),false)
    or OppHasStrongestMonster()
    or #OppHand()==0)
    then
      return i
    end
    if options[i]==23064604*16+5
    and #OppHand()==0
    and #OppField()==0
    then
      return i
    end
    if options[i]==983460962 then -- Return, select lvl 8
      return i
    end
    if GlobalSummonedCard 
    and (GlobalSummonedCard.id == 96570609
    or GlobalSummonedCard.id == 23064604
    or GlobalSummonedCard.id == 69230391
    or GlobalSummonedCard.id ==87288189)
    then
      if GlobalAither and GlobalSummonedCard.id == 96570609 then
        if options[i]==1 and #GlobalAither>1 then
          return i
        end
        if options[i]==1107686256 and #GlobalAither==1 
        and FilterSummon(GlobalAither[1],SUMMON_TYPE_ADVANCE)
        and not (GlobalStormforth == Duel.GetTurnCount()
        and CardsMatchingFilter(OppMon(),StormforthFilter)>0)
        then
          return i
        end
      end
      if options[i]==1 
      and (TributeFodder()>1 or GlobalStormforth == Duel.GetTurnCount())
      then
        return i
      end
      if options[i]==1107686256  
      and TributeFodder()<2
      and GlobalStormforth ~= Duel.GetTurnCount()
      then -- Return select lvl 8
        return i
      end
    end
  end
end
function MegaMonarchChainOrder(cards)
  result = {}
  for i=1,#cards do
    local c=cards[i]
    if c.level>5 then
      result[1]=i -- put any Monarch at the front of the chain to protect it from effect negation.
    end
  end
  for i=1,#cards do
    local c=cards[i]
    if not (c.level>5) then
      result[#result+1]=i
    end
  end
  return result
end

MegaMonarchAtt={
96570609, -- Aither
23064604, -- Erebus
69230391, -- Mega Thestalos
87288189, -- Mega Caius
09748752, -- Caius
57666212, -- Kuraz
}
MegaMonarchDef={
95993388, -- Landrobe
22382087, -- Garum
59463312, -- Eidos
95457011, -- Idea
54241725, -- Original
}
function MegaMonarchPosition(id,available)
  result = nil
  for i=1,#MegaMonarchAtt do
    if MegaMonarchAtt[i]==id 
    then 
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#MegaMonarchDef do
    if MegaMonarchDef[i]==id 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  if id==09126351 and TurnEndCheck() then
    result=POS_FACEUP_DEFENSE 
  end
  if id==53334641 and TurnEndCheck() then
    result=POS_FACEUP_DEFENSE 
  end
  return result
end

