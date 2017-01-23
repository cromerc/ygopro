--- OnSelectBattleCommand() ---
--
-- Called when AI can battle
-- 
-- Parameters:
-- cards = table of cards that can attack
--
-- Return (2): 
-- execute_attack = should AI attack or not
--		1 = yes
--		0 = no
-- index = index of the card to attack with

-- function to select attack targets. Redirected from SelectCard.lua
function AttackTargetSelection(cards,attacker)
  local id = attacker.id
  local result ={attacker}
  ApplyATKBoosts(result)
  ApplyATKBoosts(cards)
  result = nil
  local d = DeckCheck()
  if d and d.AttackTarget then
    result = d.AttackTarget(cards,attacker)
  end
  if result~=nil then return result end
  --print("attack target selection")
  --print("specific attacker")
  result = {}
  local atk = attacker.attack
  if NotNegated(attacker) then
  
    -- Utopia Lightning
    if id == 56832966 and CanWinBattle(attacker,cards) then
      return BestAttackTarget(cards,attacker,false,LightningPrioFilter,attacker)
    end
    
    -- High Laundsallyn
    if id == 83519853 and CanWinBattle(attacker,cards,true) then                 
      return BestAttackTarget(cards,attacker,false,FilterPendulum)
    end
    
    -- Shura
    if id == 58820853 and CanWinBattle(attacker,cards,true,true) then                 
      return BestAttackTarget(cards,attacker,true,FilterPendulum)
    end
    
    -- Shura with Kalut
    if id == 58820853 and CanWinBattle(attacker,cards,true) then                 
      return BestAttackTarget(cards,attacker,false,FilterPendulum)
    end
    
    -- FF Gorilla
    if id == 70355994 and CanWinBattle(attacker,cards,true) then                 
      return BestAttackTarget(cards,attacker)
    end
    
    -- FF Bear
    if id == 06353603 and CanDealBattleDamage(attacker,cards) then              
      return BestAttackTarget(cards,attacker,false,BattleDamageFilter,attacker)
    end
    
    -- F0
    if id == 65305468 then              
      return BestTargets(cards,1,TARGET_CONTROL,F0Filter)
    end
    
    -- BLS
    if id == 72989439 and CanWinBattle(attacker,cards,true) then                 
      return BestAttackTarget(cards,attacker)
    end
    
    -- Centaurea
    if id == 36776089 and CardsMatchingFilter(cards,CentaureaFilter,attacker)>0 then       
      return BestTargets(cards,1,TARGET_TOHAND,CentaureaFilter,attacker,true,attacker)
    end
    
    -- Catastor
    if id == 26593852 and CardsMatchingFilter(cards,CatastorFilter)>0 then       
      return BestTargets(cards,1,TARGET_DESTROY,CatastorFilter,nil,true,attacker)
    end
    
    -- Shaddoll Construct
    if id == 20366274 and CardsMatchingFilter(cards,ConstructFilter)>0 then       
      return BestTargets(cards,1,TARGET_DESTROY,ConstructFilter,nil,true,attacker)
    end
    
    -- Lightpulsar Dragon
    if id == 99365553 and LightpulsarCheck() then                                 
      return BestAttackTarget(cards,attacker,false,HandFilter,atk)
    end
    
    -- Mermail Abysslinde
    if id == 23899727 and LindeCheck() then                                       
      return BestAttackTarget(cards,attacker,false,HandFilter,atk)
    end
    
    -- Fire Hand
    if id == 68535320 and FireHandCheck() then
      return BestAttackTarget(cards,attacker,false,HandFilter,atk)
    end
    
    -- Ice Hand
    if id == 95929069 and IceHandCheck() then
      return BestAttackTarget(cards,attacker,false,HandFilter,atk)
    end
    
    -- Gwen
    if HasGwen(attacker) and CardsMatchingFilter(cards,GwenFilter,atk) then
      return BestTargets(cards,1,TARGET_DESTROY,GwenFilter,atk)
    end
    
    -- Zenmaines
    if id == 78156759 and ZenmainesCheck(attacker,cards) then
      return BestAttackTarget(cards,attacker,false,ZenmainesFilter,attacker)
    end
    
    -- Armed Wing
    if id == 76913983 and ArmedWingCheck(attacker,cards) then
      return BestAttackTarget(cards,attacker,false,ArmedWingFilter,attacker)
    end
    
    -- Crystal Wing
     if id == 50954680 and CrystalWingCheck(attacker,cards) then
      return BestAttackTarget(cards,attacker,false,CrystalWingFilter,attacker)
    end
    
  end
  --print("generic attacker")
  return BestAttackTarget(cards,attacker)
end
function BestAttackTarget(cards,source,ignorebonus,filter,opt)
  --print("best attack target")
  local atk = source.attack
  local bonus = 0
  if source.bonus and source.bonus > 0 then
    bonus = source.bonus
  end
  if ignorebonus then
    atk = math.max(0,atk - bonus)
  end
  local result = nil
  for i=1,#cards do
    local c = cards[i]
    c.index = i
    c.prio = 0
    if FilterPosition(c,POS_FACEUP_ATTACK) then
      if c.attack<atk 
      or (CrashCheck(source) and c.attack==atk 
      and AIGetStrongestAttack()<=c.attack) 
      then 
        if atk-bonus<=c.attack
        and CanWinBattle(source,cards,nil,true)
        and AIGetStrongestAttack(true)>c.attack
        then
          c.prio = 1
        else
          c.prio = c.attack
        end
      else
        c.prio = c.attack * -1
      end
    end
    if FilterPosition(c,POS_DEFENSE) then
      if FilterPublic(c) then
        if c.defense<atk then 
          c.prio = math.max(c.defense - 1,c.attack)
        else
          c.prio = atk - c.defense
        end
      end
    end
    if filter and (opt and not filter(c,opt) or opt==nil and  not filter(c)) 
    then
      c.prio = (c.prio or 0)-99999
    end
    if c.prio and c.prio>0 and not BattleTargetCheck(c,source) then
      c.prio = -4
    end
    if not AttackBlacklistCheck(c,source) then
      c.prio = (c.prio or 0)-99999
    end
    if CanFinishGame(source,c) then
      c.prio=99999
    end
    if FilterPosition(c,POS_DEFENSE) and FilterPrivate(c) then
      if atk>=1500 then
        c.prio = -1
      else
        c.prio = -2
      end
    end
    if c.prio and c.prio>0 and FilterPublic(c) then
      if FilterType(c,TYPE_SYNCHRO+TYPE_RITUAL+TYPE_XYZ+TYPE_FUSION) then
        c.prio = c.prio + 1
      end
      if FilterType(c,TYPE_EFFECT) then
        c.prio = c.prio + 1
      end
      if c.level>4 then
        c.prio = c.prio + 1
      end
    end
    if CurrentOwner(c)==1 then
      c.prio = -1*c.prio
    end
  end  
  table.sort(cards,function(a,b) return a.prio > b.prio end)
  --print("table:")
  --print("attacker: "..source.id..", atk: "..atk)
  for i=1,#cards do
    --print(i..") id: "..cards[i].id.." index: "..cards[i].index.." prio: "..cards[i].prio)
  end
  result={cards[1].index}
  return result
end

function SortByATK(cards,descending)
  local func = function(a,b) return a.attack > b.attack end
  if descending then func = function(a,b) return a.attack < b.attack end end
  for i=1,#cards do
    cards[i].index2 = cards[i].index
  end
  table.sort(cards,func)
  for i=1,#cards do
    cards[i].index = cards[i].index2
    cards[i].index2 = nil
  end
end
  
function OnSelectBattleCommand(cards,activatable)
  --print("battle command selection")
  -- shortcut function that returns the proper attack index and sets some globals 
  -- needed for attack target selection
  function Attack(index,direct)
    index = index or CurrentIndex
    local i = cards[index].index
    if direct then
      GlobalAIIsAttacking = nil
    else
      --print("attack: "..cards[index].id)
      GlobalCurrentAttacker = cards[index].cardid
      GlobalAIIsAttacking = true
    end
    return 1,i
  end
  

	
  ApplyATKBoosts(cards)
  for i=1,#cards do
    cards[i].index = i
  end
  
  
  -- check for monsters, that cannot be attacked, or have to be attacked first.
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
  end
  if #mustattack>0 then
    targets = mustattack
  else
    targets = attackable
  end
  ApplyATKBoosts(targets)
  
  local result,result2 = nil,nil
  local d = DeckCheck()
  if d and d.BattleCommand then
    result,result2 = d.BattleCommand(cards,targets,activatable) 
  end
  if result~=nil then
    return result,result2
  end
  
  --print("for game")
  -- can attack for game on a certain target
  SortByATK(cards)
  if #targets>0 and #cards>0 then
    for i=1,#targets do
      if CanFinishGame(cards[1],targets[i]) then
        return Attack(1)
      end
    end
  end
  
  --print("direct")
  -- can attack directly
  SortByATK(cards,true)
  if #cards>0 then
    for i=1,#cards do
      if FilterAffected(cards[i],EFFECT_DIRECT_ATTACK) then
        return Attack(i,true)
      end
    end
  end
  
  -- attack with monsters, that get beneficial effects from destroying stuff
  -- print("specific attackers")
  
  -- Utopia Lightning
  if HasIDNotNegated(cards,56832966)
  and (CanWinBattle(cards[CurrentIndex],targets) 
  or #OppMon()==0)
  then 
    return Attack(CurrentIndex)
  end
  
  -- BLS
  if HasIDNotNegated(cards,72989439) 
  and (CanWinBattle(cards[CurrentIndex],targets) 
  or #OppMon()==0 and GlobalBLS==Duel.GetTurnCount())
  then 
    return Attack(CurrentIndex)
  end
  
  -- High Laundsallyn
  if HasIDNotNegated(cards,83519853) and CanWinBattle(cards[CurrentIndex],targets,true) then 
    return Attack(CurrentIndex)
  end
  
  -- Shura
  if HasIDNotNegated(cards,58820853) and CanWinBattle(cards[CurrentIndex],targets,true) then 
    return Attack(CurrentIndex)
  end
  
  -- Fire Fist Gorilla
  if HasIDNotNegated(cards,70355994) and CanWinBattle(cards[CurrentIndex],targets,true) then
    return Attack(CurrentIndex)
  end

  -- Fire Fist Bear
  if HasIDNotNegated(cards,06353603) and CanDealBattleDamage(cards[CurrentIndex],targets) then
    return Attack(CurrentIndex)
  end
  
  -- F0
  if HasID(cards,65305468,F0Check,targets) then 
    return Attack(CurrentIndex)
  end
  
  -- Lightpulsar Dragon
  if HasID(cards,99365553) and LightpulsarCheck() then 
    return Attack(CurrentIndex)
  end
  
  -- Fire Hand
  if HasID(cards,68535320) and FireHandCheck() then 
    return Attack(CurrentIndex)
  end
  
  -- Ice Hand
  if HasID(cards,95929069) and IceHandCheck() then 
    return Attack(CurrentIndex)
  end
  
  -- Shaddoll Construct
  if HasID(cards,20366274) and CardsMatchingFilter(OppMon(),ConstructFilter)>0 then 
    return Attack(CurrentIndex)
  end
  
  -- Catastor
  if HasID(cards,26593852) and CardsMatchingFilter(OppMon(),CatastorFilter)>0 then 
    return Attack(CurrentIndex)
  end
  
  -- Centaurea
  if HasID(cards,36776089) and CardsMatchingFilter(OppMon(),CentaureaFilter)>0 then 
    return Attack(CurrentIndex)
  end
  
  -- Mermail Abysslinde
  if HasID(cards,23899727) and LindeCheck() then 
    return Attack(CurrentIndex)
  end
  
  -- Gwen
  for i=1,#cards do
    if HasGwen(cards[i]) and CardsMatchingFilter(OppMon(),GwenFilter,cards[i].attack)>0 then
      return Attack(i)
    end
  end
  
  -- Bujin Susanowo
  if HasID(cards,75840616) and CanWinBattle(cards[CurrentIndex],targets,nil,true) then 
    return Attack(CurrentIndex)
  end
  
  if HasID(cards,75840616) and CanWinBattle(cards[CurrentIndex],targets) then 
    return Attack(CurrentIndex)
  end
  
  -- Zenmaines
  if HasID(cards,78156759) and ZenmainesCheck(cards[CurrentIndex],targets) then 
    return Attack(CurrentIndex)
  end
  
  -- Armed Wing
  if HasID(cards,76913983,ArmedWingCheck,targets) then 
    return Attack(CurrentIndex)
  end
  -- generic attacks
  --print("generic attackers")

  --print("without boost")
  -- can destroy a monster without additional attack boosting cards
  SortByATK(cards,true)
  if #targets>0 and #cards>0 then
    for i=1,#cards do
      if CanWinBattle(cards[i],targets,nil,true) then
        return Attack(i)
      end
    end
  end
  --print("with boost")
  -- can destroy a monster with additional boost
  SortByATK(cards,true)
  if #targets>0 and #cards>0 then
    for i=1,#cards do
      if CanWinBattle(cards[i],targets) then
        return Attack(i)
      end
    end
  end
  --print("face-down")
  -- can probably destroy an unknown face-down monster
  SortByATK(cards,true)
  if #targets>0 and #cards>0  then
    for i=1,#cards do
      for j=1,#targets do
        if FilterPosition(targets[j],POS_FACEDOWN_DEFENSE) and (cards[i].attack >= 1500 
        or FilterPublic(targets[j]) and cards[i].attack > targets[j].defense)
        then
          return Attack(i)
        end
      end
    end
  end
  --print("battle damage")
  -- can deal battle damage (against battle-immune targets etc)
  SortByATK(cards,true)
  if #targets>0 and #cards>0 then
    for i=1,#cards do
      if CanDealBattleDamage(cards[i],targets,true) then
        return Attack(i)
      end
    end
  end
  --print("direct")
  -- direct attack
  SortByATK(cards,true)
  if #OppMon()==0 and #cards>0 then
    return Attack(1,true)
  end
  --print("attack anyways")
  -- might finish off some stuff (against monsters with a protection count)
  -- but might also attack into battle-immune targets for no reason.
  SortByATK(cards,true)
  if #targets>0 and #cards>0 then
    for i,c in pairs(cards) do
      if CanAttackSafely(c,targets)
      and CardsMatchingFilter(targets,function(target)
        return not (FilterAffected(target,EFFECT_CANNOT_BE_BATTLE_TARGET)
        or FilterAffected(target,EFFECT_CANNOT_SELECT_BATTLE_TARGET)
        or FilterAffected(target,EFFECT_INDESTRUCTABLE_BATTLE))
        and (FilterPosition(target,POS_FACEUP_ATTACK)
        or c.attack>target.defense)
      end)>0
      then
        return Attack(i)
      end
    end
  end
  --print("forced")
  -- forced to attack
  SortByATK(cards)
  for i=1,#cards do
    if cards[i] and cards[i]:is_affected_by(EFFECT_MUST_ATTACK)>0 then
      return Attack(i)
    end
  end
  --print("not attack")
  
---
-- activate cards 
---
  GlobalBPEnd = true
  if HasID(activatable,60202749) and UseSphereBP() then
    return 2,CurrentIndex
  end
  if HasID(activatable,97077563) and UseCotHBP() then
    return 2,CurrentIndex
  end
  if HasID(activatable,03580032) and UseMerlinBP() then
    return 2,CurrentIndex
  end
  if HasID(activatable,77778835,ChainParty) then
    return 2,CurrentIndex
  end
  if HasID(activatable,83555666,ChainRoD) then -- Ring of Destruction
    return 2,CurrentIndex
  end
  if HasID(activatable,83555666,ChainRoD) then -- Ring of Destruction
    return 2,CurrentIndex
  end
  local result,result2 = nil,nil
  local d = DeckCheck()
  if d and d.Chain then
    result,result2 = d.Chain(activatable,nil)
  end
  if result ~= nil then
    if type(result)=="table" then
      return 2,result[2]
    else
      return 2,result2
    end
  end
  result = HEROChain(activatable)
  if result then
    if type(result)=="table" then
      return 2,result[2]
    else
      return 2,result2
    end
  end
  GlobalBPEnd = false
  -------------------------------------
  -- If it gets this far, don't attack.
  -------------------------------------
  return 0,0

end
--[[
78371393,04779091,31764700, -- Yubel 1,2 and 3
54366836,88241506,23998625, -- Lion Heart, Maiden with the Eyes of Blue, Heart-eartH
80344569,68535320,95929069, -- Grand Mole, Fire Hand, Ice Hand
74530899, -- Metaion
]]
function AttackIceHand(c,source)
  return not MacroCheck(2)
  or DestroyCheck(AIST())<1
  or ArmadesCheck(source)
  or CardsMatchingFilter(AIMon(),FilterAttackMin,1500)>2
end
function AttackFireHand(c,source)
  return not MacroCheck(2)
  or DestroyCheck(AIMon())<1
  or ArmadesCheck(source)
  or StareaterCheck(source)
  or CardsMatchingFilter(AIMon(),FilterAttackMin,1500)>2
end
function AttackYubel(c,source)
  return Negated(c)
  or ArmadesCheck(source)
  or StareaterCheck(source)
  or not Affected(source,TYPE_MONSTER,c.level)
end
function AttackMaiden(c,source)
  return Negated(c)
  or ArmadesCheck(source)
  or FilterPosition(c,POS_DEFENSE)
  or CardsMatchingFilter(AIMon(),FilterAttackMin,3000)>0
  or not DualityCheck(2)
end
function AttackMole(c,source)
  return Negated(c)
  or not source
  or ArmadesCheck(source)
  or StareaterCheck(source)
  or CardsMatchingFilter(AIMon(),FilterAttackMin,1500)>1
  or not Affected(source,TYPE_MONSTER,c.level)
end
function AttackMetaion(c,source)
  return Negated(c)
  or ArmadesCheck(source)
  or StareaterCheck(source)
end
function AttackCatastor(c,source)
  return Negated(c)
  or ArmadesCheck(source)
  or StareaterCheck(source)
  or FilterAttribute(source,ATTRIBUTE_DARK)
  or not Affected(source,TYPE_MONSTER,c.level)
end
function AttackConstruct(c,source)
  return Negated(c)
  or ArmadesCheck(source)
  or StareaterCheck(source)
  or not FilterSummon(source,SUMMON_TYPE_SPECIAL)
  or not Affected(source,TYPE_MONSTER,c.level)
end
function AttackF0(c,source)
  return Negated(c)
  or ArmadesCheck(source)
  or StareaterCheck(source) 
  or not Affected(source,TYPE_MONSTER,c.level)
end
function AttackFirstOfDragons(c,source)
  return FilterType(source,TYPE_NORMAL)
  or Negated(c)
end
function SelectAttackConditions(c,source) 
  if c.id == 95929069 then
    return AttackIceHand(c,source)
  end
  if c.id == 68535320 then
    return AttackFireHand(c,source)
  end
  if c.id == 78371393 or c.id == 04779091 or c.id == 31764700 then -- Yubel 1,2 and 3
    return AttackYubel(c,source)
  end
  if c.id == 88241506 then
    return AttackMaiden(c,source)
  end
  if c.id == 80344569 then
    return AttackMole(c,source)
  end
  if c.id == 74530899 then
    return AttackMetaion(c,source)
  end
  if c.id == 26593852 then
    return AttackCatastor(c,source)
  end
  if c.id == 20366274 then
    return AttackConstruct(c,source)
  end
  if c.id == 65305468 then
    return AttackF0(c,source)
  end
  if c.id == 10817524 then
    return AttackFirstOfDragons(c,source)
  end
  return true
end
  
