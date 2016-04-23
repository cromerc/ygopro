function HeraldicCount(cards)
  local result = 0
  if cards then
    for i=1,#cards do
      if IsSetCode(cards[i].setcode,0x76) then result = result + 1 end
    end
  end
  return result
end
function HeraldicCanXYZ()
  local AIMon=AIMon()
  local cards=UseLists({AIHand(),AIMon})
  local handcount=HeraldicCount(AIHand())
  local gravecount=HeraldicCount(AIGrave())
  local fieldcount=HeraldicCount(AIMon)
  local result = false
  if not NormalSummonCheck(player_ai) then
    if HasID(AIHand(),65367484) and handcount>0 and #AIMon==0 then --Thrasher
      result=true
    end
    if HasID(AIHand(),94656263) and handcount>0 then --Kagetokage
      result=true
    end
    if HasID(AIHand(),87255382) and (handcount>2 or HasID(AIHand(),82293134) and OPTCheck(82293134)) then
      result=true
    end
    if HasID(UseLists({AIHand(),AIST()}),84220251) and handcount>0 and gravecount >0 then
      result=true
    end
    if FieldCheck(4)>0 then
      result=true
    end
  end
  return result
end
function UsePlainCoat()
  local cards=UseLists({AIMon(),OppMon()})
  local check={}
  local result=false
  for i=1,#cards do
    if check[cards[i].id] and (check[cards[i].id].owner==2 or cards[i].owner==2) then
      result=true
    end
    check[cards[i].id]=cards[i]
  end
  return result
end
function SummonPlainCoat()
  return UsePlainCoat() or not(HasAccess(23649496)) and (HasID(AIHand(),92365601,true) 
  or OppGetStrongestAttDef()<=2200) or not(HasAccess(23649496)) and Duel.GetCurrentPhase() == PHASE_MAIN2
end
function SummonGenomHeritage()
  return UseGenomHeritage()
end
function SummonChainHeraldic()
  return DeckCheck(DECK_HERALDIC) and not(HasAccess(82293134)) 
  and MP2Check(1800) and OppGetStrongestAttDef()<=1800 and not HasID(AIHand(),92365601,true)
end
function SummonLeo()
  return FieldCheck(4)==1 or FieldCheck(4)==0 and HasID(AIHand(),94656263)
  or HeraldicCount(AIGrave())>0 and HasID(AIHand(),84220251)
  or HeraldicCount(AIHand())>2 and HasID(AIHand(),87255382)
end
function SummonAmphisbaena()
  return FieldCheck(4)==1 or FieldCheck(4)==0 and HasID(AIHand(),82293134)
  or HeraldicCount(AIGrave())>0 and HasID(AIHand(),84220251)
end
function UseAmphisbaena(card)
  if bit32.band(card.location,LOCATION_HAND)>0 then
    return NormalSummonCheck(player_ai) and FieldCheck(4)==1 
    and (not HasID(AIHand(),82293134) or OPTCheck(82293134))
    or HeraldicCanXYZ() and FieldCheck(4)==0 
    and (HasID(AIHand(),82293134) and OPTCheck(82293134) 
    or HeraldicCount(AIHand())>0)
    and not HasID(AIHand(),94656263,true)
    and not(HeraldicCount(AIGrave())>0 and HasID(AIHand(),84220251))
  else
    return false
  end
end
function UseAberconway()
  return #AIHand() <= 4 or HeraldicCount(AIHand())<=2
end
function UseHeraldryReborn()
  return FieldCheck(4)==1 and (HeraldicCount(AIHand())==0 
  or NormalSummonCheck(player_ai))
end
function C101Filter(c)
	return bit32.band(c.summon_type,SUMMON_TYPE_SPECIAL)>0 
  and bit32.band(c.type,TYPE_TOKEN)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
end
function UseC101()
  return CardsMatchingFilter(OppMon(),C101Filter)>0
end
function SummonC101()
  return HasID(AIExtra(),12744567,true) and UseC101() 
  and (HasID(AIGrave(),48739166) or CardsMatchingFilter(AIMon(),UsedSHarkFilter)>0)
end
function UsedSHarkFilter(c)
  return c.id == 48739166 and c.xyz_material_count < 2
end
function UseRUM()
  return HasID(AIMon(),23649496,true) 
  or HasID(AIMon(),48739166,true) and SummonC101()
end
function UseTwinEagle()
  local cards=AIMon()
  for i=1,#cards do
    if cards[i].id==48739166 and cards[i].xyz_material_count==0 
    and SummonSharkKnight() and NotNegated(cards[i]) then
      return true
    end
    if cards[i].id==23649496 and cards[i].xyz_material_count==0 
    and (UsePlainCoat() and NotNegated(cards[i])
    or HasID(AIHand(),92365601) and HasID(AIGrave(),82293134)) then
      return true
    end
    if cards[i].id==34086406 and cards[i].xyz_material_count==0 and NotNegated(cards[i])
    and OPTCheck(82293134) then
      return true
    end
    if cards[i].id==94380860 and SummonRagnaZero(FindID(94380860,cards)) and NotNegated(cards[i])
    and cards[i].xyz_material_count==0 then
      return true
    end
    if (cards[i].id==55888045 or cards[i].id==12744567 
    or cards[i].original_id==47387961) and NotNegated(cards[i])
    and cards[i].xyz_material_count==0 
    then
      return true
    end
  end
  return false
end
function GenomHeritageFilter(c)
  return bit32.band(c.type,TYPE_XYZ)>0 and c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  and (c.original_id~=47387961 or c.attack>0)
  and bit32.band(c.position,POS_FACEUP_ATTACK)>0
end
function UseGenomHeritage() 
  return CardsMatchingFilter(OppMon(),GenomHeritageFilter)>0
end
function UseAHA()
  return OverExtendCheck() and FieldCheck(4)<2
end
function HeraldicOnSelectInit(cards, to_bp_allowed, to_ep_allowed)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  local SetableST = cards.st_setable_cards
  local HasBackrow = HasBackrow(SetableST)
  if HasID(Activatable,81439173) and not DeckCheck(DECK_BA) then   -- Foolish Burial
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,32807846) and UseRotA() then   -- Reinforcement of the Army
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  
  if HasIDNotNegated(Activatable,12744567) then  -- SHDark Knight
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  if HasIDNotNegated(Activatable,47387961) and UseGenomHeritage() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,23649496) and UsePlainCoat() then
    GlobalPlainCoat = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(SpSummonable,65367484) and not DeckCheck(DECK_CONSTELLAR) then -- Photon Thrasher
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,60316373) and UseAberconway() then   -- Aberconway
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,IndexByID(Activatable,60316373)}
  end  
  if HasID(Activatable,87255382) and UseAmphisbaena(Activatable[CurrentIndex]) then   -- Amphisbaena
    return {COMMAND_ACTIVATE,IndexByID(Activatable,87255382)}
  end
  if HasID(Activatable,45705025) then  -- Unicorn
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,19310321) and UseTwinEagle() then  -- Twin Eagle
    return {COMMAND_ACTIVATE,IndexByID(Activatable,19310321)}
  end
  if HasID(Activatable,92365601) and UseRUM() then   -- Rank-Up Magic - Limited Barian's Force
    GlobalCardMode = 1
    return {COMMAND_ACTIVATE,IndexByID(Activatable,92365601)}
  end
  if HasID(Activatable,84220251) and UseHeraldryReborn() then 
    return {COMMAND_ACTIVATE,IndexByID(Activatable,84220251)}
  end
  
  if HasID(SpSummonable,34086406) and SummonChainHeraldic() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,47387961) and SummonGenomHeritage() then
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,23649496) and SummonPlainCoat() then
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,23649496)}
  end

  
  if HasID(Summonable,82293134) and SummonLeo() then   -- Leo
    return {COMMAND_SUMMON,IndexByID(Summonable,82293134)}
  end
  if HasID(Summonable,60316373) and HeraldicCanXYZ() then   -- Aberconway
    return {COMMAND_SUMMON,IndexByID(Summonable,60316373)}
  end
  if HasID(Summonable,45705025) and HeraldicCanXYZ() then   -- Unicorn
    return {COMMAND_SUMMON,IndexByID(Summonable,45705025)}
  end
  if HasID(Summonable,19310321) and HeraldicCanXYZ() then   -- Twin Eagle
    return {COMMAND_SUMMON,IndexByID(Summonable,19310321)}
  end
  if HasID(Summonable,82315772) and HeraldicCanXYZ() then   -- Eale
    return {COMMAND_SUMMON,IndexByID(Summonable,82315772)}
  end
  if HasID(Summonable,56921677) and HeraldicCanXYZ() then   -- Basilisk
    return {COMMAND_SUMMON,IndexByID(Summonable,56921677)}
  end
  if HasID(Summonable,87255382) and SummonAmphisbaena() then   -- Amphisbaena
    return {COMMAND_SUMMON,IndexByID(Summonable,87255382)}
  end
  if HasID(Summonable,56921677) and HasBackrow then   -- Basilisk
    return {COMMAND_SUMMON,IndexByID(Summonable,56921677)}
  end
  if HasID(Summonable,60316373) and HasBackrow then   -- Aberconway
    return {COMMAND_SUMMON,IndexByID(Summonable,60316373)}
  end
  if HasID(Summonable,45705025) and HasBackrow then   -- Unicorn
    return {COMMAND_SUMMON,IndexByID(Summonable,45705025)}
  end
  if HasID(Summonable,19310321) and HasBackrow then   -- Twin Eagle
    return {COMMAND_SUMMON,IndexByID(Summonable,19310321)}
  end
  if HasID(Summonable,82315772) and HasBackrow then   -- Eale
    return {COMMAND_SUMMON,IndexByID(Summonable,82315772)}
  end
  if HasID(Summonable,60316373) then   -- Aberconway
    return {COMMAND_SUMMON,IndexByID(Summonable,60316373)}
  end
  if HasID(Activatable,61314842) and UseAHA() then 
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,IndexByID(Activatable,61314842)}
  end
  if HasID(SetableMon,82293134) then   -- Leo
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,56921677) then   -- Basilisk
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,45705025) then   -- Unicorn
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  return nil
end
GlobalLeoCheck = 0
GlobalUnicornCheck = 0
function HeraldicToGravePriority(card)
  local id=card.id
  if id==90411554 then
    return 4
  end
  if id==05556499 then
    return 3
  end
  if id==82293134 then
    if OPTCheck(82293134) and Duel.GetTurnCount()~=GlobalLeoCheck and card.location ~= LOCATION_REMOVED then
      GlobalLeoCheck=Duel.GetTurnCount()
      return 10
    elseif card.location == LOCATION_REMOVED then
      return 2
    else
      return 0
    end
  end
  if id==45705025 then
    if HasID(AIGrave(),id) or Duel.GetTurnCount()==GlobalUnicornCheck then
      return 4
    else
      GlobalUnicornCheck=Duel.GetTurnCount()
      return 7
    end
  end
  if id==19310321 then
    if HasID(AIGrave(),id) then
      return 3
    else
      return 6
    end
  end
  if id==60316373 then return 5 end
  if card.attribute==ATTRIBUTE_EARTH then 
    return 2 
  end
  return GetPriority(card,PRIO_TOGRAVE)
end
function HeraldicAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_GRAVE then
    func = HeraldicToGravePriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end
function HeraldicToGrave(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  HeraldicAssignPriority(cards,LOCATION_GRAVE)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end
function HeraldicToFieldPriority(card)
  local id=card.id
  if id==82293134 then
    return 4
  end
  if id==87255382 then
    return 3
  end
  if id==60316373 then
    return 2
  end
  if id==56921677 then
    return 2
  end
  if id==45705025 then
    return 0
  end
  if id==19310321 then
    return 0
  end
  return 1
end
function HeraldicToField(cards,amount)
  result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  table.sort(cards,function(a,b) return HeraldicToFieldPriority(a)>HeraldicToFieldPriority(b) end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end
function HeraldicToHand(cards)
  local AICards=UseLists({AIMon(),AIHand()})
  local AICardsGrave=UseLists({AICards,AIGrave()})
  if NeedsCard(82293134,cards,AICardsGrave) 
  or NeedsCard(82293134,cards,AIHand()) and HasID(AIHand(),87255382) then -- Leo
    return IndexByID(cards,82293134)
  end
  if NeedsCard(87255382,cards,AICards)          -- Amphisbaena
  and (HeraldicCount(AIHand())>1 or HasID(AIHand(),82293134) )
  then 
    return IndexByID(cards,87255382)
  end
  if NeedsCard(45705025,cards,AICardsGrave) then -- Unicorn
    return CurrentIndex
  end

  if NeedsCard(82293134,cards,AICards) then -- Leo
    return CurrentIndex
  end
  if NeedsCard(60316373,cards,AICards) then -- Aberconway
    return CurrentIndex
  end
  if NeedsCard(87255382,cards,AICards) then -- Amphisbaena
    return CurrentIndex
  end
  if NeedsCard(56921677,cards,AICards) then -- Basilisk
    return CurrentIndex
  end
  if NeedsCard(82315772,cards,AICards) then -- Eale
    return CurrentIndex
  end
  if HasID(cards,60316373) then --Aberconway
    return CurrentIndex
  end
  if NeedsCard(19310321,cards,AICardsGrave) then -- Twin Eagle
    return CurrentIndex
  end  
  if HasID(cards,82293134) then --Leo
    return CurrentIndex
  end
  return math.random(#cards)
end
function LavalvalChainTarget(cards)
    local result = nil
    if DeckCheck(DECK_HERALDIC) 
    or DeckCheck(DECK_GADGET)
    then
      result = HeraldicToGrave(cards,1)
    else
      if GlobalCardMode == 2 then
        GlobalCardMode = 1
        result = Add(cards,PRIO_TOGRAVE)
      elseif GlobalCardMode == 1 then
        GlobalCardMode = nil
        result = Add(cards,PRIO_TOHAND)
      else
        result = Add(cards,PRIO_TOGRAVE)
      end
    end
    if result then return result end
    return {math.random(#cards)}
end
function ImpKingTarget(cards)
  if LocCheck(cards,LOCATION_OVERLAY) then
    return Add(cards,PRIO_TOGRAVE)
  end
  return Add(cards)
end
function PlainCoatTarget(cards,min)
    local result = nil
    if GlobalPlainCoat == 2 then 
      GlobalPlainCoat = nil
      result = HeraldicToGrave(cards,2)
    elseif GlobalPlainCoat == 1 then
      GlobalPlainCoat = nil
      result = HeraldicToGrave(cards,1)
    else
      for i=1,#cards do
        if cards[i].owner == 1 and HasID(OppMon(),cards[i].id)
        or cards[i].owner == 2 and not HasID(AIMon(),cards[i].id)
        then
          result = {i}
        end
      end
    end
    if result then return result end
    return HeraldicToGrave(cards,min)
end
function AberconwayTarget(cards)
  local result=nil
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
  else
    result={HeraldicToHand(cards)}
  end
  if result == nil then result={math.random(#cards)} end
  return result
end
function SafeZoneTarget(cards)
  result = {}
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    result=Index_By_Loc(cards,2,"Highest",TYPE_MONSTER,nil,"==",LOCATION_MZONE)
  else
    result=GlobalTargetGet(cards,true)
  end  
  if result == nil then result={math.random(#cards)} end
  return result
end
function LanceTarget(cards)
  result = {}
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    result=Index_By_Loc(cards,2,"Highest",TYPE_MONSTER,nil,"==",LOCATION_MZONE)
  else
    result=GlobalTargetGet(cards,true)
  end  
  if result == nil then result={math.random(#cards)} end
  return result
end
function RUMTarget(cards)
  local result = nil
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    if HasID(cards,48739166) and UseC101() then
      GlobalRUMTarget = 48739166
      result = CurrentIndex
    end
    if HasID(cards,23649496) then
      GlobalRUMTarget = 23649496
      result = CurrentIndex
    end
  else
    if SummonC101() then
      result = IndexByID(cards,12744567)
    else
      if OppGetStrongestAttDef()>2600 or #OppMon()==0 and Duel.GetTurnCount()>1 then
        result = IndexByID(cards,11522979)
      else
        result = IndexByID(cards,55888045)
      end
    end
    GlobalRUMTarget = nil
  end
  if result == nil then result = math.random(#cards) end
  return {result}
end
function ChidoriCheck(cards)
  result=0
  for i=1,#cards do
    if bit32.band(cards[i].attribute,ATTRIBUTE_WIND)>0 then
      result = result + 1
    end
  end
  return result>=2
end
function SummonChidoriHeraldic()
  if not DeckCheck(DECK_HERALDIC) then return false end
  local cards = UseLists({OppMon(),OppST()})
  local result={0,0}
  for i=1,#cards do
    if bit32.band(cards[i].position,POS_FACEUP)>0 
    and cards[i]:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
    then 
      result[1]=1 
    end
    if bit32.band(cards[i].position,POS_FACEDOWN)>0 
    and cards[i]:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0 
    then 
      result[2]=1
    end
  end
  return result[1]+result[2]>=2 
  or OppGetStrongestAttDef() >= 2300 and MP2Check()
end
function AHATarget(cards)
  local result = nil
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    result = HeraldicToField(cards,1)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    result = HeraldicToField(cards,1)
  else
    if HasID(cards,23649496) and not HasID(AIMon(),23649496) then
      result=IndexByID(cards,23649496)
    end
    if HasID(cards,12014404) and SummonCowboyAtt() then
      result=IndexByID(cards,12014404)
    end
    if HasID(cards,34086406) and SummonChainHeraldic() then
      result=IndexByID(cards,34086406)
    end
    if HasID(cards,11398059) and SummonImpKing(cards[CurrentIndex]) then
      result=IndexByID(cards,11398059)
    end
    if HasID(cards,23649496) and SummonPlainCoat() then
      result=IndexByID(cards,23649496)
    end
    if HasID(cards,48739166) and SummonSharkKnight() then 
      result=IndexByID(cards,48739166)
    end
    if HasID(cards,22653490) and SummonChidoriHeraldic() then
      result=IndexByID(cards,22653490)
    end
    if HasID(cards,94380860,SummonRagnaZero) then
      result=IndexByID(cards,94380860)
    end
    if HasID(cards,61344030) and SummonPaladynamo() then
      result=IndexByID(cards,61344030)
    end 
    if HasID(cards,47387961) and SummonGenomHeritage() then
      result=IndexByID(cards,47387961)
    end
    if HasID(cards,46772449) and DeckCheck(DECK_HERALDIC) and SummonBelzebuth() then
      result=IndexByID(cards,46772449)
    end  
    if HasID(cards,12014404) and SummonCowboyDef() then
      result=IndexByID(cards,12014404)
    end
    result = {result}
  end
  if result == nil or #result==0 then result={math.random(#cards)} end
  return result
end
function TwinEagleTarget(cards,minTargets)
 local result=nil
 if minTargets==2 then
  return HeraldicToField(cards,2)
 else
   for i=1,#cards do
    if cards[i].id==48739166 and cards[i].xyz_material_count==0 then
      result=IndexByID(cards,48739166)
    end
    if cards[i].id==23649496 and cards[i].xyz_material_count==0 
    and (UsePlainCoat() and NotNegated(cards[i])
    or HasID(AIHand(),92365601) and HasID(AIGrave(),82293134)) then
      result=IndexByID(cards,23649496)
    end
    if cards[i].id==34086406 and cards[i].xyz_material_count==0
    and OPTCheck(82293134) then
      result=IndexByID(cards,34086406)
    end
    if cards[i].id==55888045 then
      result=IndexByID(cards,55888045)
    end
    if cards[i].id==12744567 then
      result=IndexByID(cards,12744567)
    end
    if cards[i].id==94380860 and SummonRagnaZero(FindID(94380860,cards)) then
      result=IndexByID(cards,94380860)
    end
    if result == nil then result = math.random(#cards) end
    return {result}
  end
 end
end
function UnicornTarget(cards)
  if HasID(cards,11522979) then
    return {CurrentIndex}
  end
  if HasID(cards,23649496) then
    return {CurrentIndex}
  end
  return {math.random(#cards)}
end
function ChidoriTargetHeraldic(cards)
  local result = nil
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    result = HeraldicToGrave(cards,1)
  elseif GlobalCardMode == 1 then
    GlobalCardMode = nil
    local attdef=-2
    local prev=-2
    for i=1,#cards do
      if bit32.band(cards[i].type,TYPE_MONSTER) then
        if bit32.band(cards[i].type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION) then 
          attdef=math.max(attdef,cards[i].attack,cards[i].defense)
        else
          attdef=0
        end
      else
        attdef=-1
      end
      if attdef > prev then
        prev = attdef
        result = {i}
      end
    end 
  end
  if result == nil then result = {math.random(#cards)} end
  return result
end
function RagnaZeroTarget(cards)
  local result = nil
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    result = HeraldicToGrave(cards,1)
  else
    local attdef=-2
    local prev=-2
    for i=1,#cards do
      if cards[i]:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)>0 then
        attdef=-1
      else
        attdef=math.max(cards[i].attack,cards[i].defense)
      end
      if attdef > prev then
        prev = attdef
        result = {i}
      end
    end 
  end
  if result == nil then result = {math.random(#cards)} end
  return result
end
function PaladynamoTarget(cards,minTargets)
  if minTargets==2 then
    return {1,2}
  else
    local attdef=-2
    local prev=-2
    for i=1,#cards do
      attdef=math.max(cards[i].attack,cards[i].defense)
      if attdef > prev then
        prev = attdef
        result = {i}
      end
    end 
  end
  if result == nil then result = {math.random(#cards)} end
  return result
end
function FoolishTarget(cards)
  if DeckCheck(DECK_BUJIN) then
    return BujinAdd(cards,LOCATION_GRAVE)
  elseif DeckCheck(DECK_CHAOSDRAGON) or DeckCheck(DECK_BA) then
    return Add(cards,PRIO_TOGRAVE)
  else
    return HeraldicToGrave(cards,1)
  end
end
function GenomHeritageTarget(cards)
  return BestTargets(cards,1,false,function(c) return c.original_id ~= 47387961 or c.attack > 0 end)
end
function HeraldicOnSelectCard(cards, minTargets, maxTargets, triggeringID, triggeringCard)
  local result = {}
  if triggeringID == 47387961 then -- Genom Heritage
    return GenomHeritageTarget(cards)
  end
  if triggeringID == 34086406 then -- Lavalval Chain
    return LavalvalChainTarget(cards)
  end
  if triggeringID == 11398059 then -- King of the Feral Imps
    return ImpKingTarget(cards)
  end
  if triggeringID == 22653490 and DeckCheck(DECK_HERALDIC) then -- Chidori
    return ChidoriTargetHeraldic(cards)
  end
  if triggeringID == 94380860 then -- Ragna Zero
    return RagnaZeroTarget(cards)
  end 
  if triggeringID == 61344030 then -- Paladynamo
    return PaladynamoTarget(cards,minTargets)
  end
  if triggeringID == 23649496 then -- Plain Coat
    return PlainCoatTarget(cards,minTargets)
  end
  if triggeringID == 81439173 then -- Foolish Burial 
    return FoolishTarget(cards)
  end
  if triggeringID == 82293134 then -- Leo
    OPTSet(82293134)
    return {HeraldicToHand(cards)}
  end
  if triggeringID == 45705025 then -- Unicorn
    return UnicornTarget(cards)
  end
  if triggeringID == 19310321 then -- Twin Eagle
    return TwinEagleTarget(cards,minTargets)
  end
  if triggeringID == 60316373 then -- Aberconway
    return AberconwayTarget(cards)
  end
  if triggeringID == 87255382 then -- Amphisbaena
    return HeraldicToGrave(cards,1)
  end
  if triggeringID == 38296564 then -- Safe Zone
    return SafeZoneTarget(cards)
  end
  if triggeringID == 27243130 then -- Forbidden Lance
    return LanceTarget(cards)
  end
  if triggeringID == 84220251 then -- Heraldry Reborn
    return HeraldicToField(cards,1)
  end
  if triggeringID == 92365601 then -- Rank-Up Magic - Limited Barian's Force
    return RUMTarget(cards)
  end
  if triggeringID == 61314842 then -- Advanced Heraldry Art
    return AHATarget(cards)
  end
  if triggeringID == 55888045 then -- C106: Giant Hand Red
    GlobalC106=Duel.GetTurnCount()
    return HeraldicToGrave(cards,1)
  end
  return nil
end
GlobalC106=0
function ChainPlainCoat(c)
  if bit32.band(c.location,LOCATION_GRAVE)>0 then
    for i=1,Duel.GetCurrentChain() do
      effect = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      if effect and effect:GetHandler():GetCode()==82293134 then
        OPTSet(82293134)
      end
    end
    GlobalPlainCoat = 2
    return true
  else
    local result = true
    local effect
    for i=1,Duel.GetCurrentChain() do
      effect = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      if effect and effect:GetHandler():GetCode()==23649496 then
        result=false
      end
    end
    effect = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
    if effect and effect:IsHasCategory(CATEGORY_DISABLE+CATEGORY_NEGATE) then 
      result = true 
    end
    if result and UsePlainCoat() then
      GlobalPlainCoat = 1
      return true
    end
  end
end
function SafeZoneFilter(c)
  return CurrentOwner(c) == 1 and FilterType(c,TYPE_MONSTER)
  and c.id~=23649496 and c.id~=82293134
  and FilterPosition(c,POS_FACEUP_ATTACK) and DestroyFilter(c)
  and Affected(c,TYPE_TRAP) and Targetable(c,TYPE_TRAP)
end
function SafeZoneFilterEnemy(c)
  return CurrentOwner(c) == 2 and FilterType(c,TYPE_MONSTER)
  and FilterPosition(c,POS_FACEUP_ATTACK) and DestroyFilter(c)
  and Affected(c,TYPE_TRAP) and Targetable(c,TYPE_TRAP)
end

function ChainSafeZone(c)
  if RemovalCheckCard(c) and CardsMatchingFilter(OppMon(),SafeZoneFilterEnemy)>0 then
    GlobalCardMode=1
    return true
  end	
  if not UnchainableCheck(38296564) then
    return false
  end
  local targets=RemovalCheckList(AIMon(),CATEGORY_DESTROY,nil,nil,nil,SafeZoneFilter)
  if targets and #targets > 0 then
    BestTargets(targets,1,TARGET_PROTECT)
    GlobalTargetSet(targets[1],targets)
    return true
  end
  if Duel.GetCurrentPhase() == PHASE_BATTLE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if source:GetAttack() >= target:GetAttack() and target:IsControler(player_ai) 
      and source:IsPosition(POS_FACEUP_ATTACK) and target:IsPosition(POS_FACEUP_ATTACK) and not target:IsCode(23649496)
      and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) and not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
      then
        GlobalTargetSet(target,AIMon())
        return true
      end
    end
  end
  if MKBCheck(c) then
    GlobalTargetSet(MKBCheck(c),AIMon())
    return true
  end
  return false
end

function LanceFilter(card)
  return Targetable(card,TYPE_SPELL)
  and Affected(card,TYPE_SPELL)
  and FilterType(card,TYPE_MONSTER)
  and FilterPosition(card,POS_FACEUP_ATTACK)
  and FilterLocation(card,LOCATION_MZONE)
end
function ChainLance()
  local targets={}
  local aimon,oppmon=GetBattlingMons()
  for i=1,#AIMon() do
    local c = AIMon()[i]
    if RemovalCheckCard(c,nil,TYPE_SPELL+TYPE_TRAP,nil,nil,LanceFilter)
    and UnchainableCheck(27243130)
    then
      if not(aimon and oppmon 
      and CardsEqual(aimon,c) 
      and not AttackBoostCheck(-800)) 
      then
        targets[#targets+1]=c
      end
    end
  end
  if #targets>0 then
    SortByATK(targets)
    GlobalTargetSet(targets[1])
    return true
  end
  if Duel.GetCurrentPhase() == PHASE_DAMAGE and aimon and oppmon then
    local c = GetCardFromScript(aimon)
    ApplyATKBoosts({c})
    if (AttackBoostCheck(c.bonus,800)
    and not AttackBoostCheck(c.bonus))
    and LanceFilter(oppmon)
    and UnchainableCheck(27243130)
    then
      GlobalTargetSet(oppmon)
      return true
    end
  end
  return false
end

function ChainKage()
  local e=Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
  if e and e:GetHandler():IsCode(18063928) then
    return false
  end
  return FieldCheck(4)==1
end


function HeraldicOnSelectChain(cards,only_chains_by_player)
  if HasIDNotNegated(cards,23649496) and ChainPlainCoat(cards[CurrentIndex]) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,38296564,nil,nil,nil,nil,ChainSafeZone) then
    return {1,CurrentIndex}
  end
  if HasID(cards,27243130) and ChainLance() then
    return {1,CurrentIndex}
  end
  if HasID(cards,94656263) and ChainKage() then
    return {1,IndexByID(cards,94656263)}
  end
  if HasIDNotNegated(cards,94380860) then  -- Ragna Zero
    GlobalCardMode = 1
    return {1,CurrentIndex}
  end
  if HasID(cards,82293134) then
    OPTSet(82293134)
    return {1,CurrentIndex}
  end
  return nil
end

function HeraldicOnSelectOption(options)
  return nil
end
function HeraldicOnSelectEffectYesNo(id,triggeringCard)
  local result = nil
  if id == 23649496 and ChainPlainCoat(triggeringCard) then
    result = 1
  end
  if id == 11522979 or id == 12744567 then
    result = 1
  end
  if id == 82293134 then
    OPTSet(82293134)
    result = 1
  end
  return result
end
HeraldicAtt={
  65367484,60316373,87255382,61344030,
  47387961,11398059,34086406,22653490,
  11522979,55888045,12744567,94380860
}
HeraldicDef={
  19310321,45705025,82315772,56921677
}
function HeraldicOnSelectPosition(id, available)
  result = nil
  for i=1,#HeraldicAtt do
    if HeraldicAtt[i]==id then result=POS_FACEUP_ATTACK end
  end
  for i=1,#HeraldicDef do
    if HeraldicDef[i]==id then result=POS_FACEUP_DEFENCE end
  end
  if id==23649496 then
    if AI.GetCurrentPhase() == PHASE_MAIN2 or Duel.GetTurnCount() == 1 then
      result=POS_FACEUP_DEFENCE
    else
      result=POS_FACEUP_ATTACK
    end
  end
  return result
end
