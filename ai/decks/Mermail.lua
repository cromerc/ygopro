function MermailPriority()

AddPriority({
-- Mermail
[21954587] = {6,4,5,3,4,1,5,1,1,1,MegaloCond},        -- Mermail Abyssmegalo
[22446869] = {7,3,4,2,2,1,1,1,1,1,TeusCond},          -- Mermail Abyssteus
[37781520] = {7,1,6,4,5,1,4,1,1,1,LeedCond},          -- Mermail Abyssleed
[58471134] = {4,2,8,2,2,1,1,1,1,1,PikeCond},          -- Mermail Abysspike
[22076135] = {4,2,7,2,2,1,1,1,1,1,TurgeCond},         -- Mermail Abyssturge
[69293721] = {7,5,0,0,0,0,7,0,0,0,GundeCond},         -- Mermail Abyssgunde
[23899727] = {5,2,3,2,1,1,1,1,1,1,LindeCond},         -- Mermail Abysslinde
[74298287] = {5,2,3,2,2,2,4,1,3,3,DineCond},          -- Mermail Abyssdine
[37104630] = {5,2,8,1,7,2,6,2,2,2,InfantryCond},      -- Atlantean Heavy Infantry
[00706925] = {4,2,4,1,7,2,6,2,2,2,MarksmanCond},      -- Atlantean Marksman
[74311226] = {7,5,9,1,8,4,6,4,1,1,DragoonsCond},      -- Atlantean Dragoons
[21565445] = {6,1,6,1,9,1,5,1,5,1,NeptabyssCond},     -- Atlantean Prince Neptabyss
[47826112] = {8,1,5,1,6,1,5,1,1,1,PoseidraCond},      -- Atlantean Poseidra
[13959634] = {9,1,1,1,1,1,1,1,1,1,MoulinclaciaCond},  -- Elemental Lord Moulinclacia


[26400609] = {6,3,4,2,6,4,5,4,0,0,TidalCond},         -- Tidal
[78868119] = {8,3,2,2,2,1,4,1,2,2,DivaCond},          -- Deep Sea Diva
[04904812] = {4,2,2,2,2,1,5,1,3,3,UndineCond},        -- Genex Undine
[68505803] = {2,1,2,2,3,1,4,1,5,5,ControllerCond},    -- Genex Controller

[72932673] = {5,2,1,1,1,1,1,1,1,1,MizuchiCond},       -- Abyss-Scale of the Mizuchi

[60202749] = {3,3,1,1,1,1,1,1,1,1,nil},               -- Abyss-sphere
[34707034] = {4,2,1,1,1,1,1,1,1,1,SquallCond},        -- Abyss-squall
[37576645] = {1,1,1,1,1,1,1,1,1,1,nil},               -- Reckless Greed

[74371660] = {1,1,1,1,1,1,1,1,5,1,nil},               --  Mermail Abyssgaios
[22110647] = {1,1,1,1,1,1,1,1,1,1,nil},               --  Mecha Phantom Beast Dracossack
[80117527] = {1,1,1,1,1,1,1,1,1,1,nil},               --  Number 11 -  Big Eye
[21044178] = {1,1,1,1,1,1,1,1,5,1,nil},               --  Abyss Dweller
[00440556] = {1,1,1,1,1,1,1,1,5,1,nil},               --  Bahamut Shark
[46772449] = {1,1,1,1,1,1,1,1,1,1,nil},               --  Evilswarm Exciton Knight
[12014404] = {1,1,1,1,1,1,1,1,1,1,nil},               --  Gagaga Cowboy
[59170782] = {1,1,4,3,1,1,1,1,5,1,TriteCond},         --  Mermail Abysstrite
[50789693] = {1,1,5,2,1,1,1,1,5,1,KappaCond},         --  Armored Kappa
[65749035] = {1,1,1,1,1,1,1,1,5,1,nil},               --  Gugnir, Dragon of  the Ice Barrier
[70583986] = {1,1,1,1,1,1,1,1,5,1,nil},               --  Dewloren Tiger King of the Ice Barrier
[88033975] = {1,1,1,1,1,1,1,1,1,1,nil},               --  Armades keeper of Illusions

[55863245] = {1,1,1,1,1,1,1,1,1,1,nil},   -- Child Dragon
})
end
function AtlanteanFilter(c,exclude)
  return IsSetCode(c.setcode,0x77) and (exclude == nil or c.id~=exclude)
end
function MermailFilter(c,exclude)
  return IsSetCode(c.setcode,0x74) and (exclude == nil or c.id~=exclude)
end
function NeptabyssCond(loc,c) 
  if loc == PRIO_TOHAND then
    return (not (HasID(AICards(),21565445,true)
    or  HasID(AICards(),78868119,true))
    and OPTCheck(21565445) )
    or FilterLocation(c,LOCATION_MZONE)
  end
  if loc == PRIO_TOGRAVE or loc == PRIO_DISCARD then
    return OPTCheck(21565446) 
    and CardsMatchingFilter(AIGrave(),AtlanteanFilter,21565445)>0
    and (not FilterLocation(c,LOCATION_HAND) 
    or NormalSummonCheck(player_ai))
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(21565445)
    and not HasID(AIMon(),21565445,true)
  end
  return true
end
function PoseidraCond(loc,c)
  if loc == PRIO_TOHAND then
    return SummonPoseidra(c)
    or LeoComboCheck()
  end
  if loc == PRIO_DISCARD then
    if SummonPoseidra(c) then
      return 8
    end
    return true
  end
  return true
end
function MizuchiCond(loc,c)
  if loc == PRIO_TOHAND then
    return BattlePhaseCheck() or HasID(AICards(),60202749,true)
  end
  return true
end
function LeoComboCheck()
  return (HasID(AIMon(),78868119,true) 
  and HasID(AIMon(),21565445,true)
  and HasID(AIExtra(),55863245,true)
  and HasID(AIExtra(),08561192,true)
  and CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_WATER)==1
  and HasID(AIGrave(),74311226,true)
  or HasID(AIMon(),55863245,true)
  and HasID(AIExtra(),08561192,true)
  and HasID(AIHand(),13959634,true)
  and CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_WATER)==3)
  and DualityCheck()
  and MacroCheck()
end
function MoulinclaciaCond(loc,c)
  if loc == PRIO_TOHAND then
    return SummonMoulinglacia()
    or LeoComboCheck() and not HasID(AIMon(),37104630,true)
  end
  return true
end
function InfantryFilter(c)
  return bit32.band(c.position,POS_FACEUP)>0 and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 --and c.owner==2
end
function InfantryCond(loc)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(UseLists({OppMon(),OppST()}),InfantryFilter)
    > CardsMatchingFilter(AIHand(),function(c) return c.id==37104630 end)
  elseif loc == PRIO_DISCARD or loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(UseLists({OppMon(),OppST()}),InfantryFilter)
    > GetMultiple(37104630)
  end
  if loc == PRIO_TOFIELD then
    if HasID(AIHand(),21565445,true) 
    and not HasID(AIMon(),37104630,true)
    and OPTCheck(21565445)
    and HasID(AIMon(),78868119,true)
    and CardsMatchingFilter(AIHand(),FilterAttribute,ATTRIBUTE_WATER)>1
    and BattlePhaseCheck()
    then
      return true
    end
    return false
  end
  return true
end
function MarksmanFilter(c)
    return bit32.band(c.position,POS_FACEDOWN)>0 and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 --and c.owner==2
end
function MarksmanCond(loc)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(UseLists({OppMon(),OppST()}),MarksmanFilter)
    > CardsMatchingFilter(AIHand(),function(c) return c.id==00706925 end)
  elseif loc == PRIO_DISCARD or loc == PRIO_TOGRAVE then
    return CardsMatchingFilter(UseLists({OppMon(),OppST()}),MarksmanFilter)
    > GetMultiple(00706925)
  elseif loc == PRIO_TOFIELD then
    return #OppMon()==0 and BattlePhaseCheck()
    --and not HasIDNotNegated(AIMon(),21954587,true)
  end
  return true
end
function DragoonsCond(loc)
  if loc == PRIO_DISCARD then
    if SummonPoseidra() then
      return 7
    end
  end
  return true
end
function GundeFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and IsSetCode(c.setcode,0x74) and c.id~=69293721
end
function GundeCond(loc)
  if loc == PRIO_DISCARD then
    return (CardsMatchingFilter(AIGrave(),GundeFilter)>0
    or GlobalGunde)
    and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1
    and OPTCheck(69293721)
  end
  if loc == PRIO_TOHAND then
    return not HasID(AIHand(),69293721,true)
    and GetMultiple(69293721)==0
  end
  return true
end
function PikeCond(loc,c)
  if loc == PRIO_TOFIELD then
    return (c==nil or NotNegated(c))
    and (MermailPriorityCheck(AIHand(),PRIO_DISCARD) > 4 
    and OPTCheck(58471134)
    and Duel.GetCurrentChain()<=1
    or FieldCheck(4)==1 and Duel.GetTurnPlayer()==player_ai)
  end
  return true
end
function TurgeFilter(c)
  return c.level<=3 and bit32.band(c.attribute,ATTRIBUTE_WATER)>0
end
function TurgeCond(loc,c)
  if loc == PRIO_TOFIELD then
    return (c==nil or NotNegated(c))
    and (MermailPriorityCheck(AIHand(),PRIO_DISCARD) > 4 
    and CardsMatchingFilter(AIGrave(),TurgeFilter)>0
    and OPTCheck(22076135)
    and Duel.GetCurrentChain()<=1
    or FieldCheck(4)==1 and Duel.GetTurnPlayer()==player_ai)
  end
  return true
end
function LindeCheck()
  return DualityCheck() and MacroCheck() and CardsMatchingFilter(OppMon(),HandFilter,1500)>0 
  and OPTCheck(23899727) --and OppGetStrongestAttDef()<2700 
end
function LindeCond(loc)
  local cards=UseLists({AIHand(),AIMon()})
  local check = not(HasID(cards,23899727,true) 
  or (HasIDNotNegated(cards,23899727,true) and HasID(AIDeck(),23899727,true)))
  if loc == PRIO_TOHAND then 
    return check
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(23899727) and check
  end
  return true
end
function MegaloCond(loc)
  if loc == PRIO_TOHAND then
    return MermailPriorityCheck(AIHand(),PRIO_DISCARD,2)>3 
    and not HasID(UseLists(AIHand(),AIMon()),21954587,true)
  end
  if loc == PRIO_DISCARD then
    return false-- CardsMatchingFilter(AIHand(),function(c) return c.id==21954587 end)>1
  end
  return true
end
function TeusCond(loc)
  if loc == PRIO_TOHAND then
    return MermailPriorityCheck(AIHand(),PRIO_DISCARD)>5
  end
  return true
end
function LeedCond(loc)
  if loc == PRIO_TOHAND then
    return MermailPriorityCheck(AIHand(),PRIO_DISCARD,3)>5
    and CardsMatchingFilter(AIGrave(),function(c) return bit32.band(c.setcode,0x75)>0 and bit32.band(c.type,TYPE_SPELL+TYPE_TRAP)>0 end)>0 
  end
  return true
end
function TidalCond(loc)
  return true
end
function TriteFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and IsSetCode(c.setcode,0x74)
end
function TriteCond(loc)
  if loc == PRIO_TOFIELD then
    return CardsMatchingFilter(AIGrave(),TriteFilter)>0
  end
  return true
end
function KappaCond(loc)
  if loc == PRIO_TOFIELD then
    return MermailPriorityCheck(AIHand(),PRIO_DISCARD)>5 and #AIMon()>2
  end
  return true
end
function DineFilter(c)
  return c.level<=3 and IsSetCode(c.setcode,0x74)
end
function DineCond(loc)
  if loc == PRIO_TOHAND then
    return Duel.GetCurrentChain()<=1 
    and CardsMatchingFilter(AIMon(),DineFilter)>0
  end
  if loc == PRIO_TOFIELD then
    return Duel.GetCurrentChain()<=1 
    and CardsMatchingFilter(AIGrave(),DineFilter)>0
  end
  return true
end
function SquallFilter(c)
  return bit32.band(c.type,TYPE_MONSTER)>0 and IsSetCode(c.setcode,0x74)
end
function SquallCond(loc)
  if loc == PRIO_TOHAND then
    return CardsMatchingFilter(AIGrave(),SquallFilter)>3 or HasID(UseLists(AIHand(),AIST()),60202749,true)
  end
  return true
end
function DivaCond(c,loc)
  if loc == PRIO_TOHAND then
    return ((HasIDNotNegated(AIST(),60202749,true) 
    or FieldCheck(4)>1) 
    and Duel.GetTurnPlayer()==player_ai 
    and not NormalSummonCheck(player_ai))
    or not HasID(AICards(),21565445,true)
  end
  if loc == PRIO_TRIBUTE then
    return FilterLocation(c,LOCATION_MZONE)
  end
  return true
end
function UndineCond(loc)
  if loc == PRIO_TOHAND then
    return HasID(AIDeck(),68505803,true)
  end
  if loc == PRIO_DISCARD then
    return not HasID(AIDeck(),68505803,true)
  end
  return true
end
function ControllerCond(loc)
  return true
end

function MermailGetPriority(c,loc)
  local id=c.id
  local checklist = nil
  local result = 0
  if loc == nil then
    loc = PRIO_TOHAND
  end
  checklist = Prio[id]
  if checklist then
    if checklist[11] then
      if type(checklist[11](loc,c))=="number" then
        result = checklist[11](loc,c)
      else
        if not(checklist[11](loc,c)) then
          loc = loc + 1
        end
        result = checklist[loc]
      end
    end 
  end
  if GlobalSummonNegated and id==23899727 
  and loc == PRIO_TOFIELD and OPTCheck(23899727) 
  then
    result = 10
    GlobalSummonNegated=nil
  end
  if GundeFilter(c) and loc==PRIO_DISCARD and GlobalGunde then
    result = 0.1*result + 6
  end
  return result
end
GlobalGunde = nil
function MermailAssignPriority(cards,loc,filter,opt)
  local index = 0
  local check = false
  Multiple = nil
  for i=1,#cards do
    if GundeFilter(cards[i]) then
      check = true
    end
  end
  if GlobalGunde and not check then
    GlobalGunde = nil
  end
  for i=1,#cards do
    cards[i].index=i
    if not MermailMultiTargetFilter(cards[i]) then
      cards[i].prio=-1
    else
      cards[i].prio=MermailGetPriority(cards[i],loc)
    end
    if filter and (opt==nil and not filter(cards[i]) 
    or opt and not filter(cards[i],opt)) 
    then
      cards[i].prio=-1
    end
    if loc==PRIO_BANISH and cards[i].location~=LOCATION_GRAVE then
      cards[i].prio=cards[i].prio-2
    end
    SetMultiple(cards[i].id)
  end
end
function MermailPriorityCheck(cards,loc,count,filter,opt)
  if count == nil then count = 1 end
  if count > 1 and HasID(AIHand(),69293721,true) then GlobalGunde = true end
  if loc==nil then loc=PRIO_TOHAND end
  if cards==nil or #cards<count then return -1 end
  MermailAssignPriority(cards,loc,filter,opt)
  table.sort(cards,function(a,b) return a.prio>b.prio end)
  return cards[count].prio
end
function MermailAdd(cards,loc,count,filter,opt)
  local result={}
  if count==nil then count=1 end
  if count > 1 and HasID(AIHand(),69293721,true) then GlobalGunde = true end
  if loc==nil then loc=PRIO_TOHAND end
  local compare = function(a,b) return a.prio>b.prio end
  MermailAssignPriority(cards,loc,filter,opt)
  table.sort(cards,compare)
  for i=1,count do
    result[i]=cards[i].index
    MermailTargets[#MermailTargets+1]=cards[i].cardid
  end
  return result
end
function UseMegalo(card)
  return OverExtendCheck()
  and (MermailPriorityCheck(AIHand(),PRIO_DISCARD,2,FilterAttribute,ATTRIBUTE_WATER)>3
  or HasID(AIHand(),69293721,true) 
  and OPTCheck(69293721) 
  and CardsMatchingFilter(AIHand(),GundeFilter)>1
  or #OppMon()==0
  and HasID(AIMon(),21565445)
  and OPTCheck(21565446)
  and BattlePhaseCheck()
  and MermailPriorityCheck(AIHand(),PRIO_DISCARD,1,FilterAttribute,ATTRIBUTE_WATER)>3
  or #AIHand()>6)
end
function MegaloFilter(c)
  return bit32.band(c.position,POS_FACEUP_ATTACK)>0 
  and bit32.band(c.attribute,ATTRIBUTE_WATER)>0 and c.level<5
end
function UseMegaloField(card)
  local cards = SubGroup(AIMon(),MegaloFilter)
  if #cards>0
  and #OppMon()==0 and GlobalBPAllowed
  and Duel.GetCurrentPhase() == PHASE_MAIN1
  and card.attack>=2000
  and card:is_affected_by(EFFECT_CANNOT_ATTACK)==0
  and card:is_affected_by(EFFECT_CANNOT_ATTACK_ANNOUNCE)==0
  and bit32.band(card.position,POS_FACEUP_ATTACK)>0
  or MermailPriorityCheck(cards,PRIO_TOGRAVE)>4
  then
    OPTSet(card)
    return true
  end
end
function UseTeus()
  return MermailPriorityCheck(AIHand(),PRIO_DISCARD,1,FilterAttribute,ATTRIBUTE_WATER)>4
end
function UseLeed(card)
  return FilterLocation(card,LOCATION_HAND)
  and MermailPriorityCheck(AIHand(),PRIO_DISCARD,3,FilterAttribute,ATTRIBUTE_WATER)>5 
  and CardsMatchingFilter(AIGrave(),
    function(c) 
      return FilterSet(c,0x75)
      and FilterType(c,TYPE_SPELL+TYPE_TRAP)
    end)>0 
end
function LeedFilter(c)
  return bit32.band(c.position,POS_FACEUP_ATTACK)>0 
  and IsSetCode(c.setcode,0x74) and c.level<5
end
function UseLeedField(card)
  return bit32.band(card.location,LOCATION_ONFIELD)>0 
   and CardsMatchingFilter(AIMon(),LeedFilter)>0
   and #OppHand()>0 and (Duel.GetCurrentPhase() == PHASE_MAIN2 or Duel.GetTurnCount()==1)
end
function UsePike(c)
  return PikeCond(PRIO_TOFIELD,c)
end
function UseTurge(c)
  return TurgeCond(PRIO_TOFIELD,c)
end
function UseSalvage()
  return MermailPriorityCheck(AIGrave(),PRIO_TOHAND,2,
    function(c) return FilterAttribute(c,ATTRIBUTE_WATER) and c.attack<=1500 end)>1
  and #AIHand()<6
  and CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_WATER)~=5
end
function SummonBahamut()
  return OppGetStrongestAttDef()<2600
end
function UseBahamut()
  return Duel.GetCurrentPhase() == PHASE_MAIN2 or Duel.GetTurnCount()==1
end
function SummonGaios()
  return MP2Check(2800) and OppGetStrongestAttDef()<2800
end
function SummonDiva1()
  return (HasIDNotNegated(AIST(),60202749,true) 
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>2 
  or FieldCheck(4)>1 
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1)
  and HasID(AIExtra(),70583986,true)
  or HasID(AIDeck(),21565445,true) and OPTCheck(21565445)
end
function SummonDiva2()
  return OverExtendCheck() 
  and OppGetStrongestAttDef()<2300 
  and SummonArmades(FindID(88033975,AIExtra()))
  and Duel.GetCurrentPhase() == PHASE_MAIN1 
  and GlobalBPAllowed
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1
end
function SummonDewloren()
  return MermailPriorityCheck(UseLists({AIMon(),AIST()}),PRIO_TOHAND,3)>1
  and HasID(AIExtra(),70583986,true)
end
function UseDewloren()
  return MP2Check() and MermailPriorityCheck(UseLists({AIMon(),AIST()}))>1
end
function UseSphere()
  if HasID(AIMon(),70583986,true) then
    GlobalSphere = 5
    return true
  end
  if HasID(AIMon(),78868119,true) 
  and not (LeoComboCheck() or HasID(AIMon(),37104630,true))
  then
    GlobalSphere = 4
    return true
  end
  if HasID(AIMon(),68505803,true) then
    GlobalSphere = 2
    return true
  end
  if FieldCheck(7) == 1 and OverExtendCheck() and ExtraDeckCheck(TYPE_XYZ,7)>0 then
    GlobalSphere = 7  
    return true
  end
  if FieldCheck(4) == 1 and OverExtendCheck() and ExtraDeckCheck(TYPE_XYZ,4)>0 then
    GlobalSphere = 4
    return true
  end
  return false
end
function GungnirFilter(c)
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0 and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function SummonGungnir()
  return UseGungnir() and HasID(AIExtra(),65749035,true)
end
function UseGungnir()
  return MermailPriorityCheck(AIHand(),PRIO_DISCARD,1)>4 and CardsMatchingFilter(UseLists({OppMon(),OppST()}),GungnirFilter)>0
end
function SummonSharkKnightMermail(cards)
  local targets=SubGroup(OppMon(),SharkKnightFilter)
  if DeckCheck(DECK_MERMAIL) and #targets > 0 and OPTCheck(48739166) then
    return true
  end
  return false
end
function SummonArmadesMermail(c)
  return BattlePhaseCheck()
  and CanWinBattle(c,OppMon())
end
function MermailOpenFieldCheck()
  return (#AIMon()==0 and #OppMon()==0 and not HasID(UseLists({AIHand(),AIST()}),60202749,true) 
  and (not HasID(AIHand(),23899727,true) or NormalSummonCheck(player_ai)))
  or #OppMon()>1
end
function UseTidal()
  return false--MermailPriorityCheck(AIHand(),PRIO_DISCARD,2)>4 or HasID(AIHand(),69293721,true) 
  --and OPTCheck(69293721) and OverExtendCheck()
end
function SummonTidal()
  local check=MermailPriorityCheck(AIGrave(),PRIO_BANISH,2)
  return check>1 and OverExtendCheck() or check>0 and (FieldCheck(7)==1 
  and not HasID(AIMon(),68505803) or MermailOpenFieldCheck())
end
function UseSquall()
  if RemovalCheck(34707034) then
    return true
  end
  if Duel.GetTurnPlayer()==player_ai and Duel.GetCurrentChain()==0 
  and Duel.GetCurrentPhase()==PHASE_MAIN1
  then
    if OverExtendCheck() then
      return true
    elseif HasID(AIMon(),70583986,true) then
      GlobalSummonToHand = true
      return true
    end
  end
  return false
end
function SummonLinde()
  return LindeCheck() and Duel.GetCurrentPhase()==PHASE_MAIN1 and GlobalBPAllowed
end
function SetLinde()
  return (Duel.GetCurrentPhase()==PHASE_MAIN2 or not GlobalBPAllowed) and not HasID(AIMon(),23899727,true)
end
function UseUndine()
  return true
end
function SummonUndine()
  return HasID(AIDeck(),68505803,true)
end
function SummonController()
  local check = HasIDNotNegated(AIST(),60202749,true) and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1
  return (FieldCheck(3)>0 or check) and SummonDewloren() 
  or (FieldCheck(4)>0 or check) and SummonGungnir()
  or (FieldCheck(7)==1 or check) and ExtraDeckCheck(TYPE_SYNCHRO,10)>0
end
function SetController()
  return #AIMon()==0
end

function SummonMarksman()
  return Duel.GetCurrentPhase(PHASE_MAIN1) and GlobalBPAllowed 
  and #OppMon()==0 and OverExtendCheck() and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>1
end
function SummonDine()
  return OverExtendCheck() and FieldCheck(3)==1
end
GlobalATK = nil
function UseNeptabyss(c)
  OPTSet(21565445)
  GlobalCardMode = 1
  return true
end
function SummonNeptabyss(c)
  return not HasID(AIMon(),21565445,true) and OPTCheck(21565445)
end
function SummonMoulinglacia(c)
  return #OppHand()>1 and OPTCheck(13959634) 
  and CardsMatchingFilter(AIGrave(),FilterAttribute,ATTRIBUTE_WATER)==5
end
function PoseidraFilter(c)
  return c.level<4 and FilterAttribute(c,ATTRIBUTE_WATER)
end
function SummonPoseidra(c)
  local cards = SubGroup(AIMon(),PoseidraFilter)
  return #cards>2 --and MermailPriorityCheck(cards,PRIO_TOGRAVE,2)>4
end
function SummonInfantry(c)
  return HasID(AIHand(),78868119,true) 
  and not HasID(AIMon(),37104630,true)
  and BattlePhaseCheck() 
  and CardsMatchingFilter(AIHand(),FilterAttribute,ATTRIBUTE_WATER)>1
  and Duel.GetLocationCount(player_ai,LOCATION_MZONE)>2
end
function SummonChildDragon(c)
  return LeoComboCheck() and not HasID(AIMon(),37104630,true)
end
function SummonLeoMermail(c)
  return LeoComboCheck()
end
function MizuchiFilter(c,id)
  return MermailFilter(c)
  and CanAttack(c)
  and c.id~=23899727 -- Linde
  and c.id~=69293721 -- Gunde
  and (id==nil or c.id==id)
end
function UseMizuchi(c)
  return CardsMatchingFilter(AIMon(),MizuchiFilter)>0
  and (BattlePhaseCheck() or HasIDNotNegated(AIMon(),74371660,true))
end
function SummonDragoons(c)
  return HasIDNotNegated(AIMon(),21954587,true,FilterOPT)
  and BattlePhaseCheck()
  or FieldCheck(4)==1
end
function MermailOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  local SetableST = cards.st_setable_cards
  MermailTargets = {}
  GlobalSummonNegated=nil
  GlobalSummonToHand=nil
  if HasID(Activatable,70368879) then -- Upstart Goblin
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(SpSummonable,13959634,SummonMoulinglacia) then
    OPTSet(13959634)
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSummonable,55863245,SummonChildDragon) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(SpSummonable,08561192,SummonLeoMermail) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,21044178,UseDweller) then
    return Activate()
  end
  if HasIDNotNegated(Activatable,21565445,UseNeptabyss) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,47826112,false,nil,LOCATION_GRAVE,SummonPoseidra) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,21954587,false,nil,LOCATION_MZONE) and UseMegaloField(Activatable[CurrentIndex]) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,96947648) and UseSalvage() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Summonable,37104630,SummonInfantry) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Summonable,78868119) and SummonDiva1() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasIDNotNegated(Summonable,21565445,SummonNeptabyss) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,21954587,false,nil,LOCATION_HAND) and UseMegalo(Activatable[CurrentIndex]) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,22446869) and UseTeus() then
    GlobalCardMode=1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,37781520) and UseLeed(Activatable[CurrentIndex]) then
    GlobalCardMode=1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,37781520) and UseLeedField(Activatable[CurrentIndex]) then
    GlobalCardMode=2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,60202749) and UseSphere() then
    GlobalSummonNegated=true
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,00440556) and UseBahamut() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,70583986) and UseDewloren() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,65749035) and UseGungnir() then
    GlobalCardMode=1
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(cards,34707034) and UseSquall() then
    GlobalSummonNegated=true
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Summonable,04904812) and SummonUndine() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,68505803) and SummonController() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,23899727) and SummonLinde() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,58471134) and (UsePike() or FieldCheck(4)==1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,22076135) and (UseTurge() or FieldCheck(4)==1) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,70583986) and SummonDewloren() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,65749035) and SummonGungnir() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,74371660) and SummonGaios() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,21044178,SummonDweller,2) and DeckCheck(DECK_MERMAIL) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
   if HasID(SpSummonable,00440556) and SummonBahamut() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,48739166) and SummonSharkKnightMermail(OppMon()) then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,74311226,SummonDragoons) then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,00706925) and SummonMarksman() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,74298287) and SummonDine() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(SetableMon,23899727) and SetLinde() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(Summonable,78868119) and SummonDiva2() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,26400609,false,422409746) and UseTidal() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  local check = DeckCheck(DECK_MERMAIL) and MermailPriorityCheck(AIHand(),PRIO_DISCARD)>1 and MermailOpenFieldCheck()
  if HasID(Activatable,22446869) and check then
    GlobalCardMode=1
    return {COMMAND_ACTIVATE,IndexByID(Activatable,22446869)}
  end
  if HasID(Activatable,21954587,false,nil,LOCATION_HAND) and MermailPriorityCheck(AIHand(),PRIO_DISCARD)>5  
  and MermailPriorityCheck(AIHand(),PRIO_DISCARD,2)>1 and MermailOpenFieldCheck()
  then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Summonable,58471134) and MermailOpenFieldCheck() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,22076135) and MermailOpenFieldCheck() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,26400609,false,422409744) and SummonTidal() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SetableMon,68505803) and MermailOpenFieldCheck() then
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(Repositionable,23899727,false,nil,nil,POS_FACEDOWN_DEFENSE) and SummonLinde() then
    return {COMMAND_CHANGE_POS,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,47826112,false,nil,LOCATION_HAND,SummonPoseidra) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,72932673,UseMizuchi) then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  cards=AIHand()
  --
  return nil
end
MermailTargets = {}
function MermailMultiTargetFilter(card) 
  local result = 0
  for i=1,#MermailTargets do
    if MermailTargets[i]==card.cardid then
      result = result+1
    end
  end
  return result==0
end
function BestTargetsMermail(cards,count)
  local result = {}
  if count == nil then
    count = 1
  end
  BestTargets(cards,count,true,MermailMultiTargetFilter) 
  for i=1,count do
    MermailTargets[#MermailTargets+1]=cards[1].cardid
    result[i]=cards[i].index
  end
  return result
end
function SphereTarget(cards)
  if GlobalSphere == 1 then
    local id = GlobalSphereID
    GlobalSphere = nil
    GlobalSphereID = nil
    return MermailAdd(cards,PRIO_TOFIELD,1,FilterID,id)
  end
  if GlobalSphere == 2 then
    GlobalSphere = nil
    for i=1,#cards do
      if cards[i].level == 3 and SummonDewloren() then
        return {i}
      end
      if cards[i].level == 4 and SummonGungnir() then
        return {i}
      end
      if cards[i].level == 7 and SummonLeoh(FindID(08561192,AIExtra())) then
        return {i}
      end
    end
  end
  if GlobalSphere == 3 then
    GlobalSphere = nil
    return MermailAdd(cards,PRIO_TOGRAVE,1,FilterAttackMin,AI.GetPlayerLP(2))
  end
  if GlobalSphere == 4 or GlobalSphere == 7 then
    local level = GlobalSphere
    GlobalSphere = nil
    return MermailAdd(cards,PRIO_TOGRAVE,1,FilterLevel,level)
  end
  if GlobalSphere == 5 then
    GlobalSphere = nil
    return MermailAdd(cards,PRIO_TOHAND)
  end
  return MermailAdd(cards,PRIO_TOFIELD)
end
function DewlorenTarget(cards,Min,Max)
  MermailAssignPriority(cards,PRIO_TOHAND)
  result = {}
  for i=1,#cards do
    if cards[i].prio>1 then
      result[#result+1]=i
    end
  end
  return result
end
function GungnirTarget(cards,Min,Max)
  local result = nil
  if GlobalCardMode == 1 then
    local count = math.min(CardsMatchingFilter(UseLists({AIMon(),AIST()}),GungnirFilter),2)
    if count > 1 and MermailPriorityCheck(AIHand(),PRIO_DISCARD,count)<4 then
      count = 1
    end
    result = MermailAdd(cards,PRIO_DISCARD,count)
  else
    result = BestTargetsMermail(cards,Min)
  end
  GlobalCardMode = nil
  if result == nil then result = {math.random(#cards)} end
  return result
end
function KappaTarget(cards)
  return MermailAdd(cards,PRIO_DISCARD)
end
function TidalTarget(cards)
  local result = nil
  if GlobalCardMode == 2 then
    GlobalCardMode=1
    result = MermailAdd(cards,PRIO_DISCARD)
  elseif GlobalCardMode == 1 then
    GlobalCardMode=nil
    result = MermailAdd(cards,PRIO_TOGRAVE)
  else
    result = MermailAdd(cards,PRIO_BANISH,2)
  end
  return result
end
function DivaTarget(cards)
  return MermailAdd(cards,PRIO_TOFIELD)
end
function MechquippedTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  else
    return GlobalTargetGet(cards,true)
  end
end
function UndineTarget(cards)
  return MermailAdd(cards,PRIO_TOGRAVE)
end
function NeptabyssTarget(cards)
  if LocCheck(cards,LOCATION_GRAVE) then
    OPTSet(21565446)
    return MermailAdd(cards,PRIO_TOFIELD)
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return MermailAdd(cards,PRIO_TOGRAVE)
  end
  return MermailAdd(cards)
end
function PoseidraTarget(cards,min)
  return MermailAdd(cards,PRIO_TOGRAVE,min)
end
function MizuchiTarget(cards)
  return BestTargets(cards,1,TARGET_PROTECT,MizuchiFilter,21954587)
end
function MegaloTarget(cards,min)
  if min==2 then
    return MermailAdd(cards,PRIO_DISCARD,2)
  end
  if LocCheck(cards,LOCATION_MZONE) then
    return MermailAdd(cards,PRIO_TOGRAVE)
  end
  if LocCheck(cards,LOCATION_DECK) then
    return MermailAdd(cards)
  end
  return BestTargetsMermail(cards,min)
end
function MarksmanTarget(cards,c)
  if FilterLocation(c,LOCATION_MZONE) then
    if SummonInfantry() then
      return MermailAdd(cards,PRIO_TOFIELD,1,FilterID,37104630)
    end
    return MermailAdd(cards,PRIO_TOFIELD)
  end
  return BestTargetsMermail(cards)
end
function MermailOnSelectCard(cards, minTargets, maxTargets,triggeringID,triggeringCard)
  local ID 
  local result=nil
  GlobalGunde=nil
  if triggeringCard then
    ID = triggeringCard.id
  else
    ID = triggeringID
  end
  if ID == 37104630 then
    return BestTargetsMermail(cards)
  end
  if ID == 00706925 then
    return MarksmanTarget(cards,triggeringCard)
  end
  if ID == 21954587 then
    return MegaloTarget(cards,minTargets)
  end
  if ID == 58471134 or ID == 22076135  
  or ID == 37781520 or ID == 22446869 or ID == 74311226
  then
    if GlobalCardMode==2 then
      result=BestTargetsMermail(cards,minTargets)
    elseif GlobalCardMode==1 then
      result=MermailAdd(cards,PRIO_DISCARD,minTargets)
    else
      result=MermailAdd(cards,PRIO_TOHAND,minTargets)
    end
    GlobalCardMode=nil
    if result==nil then result = {math.random(#cards)} end
    return result
  end
  if ID == 23899727 or ID == 69293721
  or ID == 37104630 or ID == 00440556 or ID == 59170782
  then
    return MermailAdd(cards,PRIO_TOFIELD)
  end
  if ID == 78868119 then
    return DivaTarget(cards)
  end
  if ID == 60202749 then
    return SphereTarget(cards)
  end
  if ID == 96947648 then
    return MermailAdd(cards,PRIO_TOHAND,2)
  end
  if ID == 70583986 then
    return DewlorenTarget(cards,minTargets,maxTargets)
  end
  if ID == 65749035 then
    return GungnirTarget(cards,minTargets,maxTargets)
  end
  if ID == 50789693 then
    return KappaTarget(cards)
  end
  if ID == 34707034 then
    return MermailAdd(cards,PRIO_TOFIELD,3)
  end
  if ID == 26400609 then
    return TidalTarget(cards)
  end
  if ID == 15914410 then
    return MechquippedTarget(cards)
  end
  if ID == 04904812 then
    return UndineTarget(cards)
  end
  if ID == 21565445 then
    return NeptabyssTarget(cards)
  end
  if ID == 47826112 then
    return PoseidraTarget(cards,minTargets)
  end
  if ID == 72932673 then
    return MizuchiTarget(cards)
  end
  return nil
end
function SphereFilter(c,dmg)
  return IsSetCode(c.setcode,0x74) and (dmg == nil or c.attack>=dmg) -- and c.attack>=dmg
end
function UseSphereBP()
  if Duel.GetTurnPlayer() == player_ai and #OppMon()==0 
  and CardsMatchingFilter(AIDeck(),SphereFilter,AI.GetPlayerLP(2))>0 and AI.GetPlayerLP(2)>ExpectedDamage(2)
  then
    GlobalSphere = 3
    return true
  end
end
function ChainSphere(c)
  if RemovalCheckCard(c) then
    if HasID(AIDeck(),23899727,true) and LindeCond(PRIO_TOFIELD) then -- Linde
      GlobalSphere = 1
      GlobalSphereID = 23899727 -- Linde
    end
    return true
  end
  local effect = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
	if effect then
    local c=effect:GetHandler() 
    if c:IsCode(60202749) and c:IsControler(player_ai) then -- Sphere
      return false
    end
  end
  if Duel.GetCurrentPhase()==PHASE_MAIN2 and Duel.CheckTiming(TIMING_MAIN_END) and Duel.GetTurnPlayer() == 1-player_ai 
  and HasID(AIDeck(),23899727,true) and LindeCond(PRIO_TOFIELD) -- Linde
  then
    GlobalSphere = 1
    GlobalSphereID = 23899727 -- Linde
    return true
  end
  if IsBattlePhase() and Duel.GetTurnPlayer() == 1-player_ai
  --and HasID(AIDeck(),23899727,true) and LindeCond(PRIO_TOFIELD) 
  then
    if Duel.GetAttacker() and #AIMon()==0 then
      GlobalSphere = 1
      GlobalSphereID = 23899727 -- Linde
      return true
    end
  end
  return false
end
function ChainReckless(c)
  local cards = AIMon()
  if RemovalCheckCard(c) then
    return true
  end
  if Duel.GetCurrentPhase() == PHASE_END and Duel.GetTurnPlayer() == 1-player_ai
  and (#AIHand()<3 or Duel.IsPlayerAffectedByEffect(player_ai,EFFECT_SKIP_DP)) 
  then
    return true
  end
  return false
end
function MechquippedFilter(c,id)
  return CurrentOwner(c)==1
  and FilterType(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK) 
  and c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)==0
  and c:is_affected_by(EFFECT_IMMUNE_EFFECT)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and (id == nil or c.id~=id)
end
function ChainMechquipped(c)
  local targets = RemovalCheckList(AIMon(),CATEGORY_DESTROY,nil,nil,MechquippedFilter)
  if targets then
    for i=1,#targets do
    end
    BestTargets(targets,1,TARGET_PROTECT)
    GlobalTargetSet(targets[1],AIMon())
    return true
  end
  if IsBattlePhase() then
    local aimon,oppmon = GetBattlingMons()
    if WinsBattle(oppmon,aimon) 
    and aimon.id ~= 23899727 
    then
      GlobalTargetSet(aimon)
      return true
    end
  end
  targets = SubGroup(AIMon(),MechquippedFilter,15914410)
  if RemovalCheckCard(c) then
    BestTargets(targets,1,TARGET_PROTECT)
    GlobalTargetSet(targets[1],AIMon())
    return true
  end
  targets = SubGroup(AIMon(),MechquippedFilter)
  if NegateCheckCard(c) then
    BestTargets(targets,1,TARGET_PROTECT)
    GlobalTargetSet(targets[1],AIMon())
    return true
  end
  return false
end
function ChainKappa()
  if IsBattlePhase() then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if source:GetAttack() >= target:GetAttack() and target:IsControler(player_ai) 
      and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) and not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
      then
        return MermailPriorityCheck(AIHand(),PRIO_DISCARD)>4
      end
    end
  end
  return false
end

function ChainGaios()
local gaios=Duel.GetMatchingGroup(function(c) return c:IsCode(74371660) end,player_ai,LOCATION_MZONE,0,nil):GetFirst()
local effect = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
	if effect then
    card=effect:GetHandler()
    player=player_ai
    if card and card:IsControler(1-player) and card:IsLocation(LOCATION_MZONE) 
    and not NegateBlacklist(card:GetCode()) and card:GetAttack()<gaios:GetAttack()
    then
      return true
    end
  end
  if IsBattlePhase() then
    if Duel.GetTurnPlayer()==player_ai then
      local cards=OppMon()
      for i=1,#cards do
        if VeilerTarget(cards[i]) and cards[i].attack<gaios:GetAttack()then
          return true
        end
      end
    end
  end
  return false
end
function UseDweller(c,mode)
  if HasID(c.xyz_materials,74311226) then
    return true
  end
  return false
end
function ChainDweller(c,mode)
  if RemovalCheckCard(c) or NegateCheckCard(c) then
    --print("Dweller removed, chaining")
    return true
  end
  if Duel.GetTurnPlayer()==1-player_ai
  and MatchupCheck(c.id)
  then
    --print("Dweller matchup, chaining asap")
    return true
  end
  for i=1,Duel.GetCurrentChain() do
    local e = Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    if e and Duel.GetChainInfo(i,CHAININFO_TRIGGERING_PLAYER)==1-player_ai
    then
      local ec = e:GetHandler()
      if Duel.GetOperationInfo(i,CATEGORY_TOGRAVE)
      or Duel.GetOperationInfo(i,CATEGORY_DECKDES)
      then
        --print("dump or mill effect activated, chaining")
        return true
      end
      if Duel.GetOperationInfo(i,CATEGORY_SPECIAL_SUMMON)
      and FilterType(ec,TYPE_SPELL+TYPE_TRAP) 
      and (FilterType(ec,TYPE_RITUAL)
      or FilterSet(ec,0x46))
      and not ec:IsCode(01845204) -- Instant Fusion
      then
        --print("ritual or fusion summon, chaining")
        return true
      end
    end
  end
  for i=1,Duel.GetCurrentChain() do
    local e = Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    if e and Duel.GetChainInfo(i,CHAININFO_TRIGGERING_PLAYER)==player_ai
    then
      cat={CATEGORY_TOGRAVE,CATEGORY_DESTROY}
      for j=1,2 do
        local ex,cg=Duel.GetOperationInfo(i,cat[j])
        if ex then
          local c = GetCardFromScript(cg:GetFirst())
          if CurrentOwner(c)==2 then
            --print(removal by AI, chaining")
            return true
          end
        end
      end
    end
  end
  if IsBattlePhase() then
    local aimon,oppmon = GetBattlingMons()
    if WinsBattle(aimon,oppmon) 
    or WinsBattle(oppmon,aimon) and CardsEqual(c,aimon)
    then
      --print("winning battle, chaining")
      return true
    end
  end
  return false
end
function MermailOnSelectChain(cards,only_chains_by_player)
  MermailTargets = {}
  if HasID(cards,37576645,nil,nil,nil,nil,ChainReckless) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,58471134) and UsePike() then
    OPTSet(58471134)
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,22076135) and UseTurge() then
    OPTSet(22076135)
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasID(cards,60202749,nil,nil,nil,nil,ChainSphere) then
    GlobalSummonNegated=true
    return {1,CurrentIndex}
  end
  if HasID(cards,34707034) and UseSquall() then
    GlobalSummonNegated=true
    return {1,CurrentIndex}
  end
  if HasID(cards,21954587) then
    return {1,CurrentIndex}
  end
  if HasID(cards,37781520) then
    return {1,CurrentIndex}   
  end
  if HasID(cards,22446869) then
    return {1,CurrentIndex}
  end
  if HasID(cards,69293721) then
    return {1,CurrentIndex}
  end
  if HasID(cards,23899727) then
    OPTSet(23899727)
    return {1,CurrentIndex}
  end
  if HasID(cards,74298287) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,04904812) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,15914410,ChainMechquipped) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,50789693) and ChainKappa() then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,74371660) and ChainGaios() then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,21044178,ChainDweller) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,21565445) then
    OPTSet(21565446)
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,47826112) then
    return {1,CurrentIndex}
  end
  return nil
end

function MermailOnSelectEffectYesNo(id,triggeringCard)
  local result = nil
  if id==37781520 or id==21954587 or id==22446869 or id==69293721 or id==23899727 then
    OPTSet(id)
    result = 1
  end
  if id==58471134 then
    if UsePike(triggeringCard) then
      OPTSet(58471134)
      GlobalCardMode = 1
      result = 1
    else
      result = 0
    end
  end
  if id==22076135 then
    if UseTurge(triggeringCard) then
      OPTSet(22076135)
      GlobalCardMode = 1
      result = 1
    else
      result = 0
    end
  end
  if id==74298287 or id==59170782 or id == 78868119 
  or id==04904812 or id==00706925 or id == 47826112
  then
    result = 1
  end
  if id == 21565445 then
    OPTSet(21565446)
    result = 1
  end
  return result
end

MermailAtt={
  21954587,15914410,70583986, -- Megalo,Mechquipped Angineer,Dewloren
  74311226,00706925,21565445, -- Dragoons, Marksman, Neptabyss (for Megalo)
  37104630,21044178, -- Infantry (for Megalo), Dweller
}
MermailDef={
  59170782,50789693,--22446869,  -- Trite, Kappa,Teus
  --23899727, -- Linde
}
function MermailOnSelectPosition(id, available)
  result = nil
  for i=1,#MermailAtt do
    if MermailAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#MermailDef do
    if MermailDef[i]==id and not (IsBattlePhase() 
    and Duel.GetTurnPlayer()==player_ai) 
    then 
      result=POS_FACEUP_DEFENSE 
    end
  end
  if id == 22446869 then -- Teus
    if Duel.GetTurnPlayer()==player_ai
    and BattlePhaseCheck() 
    and (CardsMatchingFilter(OppMon(),FilterAttackMin,1700)==0 
    or not OppHasStrongestMonster())
    then
      result=POS_FACEUP_ATTACK
    else
      result=POS_FACEUP_DEFENSE
    end
  end
  if id == 23899727 then -- Linde
    if Duel.GetTurnPlayer()==player_ai
    and BattlePhaseCheck() 
    and LindeCheck()
    then
      result=POS_FACEUP_ATTACK
    else
      result=POS_FACEUP_DEFENSE
    end
  end
  return result
end