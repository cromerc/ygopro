-- returns true, if the AI can XYZ summon with its current cards
function CanXYZ(rank)
  local cards=UseLists({AIHand(),AIST()})
  return CardsMatchingFilter(AIMon(),function(c,lvl)return c.level==lvl end,rank)>0
  or CardsMatchingFilter(AIHand(),function(c,lvl)return c.level==lvl end,rank)>=2 
  and HasID(cards,10719350,true) and not NormalSummonCheck(player_ai)
end

FF={}          
FF[57103969]=5  --Tenki       Priority for using Fire Formations as a cost.
FF[10719350]=1  --Tensu       Higher priority = gets used earlier
FF[19059929]=2  --Gyokko      Yoko + Tenki are always preferred
FF[36499284]=6  --Yoko        Tensu is only used if nothing else available
FF[44920699]=4  --Tensen
FF[70329348]=3  --Tenken
function FireFormationCostCheck(cards,count)
  --returns the highest priority available for the requested count
  local result=0
  local list={}
  for i=1,#cards do
    if FF[cards[i].id] and bit32.band(cards[i].position,POS_FACEUP)>0 then
      list[#list+1]=cards[i]
    end
  end
  if #list>=count then
    table.sort(list,function(a,b)return FF[a.id]>FF[b.id] end)
    result=FF[list[count].id]
  end
  return result
end
function FireFormationCost(cards,count)
  --returns the preferred cards to be used as a cost
  local list={}
  local result=nil
  for i=1,#cards do
    if FF[cards[i].id] and bit32.band(cards[i].position,POS_FACEUP)>0 then
      cards[i].index=i
      list[#list+1]=cards[i]
    end
  end
  if #list>=count then
    table.sort(list,function(a,b)return FF[a.id]>FF[b.id] end)
    result={}
    for i=1,count do
      result[i]=list[i].index
    end
  end
  return result
end
function UseBear()
  local cost=FireFormationCostCheck(AIST(),1)
  if DestroyCheck(OppMon())==0 then return false end
  return cost>1 and OppHasStrongestMonster() or cost>2 and OppHasFacedownMonster() or cost>4 and OppHasMonsterInMP2()
end 
function UseGorilla()
  local cards=OppST()
  return FireFormationCostCheck(AIST(),1)>1 and DestroyCheck(OppST())>0
end
function GorillaFilter(c)
  return 
end
function GyokkoFilter(card)
  return bit32.band(card.position,POS_FACEDOWN)>0 and card:is_affected_by(EFFECT_CANNOT_TRIGGER)==0
end
function UseGyokko()
  local cards=OppST()
  return CardsMatchingFilter(OppST(),GyokkoFilter)>0
end
function UseYoko()
  --placeholder
  return false
end
function SpiritFilter(card)
  return card.defense<=200 
  and bit32.band(card.attribute,ATTRIBUTE_FIRE) 
  and card.level==3 
  and not FilterType(card,TYPE_TUNER)
end
function SummonSpirit()
  return CardsMatchingFilter(AIGrave(),SpiritFilter)>0 --or CanXYZ(3)
end
function WolfbarkFilter(c)
  return FilterRace(c,RACE_BEASTWARRIOR)
  and FilterAttribute(c,ATTRIBUTE_FIRE)
  and c.level==4
end
function GetWolfbark()
  return CardsMatchingFilter(AIGrave(),WolfbarkFilter)>0 
  or HasID(UseLists({AIHand(),AIMon()}),06353603,true)
end
function SummonWolfbark()
  return CardsMatchingFilter(AIGrave(),WolfbarkFilter)>0 and OPTCheck(03534077)
end
function FireFormationSearch(cards)
  --returns the preferred Fire Formation to be searched
  local AICards=UseLists({AIHand(),AIMon(),AIST()})
  if SummonSpirit() and NeedsCard(01662004,AIDeck(),AIHand(),true) and HasID(cards,57103969) then
    return {CurrentIndex}
  end
  if SummonSpirit() and HasID(AIHand(),01662004,true) and NeedsCard(10719350,cards,AICards,true) then
    return {IndexByID(cards,10719350)}
  end
  if NeedsCard(57103969,cards,AICards) and OPTCheck(57103969) then
    return {CurrentIndex}
  end
  if NeedsCard(10719350,cards,AICards) and CardsMatchingFilter(AIHand(),function(c) return c.race==RACE_BEASTWARRIOR end)>0 then
    return {CurrentIndex}
  end
  if NeedsCard(19059929,cards,AICards) and UseGyokko() then
    return {CurrentIndex}
  end
  if NeedsCard(44920699,cards,AICards) then
    return {CurrentIndex}
  end
  if NeedsCard(70329348,cards,AICards) then
    return {CurrentIndex}
  end
  if HasID(cards,57103969) then
    return {CurrentIndex}
  end
  return {math.random(#cards)}
end
function FFDragonFilter(card,level)
  return card.level==level and (card.location==LOCATION_MZONE or IsSetCode(card.setcode,0x79) and card.id~=43748308)
end
function UseFFDragon()
  return FireFormationCostCheck(AIST(),2)>0 and (CardsMatchingFilter(AIGrave(),FFDragonFilter,4)>0
  or CardsMatchingFilter(AIMon(),FFDragonFilter,3)>0 and CardsMatchingFilter(AIGrave(),FFDragonFilter,3)>0)
end
function UseLeopard()
  if CardsMatchingFilter(AIMon(),function(c) return c.level==3 end)==2 then
    return false
  end
  return true
end
function UseChicken()
  return FireFormationCostCheck(AIST(),1)>2
end
function UseBuffalo()
  return FireFormationCostCheck(AIST(),2)>1 and CardsMatchingFilter(AIMon(),function(c) return c.level==4 end)>0
end
function SummonLeopard()
  local AICards=UseLists({AIHand(),AIMon(),AIST()})
  local result=0
  if HasID(AIMon(),01662004,true) then
    result=result+1
  end
  if HasID(AIHand(),01662004,true) and not NormalSummonCheck(player_ai) and not SummonSpirit() then
    result=result+1
  end
  if HasID(AICards,57103969,true) and HasID(AIDeck(),01662004,true) then
    result=result+1
  end
  if HasID(AICards,10719350,true) and HasID(AIDeck(),57103969,true) and HasID(AIDeck(),01662004,true) then
    result=result+1
  end
  if CanXYZ(3) then
    result=result+1
  end
  return result>0
end
function VulcanFilter(c)
  return (bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO+TYPE_FUSION+TYPE_RITUAL)>0 or c.level>4) and bit32.band(c.position,POS_FACEUP)>0
end
function SummonVulcanFF()
  return DeckCheck(DECK_FIREFIST) and HasID(AIST(),57103969,true)
  and CardsMatchingFilter(OppMon(),VulcanFilter)>0 and Chance(50)
end


function SummonCardinal(c)
  local cards=UseLists({OppMon(),OppST()})
  local result=0;
  for i=1,#cards do
    if bit32.band(cards[i].position,POS_FACEUP)>0 then 
      result = result + 1
    end
  end
  result = math.max(result,2)
  cards=AIGrave()
  for i=1,#cards do
    if cards[i].id == 57103969 then
      result=result+1
    end
    --[[if cards[i].setcode == 0x7c then
      result=result+1
    end]]
  end
  return result>=4 and MP2Check(c)
end
function UseTensu()
  return CardsMatchingFilter(AIHand(),function(c) return c.race==RACE_BEASTWARRIOR end)>0
  and NormalSummonCheck(player_ai)
  and CardsMatchingFilter(AIST(),function(c) return c.id==10719350 and bit32.band(c.position,POS_FACEUP)>0 end)==0
end


function TigerKingFilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsType(TYPE_TOKEN) 
  and (c:IsType(TYPE_XYZ+TYPE_SYNCHRO+TYPE_RITUAL+TYPE_FUSION) or c:GetAttack()>=2000)
end
function UseTigerKing()
  local cards = UseLists({AIMon(),OppMon()})
  local count = 0
  for i=1,#cards do
    if cards[i].race~=RACE_BEASTWARRIOR then
      if cards[i].owner==1 then
        count = count-1
      else
        count = count+1
      end
    end
  end
  return count>0
end
function RekindlingFilter(c)
  return bit32.band(c.attribute,ATTRIBUTE_FIRE)>0 and c.defense==200
end
function UseRekindling()
  return OverExtendCheck() and CardsMatchingFilter(AIGrave(),RekindlingFilter)
end
function FireFistInit(cards, to_bp_allowed, to_ep_allowed)
  local Activatable = cards.activatable_cards
  local Summonable = cards.summonable_cards
  local SpSummonable = cards.spsummonable_cards
  local Repositionable = cards.repositionable_cards
  local SetableMon = cards.monster_setable_cards
  if HasIDNotNegated(Activatable,58504745) then -- Cardinal
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,19059929) and UseGyokko() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,70355994) and UseGorilla() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,10719350) and UseTensu() then
    return {COMMAND_ACTIVATE,IndexByID(Activatable,10719350)}
  end
  if HasID(Activatable,57103969) then -- Tenki
    OPTSet(57103969)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,36499284) and UseYoko() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,06353603) and UseBear() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,39699564) and UseLeopard() then
    GlobalCardMode = 1
    OPTSet(39699564)
    return {COMMAND_ACTIVATE,IndexByID(Activatable,39699564)}
  end
  if HasIDNotNegated(Activatable,96381979) and UseTigerKing() then  
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,30929786) and UseChicken() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,03534077) then -- Wolfbark
    OPTSet(03534077)
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasIDNotNegated(Activatable,43748308) and UseFFDragon() then
    GlobalCardMode = 2
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Activatable,92572371) and UseBuffalo() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end
  if HasID(Summonable,39699564) and SummonLeopard() then
    return {COMMAND_SUMMON,IndexByID(Summonable,39699564)}
  end
  if HasID(Summonable,01662004) and SummonSpirit() then
    return {COMMAND_SUMMON,IndexByID(Summonable,01662004)}
  end
  if HasID(Summonable,03534077) and SummonWolfbark() then
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,43748308) and (UseFFDragon() or CanXYZ(4)) then              
    return {COMMAND_SUMMON,IndexByID(Summonable,43748308)}           --Dragon 
  end
  if HasID(Summonable,06353603) and (UseBear() or CanXYZ(4)) 
  and not DeckCheck(DECK_CONSTELLAR)
  then 
    return {COMMAND_SUMMON,IndexByID(Summonable,06353603)}           --Bear
  end
  if HasID(Summonable,70355994) and (UseGorilla() or CanXYZ(4)) then 
    return {COMMAND_SUMMON,IndexByID(Summonable,70355994)}           --Gorilla
  end 
  if HasID(Summonable,30929786) and (UseChicken() or CanXYZ(3)) then
    return {COMMAND_SUMMON,IndexByID(Summonable,30929786)}           --Chicken
  end
  if HasID(Summonable,44860890) and CanXYZ(3) then --Raven
    return {COMMAND_SUMMON,IndexByID(Summonable,44860890)}
  end
  if HasID(Summonable,93294869) and CanXYZ(3) then --Wolf
    return {COMMAND_SUMMON,IndexByID(Summonable,93294869)}
  end
  if HasID(Summonable,17475251) and CanXYZ(3) then --Hawk
    return {COMMAND_SUMMON,IndexByID(Summonable,17475251)}
  end
  if HasID(Summonable,66762372) and CanXYZ(4) then --Boar
    return {COMMAND_SUMMON,IndexByID(Summonable,66762372)}
  end
  if HasID(Summonable,92572371) and CanXYZ(4) then --Buffalo
    return {COMMAND_SUMMON,IndexByID(Summonable,92572371)}
  end
  if HasID(Summonable,39699564) and OPTCheck(39699564) then 
    return {COMMAND_SUMMON,CurrentIndex} --Leopard           
  end
  if HasID(Summonable,43748308) then --Dragon              
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,06353603) and not DeckCheck(DECK_CONSTELLAR) then --Bear
    return {COMMAND_SUMMON,CurrentIndex}           
  end
  if HasID(Summonable,70355994) then --Gorilla
    return {COMMAND_SUMMON,CurrentIndex}           
  end
  if HasID(Summonable,30929786) then --Chicken
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Summonable,92572371) then --Buffalo
    return {COMMAND_SUMMON,CurrentIndex}
  end
  if HasID(Activatable,74845897) and UseRekindling() then
    return {COMMAND_ACTIVATE,CurrentIndex}
  end

  if HasID(SpSummonable,98012938) and SummonVulcanFF() then
    GlobalCardMode = 1
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,98012938)}
  end
  if HasID(SpSummonable,74168099) then -- Horse Prince                
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,37057743,MP2Check) then -- Lion Emperor                
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,58504745,SummonCardinal) then -- Cardinal           
    return {COMMAND_SPECIAL_SUMMON,IndexByID(SpSummonable,58504745)}
  end

  if HasID(SpSummonable,89856523,MP2Check) and Chance(50) then -- Kirin            
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SpSummonable,96381979,MP2Check) and not DeckCheck(DECK_BUJIN) then -- Tiger King 
    return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
  if HasID(SetableMon,93294869) then --Wolf
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,17475251) then --Hawk
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,44860890) then --Raven
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,66762372) then --Boar
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  if HasID(SetableMon,92572371) then --Buffalo
    return {COMMAND_SET_MONSTER,CurrentIndex}
  end
  return nil
end
function TenkiTarget(cards)
  local result = nil
  local AICards=UseLists({AIHand(),AIMon()})
  if not (DeckCheck(DECK_BUJIN) or DeckCheck(DECK_FIREFIST)) then
    return Add(cards)
  end
  if NeedsCard(43748308,cards,AIcards) then
    result={CurrentIndex} --get Dragon 
  end
  if NeedsCard(06353603,cards,AIcards) then
    result={CurrentIndex} --get Bear 
  end
  if NeedsCard(39699564,cards,AICards) and HasID(AIHand(),01662004,true) and not SummonSpirit() then
    result={IndexByID(cards,39699564)} --get leopard when you need a spirit target
  end
  if HasID(cards,03534077) and GetWolfbark() then
    result={IndexByID(cards,03534077)}  --get wolfbark when available and he has targets in grave
  end                                   --or you have Bear already
  if NeedsCard(39699564,cards,AICards) and HasID(AIHand(),06353603,true) and not SummonSpirit() then
    result={IndexByID(cards,39699564)} --get leopard when you need a spirit target
  end
  if NeedsCard(01662004,cards,AICards) then
    result={CurrentIndex} --get spirit when available and not in hand/field yet
  end
  if result == nil then
    result = BujinAdd(cards)
  end
  if result == nil then result = {math.random(#cards)}end
  return result
end
function GyokkoTarget(cards)
  return RandomIndexFilter(cards,GyokkoFilter)
end
function BearTarget(cards)
  local result = nil
  if GlobalCardMode == nil then
    return FireFormationSearch(cards)
  end
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    result = FireFormationCost(cards,1)
    if result == nil then result = {math.random(#cards)} end
    return result
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    local attdef=-2
    local prev=-2
    for i=1,#cards do
      if cards[i].owner==2 then
        if cards[i]:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)>0 then
          attdef=-1
        else
          attdef=math.max(cards[i].attack,cards[i].defense)
        end
        if bit32.band(cards[i].position,POS_FACEDOWN)>0 then
          attdef=1600
        end
      end
      if attdef > prev then
        prev = attdef
        result = {i}
      end
    end 
   if result == nil then result = {math.random(#cards)} end
    return result
  end
end
function GorillaTarget(cards)
  if GlobalCardMode == nil then
    return FireFormationSearch(cards)
  end
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    result = FireFormationCost(cards,1)
    if result == nil then result = {math.random(#cards)} end
    return result
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    for i=1,#cards do
      cards[i].index=i
      if cards[i].owner==2 then
        if cards[i]:is_affected_by(EFFECT_CANNOT_TRIGGER)>0 then
          cards[i].prio=1
        elseif bit32.band(cards[i].position,POS_FACEUP)>0 then
          cards[i].prio=3
        else
          cards[i].prio=2
        end
      else
        cards[i].prio=0
      end
    end
    table.sort(cards,function(a,b) return a.prio>b.prio end)
    return {cards[1].index} 
  end
end
function LeopardTarget(cards)
  local result = nil
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    result={IndexByID(cards,39699564)}
  else
    result = FireFormationSearch(cards)
  end
  if result == nil then result={math.random(#cards)} end
  return result
end
function SpiritTarget(cards)
  local result = nil
  if HasID(cards,44860890) then
    result=CurrentIndex
  end
  if HasID(cards,30929786) then
    result=CurrentIndex
  end
  for i=1,#cards do
    local c = cards[i]
    if not FilterType(c,TYPE_TUNER) then
      result = i
    end
  end
  if result==nil then result=math.random(#cards) end
  return {result}
end
function WolfbarkTarget(cards)
  local result = nil
  for i=1,#cards do
    if cards[i].setcode==0x79 then
      result = i
    end
  end
  if result==nil then result=math.random(#cards) end
  return {result}
end
function HorsePrinceTarget(cards)
  local result = nil
  if HasID(cards,17475251) then
    result=CurrentIndex
  end
  if HasID(cards,30929786) and OPTCheck(30929786) then
    result=CurrentIndex
  end
  if result==nil then result=math.random(#cards) end
  return {result}
end
function TigerKingTarget(cards,minTargets)
  local result = nil
  if GlobalCardMode==1 and minTargets == 1 then
    GlobalCardMode=nil
    return FireFormationSearch(cards)
  end
  if GlobalCardMode==1 and minTargets == 3 then
    GlobalCardMode=nil
    result = FireFormationCost(cards,3)
    return result
  end
  if result == nil then result = {math.random(#cards)} end
  return result
end
function CardinalTarget(cards)
  local list={}
  if GlobalCardMode == 2 then
    GlobalCardMode = 1
    return {1,2}
  end
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    for i=1,#cards do
      cards[i].index=i
      list[#list+1]=cards[i]
    end
    local v=function(a) if a.id==57103969 then return 2 elseif a.id==10719350 then return 1 else return 0 end end
    table.sort(list,function (a,b) return v(a)>v(b) end) 
    return {list[1].index,list[2].index}
  end
  for i=1,#cards do
    cards[i].index=i
    list[#list+1]=cards[i]
  end
  local v=function(a)if a.location==LOCATION_MZONE then return a.attack elseif a.location==LOCATION_SZONE then return 1 else return 0 end end
  table.sort(list,function (a,b) return v(a)>v(b) end) 
  return {list[1].index,list[2].index}
end
function KirinTarget(cards)
  local result = FireFormationSearch(cards)
  if result==nil then result={math.random(#cards)} end
  return result
end
function LionEmperorTarget(cards)
  if HasID(cards,01662004) then
    return {CurrentIndex}
  elseif HasID(cards,03534077) then
    return {CurrentIndex}
  elseif HasID(cards,06353603) then
    return {CurrentIndex}
  end
  return {math.random(#cards)}
end
function ChickenTarget(cards)
  local result = nil
  if GlobalCardMode==2 then
    GlobalCardMode=1
    result = FireFormationCost(cards,1)
    if result == nil then result = {math.random(#cards)} end
    return result
  end
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    return FireFormationSearch(cards)
  end
  return TenkiTarget(cards)
end
function LeviairTarget(cards)
  if HasID(cards,01662004) then
    return {CurrentIndex}
  elseif HasID(cards,03534077) then
    return {CurrentIndex}
  elseif HasID(cards,06353603) then
    return {CurrentIndex}
  end
  return {math.random(#cards)}
end
function FFDragonTarget(cards)
  local result=nil
  if GlobalCardMode==2 then
    GlobalCardMode=1
    result = FireFormationCost(cards,2)
    if result == nil then result = {math.random(#cards)} end
    return result
  end
  if GlobalCardMode==1 then
    GlobalCardMode=nil
    local filter=function(c,lvl)return c.level==lvl end
    if CardsMatchingFilter(AIMon(),filter,3)>0 then
      result=RandomIndexFilter(cards,filter,3)
    else
      result=RandomIndexFilter(cards,filter,4)
    end
    return result
  end
  result=FireFormationSearch(cards)
  if result == nil then result = {math.random(#cards)} end
  return result
end

function SharkKnightTarget(cards,targets)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  table.sort(cards,function(a,b)return a.attack>b.attack end)
  for i=1,targets do
    result[#result+1]=cards[i].index
  end
  return result
end

function BoarTarget(cards)
  local result = nil
  if cards[1].setcode==0x7c then --Fire Formations
    result=FireFormationSearch(cards)
  end
  if result == nil then result = {math.random(#cards)} end
  return result
end
function BuffaloTarget(cards)
    local result = FireFormationCost(cards,2)
    if result == nil then result = {math.random(#cards)} end
    return result
end
function RekindlingTarget(cards,min,max)
  local result = {}
  for i=1,max do
    result[i]=i
  end
  return result
end
function FireFistCard(cards, minTargets, maxTargets, triggeringID, triggeringCard)
  if triggeringID == 74845897  then
    return RekindlingTarget(cards,minTargets,maxTargets)
  end
  if triggeringID == 57103969 then -- Tenki
    return TenkiTarget(cards)
  end
  if triggeringID == 19059929 then -- Gyokko
    return GyokkoTarget(cards)
  end
  if triggeringID == 66762372 then -- Boar
    return BoarTarget(cards)
  end
  if triggeringID == 92572371 then -- Buffalo
    return BuffaloTarget(cards)
  end
  if triggeringID == 43748308 then -- Dragon
    return FFDragonTarget(cards)
  end
  if triggeringID == 39699564 then -- Leopard
    return LeopardTarget(cards)
  end
  if triggeringID == 01662004 then -- Spirit
    return SpiritTarget(cards)
  end
  if triggeringID == 03534077 then -- Wolfbark
    return WolfbarkTarget(cards)
  end
  if triggeringID == 06353603 then -- Bear
    return BearTarget(cards)
  end
  if triggeringID == 70355994 then -- Gorilla
    return GorillaTarget(cards)
  end
  if triggeringID == 74168099 then -- Horse Prince
    return HorsePrinceTarget(cards)
  end 
  if triggeringID == 96381979 then -- Tiger King
    return TigerKingTarget(cards,minTargets)
  end 
  if triggeringID == 58504745 then -- Cardinal
    return CardinalTarget(cards)
  end 
  if triggeringID == 37057743 then -- Lion Emperor
    return LionEmperorTarget(cards)
  end 
  if triggeringID == 48739166 then -- SHark Knight
    return SharkKnightTarget(cards,minTargets)
  end 
  if triggeringID == 95992081 then -- Leviair
    return LeviairTarget(cards)
  end
  if triggeringID == 89856523 then -- Kirin
    return KirinTarget(cards)
  end 
  if triggeringID == 30929786 then -- Chicken
    return ChickenTarget(cards)
  end 
  if triggeringID == 17475251 or triggeringID == 44860890 
  or triggeringID == 93294869 then  -- Hawk, Raven, Wolf
    return FireFormationSearch(cards)
  end
  if triggeringID == 44920699 or triggeringID == 21350571 -- Tensen, Horn of Phantom Beast
  or triggeringID == 97268402 or triggeringID == 78474168 -- Effect Veiler, Breakthrough Skill
  or triggeringID == 70329348
  then 
    return GlobalTargetGet(cards,true)     
  end
  return nil
end
function ChainTensen()
	local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_DESTROY)
	if RemovalCheck(44920699) then
    return true
	end
  if Duel.GetCurrentPhase() == PHASE_DAMAGE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target then
      if source:IsControler(player_ai) then
        target = Duel.GetAttacker()
        source = Duel.GetAttackTarget()
      end
      if (source:GetAttack() >= target:GetAttack() and source:GetAttack() <= target:GetAttack()+1000 and source:IsPosition(POS_FACEUP_ATTACK)
      or source:GetDefense() >= target:GetAttack() and source:GetDefense() <= target:GetAttack()+1000 and source:IsPosition(POS_FACEUP_DEFENSE))
      and target:IsPosition(POS_FACEUP_ATTACK) and target:IsControler(player_ai) and target:IsRace(RACE_BEASTWARRIOR) 
      then
        GlobalTargetSet(target,AIMon())
        return true
      end
    end
    return false
  end
end
function ChainHornOfPhantomBeast()
  if Duel.GetCurrentPhase() == PHASE_DAMAGE then
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
    if source and target and source:GetAttack() >= target:GetAttack() and source:GetAttack() <= target:GetAttack()+800
    and target:IsControler(player_ai) and target:IsRace(RACE_BEAST+RACE_BEASTWARRIOR) and target:IsPosition(POS_FACEUP_ATTACK)
    then
      GlobalTargetSet(target,AIMon())
      return true
    end
    return false
  end
end
function TenkenFilter(card)
	return card:IsControler(player_ai) and card:IsType(TYPE_MONSTER) 
  and card:IsLocation(LOCATION_MZONE) and card:IsRace(RACE_BEASTWARRIOR) 
  and card:IsPosition(POS_FACEUP)
end
function ChainTenken()
	local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_DESTROY)
	if RemovalCheck(70329348) then
    return true
  end
  local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_DESTROY)
  local tg = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TARGET_CARDS)
  if ex then
    local g = nil
    if cg then
      g = cg:Filter(TenkenFilter, nil):GetMaxGroup(Card.GetAttack)
    end
    if g and cg:IsExists(TenkenFilter, 1, nil) and Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_PLAYER)~=player_ai then
      GlobalTargetSet(g:GetFirst(),AIMon())
      return true
    elseif tg then
      local g = tg:GetMaxGroup(Card.GetAttack)
      if g and tg:IsExists(TenkenFilter, 1, nil) and Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_PLAYER)~=player_ai then
        GlobalTargetSet(g:GetFirst(),AIMon()) 
        return true
      end
    end
    return 
  else 
    return false
  end
end
function ChainMaxxC()
  for i=1,Duel.GetCurrentChain() do
    if Duel.GetOperationInfo(i,CATEGORY_SPECIAL_SUMMON) 
    and  Duel.GetChainInfo(i,CHAININFO_TRIGGERING_PLAYER)~=player_ai 
    and CheckNegated(i)
    then
      return true
    end
  end
  return false
end
function NegateBPCheck(card)
  if Negated(card) then
    return false
  end
  if card.id==22110647 then --Dracossack
    return HasID(OppMon(),22110648,true) and not HasID(AIMon(),75840616,true)
  end
  if card.id==78156759 or card.id==25341652 or card.id==48739166 -- Zenmaines, Maestroke, SHArk Knight
  or card.id==10002346 -- Gachi
  then
    return card.xyz_material_count>0
  end
  if IsUndestroyableByBattle(card.id)>0 then
    return true
  end
  return false
end
function VeilerTarget(card)
  local value=nil
  local att=AIGetStrongestAttack()
  if bit32.band(card.position,POS_FACEUP_ATTACK)>0 then
    value=card.attack
  elseif bit32.band(card.position,POS_FACEUP_DEFENSE)>0 then
    value=card.defense
  end
  if value and att>value and NegateBPCheck(card) 
  and card:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  then
    return true
  end
  return false
end

function FireFistOnChain(cards,only_chains_by_player)
  if HasID(cards,70329348) and ChainTenken() then
    return {1,CurrentIndex}
  end
  if HasID(cards,44920699) and ChainTensen() then
    return {1,CurrentIndex}
  end
  if HasID(cards,21350571) and ChainHornOfPhantomBeast() then
    return {1,CurrentIndex}
  end
  if HasID(cards,23434538) and ChainMaxxC() then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,46772449,UseFieldNuke,1) then
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,01662004) then
    OPTSet(01662004)
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,30929786) then
    OPTSet(30929786)
    return {1,CurrentIndex}
  end
  return nil
end
function FireFistOnSelectEffectYesNo(id,triggeringCard)
  local result=nil   
  if id == 96381979 then
    if bit32.band(triggeringCard.location,LOCATION_ONFIELD)>0 then --Tiger King
      GlobalCardMode=1
      result = 1
    elseif bit32.band(triggeringCard.location,LOCATION_GRAVE )>0
    and FireFormationCostCheck(AIST(),3)>0 then
      GlobalCardMode=1
      result = 1
    end
  end
  if id == 06353603 or id == 70355994 
  or id == 43748308 or id == 66762372 or id == 17475251
  or id == 44860890 or id == 93294869 or id == 89856523
  or id == 74168099 
  then
    result = 1
  end
  if id == 30929786 or id == 01662004 
  and NotNegated(triggeringCard) then
    OPTSet(triggeringCard.id)
    result = 1
  end
  return result
end
FFAtt={
66762372,  -- Boar
92572371,  -- Buffalo
43748308,  -- Dragon
01662004,  -- Spirit
06353603,  -- Bear
70355994,  -- Gorilla
74168099,  -- Horse Prince
96381979,  -- Tiger King
37057743,  -- Lion Emperor
58504745,  -- Cardinal
30929786,  -- Chicken
98012938,  -- Vulcan
03534077,  -- Wolfbark
48739166,  -- SHark Knight
46772449,  -- Noblswarm Belzebuth
}
FFDef={
44860890,  -- Raven
17475251,  -- Hawk
39699564,  -- Leopard
93294869,  -- Wolf
--89856523,  -- Kirin
}
function FFGetPos(id)
  result = nil
  for i=1,#FFAtt do
    if FFAtt[i]==id then return POS_FACEUP_ATTACK end
  end
  for i=1,#FFDef do
    if FFDef[i]==id then return POS_FACEUP_DEFENSE end
  end
  if id == 12014404 then -- Cowboy
    if AI.GetPlayerLP(2)<=800 or not BattlePhaseCheck() then
      return POS_FACEUP_DEFENSE
    else
      return POS_FACEUP_ATTACK
    end
  end
  if id == 89856523 and AI.GetCurrentPhase() == PHASE_MAIN2 then -- Kirin
    return POS_FACEUP_DEFENSE
  end
  return result
end
function FireFistOnSelectPosition(id, available)
  return FFGetPos(id)
end
