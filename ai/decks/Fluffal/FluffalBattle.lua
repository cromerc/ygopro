------------------------
-------- BATTLE --------
------------------------
FluffalAtt={
39246582, -- Fluffal Dog
13241004, -- Fluffal Penguin
97567736, -- Edge Imp Tomahawk

91034681, -- Frightfur Daredevil
80889750, -- Frightfur Sabre-Tooth
40636712, -- Frightfur Kraken
10383554, -- Frightfur Leo
85545073, -- Frightfur Bear
11039171, -- Frightfur Wolf
00464362, -- Frightfur Tiger
57477163, -- Frightfur Sheep
41209827, -- Starve Venom Fusion Dragon
42110604, -- Hi-Speedroid Chanbara
83531441, -- Dante
}
FluffalDef={
98280324, -- Fluffal Sheep
87246309, -- Fluffal Octo
02729285, -- Fluffal Cat
38124994, -- Fluffal Rabit
06142488, -- Fluffal Mouse
72413000, -- Fluffal Wings
81481818, -- Fluffal Patchwork
79109599, -- King of the Swamp
06205579, -- Parasite Fusioner
67441435, -- Glow-Up Bulb
}
function FluffalPosition(id,available) -- FLUFFAL POSITION
  result = nil
  for i=1,#FluffalAtt do
    if FluffalAtt[i]==id
    then
      result = POS_FACEUP_ATTACK
    end
  end
  for i=1,#FluffalDef do
    if FluffalDef[i]==id
    then
      result = 4 -- POS_FACEUP_DEFENSE?
    end
  end

  if id == 57477163 and GlobalIFusion == 1 then -- FSheep by IFusion
    return 4 -- POS_FACEUP_DEFENSE?
  end

  if id == 57477163 then -- FSheep
      local frightfurAtk = 2000 + FrightfurBoost(id)
	  --print("FSheep - Atk: "..frightfurAtk)
      if FluffalCanAttack(OppMon(),frightfurAtk) == 0
	  and FluffalCannotAttack(OppMon(),frightfurAtk,FilterPosition,POS_FACEUP_ATTACK) > 0
	  and frightfurAtk < 3200
	  then
        result = 4 -- POS_FACEUP_DEFENSE?
	  else
	    result = 1 -- POS_FACEUP_ATTACK
      end
  end

  if id == 40636712 then -- FKraken
	local frightfurAtk = 2200 + FrightfurBoost(40636712)
	print("FKraken Atk: "..frightfurAtk)
	if frightfurAtk < 3000
	and #OppMon() == 1
	and CardsMatchingFilter(OppMon(),FKrakenSendFilter) > 0
	and AIGetStrongestAttack() <= OppGetStrongestAttDef()
	and frightfurAtk <= OppGetStrongestAttDef()
	or
	#OppMon() > 1
	and FluffalCanAttack(OppMon(),frightfurAtk) == 0
	or
	not BattlePhaseCheck()
	and frightfurAtk < 3000
	then
	  result = 4 -- POS_FACEUP_DEFENSE?
	end
  end

  if (not BattlePhaseCheck() or AI.GetCurrentPhase() == PHASE_MAIN2)
  and (
    id == 65331686 -- Owl
    or id == 61173621 -- Chain
	or id == 30068120 -- Sabres
	or id == 40636712 -- FKraken
	or id == 83531441 -- Dante
  )
  then
    result = 4 -- POS_FACEUP_DEFENSE?
  end

  if id == 03113836 -- GKSeraphinite
  and GlobalEffectId == 07394770 -- BFusion
  then
    result = 4
  end
  return result
end

function FluffalBattleCommand(cards,activatable)  -- FLUFFAL BATTLE COMMAND
  ApplyATKBoosts(cards)
  for i=1,#cards do
    cards[i].index = i
  end

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
  -- Frightfur Attack
  if HasIDNotNegated(cards,57477163) -- FSheep
  and CardsMatchingFilter(OppST(),FilterPosition,POS_FACEDOWN) > 0
  and (
    CanWinBattle(cards[CurrentIndex],targets,false,false)
	or #targets == 0
  )
  then
    return Attack(IndexByID(cards,57477163))
  end
  if HasIDNotNegated(cards,85545073) -- FBear
  and CanWinBattle(cards[CurrentIndex],targets,true,false)
  then
    return Attack(IndexByID(cards,85545073))
  end
  if HasIDNotNegated(cards,10383554) -- FLeo
  and CanWinBattle(cards[CurrentIndex],targets,false,false)
  then
    return Attack(IndexByID(cards,10383554))
  end
  if HasIDNotNegated(cards,40636712) -- FKraken
  and CanWinBattle(cards[CurrentIndex],targets,false,false)
  and cards[CurrentIndex]:is_affected_by(EFFECT_CANNOT_DIRECT_ATTACK) > 0
  then
    return Attack(IndexByID(cards,40636712))
  end
  if HasIDNotNegated(cards,57477163) -- FSheep
  and (
    CanWinBattle(cards[CurrentIndex],targets,false,false)
	or #targets == 0
  )
  then
    return Attack(IndexByID(cards,57477163))
  end
  if HasIDNotNegated(cards,91034681) -- FDaredevil
  and CanWinBattle(cards[CurrentIndex],targets,false,false)
  and CardsMatchingFilter(targets,FilterPosition,POS_DEFENSE) == #targets
  then
    return Attack(IndexByID(cards,91034681))
  end
  if HasIDNotNegated(cards,80889750) -- FSabreTooth
  and CanWinBattle(cards[CurrentIndex],targets,false,false)
  and CardsMatchingFilter(targets,FilterPosition,POS_ATTACK) == #targets
  then
    return Attack(IndexByID(cards,80889750))
  end

  return nil
end

function FluffalAttackTarget(cards,attacker)  -- FLUFFAL ATTACK TARGET
  local id = attacker.id
  local result ={attacker}
  --print("1",attacker.id,attacker.attack,attacker.bonus)
  result = {}
  local atk = attacker.attack
  if NotNegated(attacker) then
    -- Frightfur Sheep
    if id == 57477163 and CanWinBattle(attacker,cards,true,false) then
      return FrighfurAttackTarget(cards,attacker,false)
    end
  end
  return nil
end

function FluffalAttackBoost(cards)  -- FLUFFAL BOOST
  for i=1,#cards do
    local c = cards[i]
    if c.id == 42110604 then -- Chanbara
      c.attack = c.attack + 200
    end
	if c.id == 57477163 then -- FSheep
	  local boost = FrightfurBoost(0)
	  if c.attack - boost == c.base_attack
	  and OPTCheck(57477163)
	  and AI.GetPlayerLP(1) > 800
	  and CardsMatchingFilter(OppMon(),FilterPosition,POS_FACEUP_ATTACK) > 0
	  then
	    c.bonus = 800
	    c.attack = c.attack + 800
	  end
	end
  end
end

-- ATTACK FUNCTIONS
function FrighfurAttackTarget(cards,source,ignorebonus,filter,opt)
  local atk = source.attack
  local bonus = 0
  --print("3",source.id,source.attack,source.bonus)
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
	  -- FSheep own boost
	  if source.id == 57477163
	  and OPTCheck(57477163)
	  then
	    if c.attack >= atk-bonus and c.attack <= atk
		then
		  c.prio = c.attack * 9999 - (atk-c.attack)
		end
	  end
    end
    if FilterPosition(c,POS_DEFENSE) then
	  -- FSheep own boost
	  if source.id == 57477163
	  and bonus == 800
	  then
	    if FilterPublic(c) then
          if c.defense<(atk-bonus) then
            c.prio = math.max(c.defense - 1,c.attack)
          else
            c.prio = (atk-bonus) - c.defense
          end
        end
	  else
        if FilterPublic(c) then
          if c.defense<atk then
            c.prio = math.max(c.defense - 1,c.attack)
          else
            c.prio = atk - c.defense
          end
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
  --for i=1,#cards do
    --print(i..") id: "..cards[i].id.." index: "..cards[i].index.." prio: "..cards[i].prio)
  --end
  result={cards[1].index}
  return result
end

function FrightfurBoost(frightfurId)
  local boost = 0
  local frightufs = CountFrightfurMon(AIMon()) + 1 -- Own

  if frightfurId == 80889750 -- FSabreTooth
  then
    if CountFrightfurMon(AIGrave()) > 0 then
      frightufs = frightufs + 1
	  if not HasIDNotNegated(AIMon(),00464362,true) -- FTiger Field
	  and HasIDNotNegated(AIGrave(),00464362,true) -- FTiger Grave
	  then
	    boost = boost + (frightufs * 300)
	  end
	end
	boost = boost + 400
  end

  if frightfurId == 00464362 -- FTiger
  then
    boost = boost + (frightufs * 300)
  end

  if frightfurId == 57477163 -- FSheep
  and CardsMatchingFilter(OppMon(),FilterPosition,POS_ATTACK) > 0
  and OPTCheck(57477163)
  and AI.GetPlayerLP(1) > 800
  then
    boost = boost + 800
  end

  boost = boost + (400 * CardsMatchingFilter(AIMon(),FSabreToothFilter)) --FSabreTooth

  if HasIDNotNegated(AIMon(),00464362,true) -- FTiger
  then
    boost = boost + (frightufs * 300)
  end

  return boost
end

function FluffalCanAttack(cards,attack,filter,opt)
  local result = 0
  for i=1, #cards do
    local c = cards[i]
	if (
	  FilterAttackMax(c,attack-1) and FilterPosition(c,POS_ATTACK)
	  or
	  FilterDefenseMax(c,attack-1) and FilterPosition(c,POS_DEFENSE)
	)
	and FilterCheck(c,filter,opt)
	then
	  result = result + 1
	end
  end
  return result
end
function FluffalCannotAttack(cards,attack,filter,opt)
  local result = 0
  for i=1, #cards do
    local c = cards[i]
	if (
	  FilterAttackMin(c,attack) and FilterPosition(c,POS_ATTACK)
	  or
	  FilterDefenseMin(c,attack) and FilterPosition(c,POS_DEFENSE)
	)
	and FilterCheck(c,filter,opt)
	then
	  result = result + 1
	end
  end
  return result
end

function ExpectedDamageMichelet(player,filter,opt)
  if player == nil then player = 1 end
  local oppMons = {}
  local aiAtts = {}
  local aiHasAttacked = 0

  aiAtts = SubGroup(AIMon(),FilterPosition,POS_ATTACK)
  oppMons = SubGroup(OppMon(),FilterLocation,LOCATION_MZONE)

  if player == 2 then
    aiAtts = SubGroup(OppMon(),FilterPosition,POS_ATTACK)
    oppMons = SubGroup(AIMon(),FilterLocation,LOCATION_MZONE)
  end

  if #aiAtts > 0 then
    table.sort(aiAtts, function(a,b) return a.attack < b.attack end)
  end

  if #oppMons > 0 then
    table.sort(oppMons,
      function(a,b)
	    local attDefA = 0
	    local attDefB = 0
	    if FilterPosition(a,POS_ATTACK) then
	      attDefA = a.attack
	    else
	      attDefA = a.defense
	    end
	    if FilterPosition(b,POS_ATTACK) then
	      attDefB = b.attack
	    else
	      attDefB = b.defense
	    end
	    return attDefA > attDefB
	  end
    )
  end

  local damageExpectedInBattle = 0
  for i=1, #oppMons do
    local oppM = oppMons[i]
	local oppAttDef = oppM.defense

	local dealDamage = false
	if FilterPosition(oppM,POS_ATTACK) then
	  dealDamage = true
	  oppAttDef = oppM.attack
	end

	--print("oppMon - id: "..oppM.id.." - AttDef: "..oppAttDef)

	for j=1, #aiAtts do
	  local aiM = aiAtts[j]
	  local aiAtt = aiM.attack
	  if FilterCheck(aiM,filter,opt) then
	    if not oppM.HasBeenDefeated and not aiM.HasAttacked
	    and AvailableAttacks(aiM) > 0
	    then
	      --print("aiAtt: "..aiAtt.." vs oppAttDef: "..oppAttDef)
	      if aiAtt > oppAttDef then
	        aiM.HasAttacked = true
		    oppM.HasBeenDefeated = true
		    aiHasAttacked = aiHasAttacked + 1
		    if dealDamage then
		      damageExpectedInBattle = damageExpectedInBattle + (aiAtt - oppAttDef)
		    end
	      end
	    end
	  end
	end
	if not oppM.HasBeenDefeated then
	  damageExpectedInBattle = damageExpectedInBattle - oppAttDef
	end
  end

  --print("DamageExpected - In Battle: ".. damageExpectedInBattle)

  local damageExpectedDirect = 0
  if aiHasAttacked >= #oppMons
  or #oppMons == 0
  then
    for j=1, #aiAtts do
	  local aiM = aiAtts[j]
	  local aiAtt = aiM.attack
	  --print("aiMon - id: "..aiM.id.." - Att: "..aiAtt)
	  if FilterCheck(aiM,filter,opt) then
	    if not aiM.HasAttacked
	    and not FilterAffected(aiM,EFFECT_CANNOT_DIRECT_ATTACK)
	    then
	      --print("DirectDamage: "..(aiAtt *  AvailableAttacks(aiM)))
	      damageExpectedDirect = damageExpectedDirect + (aiAtt *  AvailableAttacks(aiM))
	    end
	  end
    end
  end

  --print("DamageExpected - Direct: ".. damageExpectedDirect)

  return damageExpectedInBattle + damageExpectedDirect
end