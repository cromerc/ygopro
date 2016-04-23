function CthStartup(deck)
	AI.Chat("Cth AI ver -3.0.0")
	AI.Chat("produced by Ildana & Satone")
	deck.Init = CthOnSelectInit
	deck.Card = CthOnSelectCard
	deck.Chain = CthOnSelectChain
	deck.EffectYesNo = CthOnSelectEffectYesNo
	deck.Position = CthOnSelectPosition
	deck.Option = CthOnSelectOption
--	deck.ActivateBlackList = CthActivateBlackList
--	deck.SummonBlackList = CthSummonBlackList
	deck.PriorityList = CthPriorityList
     local e1=Effect.GlobalEffect()
     e1:SetType(EFFECT_TYPE_FIELD)
     e1:SetCode(EFFECT_PUBLIC)
     e1:SetTargetRange(LOCATION_HAND,0)
     --Duel.RegisterEffect(e1,player_ai)
end
DECK_CTH = NewDeck("Cth",12948099,CthStartup)
CthPriorityList={
[15839054] = {1,1,-10,1,9.5,1,1,1,-10,1,nil},
[17412721] = {1,1,6,1,1.5,1,1,1,1,1,nil},
[11066358] = {1,1,0.5,1,1,1,1,1,1,1,nil},
[28985331] = {13,1,1,1,5,1,1,1,1,1,nil},
[12948099] = {1,1,2,1,2,1,0.5,1,1,1,nil},
[15981690] = {1,1,-10,1,10,1,1,1,1,1,nil},
[74694807] = {3,1,1,1,1,1,1,1,1,1,nil},
[67556500] = {1,1,1,1,-99,1,-99,1,1,1,nil},
[35952884] = {1,1,1,1,1,1,-99,1,1,1,nil},
[10443957] = {1,1,1,1,1,1,-99,1,1,1,nil},
}
function AssignCthFusSub(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index=i
		c.prio=GetPriority(c,PRIO_DISCARD)
		if c.level>4 then
			c.prio=-99
		end
		if c.rank>4 then
			c.prio=-99
		end
		if bit32.band(c.type,TYPE_XYZ+TYPE_SYNCHRO)==0 then
			c.prio=-99
		end
	end
end
function UseCthFusSub(cards,count)
	AssignCthFusSub(cards)
	table.sort(cards,function(a,b) return a.prio>b.prio end)
	return cards[count].prio>0
end
function AssignCthSC(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index=i
		c.prio=GetPriority(c,PRIO_TOFIELD)
		if bit32.band(c.type,TYPE_MONSTER)==0 or c.id == 8903700 or c.rank == 4 then
			c.prio=-99
		end
	end
end
function UseCthSC(cards,count)
	AssignCthSC(cards)
	table.sort(cards,function(a,b) return a.prio>b.prio end)
	return cards[count].prio>0
end
function AssignCthXyz(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index=i
		c.prio=GetPriority(c,PRIO_TOGRAVE)
		if c.level~=4 then
			c.prio=-99
		end
	end
end
function UseCthXyz(cards,count)
	AssignCthXyz(cards)
	table.sort(cards,function(a,b) return a.prio>b.prio end)
	return cards[count].prio>0
end
function UseCthDraw()
	return #AIDeck()>1 and #AIMon()<5
end
function CthRebornFilter(c)
	return bit32.band(c.type,TYPE_MONSTER)>0
end
function CthOnSelectInit(cards,to_bp_allowed,to_ep_allowed)
	local Activatable = cards.activatable_cards
	local Summonable = cards.summonable_cards
	local SpSummonable = cards.spsummonable_cards
	local SetableMon = cards.monster_setable_cards
	local SetableST = cards.st_setable_cards
	if CthVoid and CthVoidCount ~= Duel.GetTurnCount() then
		CthVoid = false
	end
	if HasID(Activatable,32807846) and not HasID(AIDeck(),99185129,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,54719828) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,18144506) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,99185129,false,99185129*16) and HasID(AIGrave(),79606837,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSummonable,79606837) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSummonable,12948099) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSummonable,67556500) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(Activatable,1845204) and (HasID(AIGrave(),11066358,true) or HasID(AIMon(),28985331,true)) and HasID(AIGrave(),15839054,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,74694807) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,24094653,false,nil,LOCATION_HAND) and UseCthFusSub(AIMon(),2) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,581014,false,581014*16+2) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSummonable,581014) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(Activatable,74845897) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,54447022) and UseCthSC(AIGrave(),1) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,83764718) and UseCthSC(AIGrave(),1) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSummonable,10443957) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSummonable,18326736) and UseCthXyz(AIMon(),3) then
		CthPtolemai = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSummonable,35952884) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSummonable,54719828) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(Activatable,34086406,false,34086406*16+1) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SpSummonable,34086406) and UseCthXyz(AIMon(),2) and HasID(AIDeck(),8903700,true) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(SpSummonable,82633039) and UseCthXyz(AIMon(),2) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(Summonable,28985331) and (HasID(Activatable,15981690,true) or HasID(Activatable,81439173,true) or HasID(AIMon(),11066358,true)) and (HasID(Activatable,54447022,true) or HasID(Activatable,83764718,true) or HasID(Activatable,1845204,true)) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Activatable,32807846) and (HasID(Activatable,15981690,true) or HasID(Activatable,81439173,true) or HasID(AIMon(),11066358,true)) and (HasID(Activatable,54447022,true) or HasID(Activatable,83764718,true) or HasID(Activatable,1845204,true)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Summonable,15839054) and HasID(AIMon(),11066358,true) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Activatable,81439173) and (HasID(Summonable,15839054,true) or HasID(AIMon(),15839054,true)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,15981690) and (HasID(Summonable,15839054,true) or HasID(AIMon(),15839054,true)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,911883) and HasID(Summonable,15839054,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,911883) and (HasID(Summonable,28985331,true) or HasID(Activatable,32807846,true)) and (HasID(Activatable,54447022,true) or HasID(Activatable,83764718,true) or HasID(Activatable,1845204,true)) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,70368879) and UseCthDraw() then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,33782437) and UseCthDraw() then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,74117290) and UseCthDraw() and not HasID(Activatable,72892473,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,24094653,false,nil,LOCATION_GRAVE) and UseCthDraw() then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,93946239) and UseCthDraw() then
		CthVoid = true
		CthVoidCount = Duel.GetTurnCount()
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Summonable,15839054) and HasID(Activatable,72892473,true) and HasID(AIHand(),15981690,true) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(SetableST,1845204) and HasID(Activatable,72892473,true) then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,97211663) and HasID(AIMon(),10443957,true) then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(Activatable,72892473) and UseCthDraw() and #AIHand()<#AIDeck()+1 then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Activatable,97211663) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(SetableMon,8903700) then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	if HasID(SetableMon,15981690) then
		return {COMMAND_SET_MONSTER,CurrentIndex}
	end
	if HasID(SetableST,18144506) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,54447022) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,83764718) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,1845204) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,74845897) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,74694807) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,81439173) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,911883) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,97211663) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,32807846) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,24094653) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,93946239) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	if HasID(SetableST,98494543) and CthVoid then
		return {COMMAND_SET_ST,CurrentIndex}
	end
	return {COMMAND_TO_NEXT_PHASE,1}
end
function CthNodenTarget(cards)
  if HasID(cards,15839054) and HasID(AIExtra(),581014,true) then
    return {CurrentIndex}
  elseif HasID(cards,12948099) then
    return {CurrentIndex}
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function CthLavChainTarget(cards)
  if HasID(cards,8903700) then
    return {CurrentIndex}
  else
    return Add(cards,PRIO_TOGRAVE)
  end
end
function CthRebornTarget(cards)
  if HasID(cards,17412721) and #AIMon()<4 then
    return {CurrentIndex}
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function CthCycleTarget(cards)
  if HasID(cards,8903700) then
    return {CurrentIndex}
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function CthArmaTarget(cards)
  if HasID(cards,15839054) then
    return {CurrentIndex}
  else
    return Add(cards,PRIO_TOFIELD)
  end
end
function CthSoulChargeTarget(cards,max)
	return Add(cards,PRIO_TOFIELD,max)
end
cthdwd={}
function SetCthDWDPriority(cards)
	cthdwd[911883]=0
	cthdwd[15839054]=0
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = 0
		if c.id == 15981690 then
			c.prio = 50
		end
		if c.id == 8903700 then
			c.prio = 49
		end
		if c.id == 99185129 then
			c.prio = 48
		end
		if c.id == 911883 then
			if cthdwd[c.id] == 0 then
				cthdwd[c.id] = 1
			else
				c.prio = 47
			end
		end
		if c.id == 11066358 and not HasID(AIGrave(),c.id,true) then
			c.prio = 46
		end
		if c.id == 15839054 then
			if cthdwd[c.id] == 0 then
				cthdwd[c.id] = 1
			else
				c.prio = 45
			end
		end
		if c.id == 18144506 then
			c.prio = 44
		end
		if c.id == 24094653 then
			c.prio = 43
		end
		if c.id == 98494543 then
			c.prio = 42
		end
		if c.id == 74694807 and not HasID(AIGrave(),c.id,true) then
			c.prio = 41
		end
		if c.id == 74845897 then
			c.prio = 40
		end
		if c.id == 74117290 then
			c.prio = 39
		end
		if c.id == 93946239 then
			c.prio = 38
		end
	end
end
function CthDWDDiscard(cards,count)
	local result={}
	SetCthDWDPriority(cards)
	if cards and #cards>0 then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		for i=1,count do
			result[i]=cards[i].index
		end
	end
	return result
end
function CthDWDTarget(cards,count)
	local result = nil
	result = CthDWDDiscard(cards,count)
	if result == nil then
		result = {}
		for i=1,count do
			result[i]=i
		end
	end
	return result
end
function CthOnSelectCard(cards, minTargets, maxTargets,ID,triggeringCard)
	if ID == 15839054 then
		return Add(cards,PRIO_TOHAND,maxTargets)
	end
	if ID == 81439173 or ID == 54719828 then
		return Add(cards,PRIO_TOGRAVE,maxTargets)
	end
	if ID == 24094653 then
		return Add(cards,PRIO_DISCARD,maxTargets)
	end
	if ID == 54447022 then
		local x = maxTargets
		if HasID(AIGrave(),17412721,true) and x>1 then
			x = x-1
		end
		return CthSoulChargeTarget(cards,x)
	end
	if ID == 34086406 then
		return CthLavChainTarget(cards)
	end
	if ID == 17412721 then
		return CthNodenTarget(cards)
	end
	if ID == 83764718 then
		return CthRebornTarget(cards)
	end
	if ID == 97211663 then
		return CthCycleTarget(cards)
	end
	if ID == 28985331 then
		return CthArmaTarget(cards)
	end
	if ID == 74117290 then
		return CthDWDTarget(cards,1)
	end
	if CthPtolemai then
		CthPtolemai = false
		local x = maxTargets
		if HasID(AIMon(),67556500,true) then
			x = x-1
		end
		return Add(cards,PRIO_TOGRAVE,x)
	end
	return nil
end
function CthOnSelectEffectYesNo(id,triggeringCard)
	if id == 67556500 then
		return 0
	end
	return nil
end
function CthNeverChain()
	local cc = Duel.GetCurrentChain()
	local p = Duel.GetChainInfo(cc,CHAININFO_TRIGGERING_PLAYER)
	if p == player_ai then
		return true
	end
	return false
end
function CthOnSelectChain(cards)
	if HasID(cards,79606837) and CthNeverChain() then
		return {0,CurrentIndex}
	end
	return nil
end
function CthOnSelectOption(options)
	for i=1,#options do
		if options[i] == 72 and Duel.GetTurnCount()<3 then
			return i
		end
		if options[i] == 71 and Duel.GetTurnCount()>2 then
			return i
		end
	end
	return nil
end
CthAtt={67556500,12948099}
CthDef={15839054,79606837,11066358}
function CthGetPos(id)
  result = nil
  for i=1,#CthAtt do
    if CthAtt[i]==id then return POS_FACEUP_ATTACK end
  end
  for i=1,#CthDef do
    if CthDef[i]==id then return POS_FACEUP_DEFENCE end
  end
  return result
end
function CthOnSelectPosition(id, available)
	return CthGetPos(id)
end