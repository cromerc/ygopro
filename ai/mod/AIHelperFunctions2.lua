player_ai = nil
GlobalTargetID = nil
playersetupcomplete = false
function OnAIGoingFirstSecond(name)
  local result = 1
  player_ai = 0
  if name=="AI_Harpie"
  or name=="AI_Blackwing"
  or name=="AI_Shaddoll"
  --or name=="AI_Kozmo"
  or name=="AI_Lightsworn"
  or name=="AI_GladiatorBeast"
  or name=="AI_Fluffal"
  then
    player_ai = 1
    result = 0
  end
  if GlobalCheating then
    EnableCheats()
  end
  Globals()
  return result
end
function OnPlayerGoingFirstSecond(decision)
  if decision == 1 then
    player_ai = 1
  else
    player_ai = 0
  end
  if GlobalCheating then
    EnableCheats()
  end
  Globals()
  return
end
function Startup()
  DeckCheck()
  if PRINT_DRAW and PRINT_DRAW == 1 then
    -- display draws in debug console
    local e4=Effect.GlobalEffect()
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_DRAW)
    e4:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
      if eg and eg:GetCount()>0 then
        eg:ForEach(function(c)
          if c:GetOwner()==player_ai then
            print("AI draws: "..GetName(c))
          end
        end)
      end
    end)
    Duel.RegisterEffect(e4,player_ai)
  end
end
-- Sets up some variables for using card script functions
function set_player_turn(init)
	if not playersetupcomplete
  then
    playersetupcomplete = true
    GlobalPreviousLP=AI.GetPlayerLP(1)
	end
end
-- sets up cheats for the cheating AI
function EnableCheats()
  local e1=Effect.GlobalEffect()
  e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
  e1:SetCode(EVENT_PHASE+PHASE_DRAW)
  e1:SetCountLimit(1)
  e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==player_ai
  end)
  e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp) 
    --AI.Chat("Oh yeah, cheating feels good.")
    Duel.Draw(player_ai,EXTRA_DRAW,REASON_RULE) 
    Duel.Recover(player_ai,LP_RECOVER,REASON_RULE) 
  end)
  Duel.RegisterEffect(e1,player_ai)
  local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(1+EXTRA_SUMMON)
	Duel.RegisterEffect(e2,player_ai)
end
-- get the AI script owner from card script controler
function get_owner_by_controler(controler)
	if controler == player_ai then
		return 1
	else
		return 2
	end
end
-- chance from 0 to 100
function Chance(chance)
  return math.random(100)<=chance
end
-- returns true, if it finds the passed id in a list of cards + optional parameters)
function HasID(cards,id,skipglobal,desc,loc,pos,filter,opt)
  if type(skipglobal) == "function" then
    filter = skipglobal
    opt = desc
    skipglobal = nil
    desc = nil
  end
  if type(desc) == "function" then
    filter = desc
    opt = loc
    desc = nil
    loc = nil
  end
  if type(loc) == "function" then
    filter = loc
    opt = pos
    loc = nil
    pos = nil
  end  
  if type(pos) == "function" then
    opt = filter
    filter = pos
    pos = nil
  end
  local result = false;
  if cards then 
    for i=1,#cards do
      local c = cards[i]
      if (c.id == id 
      or c.id == 76812113 and c.original_id == id 
      or c.id == 70902743 and c.original_id == id )
      and (desc == nil or c.description == desc) 
      and (loc == nil or bit32.band(c.location,loc)>0)
      and (pos == nil or bit32.band(c.position,pos)>0)
      and FilterCheck(c,filter,opt)
      then
        if not skipglobal then CurrentIndex = i end
        result = i   
      end
    end
  end
  return result
end
-- same, but only returns true, if the card is not negated
function HasIDNotNegated(cards,id,skipglobal,desc,loc,pos,filter,opt)
  if type(skipglobal) == "function" then
    filter = skipglobal
    opt = desc
    skipglobal = nil
    desc = nil
  end
  if type(desc) == "function" then
    filter = desc
    opt = loc
    desc = nil
    loc = nil
  end
  if type(loc) == "function" then
    filter = loc
    opt = pos
    loc = nil
    pos = nil
  end  
  if type(pos) == "function" then
    opt = filter
    filter = pos
    pos = nil
  end
  local result = false
  if cards ~= nil then 
    for i=1,#cards do
      local c = cards[i]
      if (c.id == id 
      or c.id == 76812113 and c.original_id == id 
      or c.id == 70902743 and c.original_id == id )
      and (desc == nil or c.description == desc) 
      and (loc == nil or bit32.band(c.location,loc)>0)
      and (pos == nil or bit32.band(c.position,pos)>0)
      and FilterCheck(c,filter,opt)
      then
        if bit32.band(c.type,TYPE_MONSTER)>0 
        and NotNegated(c)
        then
          if not skipglobal then CurrentIndex = i end
          result = i  
        end
        if (FilterType(c,TYPE_SPELL) 
        and not FilterType(c,TYPE_QUICKPLAY)
        or FilterType(c,TYPE_SPELL) 
        and FilterType(c,TYPE_QUICKPLAY)
        and not FilterStatus(c,STATUS_SET_TURN)
        or FilterType(c,TYPE_TRAP)
        and not FilterStatus(c,STATUS_SET_TURN))      
        and NotNegated(c)
        then
          if not skipglobal then CurrentIndex = i end
          result = i 
        end
      end
    end
  end
  return result
end
--checks if the card is in cards and not in check
function NeedsCard(id,cards,check,skipglobal,filter,opt) 
  return not HasID(check,id,true) and HasID(cards,id,skipglobal,filter,opt)
end
-- returns true, if the AI has a card of this ID in hand, field, grave, or as an XYZ material
function HasAccess(id)
  for i=1,#AIMon() do
    local cards = AIMon()[i].xyz_materials
    if cards and #cards>0 then
      for j=1,#cards do
        if cards[j].id==id then return true end
      end
    end
  end
  return HasID(UseLists({AIHand(),AIField(),AIGrave()}),id,true) 
end
-- gets index of a card id in a card list
function IndexByID(cards,id)
  for i=1,#cards do
    if cards[i].id==id then return i end
  end
  return nil
end
function OppHasMonster()
  local cards=OppMon()
  return #cards>0
end

function AIGetStrongestAttack(skipbonus,filter,opt)
  local cards=AIMon()
  local result=0
  ApplyATKBoosts(cards)
  for i=1,#cards do
    local c=cards[i]
    if c
    and c:is_affected_by(EFFECT_CANNOT_ATTACK)==0 
    and c.attack>result 
    and FilterCheck(c,filter,opt)
    and not (FilterPosition(c,POS_DEFENSE) 
    and c.turnid==Duel.GetTurnCount())
    then
      result=c.attack
      if skipbonus then
        result = result-c.bonus
      end
    end
  end
  return result
end
function OppGetStrongestAttack(filter,opt)
  local cards=OppMon()
  local result=0
  ApplyATKBoosts(cards)
  for i=1,#cards do
    local c=cards[i]
    if c and c.attack>result 
    and FilterCheck(c,filter,opt)
    and FilterPosition(c,POS_FACEUP_ATTACK)
    then
      result=c.attack-c.bonus
    end
  end
  return result
end
function OppGetStrongestAttDef(filter,opt,loop)
  local cards=OppMon()
  local result=0
  if not loop then ApplyATKBoosts(cards) end
  for i=1,#cards do
    if cards[i] and (filter==nil or (opt==nil and filter(cards[i]) or filter(cards[i],opt))) then
      if bit32.band(cards[i].position,POS_ATTACK)>0 and cards[i].attack>result then
        result=cards[i].attack
        if cards[i].bonus then 
          result=result-cards[i].bonus
        end   
      elseif bit32.band(cards[i].position,POS_DEFENSE)>0 and cards[i].defense>result 
      and FilterPublic(cards[i])
      then
        result=cards[i].defense
      end
    end
  end
  return result
end
function OppGetWeakestAttDef()
  local cards=OppMon()
  local result=9999999
  ApplyATKBoosts(cards)
  if #cards==0 then return 0 end
  for i=1,#cards do
    if cards[i] and cards[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      if bit32.band(cards[i].position,POS_ATTACK)>0 and cards[i].attack<result then
        result=cards[i].attack-cards[i].bonus
      elseif bit32.band(cards[i].position,POS_DEFENSE)>0 and cards[i].defense<result 
      and FilterPublic(cards[i])
      then
        result=cards[i].defense
      end
    end
  end
  return result
end
function OppHasStrongestMonster(skipbonus)
  return #OppMon()>0 
  and ((AIGetStrongestAttack(skipbonus) <= OppGetStrongestAttDef()) 
  or HasID(AIMon(),68535320,true) and FireHandCheck() 
  or HasID(AIMon(),95929069,true) and IceHandCheck())
  and not HasIDNotNegated(AIMon(),65305468,true)
end
function OppHasFacedownMonster()
  local cards=OppMon()
  for i=1,#cards do
    if bit32.band(cards[i].position,POS_FACEDOWN) > 0 then
      return true
    end
  end
  return false
end
function OppHasMonsterInMP2()
  return AI.GetCurrentPhase() == PHASE_MAIN2 and OppHasMonster()
end
-- returns count of cards matching a filter in a card list
function CardsMatchingFilter(cards,filter,opt)
  if not cards then
    print("Warning: CardsMatchingFilter null cards")
    PrintCallingFunction()
    cards={}
  end
  local result = 0
  for i=1,#cards do
    if FilterCheck(cards[i],filter,opt) then
      result = result + 1
    end
  end
  return result
end
-- returns random index of a card matching a filter in a list
function RandomIndexFilter(cards,filter,opt)
  result={}
  for i=1,#cards do
    if opt and filter(cards[i],opt) or opt==nil and filter(cards[i]) then
      result[#result+1]=i
    end
  end
  if #result>0 then return {result[math.random(#result)]} end
  return {0}
end
-- check, if the AI can wait for an XYZ/Synchro summon until Main Phase 2
function MP2Check(atk)
  if atk and (type(atk)=="table" or type(atk)=="userdata") then
    if atk.GetCode then
      atk=atk:GetAttack()
    else
      atk=atk.attack
    end
  end
  return AI.GetCurrentPhase() == PHASE_MAIN2 or not(GlobalBPAllowed)
  or OppHasStrongestMonster() and not(CanUseHand())
  or atk and ExpectedDamage(2)<atk
end
-- check how many monsters of a specific level are on the field. optional filter
function FieldCheck(level,filter,opt)
  local result=0
  for i=1,#AIMon() do
    local c=AIMon()[i]
    if c.level==level and FilterPosition(c,POS_FACEUP) 
    and (filter == nil or (opt == nil and filter(c) or filter(c,opt)))
    then
      result = result + 1
    end
  end
  return result
end
function GraveCheck(level)
  local result=0
  local cards=AIGrave()
  for i=1,#cards do
    if cards[i].level==level then
      result = result + 1
    end
  end
  return result
end
function HandCheck(level)
  local result=0
  local cards=AIHand()
  for i=1,#cards do
    if cards[i].level==level 
    then
      result = result + 1
    end
  end
  return result
end
function ExtraDeckCheck(type,level)
  local cards=AIExtra()
  local result = 0
  for i=1,#cards do
    if bit32.band(cards[i].type,type)>0 
    and (cards[i].level==level or cards[i].rank==level) then
      result = result + 1
    end
  end
  return result
end
-- returns the cards in the list that match the filter
function SubGroup(cards,filter,opt)
  local result = {}
  if cards then
    if filter == nil then return cards end
    for i=1,#cards do
      if opt and filter(cards[i],opt) or opt==nil and filter(cards[i]) then
        result[#result+1]=cards[i]
      end
    end
  end
  return result
end
-- returns true, if the AI controls any backrow, either traps or setable bluffs
function HasBackrow(Setable)
  local cards=AIST()
  if Setable == nil then
    Setable = SubGroup(AIHand(),FilterType,TYPE_SPELL+TYPE_TRAP)
  end
  for i=1,#Setable do
    if SetBlacklist(Setable[i].id)==0 
    and SpaceCheck(LOCATION_SZONE)>0
    then
      return true
    end
  end
  for i=1,#cards do
    if bit32.band(cards[i].position,POS_FACEDOWN)>0 then
      return true
    end
  end
  return false
end
-- check, if the AI is already controlling the field, 
-- so it doesn't overcommit as much
function OverExtendCheck(limit,handlimit)
  if limit == nil then limit = 2 end
  if handlimit == nil then handlimit = 4 end
  local cards = AIMon()
  local hand = AIHand()
  return OppHasStrongestMonster() 
  or #cards < limit 
  or #hand > handlimit 
  or AI.GetPlayerLP(2)<=800 and HasID(AIExtra(),12014404,true) -- Cowboy
end
-- checks, if a card the AI controls is about to be removed in the current chain
function RemovalCheck(id,category)
  if Duel.GetCurrentChain() == 0 then return false end
  local cat={CATEGORY_DESTROY,CATEGORY_REMOVE,CATEGORY_TOGRAVE,CATEGORY_TOHAND,CATEGORY_TODECK}
  if category then cat={category} end
  for i=1,#cat do
    for j=1,Duel.GetCurrentChain() do
      local ex,cg = Duel.GetOperationInfo(j,cat[i])
      if ex and CheckNegated(j) then
        if id==nil then 
          return cg
        end
        if cg and id~=nil and cg:IsExists(function(c) return c:IsControler(player_ai) and c:IsCode(id) end, 1, nil) then
          return true
        end
      end
    end
  end
  return false
end
-- these categorys don't exist, so I'm just making them up. 
-- Negative numbers to avoid conflicts with potential new official categorys
CATEGORY_CUSTOM_FACEDOWN  =-0x1 -- Book of Moon & friends
CATEGORY_CUSTOM_ATTACH    =-0x2 -- 101, CyDra Infinity
custom_facedown={
14087893, -- Book of Moon
25341652, -- Maestroke
67050396, -- Goodwitch
94997874, -- Tarotray
}
custom_attach={
10443957, -- Infinity
12744567, -- C101
48739166, -- 101
}
function RemovalCheckCard(target,category,cardtype,targeted,chainlink,filter,opt)
  if Duel.GetCurrentChain() == 0 then return false end
  local cat={CATEGORY_DESTROY,CATEGORY_REMOVE,
  CATEGORY_TOGRAVE,CATEGORY_TOHAND,
  CATEGORY_TODECK,CATEGORY_CONTROL,
  CATEGORY_CUSTOM_FACEDOWN,CATEGORY_CUSTOM_ATTACH}
  if category then 
    if type(category)=="table" then
      cat=category
    else
      cat={category}
    end
  end
  local a=1
  local b=Duel.GetCurrentChain()
  if chainlink and type(chainlink)=="number" then
    a=chainlink
    b=chainlink
  end
  for i=1,#cat do
    for j=a,b do
      local ex,cg = Duel.GetOperationInfo(j,cat[i])
      local e = Duel.GetChainInfo(j,CHAININFO_TRIGGERING_EFFECT)
      local tg = Duel.GetChainInfo(j,CHAININFO_TARGET_CARDS)
      if ex and CheckNegated(j) and (cardtype==nil
      or e and e:GetHandler():IsType(cardtype))
      then
        if targeted and not tg then 
          return false
        end
        if e and e:GetHandler()
        and (Negated(e:GetHandler())
        or not FilterCheck(e:GetHandler(),filter,opt))
        then
          return false
        end
        if target==nil then 
          return cg
        end
        if cg and target then
          local card=false
          cg:ForEach(function(c) 
            local c=GetCardFromScript(c)
            if CardsEqual(c,target) then
              card=c
            end  end) 
          return card
        end
      end
      if e and CheckNegated(j) and (cardtype==nil
      or e and e:GetHandler():IsType(cardtype))
      then
        local id = e:GetHandler():GetCode()
        for j=1,#custom_attach do
          if cat[i]==CATEGORY_CUSTOM_ATTACH
          and id == custom_attach[j]
          then
            if target and tg 
            and CardsEqual(target,tg:GetFirst()) 
            then
              return target
            end
            if not target then
              return tg
            end
          end
        end
        for j=1,#custom_facedown do
          if cat[i]==CATEGORY_CUSTOM_FACEDOWN
          and id == custom_facedown[j]
          and FilterPosition(target,POS_FACEUP)
          then
            if target and tg 
            and CardsEqual(target,tg:GetFirst()) 
            then
              return target
            end
            if not target then
              return tg
            end
          end
        end
      end
    end
  end
  return false
end
function RemovalCheckList(cards,category,type,targeted,chainlink,filter,opt)
  if Duel.GetCurrentChain() == 0 then return false end
  local result = {}
  for i=1,#cards do
    local c = RemovalCheckCard(cards[i],category,type,targeted,chainlink,filter,opt)
    if c then result[#result+1]=c end
  end
  if #result>0 then
    return result
  end
  return false
end
function NegateCheckCard(target,type,chainlink,filter,opt)
  if Duel.GetCurrentChain() == 0 then return false end
  local a=1
  local b=Duel.GetCurrentChain()
  if chainlink then
    a=chainlink
    b=chainlink
  end
  for i=a,b do
    local e = Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    local g = Duel.GetChainInfo(i,CHAININFO_TARGET_CARDS)
    if e and e:IsHasCategory(CATEGORY_DISABLE) 
    and CheckNegated(i) and (type==nil
    or e:GetHandler():IsType(type))
    then
      if e and e:GetHandler()
      and (Negated(e:GetHandler())
      or not FilterCheck(e:GetHandler(),filter,opt))
      then
        return false
      end
      if target==nil then 
        return g
      else
        local id = e:GetHandler():GetCode()
        if id == 82732705 -- Skill Drain
        then
          return Affected(target,TYPE_TRAP)
          and FilterPosition(target,POS_FACEUP)
        end
        if id == 86848580 -- Zerofyne
        then
          return Affected(target,TYPE_MONSTER,4)
          and FilterPosition(target,POS_FACEUP)
        end
      end
      if g and target then
        local card=false
        g:ForEach(function(c) 
          local c=GetCardFromScript(c)
          if CardsEqual(c,target) then
            card=c
          end 
        end) 
        return card
      end
    end
  end
  return false
end
function NegateCheckList(cards,type,chainlink,filter,opt)
  if Duel.GetCurrentChain() == 0 then return false end
  local result = {}
  for i=1,#cards do
    local c = NegateCheckCard(cards[i],type,chainlink,filter,opt)
    if c then result[#result+1]=c end
  end
  if #result>0 then
    return result
  end
end
-- checks, if a card the AI controls is about to be negated in the current chain
function NegateCheck(id)
  if Duel.GetCurrentChain() == 0 then return false end
  local ex,cg = Duel.GetOperationInfo(Duel.GetCurrentChain(),CATEGORY_DISABLE)
  if ex then 
    if id==nil then 
      return cg 
    end
    if cg and id~=nil 
    and cg:IsExists(function(c) return c:IsControler(player_ai) and c:IsCode(id) end, 1, nil)
    then
      return true
    end
  end
  return false
end

TARGET_OTHER    = 0
TARGET_DESTROY  = 1
TARGET_TOGRAVE  = 2
TARGET_BANISH   = 3
TARGET_TOHAND   = 4
TARGET_TODECK   = 5
TARGET_FACEDOWN = 6
TARGET_CONTROL  = 7
TARGET_BATTLE   = 8
TARGET_DISCARD  = 9
TARGET_PROTECT  = 10
-- returns a list of the best targets given the parameters
function BestTargets(cards,count,target,filter,opt,immuneCheck,source)
  local result = {}
  local AIMon=AIMon()
  local DestroyCheck = false
  if not target or target == true then 
    target=TARGET_DESTROY 
  end
  if target == TARGET_BATTLE then 
    return BestAttackTarget(cards,source,false,filter,opt) 
  end
  if count == nil then count = 1 end
  ApplyATKBoosts(AIMon)
  local AIAtt=Get_Card_Att_Def(AIMon,"attack",">",nil,"attack")
  for i=1,#cards do
    local c = cards[i]
    c.index = i
    c.prio = 0
    if FilterLocation(c,LOCATION_ONFIELD) then
      if FilterType(c,TYPE_MONSTER) then
        if FilterPublic(c)
        then
          c.prio = math.max(c.attack+1,c.defense)+5
          if c.owner==2 and c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)==0 
          and Duel.GetTurnPlayer()==player_ai
          and BattlePhaseCheck()
          then
            c.prio = math.max(1,c.prio-AIAtt*.9)
          end
        else
          c.prio = 2
        end
      else  
        if FilterPosition(c,POS_FACEUP)
        and not FilterType(c,TYPE_PENDULUM)
        then
          c.prio = 3
        else
          c.prio = 4
        end
      end
      if c.prio>0 then
        if PriorityTarget(c) then
          c.prio = c.prio+2
        end
        if c.level>4 then
          c.prio = c.prio+1
        end
        if FilterPosition(c,POS_FACEUP_ATTACK) then
          c.prio = c.prio+1
        end
      end
    end
    if FilterLocation(c,LOCATION_GRAVE)
    and (target==TARGET_BANISH or target==TARGET_TODECK)
    then
      c.prio=c.prio+GetGraveTargetPriority(c)
    end
    if IgnoreList(c) 
    or (target == TARGET_TOHAND 
    and FilterType(c,TYPE_SPELL+TYPE_TRAP) 
    and FilterPosition(c,POS_FACEUP)
    and FilterLocation(c,LOCATION_ONFIELD))
    then
      c.prio = 1
    end
    if FilterPublic(c)
    and (target == TARGET_TOHAND and ToHandBlacklist(c.id)
    or target == TARGET_DESTROY and DestroyBlacklist(c)
    or target == TARGET_FACEDOWN and bit32.band(c.type,TYPE_FLIP)>0)
    then
      c.prio = -1
    end
    if FilterType(c,TYPE_PENDULUM) and HasIDNotNegated(AIST(),05851097,true,nil,nil,POS_FACEUP) then
      c.prio = -1
    end
    if immuneCheck and source and not Affected(c,source.type,source.level) 
    and FilterLocation(c,LOCATION_ONFIELD)
    then
      c.prio = -1
    end
    if CurrentOwner(c) == 1 then 
      c.prio = -1 * c.prio
    end
    if not ShouldRemove(c) then
      c.prio = -1
    end
    if target == TARGET_PROTECT then 
      c.prio = -1 * c.prio
    end
    if filter and (opt == nil and not filter(c) or opt and not filter(c,opt)) then
      c.prio = c.prio-9999
    end
  end
  table.sort(cards,function(a,b) return a.prio > b.prio end)
  local temp={}
  local prio=cards[1].prio
  for i=1,#cards do
    --print("id: "..cards[i].id..", prio: "..cards[i].prio)
  end
  if count == 1 then
    for i=1,#cards do
      if cards[i].prio==prio then
        temp[#temp+1]=cards[i].index
      end
    end
    Shuffle(temp)
    result={temp[1]}
  else
    for i=1,count do
      result[i]=cards[i].index
    end
  end
  return result
end
function RandomTargets(cards,count,filter,opt)
  local count = count or 1
  local result={}
  for i=1,#cards do
    local c = cards[i]
    c.index = i
    if FilterCheck(c,filter,opt) then
      c.prio = math.random(1,100)
    else
      c.prio = 0
    end
  end
  table.sort(cards,function(a,b) return a.prio > b.prio end) 
  for i=1,count do
    result[i]=cards[i].index
  end
  return result
end
function GlobalTargetSet(c,cards)
  if cards == nil then
    cards = All()
  end
  if c == nil then
    print("Warning: null card for Global Target")
    PrintCallingFunction()
    return nil
  end
  if type(c) == "number" then
    GlobalTargetID = c
    return c
  end
  if c.GetCode then
    c = GetCardFromScript(c,cards)
  end
  GlobalTargetID = c.cardid
  return GlobalTargetID
end
function GlobalTargetGet(cards,index)
  if cards == nil then
    cards = All()
  end
  local cardid = GlobalTargetID
  --GlobalTargetID = nil --TODO: check if this is safe to not reset
  local c = nil
  if type(c) == "number" then
    c = FindID(cardid,cards,index)
  else
    c = FindCard(cardid,cards,index)
  end
  if c == nil then
    print("Warning: Null GlobalTargetGet")
    print(cardid)
    PrintCallingFunction()
  end
  return c
end
function GlobalTarget(cards,player,original)
  for i=1,#cards do
    if (not original and cards[i].id==GlobalTargetID
    or original and cards[i].original_id==GlobalTargetID)
    and (player==nil or cards[i].owner==player) then
      GlobalTargetID = nil
      return {i}
    end
  end
  return {math.random(#cards)}
end
function IsMonster(card)
  return bit32.band(card.type,TYPE_MONSTER)>0
end
-- fool-proof check, if a card belongs to a specific archetype
function IsSetCode(card_set_code, set_code)
  local band = bit32.band
  local rshift = bit32.rshift
  local settype = band(set_code,0xfff);
  local setsubtype = band(set_code,0xf000);
  local setcode = card_set_code
  while setcode and setcode > 0 do
      if (band(setcode,0xfff) == settype and band(band(setcode,0xf000),setsubtype) == setsubtype) then
          return true
      end
      setcode = rshift(setcode,16);
  end
  return false;
end
OPT={}
-- functions to keep track of OPT clauses
-- pass an id for hard OPT clauses, 
-- pass the unique cardid for a simple OPT 
function OPTCheck(id)
  if type(id)=="table" or type(id)=="userdata" then
    id = GetCardFromScript(id)
    id = id.cardid
  end
  return OPTCount(id)==0 
end
function OPTCount(id)
  if type(id)=="table" or type(id)=="userdata"  then
    id = GetCardFromScript(id)
    id = id.cardid
  end
  local result = OPT[id*100+Duel.GetTurnCount()]
  if result == nil then
    return 0
  end
  return result 
end
function OPTSet(id)
  if type(id)=="table" or type(id)=="userdata"  then
    id = GetCardFromScript(id)
    id = id.cardid
  end
  local i = id*100+Duel.GetTurnCount()
  if OPT[i] == nil then
    OPT[i] = 1
  else
    OPT[i]=OPT[i]+1
  end
  return
end
OPD={}
-- same for once per duel
function OPDSet(id)
  if type(id)=="table" then
    id = GetCardFromScript(id).id
  end
  OPD[id]=true
end
function OPDCheck(id)
  if type(id)=="table" then
    id = GetCardFromScript(id).id
  end
  return not OPT[id]
end

-- used to keep track, if the OPT was reset willingly
-- for example if the card was bounced back to the hand
function OPTReset(id)
  OPT[id*100+Duel.GetTurnCount()]=nil
end
-- used to keep track of how many cards with the same id got a priority request
-- so the AI does not discard multiple Marksmen to kill one card, for example
Multiple = nil
function SetMultiple(id)
  if Multiple == nil then
    Multiple = {}
  end
  Multiple[#Multiple+1]=id
end
function GetMultiple(id)
  local result = 0
  if Multiple then
    for i=1,#Multiple do
      if Multiple[i]==id then
        result = result + 1
      end
    end
  end
  return result
end
-- shuffles a list
function Shuffle(t)
  local n = #t
  while n >= 2 do
    local k = math.random(n)
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end
-- returns true, if the source is expected to win a battle against the target
--[[function WinsBattle(source,target)
  if not (source and target) then return false end
  source=GetScriptFromCard(source)
  target=GetScriptFromCard(target)
  return FilterLocation(source,LOCATION_MZONE)
  and FilterLocation(target,LOCATION_MZONE)
  and (target:IsPosition(POS_FACEUP_ATTACK) 
  and source:GetAttack() >= target:GetAttack()
  or target:IsPosition(POS_FACEUP_DEFENSE)
  and source:GetAttack() > target:GetDefense()) 
  and source:IsPosition(POS_FACEUP_ATTACK)
  and not target:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
  and not source:IsHasEffect(EFFECT_CANNOT_ATTACK)
end]]
function WinsBattle(source,target)
  if not (source and target) then return false end
  source=GetCardFromScript(source)
  target=GetCardFromScript(target)
  ApplyATKBoosts({source,target})
  return FilterLocation(source,LOCATION_MZONE)
  and FilterLocation(target,LOCATION_MZONE)
  and (FilterPosition(target,POS_FACEUP_ATTACK)
  and source.attack>=target.attack
  or FilterPosition(target,POS_FACEUP_DEFENSE)
  and source.attack>target.defense)
  and FilterPosition(source,POS_FACEUP_ATTACK)
  and not FilterAffected(target,EFFECT_INDESTRUCTABLE_BATTLE)
  and not FilterAffected(source,EFFECT_CANNOT_ATTACK)
end
function NotNegated(c,onfieldonly)
  onfieldonly = onfieldonly or false
  local disabled = false
  local id
  local type
  local player
  if c==nil then
    print("warning: NotNegated null card")
    PrintCallingFunction()
    return true
  end
  if c.GetCode then
    disabled = (c:IsHasEffect(EFFECT_DISABLE) or c:IsHasEffect(EFFECT_DISABLE_EFFECT))
    id = c:GetCode()
    if c:IsControler(player_ai) then
      player = 1
    else
      player = 2
    end
  else
    disabled = c:is_affected_by(EFFECT_DISABLE)>0 or c:is_affected_by(EFFECT_DISABLE_EFFECT)>0
    id = c.id
    player = CurrentMonOwner(c.cardid)
  end
  local check = nil 
  if not GlobalNegatedLoop then
    GlobalNegatedLoop = true
    check = NotNegated
  end
  if FilterType(c,TYPE_SPELL) and id~=61740673
  and (HasID(Field(),84636823,true,nil,nil,POS_FACEUP,check) -- Spell Canceller
  or HasID(Field(),61740673,true,nil,nil,POS_FACEUP,check)   -- Imperial Order
  or HasID(OppMon(),33198837,true,nil,nil,POS_FACEUP,check)  -- Naturia Beast
  or HasID(OppMon(),99916754,true,nil,nil,POS_FACEUP,check)) -- Naturia Exterio
  then
    return false
  end
  if FilterType(c,TYPE_TRAP) and id~=51452091
  and (HasID(Field(),77585513,true,nil,nil,POS_FACEUP,check) -- Jinzo
  or HasID(Field(),51452091,true,nil,nil,POS_FACEUP,check)  -- Royal Decree
  or HasID(OppMon(),02956282,true,nil,nil,POS_FACEUP,check) and #OppGrave()>1 -- Naturia Barkion
  or HasID(OppMon(),99916754,true,nil,nil,POS_FACEUP,check)) -- Naturia Exterio
  or GlobalTrapStun == Duel.GetTurnCount()
  then
    return false
  end
  if FilterType(c,TYPE_MONSTER) 
  then
    if Duel.GetTurnCount()==GlobalFeatherStorm then
      return false
    end
    if SkillDrainCheck() then
      return onfieldonly
    end
    if HasID(Field(),33746252,true,nil,nil,POS_FACEUP,check) then -- Majesty's Fiend
      return false
    end
    if HasID(Field(),56784842,true,nil,nil,POS_FACEUP,check) then -- Angel 07
      return false
    end
    if HasID(Field(),53341729,true,nil,nil,POS_FACEUP,check) then -- Light-Imprisoning Mirror
      return onfieldonly and not FilterAttribute(c,ATTRIBUTE_LIGHT) 
    end
    if HasID(Field(),99735427,true,nil,nil,POS_FACEUP,check) then -- Shadow-Imprisoning Mirror
      return onfieldonly and not FilterAttribute(c,ATTRIBUTE_DARK)
    end
    if (FilterLocation(c,LOCATION_EXTRA) or FilterPreviousLocation(c,LOCATION_EXTRA))
    and HasID(Field(),89463537,true,nil,nil,POS_FACEUP,check) -- Necroz Unicore
    then 
      return onfieldonly and false
    end
    if disabled and onfieldonly then
      if HasID(OppST(),50078509,true,CardTargetCheck,c) then -- Fiendish Chain
        return true
      end
      if HasID(OppST(),25542642,true,CardTargetCheck,c) then -- Fog Blade
        return true
      end
      if HasID(OppMon(),63746411,true,CardTargetCheck,c) then -- Giant Hand
        return true
      end
    end
    if GlobalCoinormaTurn == Duel.GetTurnCount()
    then
      return PredictionPrincessFilter(c)
    end
  end
  GlobalNegatedLoop=false
  return not disabled
end
function Negated(c)
  return not NotNegated(c)
end
function DestroyFilter(c,nontarget,skipblacklist,skipignore)
  return (not FilterAffected(c,EFFECT_INDESTRUCTABLE_EFFECT) or skipignore)
  and not FilterStatus(c,STATUS_LEAVE_CONFIRMED)
  and (nontarget==true or not FilterAffected(c,EFFECT_CANNOT_BE_EFFECT_TARGET))
  and (skipblacklist or not (DestroyBlacklist(c)
  and FilterPublic(c)))
  and (nontarget or not RemovalCheckCard(c))
  and ShouldRemove(c)
end
function DestroyFilterIgnore(c,nontarget,skipblacklist,skipignore)
  return DestroyFilter(c,skipblacklist)
  and not IgnoreList(c)
end
-- returns the amount of cards that can be safely destroyed in a list of cards
function DestroyCheck(cards,nontarget,skipignore,skipblacklist,filter,opt)
  return CardsMatchingFilter(cards,
  function(c) 
    return DestroyFilter(c,nontarget,skipblacklist,skipignore) 
    and (skipignore or not IgnoreList(c))
    and FilterCheck(c,filter,opt)
  end)
end
function FilterAttribute(c,att)
  if c.GetCode then
    return FilterType(c,TYPE_MONSTER) and c:IsAttribute(att)
  else
    return FilterType(c,TYPE_MONSTER) and bit32.band(c.attribute,att)>0
  end
end
function FilterRace(c,race)
  if c.GetCode then
    return FilterType(c,TYPE_MONSTER) and c:IsRace(race)
  else
    return FilterType(c,TYPE_MONSTER) and bit32.band(c.race,race)>0
  end
end
function FilterLevel(c,level)
  return FilterType(c,TYPE_MONSTER) 
  and not FilterType(c,TYPE_XYZ)
  and c.level==level
end
function FilterLevelMin(c,level)
  return FilterType(c,TYPE_MONSTER) 
  and not FilterType(c,TYPE_XYZ)
  and c.level>=level
end
function FilterLevelMax(c,level)
  return FilterType(c,TYPE_MONSTER) 
  and not FilterType(c,TYPE_XYZ)
  and c.level<=level
end
function FilterRank(c,rank)
  if c.GetCode then
    return FilterType(c,TYPE_XYZ) and c:GetRank()==rank
  else
    return FilterType(c,TYPE_XYZ) and c.rank==rank
  end
end
function FilterType(c,type) -- TODO: change all filters to support card script
  if c == nil then
    print("Warning: FilterLocation null card")
    PrintCallingFunction()
  end
  if c.GetCode then
    return c:IsType(type)
  else
    return bit32.band(c.type,type)>0
  end
end
function FilterNotType(c,type) -- TODO: change all filters to support card script
  if c.GetCode then
    return not c:IsType(type)
  else
    return bit32.band(c.type,type)==0
  end
end
function FilterAttack(c,attack)
  local atk = 0
  if c.GetCode then
    atk = c:GetAttack()
  else
    atk = c.attack
  end
  return FilterType(c,TYPE_MONSTER) and atk==attack
end
function FilterAttackMin(c,attack)
  local atk = 0
  if c.GetCode then
    atk = c:GetAttack()
  else
    atk = c.attack
  end
  return FilterType(c,TYPE_MONSTER) and atk>=attack
end
function FilterAttackMax(c,attack)
  local atk = 0
  if c.GetCode then
    atk = c:GetAttack()
  else
    atk = c.attack
  end
  return FilterType(c,TYPE_MONSTER) and atk<=attack
end
function FilterDefense(c,defense)
  local def = 0
  if c.GetCode then
    def = c:GetDefense()
  else
    def = c.defense
  end
  return FilterType(c,TYPE_MONSTER) and def==defense
end
function FilterDefenseMin(c,defense)
  local def = 0
  if c.GetCode then
    def = c:GetDefense()
  else
    def = c.defense
  end
  return FilterType(c,TYPE_MONSTER) and def>=defense
end
function FilterDefenseMax(c,defense)
  local def = 0
  if c.GetCode then
    def = c:GetDefense()
  else
    def = c.defense
  end
  return FilterType(c,TYPE_MONSTER) and def<=defense
end
function FilterID(c,id)
  c=GetCardFromScript(c)
  return c.id==id
end
function ExcludeID(c,id)
  c=GetCardFromScript(c)
  return c.id~=id
end
function FilterCard(c1,c2)
  return CardsEqual(c1,c2)
end
function ExcludeCard(c1,c2)
  return not CardsEqual(c1,c2)
end
function FilterOriginalID(c,id)
  c=GetCardFromScript(c)
  return c.original_id==id
end
function ExcludeOriginalID(c,id)
  c=GetCardFromScript(c)
  return c.original_id~=id
end
function FilterPosition(c,pos)
  if c == nil then
    print("Warning: FilterPosition null card")
    PrintCallingFunction()
  end
  if pos == nil then
    print("Warning: FilterPosition null pos")
    PrintCallingFunction()
  end
  if c.GetCode then
    return c:IsPosition(pos)
  else
    return bit32.band(c.position,pos)>0
  end
end
function FilterLocation(c,loc)
  if c == nil then
    print("Warning: FilterLocation null card")
    PrintCallingFunction()
  end
  if c.GetCode then
    return c:IsLocation(loc)
  else
    return bit32.band(c.location,loc)>0
  end
end
function FilterPreviousLocation(c,loc)
  c=GetCardFromScript(c)
  return bit32.band(c.previous_location,loc)>0
end
function FilterStatus(c,status)
  if status==nil then
    print("Warning: FilterStatus null status")
    PrintCallingFunction()
  end
  if c.GetCode then
    return c:IsStatus(status)
  else
    return bit32.band(c.status,status)>0
  end
end
function FilterSummon(c,type)
  if c.GetCode then
    return bit32.band(c:GetSummonType(),type)==type
  else
    return bit32.band(c.summon_type,type)==type
  end
end
function FilterAffected(c,effect)
  if c == nil then
    print("Warning: FilterAffected null card")
    PrintCallingFunction()
  end
  if c.GetCode then
    return c:IsHasEffect(effect)
  else
    return c:is_affected_by(effect)>0
  end
end
function FilterPublic(c)
  return STATUS_IS_PUBLIC and FilterStatus(c,STATUS_IS_PUBLIC)
  or c.is_public and c:is_public()
  or FilterPosition(c,POS_FACEUP)
  or FilterSummon(c,SUMMON_TYPE_SPECIAL)
end
function FilterPrivate(c)
  return not FilterPublic(c)
end
function FilterSet(c,code)
  if c == nil then
    print("Warning: FilterSet null card")
    PrintCallingFunction()
  end
  if c.GetCode then 
    return c:IsSetCard(code)
  else
    return IsSetCode(c.setcode,code)
  end
end
function FilterOPT(c,hard)
  if hard then 
    if type(hard)=="number" then
      return OPTCheck(hard)
    end
    return OPTCheck(c.id)
  else
    return OPTCheck(c.cardid)
  end
end
function FilterOPD(c,id)
  if id then
    return OPDCheck(id)
  end
  return OPDCheck(c)
end
function FilterMaterials(c,count)
  return c.xyz_material_count>=count
end
function HasMaterials(c)
  return c.xyz_material_count>0
end
function HasEquips(c,opt)
  return opt == nil and c.equip_count>0
  or opt and c.equip_count==opt
end
function FilterPendulum(c)
  return not FilterType(c,TYPE_PENDULUM+TYPE_TOKEN) 
end
GlobalEffect = nil
function GetGlobalEffect(c)
  if GlobalEffect then
    return GlobalEffect
  else
    c=GetScriptFromCard(c)
    GlobalEffect=Effect.CreateEffect(c)
    return GlobalEffect
  end
end
function FilterRemovable(c)
  c=GetScriptFromCard(c)
  return c:IsAbleToRemove(GetGlobalEffect(c),0,nil,false,false)
end
function FilterRevivable(c,skipcond)
  c=GetScriptFromCard(c)
  return c:IsCanBeSpecialSummoned(GetGlobalEffect(c),0,nil,false,false)
end
function FilterTuner(c,level)
  return FilterType(c,TYPE_MONSTER)
  and FilterType(c,TYPE_TUNER)
  and (not level or FilterLevel(c,level))
end
function FilterNonTuner(c,level)
  return FilterType(c,TYPE_MONSTER)
  and not FilterType(c,TYPE_TUNER)
  and (not level or FilterLevel(c,level))
end
function FilterBackrow(c)
  return FilterType(c,TYPE_SPELL+TYPE_TRAP)
  and FilterPosition(c,POS_FACEDOWN)
  and FilterLocation(c,LOCATION_SZONE)
end
function Scale(c) -- backwards compatibility
  return c.lscale
end
function ScaleCheck(p)
  local cards=AIPendulum()
  local result = 0
  local count = 0
  if p == 2 then
    cards=OppPendulum()
  end
  for i=1,#cards do
    if bit32.band(cards[i].type,TYPE_PENDULUM)>0 then
      result = Scale(cards[i])
      count = count + 1
    end
  end
  if count == 0 then
    return false
  elseif count == 1 then
    return result
  elseif count == 2 then
    return true
  end
  return nil
end
function GetScales(p)
  p=p or 1
  local result={}
  for i,c in pairs(AllPendulum()) do
    if FilterType(c,TYPE_PENDULUM) 
    and FilterController(c,p)
    then
      result[#result+1]=c
    end
  end
  if #result==0 then
    return false
  end
  return result[1],result[2]
end
function CanPendulumSummon(p)
  local l,r = GetScales(p)
  return l and r and math.abs(Scale(l)-Scale(r))>1 
end
function FilterController(c,player)
  if not player then player = 1 end
  c=GetCardFromScript(c)
  return CurrentOwner(c)==player
end
function FilterOwner(c,player)
  if not player then player = 1 end
  c=GetCardFromScript(c)
  return c.owner==player
end
function FilterGlobalTarget(c,cards)
  local target = GlobalTargetGet(cards)
  return CardsEqual(c,target)
end
function FilterPriorityTarget(c)
  return PriorityTarget(c)
end
function FilterPendulumSummonable(c,scalecheck)
  return FilterType(c,TYPE_MONSTER)
  and FilterRevivable(c)
  and (FilterLocation(c,LOCATION_HAND)
  or FilterLocation(c,LOCATION_EXTRA)
  and FilterPosition(c,POS_FACEUP)
  and FilterType(c,TYPE_PENDULUM))
  and (not scalecheck) -- TODO: implement scalecheck
end
function FilterFlip(c,checkopt)
  return FilterType(c,TYPE_MONSTER)
  and FilterType(c,TYPE_FLIP)
  and FilterPosition(c,POS_FACEDOWN)
  and (not checkopt or OPTCheck(c.id))
end
function FilterFlipFaceup(c,checkopt)
  return FilterType(c,TYPE_MONSTER)
  and FilterType(c,TYPE_FLIP)
  and FilterPosition(c,POS_FACEUP)
  and (not checkopt or OPTCheck(c.id))
end
function FilterInvert(c,args)
  -- invert another filter, pass either the filter,
  -- or a list containing filter + arguments
  local filter = args
  local opt = nil
  if type(filter) == "table" then
    filter = args[1]
    opt = args[2]
  end
  return not FilterCheck(c,filter,opt)
end
GlobalSummonRestriction = nil
function FilterSummonRestriction(c)
  local filter = GlobalSummonRestriction
  if not filter then
    return true
  end
  if type(filter) == "number" then
    return FilterSet(c,filter)
  end
  return filter(c)
end
function FilterCrippled(c)
  -- check, if a targed is crippled in any way
  -- negated, cannot attack, face-down and cannot change position, stuff like that
  if not FilterLocation(c,LOCATION_ONFIELD) then
    return false
  end
  if Negated(c) 
  and not SkillDrainCheck()
  and c.attack<2200 -- negated beatstick still useful
  then
    return true
  end
  if c.base_attack>=1500 -- don't consider crippled, if the ATK is low to begin with
  and (c.attack<=0.5*c.base_attack 
  or FilterAffected(c,EFFECT_CANNOT_ATTACK))
  then
    return true
  end
  if FilterPosition(c,POS_FACEDOWN)
  and FilterAffected(c,EFFECT_CANNOT_CHANGE_POSITION)
  then
    return true
  end
  return false
end
function FilterNotCrippled(c)
  return not FilterCrippled(c)
end
function FilterEquipped(c,id)
  return CardsMatchingFilter(c:get_equipped_cards(),FilterID,id)>0
end
GlobalTargetList = {}
-- function to prevent multiple cards to target the same card in the same chain
function TargetCheck(card)
  for i=1,#GlobalTargetList do
    if card and GlobalTargetList[i].cardid==card.cardid then
      return false
    end
  end
  return true
end
function TargetSet(card)
  GlobalTargetList[#GlobalTargetList+1]=card
end

function PendulumCheck(c)
  return bit32.band(c.type,TYPE_PENDULUM)>0 and bit32.band(c.location,LOCATION_SZONE)>0
end

function EffectCheck(player,link)
  -- function to check, if an effect is used in the current chain
  if not link then 
    link = Duel.GetCurrentChain()
  end
  local p = Duel.GetChainInfo(link, CHAININFO_TRIGGERING_PLAYER)
  local e = Duel.GetChainInfo(link, CHAININFO_TRIGGERING_EFFECT)
  local c = nil
  local id = nil
  if e and p and (p == player or player == nil) then
    c = e:GetHandler()
    if c then
      id = c:GetCode()
      return e,c,id
    end
  end
  return nil
end 

function FindCard(cardid,cards,index)
  if cards == nil then cards = All() end
  if type(cardid)=="table" then
    cardid=cardid.cardid
  end
  for i=1,#cards do
    if cards[i].cardid==cardid then
      if index then
        return {i}
      else
        return cards[i]
      end
    end
  end
  return nil
end

function FindID(id,cards,index,filter,opt)
  if cards == nil then cards = All() end
  if filter and type(filter) ~= "function" then
    print("Warning: FindID invalid filter")
    print(filter)
    PrintCallingFunction()
  end
  for i=1,#cards do
    if cards[i].id == id 
    and (filter == nil
    or opt == nil and filter(cards[i])
    or filter(cards[i],opt))
    then
      if index then
        return {i}
      else
        return cards[i]
      end
    end
  end
  return nil
end

function FindCardByFilter(cards,filter,opt)
  for i,c in pairs(cards) do
    if FilterCheck(c,filter,opt) then
      return c
    end
  end
  return nil
end


function AttackBoostCheck(bonus,malus,player,filter,opt)
  local source = Duel.GetAttacker()
  local target = Duel.GetAttackTarget()
  if bonus == nil then bonus = 0 end
  if malus == nil then malus = 0 end
  if player == nil then player = player_ai end
  if source and target 
  and source:IsLocation(LOCATION_MZONE) 
  and target:IsLocation(LOCATION_MZONE) 
  then
    if source:IsControler(player) then
      target = Duel.GetAttacker()
      source = Duel.GetAttackTarget()
    end
    if target:IsPosition(POS_FACEUP_ATTACK) 
    and (source:IsPosition(POS_FACEUP_ATTACK) 
    and source:GetAttack() >= target:GetAttack() 
    and source:GetAttack()-malus <= target:GetAttack()+bonus
    or source:IsPosition(POS_FACEUP_DEFENSE) 
    and source:GetDefense() >= target:GetAttack() 
    and source:GetDefense() <= target:GetAttack()+bonus)
    and not source:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE)
    and (filter == nil 
    or opt == nil and filter(target)
    or opt and filter(target,opt))
    then
      return true
    end
  end
  return false
end

function LocCheck(cards,loc,all) -- checks the location of cards
  if not all then                -- for target functions etc
    return FilterLocation(cards[1],loc)
  end
  local result = #cards
  for i=1,#cards do
    if FilterLocation(cards[i],loc) then
      result = result-1
    end
  end
  return result == 0
end


function NormalSummonCheck(player)
  if player == nil then player = player_ai end
  -- wrapper for changed card script function
  if Duel.CheckNormalSummonActivity then
    return Duel.CheckNormalSummonActivity(player)
  else
    return Duel.GetActivityCount(player,ACTIVITY_NORMALSUMMON)>0
  end
end
function NormalSummonCount(player)
  if player == nil then player = player_ai end
  return Duel.GetActivityCount(player,ACTIVITY_NORMALSUMMON)
end
GlobalExtraSummons={}
function NormalSummonsAvailable(player)
  player = player or player_ai
  local summons = NormalSummonCount(player)
  local available = (GlobalExtraSummons[Duel.GetTurnCount] or 0) + 1
  if HasIDNotNegated(AIMon(),03113836,true) then -- Seraphinite
    available = 2
  end
  return available-summons
end
function NormalSummonAdd(amount)
  amount=amount or 1
  GlobalExtraSummons[Duel.GetTurnCount()]=(GlobalExtraSummons[Duel.GetTurnCount()] or 0)+1
end
function SpecialSummonCheck(player)
  if player == nil then player = player_ai end
  -- wrapper for changed card script function
  if Duel.CheckSpecialSummonActivity then
    return Duel.CheckSpecialSummonActivity(player)
  else
    return Duel.GetActivityCount(player,ACTIVITY_SPSUMMON)>0
  end
end
function TargetProtection(c,type)
  local id
  local mats
  if c.GetCode then
    id = c:GetCode()
    mats = c:GetMaterialCount()
  else
    id = c.id
    mats = c.xyz_material_count
  end
  if id == 16037007 or id == 58058134 then
    return NotNegated(c) and mats>0
    and FilterLocation(c,LOCATION_MZONE)
  end
  if id == 82044279 then
    return NotNegated(c) and bit32.band(type,TYPE_MONSTER)>0
    and FilterLocation(c,LOCATION_MZONE)
  end
  return false
end
function PrintCallingFunction()
  local func
  print("calling functions:")
  for i=1,10 do
    func = debug.getinfo(i)
    if func then
      s = func.name or func.source..", line: "..func.currentline
      if s then print("function "..i..": "..s) end
    end
  end
  print("calling functions end")
end
function Targetable(c,type)
  local id
  local p
  local targetable
  if not c then
    print("Warning: Null card Targetable")
    PrintCallingFunction()
    return false
  end
  if c.GetCode then
    id = c:GetCode()
    p = c:GetControler()
    targetable = not(c:IsHasEffect(EFFECT_CANNOT_BE_EFFECT_TARGET)) 
  else
    id = c.id
    p = CurrentOwner(c)
    if p==1 then
      p = player_ai
    else
      p = 1-player_ai
    end
    targetable = c:is_affected_by(EFFECT_CANNOT_BE_EFFECT_TARGET)==0
  end
  if id == 08561192 then
    return Duel.GetCurrentPhase()==PHASE_MAIN2 and Duel.GetTurnPlayer()==p
  end
  return targetable and not TargetProtection(c,type)
end
function AffectedProtection(id,type,level)
  return false
end
function Affected(c,type,level)
  local id
  local immune = false
  local atkdiff = 0
  local lvl
  local materials = 0
  if not c then
    print("Warning: Null card Affected")
    PrintCallingFunction()
    return false
  end
  if c.GetCode then
    id = c:GetCode()
    immune = c:IsHasEffect(EFFECT_IMMUNE_EFFECT) 
    atkdiff = c:GetBaseAttack() - c:GetAttack()
    lvl = c:GetLevel()
    materials = c:GetMaterialCount()
  else
    id = c.id
    immune = c:is_affected_by(EFFECT_IMMUNE_EFFECT)>0
    atkdiff = c.base_attack - c.attack
    lvl = c.level
    materials = c.xyz_material_count
  end
  if type == nil then
    type = TYPE_SPELL
  end
  if level == nil then
    level = 12
  end
  if immune and atkdiff == 800 
  and bit32.band(type,TYPE_SPELL+TYPE_TRAP)==0
  then
    return true -- probably forbidden lance
  end
  if immune and FilterSet(c,0xaa) -- Qliphort
  then
    return not FilterSummon(c,SUMMON_TYPE_NORMAL)
    or FilterType(c,TYPE_NORMAL)
    or Negated(c)
    or ((bit32.band(type,TYPE_MONSTER)==0 
    and id ~=27279764 and id ~=40061558) -- Towers, Skybase
    or lvl<=level ) 
  end
  if immune and FilterSet(c,0xd4) -- Burgessttoma
  then
    return not FilterType(c,TYPE_MONSTER)
    or bit32.band(type,TYPE_MONSTER)==0 
  end
  if immune and FilterSet(c,0x108a) -- Traptrix
  and id ~= 06511113 -- Rafflesia
  then
    return true
  end
  if immune and id == 10817524 then -- First of the Dragons
    return type~=TYPE_MONSTER
  end
  if immune and id == 06511113 --Traptrix Rafflesia
  and materials>0
  then
    return type~=TYPE_TRAP
  end
  return not immune
end
PriorityTargetList=
{
  82732705,30241314,81674782,47084486,  -- Skill Drain, Macro Cosmos, Dimensional Fissure, Vanity's Fiend
  72634965,59509952,58481572,45986603,  -- Vanity's Ruler, Archlord Kristya, Dark Law, Snatch Steal
}
function PriorityTarget(c,destroycheck,loc,filter,opt) -- preferred target for removal
  local result = false
  if loc == nil then loc = LOCATION_ONFIELD end
  if loc == LOCATION_ONFIELD then
    if FilterType(c,TYPE_MONSTER) 
    and (bit32.band(c.type,TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO)>0 
    or c.level>4 and c.attack>2000
    or c.attack>=2500
    or FilterType(c,TYPE_XYZ) and c.xyz_material_count>0)
    and not (FiendishCheck(c) and AIGetStrongestAttack()>c.attack)
    and not FilterCrippled(c)
    then
      result = true
    end
    for i=1,#PriorityTargetList do
      if PriorityTargetList[i]==c.id then
        result = true
      end
    end
    if FilterLocation(c,LOCATION_SZONE) and FilterType(c,TYPE_PENDULUM) 
    and CardsMatchingFilter(AIST(),function(c)
      return FilterLocation(c,LOCATION_SZONE) 
      and FilterType(c,TYPE_PENDULUM)
      and DestroyFilter(c) end)>1 
    then
      result = true
    end
    result = (result or not AttackBlacklistCheck(c))
  end
  if result and (not destroycheck or DestroyFilter(c)) 
  and FilterPublic(c) and (filter == nil or (opt==nil and filter(c) or filter(c,opt)))
  and ShouldRemove(c)
  then
    return true
  end
  return false
end
function HasPriorityTarget(cards,destroycheck,loc,filter,opt)
  if HasIDNotNegated(cards,05851097,true,nil,nil,POS_FACEUP,FilterPublic) then -- Vanity's Emptiness
    return true
  end
  if CardsMatchingFilter(cards,function(c)
    return FilterLocation(c,LOCATION_SZONE) 
    and FilterType(c,TYPE_PENDULUM)
    and DestroyFilter(c) end)>1 
  then
    return true
  end
  local count = 0
  for i=1,#cards do
    if PriorityTarget(cards[i],destroycheck,loc,filter,opt) then
      count = count +1
    end
  end
  return count>0
end

-- Function to determine, if a player can special summon
-- true = player can special summon
GlobalDuality = 0
function DualityCheck(player,skipmaxx)
  local cards = UseLists(AIField(),OppField())
  if player == nil then player = 1 end
  if player == 1 and Duel.GetTurnCount()==GlobalDuality then
    return false -- Pot of Duality
  end
  if HasIDNotNegated(cards,05851097,true,nil,nil,POS_FACEUP) then 
    return false -- Vanity's Emptiness
  end
  if HasIDNotNegated(cards,59509952,true,nil,nil,POS_FACEUP) then 
    return false -- Archlord Kristya
  end
  if HasIDNotNegated(cards,42009836,true,nil,nil,POS_FACEUP) then 
    return false -- Fossil Dyna Pachycephalo
  end
  if HasIDNotNegated(cards,41855169,true,nil,nil,POS_FACEUP) then 
    return false -- Jowgen the Spiritualist
  end
  if HasIDNotNegated(cards,47084486,true,nil,nil,POS_FACEUP) then 
    return false -- Vanity's Fiend
  end
  if player == 1 and HasIDNotNegated(OppMon(),72634965,true,nil,nil,POS_FACEUP) then 
    return false -- Vanity's Ruler
  end
  if player == 2 and HasIDNotNegated(AIMon(),72634965,true,nil,nil,POS_FACEUP) then 
    return false -- Vanity's Ruler
  end
  if player == 1 and not skipmaxx and not MaxxCheck() then -- Maxx "C"
    return false 
  end
  return true
end

function CanSpecialSummon(player,skipmaxx) -- better name? 
  return DualityCheck(player,skipmaxx)     -- keep old name for backwards compatibility
end

-- Function to determine, if a player's cards are being banished 
-- instead of being sent to the grave
-- true = cards are not being banished
function MacroCheck(player)
  local cards = UseLists(AIField(),OppField())
  if player == nil then player = 1 end
  if HasIDNotNegated(cards,30459350,true,nil,nil,POS_FACEUP) then 
    return true -- Imperial Iron Wall, cancels everything below
  end
  if HasIDNotNegated(cards,30241314,true,nil,nil,POS_FACEUP) then 
    return false -- Macro Cosmos
  end
  if HasIDNotNegated(cards,81674782,true,nil,nil,POS_FACEUP) then 
    return false -- Dimensional Fissure
  end
  if player == 1 and HasIDNotNegated(OppMon(),58481572,true,nil,nil,POS_FACEUP) then
    return false -- Dark Law
  end
  if player == 2 and HasIDNotNegated(AIMon(),58481572,true,nil,nil,POS_FACEUP) then
    return false -- Dark Law
  end
  return true
end

DestRep={
48739166,78156759,10002346, -- SHArk, Zenmaines, Gachi
99469936,23998625,01855932, -- Crystal Zero Lancer, Heart-eartH, Kagutsuchi
77631175,16259499, -- Comics Hero Arthur, Lead Yoke, Fortune Tune
}
-- function to determine, if a card has to be destroyed multiple times
-- true = can be destroyed properly
function DestroyCountCheck(c,type,battle)
  local id
  local mats
  local p
  local cards
  local negated
  if c.GetCode then
    id = c:GetCode()
    mats = c:GetGetMaterialCount()
    if c:GetControler()==player_ai then
      p = 1
    else
      p = 2
    end
  else
    id = c.id
    mats = c.xyz_material_count
    p = CurrentOwner(c)
  end
  if id == 81105204 then
    return Negated(c) or bit32.band(type,TYPE_SPELL+TYPE_TRAP)==0
    or battle or c:is_affected_by(EFFECT_INDESTRUCTABLE_COUNT)==0
  end
  if Negated(c) then
    return c:is_affected_by(EFFECT_INDESTRUCTABLE_COUNT)==0
  end
  if p==1 then
    cards=AIMon()
  else  
    cards=OppMon()
  end
  if BoxerMonsterFilter(c) 
  and HasIDNotNegated(cards,23232295,true,HasMaterials)
  then
    return false
  end
  for i=1,#DestRep do
    if id==DestRep[i] 
    and mats>0
    then
      return false
    end
  end
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_COUNT)==0
end

Armades={
56421754, -- U.A. Mighty Slugger
45349196, -- Archfiend Black Skull Dragon
83866861, -- Frightfur Mad Chimera
29357956, -- GB Nerokius
57477163, -- Frightfur Sheep
88033975, -- Armades
56832966, -- Utopia Lightning
}

function ArmadesCheck(c,filter,opt)
  if c then
    local id=c.id
    for i=1,#Armades do
      if Armades[i]==id then
        return NotNegated(c)
      end
    end
  end
  --58569561 -- Aromage Rosemary
  return false
end

Stareater={
41517789, -- Star Eater
86274272, -- Dododo Bot
19700943, -- Ritual Beast Ulti-Apelio
}

function StareaterCheck(c,filter,opt)
  if c then
    local id=c.id
    for i=1,#Stareater do
      if Stareater[i]==id then
        return NotNegated(c)
      end
    end
  end
  return false
end

AttBL={
-- TODO: obsolete?!?
78371393,04779091,31764700, -- Yubel 1,2 and 3
54366836,88241506,23998625, -- Lion Heart, Maiden with the Eyes of Blue, Heart-eartH
80344569,68535320,95929069, -- Grand Mole, Fire Hand, Ice Hand
74530899, -- Metaion
}
-- cards that should not be attacked without negating them first
-- (or under special circumstances) 
function AttackBlacklistCheck(c,source)
  return SelectAttackConditions(c,source)
end
-- function to determine, if a card can be destroyed by battle
-- and should be attacked at all
function BattleTargetCheck(c,source)
  return c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)==0
  and c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0
  and c:is_affected_by(EFFECT_CANNOT_SELECT_BATTLE_TARGET)==0
  and DestroyCountCheck(c,TYPE_MONSTER,true)
  and AttackBlacklistCheck(c,source)
end

function BattleDamageCheck(c,source)
  return not FilterAffected(source,EFFECT_NO_BATTLE_DAMAGE)
  and not FilterAffected(c,EFFECT_AVOID_BATTLE_DAMAGE)
  and not FilterAffected(c,EFFECT_REFLECT_BATTLE_DAMAGE)
  and AttackBlacklistCheck(c,source)
end

function SafeAttackCheck(c,source)
  return c:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0
  and AttackBlacklistCheck(c,source)
end
function AttackedCount(c)
  if not c.GetCode then
    c=GetScriptFromCard(c)
  end
  return c:GetAttackedCount()
end
function BattleDamage(c,source,atk,oppatk,oppdef,pierce)
  if c and c.GetCode then
    c=GetCardFromScript(c)
  end
  if source and source.GetCode then
    source=GetCardFromScript(source)
  end
  if source == nil then
    return 0
  end
  if atk == nil  then
    atk = source.attack
  end
  if c == nil then
    if FilterAffected(source,EFFECT_CANNOT_DIRECT_ATTACK) then
      return 0
    else 
      return atk*AvailableAttacks(source)
    end
  end
  if oppatk == nil then
    oppatk = c.attack
  end
  if oppdef == nil then
    oppdef = c.defense
  end
  if pierce == nil then
    pierce = FilterAffected(source,EFFECT_PIERCE) and NotNegated(source)
  end
  if BattleDamageCheck(c,source) then
    if FilterPosition(c,POS_FACEUP_ATTACK) then
      return atk-oppatk
    end
    if FilterPosition(c,POS_DEFENSE) and pierce then
      if FilterPublic(c) then
        return atk-oppdef
      end
      if FilterPrivate(c) then
        return atk-1500
      end
    end
  end
  return 0
end

function BattleDamageFilter(c,source)
  return BattleDamage(c,source)>0
end
function StrongerAttackerCheck(card,cards)
  card=GetCardFromScript(card)
  ApplyATKBoosts({card})
  ApplyATKBoosts(cards)
  for i=1,#cards do
    local c = cards[i]
    if CanAttack(c)
    and c.attack>card.attack
    and not CardsEqual(c,card)
    then
      return false
    end
  end
  return true
end
CrashList={
83531441,00601193,23649496, -- Dante, Virgil,Plain-Coat
23693634,34230233, -- Colossal Fighter, Grapha
}
-- function to determine, if a card is allowed to 
-- crash into a card with the same ATK
function CrashCheck(c)
  local cards=AIMon()
  local StardustSparkCheck=false
  for i=1,#cards do
    if cards[i].id == 83994433 and NotNegated(cards[i]) and FilterPosition(cards[i],POS_FACEUP)
    and GlobalStardustSparkActivation[cards[i].cardid]~=Duel.GetTurnCount()
    and StrongerAttackerCheck(c,AIMon())
    then
      return Targetable(c,TYPE_MONSTER) and Affected(c,TYPE_MONSTER,8)
    end
  end
  if FilterAffected(c,EFFECT_INDESTRUCTABLE_BATTLE) then
    return true
  end
  if not DestroyCountCheck(c,TYPE_MONSTER,true) 
  and StrongerAttackerCheck(c,AIMon())
  then
    return true
  end
  if FilterType(c,TYPE_PENDULUM) and ScaleCheck(1)==true then
    return true
  end
  if KozmoShip(c) and DualityCheck() and MacroCheck() 
  and StrongerAttackerCheck(c,AIMon())
  then --TODO: IIW?
    return true
  end
  if c.id == 93302695 and AI.GetPlayerLP(1)>2000
  and StrongerAttackerCheck(c,AIMon())
  then
    return true -- Wickedwitch
  end
  if c.id == 99365553 and HasID(AIGrave(),88264978,true) 
  then
    return true -- Lightpulsar
  end
  if c.id == 99234526 and HasID(AIDeck(),61901281,true)
  and StrongerAttackerCheck(c,AIMon())
  then
    return true -- Wyverbuster
  end
  if c.id == 61901281 and HasID(AIDeck(),99234526,true)
  and StrongerAttackerCheck(c,AIMon())
  then
    return true -- Collapserpent
  end
  if c.id == 05556499 and #OppField()>1 
  and StrongerAttackerCheck(c,AIMon())
  then
    return true -- Machina Fortress
  end
  if c.id == 94283662 and UseTrance(3) then
    return true -- Trance Archfiend
  end
  if c.id == 71921856 and HasMaterials(c) then
    return true -- Nova Caesar
  end
  if c.id == 29357956 and not FilterLocation(c,LOCATION_MZONE) then
    return true -- Nerokius
  end
  if FilterSet(c,0xd3) then -- Kaiju
    return true
  end
  if CurrentMonOwner(c.cardid) ~= c.owner 
  and StrongerAttackerCheck(c,AIMon())
  then
    return true
  end
  if #AIMon()-#OppMon()>1 and OppGetStrongestAttack()==AIGetStrongestAttack()
  and StrongerAttackerCheck(c,AIMon())
  then
    return true
  end
  for i=1,#CrashList do
    if CrashList[i]==c.id 
    and StrongerAttackerCheck(c,AIMon())
    then
      return true
    end
  end
  return false
end

-- function to determine, if a card can attack into another card
-- without needing any bonus attack or taking any damage
function CanAttackSafely(c,targets,damage,filter,opt)
  if not targets then targets=OppMon() end
  if #targets == 0 then return true end
  local sub = SubGroup(targets,filter,opt)
  local atk = c.attack
  local baseatk = c.attack
  local usedatk
  if damage == true then 
    damage = 0.2 -- percentage of lp you're willing to lose on an attack
  end
  if not damage then
    damage = 0
  end
  if c.bonus then
    baseatk = math.max(0,atk-c.bonus)
  end
  sub = SubGroup(sub,SafeAttackCheck,c)
  if tograve == true then
    sub = SubGroup(sub,FilterPendulum)
    if not MacroCheck(1) then
      return false
    end
  end
  for i=1,#sub do
    local target = sub[i]
    usedatk = atk
    local oppatk = target.attack
    local oppdef = target.defense
    usedatk = baseatk
    if FilterPosition(target,POS_FACEDOWN_DEFENSE) and not FilterPublic(target) then
      oppdef = 1500
    end
    if (FilterPosition(target,POS_ATTACK) and (oppatk<usedatk
    or CrashCheck(c) and oppatk==usedatk)
    or FilterPosition(target,POS_DEFENSE) and (oppdef-usedatk<=damage*AI.GetPlayerLP(1))
    and (FilterPosition(target,POS_FACEUP) or FilterPublic(target))) 
    and SafeAttackCheck(target,c) 
    then
      return true
    end
  end
  return false
end  

-- function to determine, if a card can win a battle against any of the targets, and if the 
-- target is expected to hit the graveyard (for effects that trigger on battle destruction)
function CanWinBattle(c,targets,tograve,ignorebonus,filter,opt)
  if c == nil then
    print("WARNING: CanWinBattle null card")
    PrintCallingFunction()
  end
  local sub = SubGroup(targets,filter,opt)
  local atk = c.attack
  local baseatk = c.attack
  local usedatk
  if c.bonus then
    baseatk = math.max(0,atk-c.bonus)
  end
  sub = SubGroup(sub,BattleTargetCheck,c)
  if tograve == true then
    sub = SubGroup(sub,FilterPendulum)
    if not MacroCheck(1) then
      return false
    end
  end
  for i=1,#sub do
    local target = sub[i]
    usedatk = atk
    local oppatk = target.attack
    local oppdef = target.defense
    if ignorebonus or ArmadesCheck(target)
    then
      usedatk = baseatk
    end
    if (ignorebonus or ArmadesCheck(target) or StareaterCheck(target))
    and target.bonus 
    then
      oppatk = oppatk - target.bonus
    end
    if FilterPosition(target,POS_FACEDOWN_DEFENSE) and not FilterPublic(target) then
      oppdef = 1500
    end
    if FilterPosition(target,POS_ATTACK) and (oppatk<usedatk
    or CrashCheck(c) and oppatk==usedatk)
    or FilterPosition(target,POS_DEFENSE) and oppdef<usedatk 
    and BattleTargetCheck(target,c) 
    then
      return true
    end
  end
  return false
end  


function AvailableAttacks(c)
  if not c then
    return 0
  end
  local cardscript=GetScriptFromCard(c)
  local aiscript=GetCardFromScript(c)
  local result= 1+aiscript.extra_attack_count
  return result-cardscript:GetAttackedCount()
end
function CanChangePos(c)
  return not FilterAffected(c,EFFECT_CANNOT_CHANGE_POSITION)
  and c.turnid<Duel.GetTurnCount()
end
function CanAttack(c,direct,filter,opt)
  return (FilterPosition(c,POS_FACEUP_ATTACK)
  or (FilterPosition(c,POS_DEFENSE) and CanChangePos(c) and not IsBattlePhase()))
  and AvailableAttacks(c)>0
  and not FilterAffected(c,EFFECT_CANNOT_ATTACK)
  and (not direct or not FilterAffected(c,EFFECT_CANNOT_DIRECT_ATTACK))
  and FilterCheck(c,filter,opt)
end

-- checks the damage the AI is expected to take or dish out during this turn
-- assuming only direct attacks
function ExpectedDamage(player,filter,opt)
  local cards = OppMon()
  if player == 2 then
    cards = AIMon()
  end
  local result=0
  local g = nil
  for i=1,#cards do
    local c=cards[i]
    if c and CanAttack(c,true,filter,opt) and CanDealBattleDamage(c,nil,nil,filter,opt) then
      result=result+BattleDamage(nil,c)
    end
  end
  return result
end

-- function to determine, if a card can deal battle damage to a targets
-- for search effects, or just to push damage against battle-immune targets
function CanDealBattleDamage(c,targets,ignorebonus,filter,opt)
  if not BattlePhaseCheck() then
    return false
  end
  if targets == nil then
    targets = {}
  end
  if #targets == 0 then
    return true
  end
  local atk = c.attack
  if ignorebonus and c.bonus and c.bonus > 0 then
    atk = math.max(0,atk - c.bonus)
  end
  local sub = CopyTable(targets)
  sub = SubGroup(sub,filter,opt)
  sub = SubGroup(sub,AttackBlacklistCheck,c)
  for i=1,#sub do
    local oppatk = sub[i].attack
    if ignorebonus and sub[i].bonus and sub[i].bonus > 0 then
      oppatk = math.max(0,oppatk - sub[i].bonus)
    end
    if BattleDamage(sub[i],c,atk,oppatk)>0 then 
      return true
    end
  end
  return false
end
    

-- function to determine, if a card can attack for game 
-- on an opponent's monster, or directly
function CanFinishGame(c,target,atk,bonus,malus)
  if FilterPosition(c,POS_DEFENSE) then
    return false
  end
  if not bonus then
    bonus = 0
  end
  if not malus then
    malus = 0
  end
  if c == nil then
    return false
  end
  local p
  if c.GetCode then
    if atk == nil then 
      atk = c:GetAttack()
    end
    if c:IsControler(player_ai) then
      p=2
    else
      p=1
    end
  else
    if atk == nil then 
      atk = c.attack
    end
    if CurrentOwner(c) == 1 then
      p = 2
    else
      p = 1 
    end
  end 
  atk = atk + bonus
  if target == nil or FilterAffected(c,EFFECT_DIRECT_ATTACK) then
    return AI.GetPlayerLP(p)<=atk
  end
  local oppatk, oppdef
  if target.GetCode then
    oppatk = target:GetAttack()
    oppdef = target:GetDefense()
  else
    oppatk = target.attack
    oppdef = target.defense
  end
  oppatk = math.max(0,oppatk-malus)
  if AttackBlacklistCheck(target,c) and BattleDamageCheck(target,c) then
    if FilterPosition(target,POS_FACEUP_ATTACK) then
      return AI.GetPlayerLP(p)<=atk-oppatk
    end
    if FilterPosition(target,POS_DEFENSE) and FilterAffected(c,EFFECT_PIERCE) then
      if FilterPublic(target) then
        return AI.GetPlayerLP(p)<=atk-oppatk
      else
        return AI.GetPlayerLP(p)<=atk-1500
      end
    end
  end
  return false
end
function GetCardFromScript(c,cards)
  if c==nil then 
    print("Warning: Requesting null card conversion")
    PrintCallingFunction()
    return nil 
  end
  if c.GetCode then
    return AI.GetCardObjectFromScript(c)
  elseif c.id then
    return c
  end
  print("Warning: invalid type to convert to card")
  PrintCallingFunction()
  return nil
end
function GetScriptFromCard(c)
  if c == nil then
    print("Warning: Requesting null card conversion")
    PrintCallingFunction()
    return nil
  end
  if c.GetCode then
    return c
  elseif c.id then
    return AI.GetScriptFromCardObject(c)
  end
   print("Warning: invalid type to convert to card")
   PrintCallingFunction()
   return nil
end
function Surrender()
  AI.Chat("I give up!")
  Duel.Win(1-player_ai,REASON_RULE)
end
Exodia={44519536,08124921,07902349,70903634,33396948}
function SurrenderCheck()
  local cards = UseLists(AIDeck(),AIHand())
  if DeckCheck(DECK_EXODIA) then
    for i=1,#Exodia do
      if not HasID(cards,Exodia[i],true) then
        Surrender()
        return
      end
    end
  end
  return
end

function CopyTable(cards)
  local cards2 = {}
  for k,v in pairs(cards) do
    cards2[k] = v
  end
  return cards2
end
function CopyMatrix(cards)
  local cards2 = {}
  for k,v in pairs(cards) do
    cards2[k] = CopyTable(v)
  end
  return cards2
end
function GetBattlingMons()
  local source = Duel.GetAttacker()
  local target = Duel.GetAttackTarget()
  local oppmon = nil
  local aimon = nil
  if source and source:IsLocation(LOCATION_MZONE) then
    if Duel.GetTurnPlayer()==player_ai then
      aimon = source
    else
      oppmon = source
    end
  end
  if target and target:IsLocation(LOCATION_MZONE) then
    if Duel.GetTurnPlayer()==player_ai then
      oppmon = target
    else
      aimon = target
    end
  end
  return aimon,oppmon
end
function GetAttackers(p,direct,filter,opt)
  local cards = OppMon()
  local result = {}
  if p == nil then
    p = 1
  end
  if p == 2 then
    cards = AIMon()
  end
  if direct == nil then
    direct = true
  end
  for i=1,#cards do
    local c=cards[i]  
    if CanAttack(c,direct,filter,opt) then
      result[#result+1]=c
    end
  end
  return result
end
function TurnEndCheck()
  return Duel.GetCurrentPhase()==PHASE_MAIN2 or not (GlobalBPAllowed 
  or Duel.GetCurrentPhase()==PHASE_DRAW or Duel.GetCurrentPhase()==PHASE_STANDBY)
end

function BattlePhaseCheck()
  local p = Duel.GetCurrentPhase()
  return (p==PHASE_DRAW
  or p==PHASE_STANDBY
  or IsBattlePhase())
  or p==PHASE_MAIN1
  and GlobalBPAllowed
end
-- returns the zone a card occupies
function Sequence(c)
  local cards = {AI.GetAIMonsterZones(),AI.GetOppMonsterZones(),
  AI.GetAISpellTrapZones(),AI.GetOppSpellTrapZones(),}
  if cards and #cards>0 then
    for i=1,#cards do
      for j=1,#cards[i] do
        if CardsEqual(c,cards[i][j]) then
          return j-1
        end
      end
    end
  end
  return nil
end

function FilterCheck(c,filter,opt)
  if not filter then
    return c
  end
  if type(filter)~="function" then
    print("Warning: FilterCheck not a valid filter")
    print(filter)
    PrintCallingFunction()
  end
  return c and (not filter or opt==nil 
  and filter(c) or filter(c,opt))
end

function EPAddedCards()  -- checks, how many cards the AI is expected
  local result = 0       -- to search during end phase
  if CardsMatchingFilter(AIGrave(),SignGraveFilter)>0
  and OPTCheck(19337371)
  then
    result = result+3
  end  
  if CardsMatchingFilter(AIGrave(),ScarmGraveFilter)>0
  and OPTCheck(84764038)
  then
    result = result+1
  end
  if CardsMatchingFilter(AIGrave(),HarpistGraveFilter)>0
  and OPTCheck(56585883)
  then
    result = result+1
  end
  if HasIDNotNegated(AIST(),51194046,true)
  then
    result=result+TributeCount()
  end
  return result
end

function CardTargetFilter(c,rc)
	return rc:IsHasCardTarget(c)
end
-- checks, if cards like CotH still have a target.
function CardTargetCheck(c,target)
  if c==nil then return nil end
  c=GetScriptFromCard(c)
  if c==nil then return nil end
  local result = 0
  if not c:IsPosition(POS_FACEUP) then return nil end
  if target then
    target=GetScriptFromCard(target)
    return c:IsHasCardTarget(target)
  end
  return GetScriptFromCard(c):GetCardTargetCount()>0
end
function FiendishCheck(target)
  for i=1,#Field() do
    local c = Field()[i]
    if c.id==50078509 and FilterPosition(c,POS_FACEUP)
    and CardTargetCheck(target,c)
    then
      return true
    end
  end
  return false
end
function FiendishChainCheck(c)
  return c.id==50078509 and FilterPosition(c,POS_FACEUP)
  and CardTargetCheck(c)==0
end

--returns the total ATK of all cards in a list, limeted by a max count.
function TotalATK(cards,limit,filter,opt)
  local result = 0
  cards = SubGroup(cards,filter,opt)
  table.sort(cards,function(a,b)return a.attack>b.attack end)
  for i=1,math.min(#cards,limit) do
    result=result+cards[i].attack
  end
  return result
end
GlobalDamageTaken=0
GlobalPreviousLP=nil
function DamageSet()
  if GlobalPreviousLP then
    GlobalDamageTaken = GlobalPreviousLP-AI.GetPlayerLP(1)
    GlobalPreviousLP = AI.GetPlayerLP(1)
  end
end
function DamageTaken()
  return GlobalDamageTaken
end
function ChainCheck(id,player,link,filter,opt)
  local start=1
  local stop=Duel.GetCurrentChain()
  if link then
    start = link
    stop = link
  end
  local result = 0
  for i=start,stop do
    local c
    local e=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler() then
      c = e:GetHandler()
      if c:GetCode() == id
      and (not player or c:GetControler() == player)
      and FilterCheck(c,filter,opt)
      then
        result = result+1
      end
    end
  end
  if result == 0 then result = false end
  return result
end
GlobalOppDeck = nil
CheckedDecks={
0x9d, -- Shaddoll
0xb1, -- Burning Abyss
0x6,  -- Dark World 
0x74, -- Mermail
0x77, -- Atlantean
0x38, -- Lightsworn
}
function OppDeckCheck(setcode) -- check for certain archetypes, for specific counters
  if GlobalOppDeck == nil then -- Abyss Dweller, Shaddoll Anoyatilis...
    local cards = SubGroup(UseLists({OppField(),OppGrave(),OppExtra(),OppBanish()}),FilterPublic)
    local filter = function(c,setcode) 
      return c.owner==2 
      and FilterSet(c,setcode) 
    end
    for i=1,#CheckedDecks do
      local s = CheckedDecks[i]
      if CardsMatchingFilter(cards,filter,s)>1 then
        GlobalOppDeck = s
        break
      end
    end
  end
  if setcode then 
    if type(setcode)=="table" then
      local result = false
      for i=1,#setcode do
        if IsSetCode(GlobalOppDeck,setcode[i]) then
          result = true
        end
      end
      return result
    else
      return IsSetCode(GlobalOppDeck,setcode)
    end
  else
    return GlobalOppDeck
  end
end
Attributes={
ATTRIBUTE_EARTH,		-- 0x01
ATTRIBUTE_WATER,		-- 0x02
ATTRIBUTE_FIRE,		  -- 0x04
ATTRIBUTE_WIND,		  -- 0x08
ATTRIBUTE_LIGHT,		-- 0x10
ATTRIBUTE_DARK,		  -- 0x20
ATTRIBUTE_DEVINE,	  -- 0x40	
}
GlobalOppAttribute = nil
function OppAttributeCheck(attribute) -- check for certain attributes, for specific counters
  if GlobalOppAttribute == nil then   -- Constellarknight Diamond, SIM/LIM...
    local cards = SubGroup(UseLists({OppField(),OppGrave(),OppExtra(),OppBanish(),OppMaterials()}),FilterPublic)
    local filter = function(c,attribute) 
      return c.owner==2 
      and FilterAttribute(c,attribute) 
    end
    for i=1,#Attributes do
      local a = Attributes[i]
      if CardsMatchingFilter(cards,filter,a)>3 then
        GlobalOppAttribute = a
        break
      end
    end
  end
  if setcode then 
    if type(setcode)=="table" then
      local result = false
      for i=1,#setcode do
        if IsSetCode(GlobalOppDeck,setcode[i]) then
          result = true
        end
      end
      return result
    else
      return IsSetCode(GlobalOppDeck,setcode)
    end
  else
    return GlobalOppDeck
  end
end
function MatchupCheck(id) -- make AI consider matchups
  local decks = {0x9d,0xb1,0x6,0x74,0x77} -- Shaddoll, BA, Dark World, Mermail, Atlantenan
  if id == 21044178 -- Abyss Dweller
  and OppDeckCheck(decks)
  then 
    return true
  end
  decks = {0x9d,0xb1,0x38} -- Shaddoll, BA, Lightsworn
  if id == 09272381 -- Constellarknight Diamond
  and (OppDeckCheck(decks)
  or OppAttributeCheck({ATTRIBUTE_DARK}))
  then
    return true
  end
  if id == 58577036 then -- Reasoning
    if OppDeckCheck(0xd2) then -- Kozmo
      return 8
    elseif OppDeckCheck(0xbb) then -- Infernoid
      return 1
    end
  end
  return false
end
function SpaceCheck(loc,p)
  if not loc then loc=LOCATION_MZONE end
  if not p then p=1 end
  if p == 1 then
    p = player_ai
  else
    p = 1-player_ai
  end
  return Duel.GetLocationCount(p,loc)
end

function GetHighestAttDef(cards,filter,opt)
  local result = -1
  for i=1,#cards do
    local c = cards[i]
    if FilterCheck(c,filter,opt) then
      if c.attack>result then result = c.attack end
      if c.defense>result then result = c.defense end
    end
  end
  return result
end

function GetName(c) -- wrapper for backwards compatibility
  if not c then
    print("Warning: null card name")
    PrintCallingFunction()
    return ""
  end
  c=GetCardFromScript(c)
  if AI.GetCardName then
    return AI.GetCardName(c.id)
  end
  return c.id
end



function SummonNegateFilter(c)
  return (c.attack>1500 and AIGetStrongestAttack(true)<=c.attack) or FilterType(c,TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ) --or c.level>4
end
function EffectNegateFilter(c,card)
  local id = c:GetCode()
  if RemovalCheck(card.id) then
    local cg = RemovalCheck()
    if cg:GetCount()>1 then
      return true
    else
      if FilterType(card,TYPE_MONSTER) then
        return true
      else
        return false
      end
    end
  end
  if RemovalCheck() then
    --WIP, don't negate stuff that destroys re-equipables
  end
  for i=1,#EffNegBL do
    if id == EffNegBL[i] then
      return false
    end
  end
  if c:IsType(TYPE_EQUIP+TYPE_FIELD) then
    return false
  end
  if (id == 53804307 or id == 26400609 -- Dragon Rulers
  or id == 89399912 or id == 90411554)
  and c:IsLocation(LOCATION_MZONE)
  then
    return false
  end
  if  id == 00423585 -- Summoner Monk
  and not Duel.GetOperationInfo(Duel.GetCurrentChain(), CATEGORY_SPECIAL_SUMMON) 
  then
    return false
  end
  return true
end
function CardNegateFilter(c,card,targeted,filter,opt)
  return c and card and c:IsControler(1-player_ai) 
  and c:IsLocation(LOCATION_ONFIELD) 
  and c:IsPosition(POS_FACEUP)
  and not NegateBlacklist(c:GetCode()) 
  and (not targeted or Targetable(c,card.type))
  and Affected(c,card.type,card.level)
  and NotNegated(c) 
  and FilterCheck(c,filter,opt)
end

GlobalNegatedChainLinks = {}
function CheckNegated(ChainLink)
  return not GlobalNegatedChainLinks[ChainLink]
end
function SetNegated(ChainLink)
  if ChainLink == nil then
    ChainLink = Duel.GetCurrentChain()
  end
  GlobalNegatedChainLinks[ChainLink] = true
end
function ChainNegation(card,prio)
-- for negating the last chain link via trigger effect
  if not prio then
    prio = 4
  end
  local check = GetNegatePriority(card)
  if check>=prio then
    if card.id~=59438930 then --Ghost Ogre
      SetNegated()
    end
    return true
  end
  return false
end

function ChainCardNegation(card,targeted,prio,filter,opt,skipnegate)
-- for negating cards on the field that activated
-- an effect anywhere in the current chain
  if not prio then
    prio=4
  end
  if prio == true then
    prio=5
  end
  for i=1,Duel.GetCurrentChain() do
    local check = GetNegatePriority(card,i,targeted)
    if check>=prio then
      if not skipnegate then
        SetNegated()
      end
      local e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
      local c = nil
      if e then
        c=e:GetHandler()
        if FilterCheck(c,filter,opt) 
        and FilterCheck(c,FilterLocation,LOCATION_ONFIELD)
        then
          return c,i
        else
        end
      end
    end
  end
  return false
end


function NegateDiscardSummon(c,e,source,link) -- like Summoner Monk
  if not Duel.GetOperationInfo(link, CATEGORY_SPECIAL_SUMMON) then
    return 0
  else
    return 4
  end
  return nil
end

function NegateDragonRuler(c,e,source,link)
  if Duel.GetCurrentPhase()==PHASE_END then
    return 0
  end
  return nil
end

function NegateUpstart(c,e,source,link)
  if GetBurnDamage(nil,link) then
    return nil
  end
  return 0
end

function NegateOTKStopper(c,e,source,link)
  if (BattlePhaseCheck()
  or IsBattlePhase())
  and Duel.GetTurnPlayer()==player_ai
  and #OppMon()==0
  and ExpectedDamage(2)>=AI.GetPlayerLP(2)
  then
    return 4
  end
  return nil
end

NegatePriority={
[70368879] = NegateUpstart, -- Upstart
[32807846] = 0, -- RotA
[12538374] = 0, -- Treeborn
[19748583] = 0, -- Gwen
[98645731] = 0, -- Duality
[81439173] = 0, -- Foolish
[75500286] = 0, -- Gold Sarc
[01845204] = 4, -- Instant Fusion
[79844764] = 5, -- Stormforth

[00423585] = NegateDiscardSummon, -- Summoner Monk
[95503687] = NegateDiscardSummon, -- Lightsworn Lumina
[90238142] = NegateDiscardSummon, -- Harpie Channeler
[17259470] = NegateDiscardSummon, -- Zombie Master

[53804307] = NegateDragonRuler,
[26400609] = NegateDragonRuler,
[89399912] = NegateDragonRuler,
[90411554] = NegateDragonRuler,

[65367484] = 3, -- Thrasher

[16947147] = NegateOTKStopper, -- Menko
[61318483] = NegateOTKStopper, -- Ghostrick Jackfrost
[54512827] = NegateOTKStopper, -- Ghostrick Lantern
[02830693] = NegateOTKStopper, -- Rainbow Kuriboh
[18964575] = NegateOTKStopper, -- Swift Scarecrow
[19665973] = NegateOTKStopper, -- Battle Fader
[44330098] = NegateOTKStopper, -- Gorz
[13313278] = NegateOTKStopper, -- BB Veil
[25857246] = NegateOTKStopper, -- Nekroz Valkyrus
}
function AdjustMonsterPrio(target,prio)
  if not FilterType(target,TYPE_MONSTER) then
    return prio
  end
  local atk = AIGetStrongestAttack()
  if CurrentOwner(target)==1 then
    atk=OppGetStrongestAttDef()
  end
  if FilterType(target,TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ) 
  or target.level>4
  then
    prio=prio+1
  end
  if FilterType(target,TYPE_XYZ) then
    if target.xyz_material_count>0
    then
      prio=prio+1
    end
  end
  if target.attack>=2000 then
    prio=prio+1
  end
  if target.attack<1200 then
    prio=prio-1
  end
  if target.attack<500 then
    prio=prio-1
  end
  if atk>=1200 and target.attack>=atk then
    prio=prio+1
  end
  return prio
end
function GetNegatePriority(source,link,targeted)
-- assign priorities, how dangerous an effect might be
-- to decide, if it should be negated
  if not link then
    link=Duel.GetCurrentChain()
  end
  local prio = 0
  local targets = nil
  local target = nil
  local e,c,id = nil,nil,nil
  local cardtype = nil
  local level = 0
  if source then
    if FilterType(source,TYPE_MONSTER) then
      cardtype = TYPE_MONSTER
      level = source.level
    elseif FilterType(source,TYPE_SPELL) then
      cardtype = TYPE_SPELL
    elseif FilterType(source,TYPE_TRAP) then
      cardtype = TYPE_TRAP
    end
  else
  end
  if EffectCheck(1-player_ai,link) then
    e,c,id=EffectCheck(nil,link)
    c=GetCardFromScript(c)
   if source and not Affected(c,cardtype,level) then
      return -1
    end
    if source and targeted and not Targetable(c,cardtype) then
      return -1
    end
    if not CheckNegated(link) then
      return -1
    end
    if Negated(c) then
      return -1
    end
    if FilterLocation(c,LOCATION_ONFIELD) 
    and FilterType(c,TYPE_SPELL+TYPE_TRAP)
    and FilterType(c,TYPE_CONTINUOUS+TYPE_FIELD+TYPE_EQUIP+TYPE_PENDULUM)
    then
      prio=prio+1
    end
    if FilterType(c,TYPE_MONSTER) 
    and FilterLocation(c,LOCATION_ONFIELD)
    then
      prio=prio+2
      prio=AdjustMonsterPrio(c,prio)
    end
    if FilterLocation(c,LOCATION_HAND) then
      prio=prio+1
    end
    targets = RemovalCheckList(AICards(),nil,nil,nil,link)
    target = nil
    if targets and #targets>0 then
      target = targets[1]
      if #targets>1 then
        prio=prio+10
      else
        if not (source and CardsEqual(source,target))
        or FilterType(c,TYPE_MONSTER)
        and FilterLocation(c,LOCATION_ONFIELD)
        or FilterType(source,TYPE_MONSTER)
        and FilterLocation(source,LOCATION_ONFIELD)
        then
          prio=prio+3
          if FilterType(targets[1],TYPE_CONTINUOUS) then
            prio=prio+1
          end
        end 
        prio=AdjustMonsterPrio(target,prio)
      end
    end
    targets = NegateCheckList(AICards(),nil,link)
    if targets and #targets>0 then
      target = targets[1]
      if #targets>1 then
        prio=prio+6
      else
        prio=prio+2
        if ChainCheck(target.id,player_ai) then
          prio=prio+2
        end
      end
    end
    if e:IsHasCategory(CATEGORY_DRAW) then
      prio=prio+1
    end
    if e:IsHasCategory(CATEGORY_SEARCH) then
      prio=prio+1
    end
    if e:IsHasCategory(CATEGORY_TOHAND) then
    end
    if e:IsHasCategory(CATEGORY_TOGRAVE) then
    end
    if e:IsHasCategory(CATEGORY_DECKDES) then
    end
    if e:IsHasCategory(CATEGORY_SPECIAL_SUMMON) then
      targets = Duel.GetChainInfo(link, CHAININFO_TARGET_CARDS)
      if targets and targets:GetCount() then
        target=GetCardFromScript(targets:GetFirst())
        if targets:GetCount()>1 then
          prio=prio+5
        else
          prio=prio+1
          if not FilterLocation(target,LOCATION_MZONE) then
            prio=AdjustMonsterPrio(target,prio)
          end 
        end
      else
        prio=prio+2
        if FilterType(c,TYPE_MONSTER) 
        and CheckSSList(c) and not FilterLocation(c,LOCATION_MZONE) 
        then
          target = c
          prio=AdjustMonsterPrio(target,prio)
        end
      end
    end
    local burn = GetBurnDamage(nil,link)
    if burn then
      if burn >= 2000 then
        prio=prio+2
      end
      if AI.GetPlayerLP(1)-burn<=800 then
        prio=prio+4
      end
      if burn>AI.GetPlayerLP(1) then
        prio=prio+100
      end
    end
    local aimon,oppmon = GetBattlingMons()
    if Duel.GetTurnPlayer()==player_ai
    and IsBattlePhase()
    and aimon and CanFinishGame(aimon,oppmon)
    then
      prio=prio+4
    end
  else
    local targets = SubGroup(OppMon(),FilterStatus,STATUS_SUMMONING)
    if targets and #targets>0 then 
      target=targets[1]
      c=target
      id=c.id
      if #targets > 1 and Duel.GetCurrentChain()<1 then
        prio = prio + 10
      end
      if #targets == 1 and Duel.GetCurrentChain()<1 then
        target=targets[1]
        prio = prio + 3
        prio=AdjustMonsterPrio(target,prio)
        local check = NegatePriority[target.id]
        if prio>-1 and check then
          if type(check) == "function" then
            if check(c,e,source,link) then
              prio=check(c,e,source,link)
            else
              --prio=-1
            end
          else
            prio=check
          end
        end
      end
    else
      prio = -1
    end
  end
  local check = NegatePriority[id]
  if prio>-1 and check then
    if type(check) == "function" then
      if check(c,e,source,link) then
        prio=check(c,e,source,link)
      else
        --prio=-1
      end
    else
      prio=check
    end
  end
  return prio
end
function VanityDestroyCheck(link,filter,opt)
  for i=1,Duel.GetCurrentChain() do
    local e = Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    if e then
      local c = e:GetHandler()
      if CurrentOwner(c)==1
      and e:IsHasCategory(CATEGORY_SPECIAL_SUMMON)
      and link>i
      then
        return FilterCheck(filter,opt)
      end
    end
  end
  return false
end
function ContractDestroyCheck(c,e,link,filter,opt)
  local id = c.id
  if e:IsHasCategory(CATEGORY_DAMAGE) 
  or not FilterCheck(c,filter,opt)
  then
    return false
  end
  if id == 46372010 then -- Hellgate
    return e:IsHasCategory(CATEGORY_SEARCH)
  end
  if id == 73360025 then -- Swamp King
    return e:IsHasCategory(CATEGORY_SPECIAL_SUMMON)
  end
  if id == 0006624 then -- Yamimakai
    return not e:IsHasType(EFFECT_TYPE_ACTIVATE)
  end
  if id == 09765723 then -- Valkyrie
    return e:IsHasCategory(CATEGORY_DESTROY)
  end
  if id == 37209439 then -- Mistaken Seal
    return true --e:IsHasCategory(CATEGORY_NEGATE)
  end
end
function RemoveOnActivationCheck(c,e,link,filter,opt)
  c=GetCardFromScript(c)
  local id = c.id
  if id == 19337371 then -- Hysteric Sign
    return true
  end
  if id == 05851097 then -- Vanity's Emptiness
    return VanityDestroyCheck(link,filter,opt)
  end
  if FilterSet(c,0xae) then -- Dark Contract
    return ContractDestroyCheck(c,e,link,filter,opt)
  end
  return FilterCheck(c,filter,opt)
end
function RemoveOnActivation(link,filter,opt)
  local startlink = 1
  local endlink = Duel.GetCurrentChain()
  if link then
    startlink = link
    endlink = link
  end
  local e = nil
  local c = nil
  local target = false
  for i=startlink,endlink do
    e = Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
    if e then
      c = e:GetHandler()
      if c and CurrentOwner(c)==2 and FilterType(c,TYPE_SPELL+TYPE_TRAP) 
      and FilterLocation(c,LOCATION_ONFIELD)
      then
        if FilterType(c,TYPE_CONTINUOUS+TYPE_EQUIP+TYPE_FIELD) 
        and RemoveOnActivationCheck(c,e,i,filter,opt)
        then
          target = c
        end
        if FilterType(c,TYPE_PENDULUM) and (ScaleCheck(2)==true
        or not e:IsHasType(EFFECT_TYPE_ACTIVATE))
        and RemoveOnActivationCheck(c,e,i,filter,opt)
        then
          target = c
        end
      end
    end
  end
  return target
end

function PrintList(cards,prio)
  print("printing list")
  for i,c in pairs(cards) do
    local s = "#"..i..": "..GetName(c)
    if prio and c.prio then s=s..", prio: "..c.prio end
    print(s)
  end
  print("end list")
end

function CheckSum(cards,sum,filter,opt)
  local result = false
  local valid = {}
  for i,c in pairs(cards) do
    if FilterCheck(c,filter,opt) then valid[#valid+1]=c end
  end
  for i=1,#valid do
    local c=valid[i]
    if c.level == sum then
      result = true
    end
    for j=math.min(i+1,#valid),#valid do
      local c2 = valid[j]
      if not CardsEqual(c,c2) and c.level+c2.level == sum then
        result = true
      end
      for k=math.min(j+1,#valid),#valid do
        local c3 = valid[k]
        if not CardsEqual(c2,c3) and not CardsEqual(c,c3) 
        and c.level+c2.level+c3.level==sum 
        then
          result=true
        end
      end
    end
  end
  return result
end

function IsBattlePhase()
  local current=Duel.GetCurrentPhase()
  local phases =
  {
    PHASE_BATTLE_START,
    PHASE_BATTLE_STEP,
    PHASE_DAMAGE,
    PHASE_DAMAGE_CAL,
    PHASE_BATTLE,
  }
  local result = false
  for i,p in pairs(phases) do
    if p and current == p then 
      result = true
    end
  end
  return result
end

function IsMainPhase()
  local current=Duel.GetCurrentPhase()
  local phases =
  {
    PHASE_MAIN1,
    PHASE_MAIN2,
  }
  local result = false
  for i,p in pairs(phases) do
    if p and current == p then 
      result = true
    end
  end
  return result
end

function AITrashTalk(s) -- to make the AI comment its plays. Can be disabled in ai.lua
  if TRASHTALK then
    AI.Chat(s)
  end
end

function CanXYZSummon(rank,materialcount,filter,opt) 
  -- checks for space on field and rank in extra
  -- does not actually check, if you have a way t put materials on board
  rank = rank or 4
  materialcount = materialcount or 2 
  local targets = SubGroup(AIExtra(),FilterRank,rank)
  local materials = SubGroup(AIMon(),FilterLevel,rank)
  return CardsMatchingFilter(AIExtra(),filter,opt)>0
  and SpaceCheck()+#materials>=materialcount
  and DualityCheck()
end

function DiscardCheck()
  -- checks, if the AI needs to keep a card to discard during the opponent's turn
  if HasIDNotNegated(AIMon(),01561110,true) -- ABC Dragon Buster 
  or HasID(AIST(),04178474,true) -- Raigeki Break
  or HasID(AIST(),63356631,true) -- PWWB
  then
    return #AIHand()>1
  end
  return true
end

function ShouldRemove(c)
  -- checks for cards, that should probably not be targeted with removal effects
  -- like spells currently activating on the field etc
  if FilterType(c,TYPE_SPELL+TYPE_TRAP)
  and not FilterType(c,TYPE_CONTINUOUS+TYPE_EQUIP+TYPE_FIELD+TYPE_PENDULUM)
  and FilterPosition(c,POS_FACEUP)
  then 
    return false
  end
  if FilterType(c,TYPE_TOKEN)
  and c.attack<1000
  then
    return false
  end
  return true
end

function GetBurnDamage(player,start,stop)
  -- returns the total burn damage expected to be dealt to the player 
  -- in the current chain
  player=player or player_ai
  start = start or 1
  stop = stop or start or Duel.GetCurrentChain()
  local result = 0

  for i=start,stop do
    local e1=Duel.IsPlayerAffectedByEffect(player,EFFECT_REVERSE_DAMAGE)
    local e2=Duel.IsPlayerAffectedByEffect(player,EFFECT_REVERSE_RECOVER)
    local rd=e1 and not e2
    local rr=not e1 and e2
    local ex,cg,ct,cp,cv=Duel.GetOperationInfo(i,CATEGORY_DAMAGE)
    if ex and (cp==player or cp==PLAYER_ALL) and not rd 
    and not Duel.IsPlayerAffectedByEffect(player,EFFECT_NO_EFFECT_DAMAGE) 
    then
      result = result + cv
    end
    ex,cg,ct,cp,cv=Duel.GetOperationInfo(i,CATEGORY_RECOVER)
    if ex and (cp==player or cp==PLAYER_ALL) and rr 
    and not Duel.IsPlayerAffectedByEffect(player,EFFECT_NO_EFFECT_DAMAGE)
    then
      result = result + cv
    end
  end
  if result>0 then
    return result
  end
  return false
end
GlobalInfiniteLoopCheck={}
function InfiniteLoopCheck(c,threshold)
  threshold = threshold or 5
  local id = c.description
  if not id or id == 0 then
    id = c.id
  end
  GlobalInfiniteLoopCheck[id]=GlobalInfiniteLoopCheck[id] or 0
  GlobalInfiniteLoopCheck[id]=GlobalInfiniteLoopCheck[id]+1
  return GlobalInfiniteLoopCheck[id]<=threshold
end
function MaxxCheck()
  return GlobalMaxxC~=Duel.GetTurnCount()
end
GlobalSummonLimit = {}
function SetSummonLimit(filter)
  GlobalSummonLimit[Duel.GetTurnCount()]=GlobalSummonLimit[Duel.GetTurnCount()] or {}
  GlobalSummonLimit[Duel.GetTurnCount()][#GlobalSummonLimit[Duel.GetTurnCount()]+1]=filter
end
function CheckSummonLimit(c)
  if GlobalSummonLimit[Duel.GetTurnCount()] then
    for i,filter in pairs(GlobalSummonLimit[Duel.GetTurnCount()]) do
      if not filter(c) then
        return false
      end
    end
  end
  return true
end

