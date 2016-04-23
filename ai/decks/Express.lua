function ExpressStartup(deck)
	AI.Chat("Express AI ver 0.0.1")
	AI.Chat("produced by Satone")
	deck.Init = ExpressInit
	deck.Card = ExpressCard
	deck.Chain = ExpressChain
	deck.EffectYesNo = ExpressEffectYesNo
	deck.Position = ExpressPosition
	deck.Option = ExpressOption
	deck.ActivateBlacklist = ExpressActivateBlacklist
	deck.SummonBlacklist = ExpressSummonBlacklist
	deck.RepositionBlacklist = ExpressRepositionBlacklist
	deck.PriorityList = ExpressPriorityList
end
DECK_EXPRESS = NewDeck("Express",76136345,ExpressStartup)
ExpressActivateBlacklist=
{
18144506,
13647631,
24919805,
73628505,
48130397,
76136345,
49032236,
}
ExpressSummonBlacklist=
{
51126152,
24919805,
3814632,
49032236,
56910167,
}
ExpressRepositionBlacklist=
{
49032236,
}
function SpSumGustavMax()
	return AI.GetPlayerLP(2)<=2000
end
function GangaridaiFilter1(c)
		return FilterPosition(c,POS_FACEUP)
			and c.id == 13647631
end
function GangaridaiFilter2(c)
		return ((c.attack >= 3200 and FilterPosition(c,POS_ATTACK))
			or (c.defense >= 3200 and FilterPosition(c,POS_DEFENCE))
			or c:is_affected_by(EFFECT_INDESTRUCTABLE_BATTLE)
			or (MP2Check() and c.attack > 4000)) and not c:is_affected_by(EFFECT_INDESTRUCTABLE_EFFECT)
end
function SpSumGangaridai()
	return CardsMatchingFilter(AIMon(),GangaridaiFilter1)<1 and CardsMatchingFilter(OppMon(),GangaridaiFilter2)>0
end
function SpSumSuperiorDora()
	return true
end
function ExpressUseShaddollFusion()
	return CardsMatchingFilter(AIMon(),FilterRank,10)<1
		and (CardsMatchingFilter(AIHand(),FilterSet,0x9d)>1
		or (HasID(AIHand(),24919805,true) and Has(AIHand(),23434538,true)))
end
function UseSwitchyard()
	return #AIHand()>1 or not HasID(AIHand(),51126152,true)
end
function ExpressInit(cards)
	local Act = cards.activatable_cards
	local Sum = cards.summonable_cards
	local SpSum = cards.spsummonable_cards
	local Rep = cards.repositionable_cards
	if HasIDNotNegated(Act,56910167) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasIDNotNegated(Act,3814632) and MP2Check() then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasIDNotNegated(Act,18144506) and DestroyCheck(OppST(),true)>1 then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasIDNotNegated(SpSum,56910167) and SpSumGustavMax() then
		GlobalExpressSummon = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasIDNotNegated(SpSum,3814632) and SpSumGangaridai() then
		GlobalExpressSummon = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasIDNotNegated(SpSum,49032236) and SpSumSuperiorDora() then
		GlobalExpressSummon = true
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
	end
	if HasID(Act,73628505) and not HasID(UseLists({AIHand(),AIST()}),76136345,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,76136345,nil,nil,LOCATION_HAND) and #AIHand()>1 and not HasID(AIST(),76136345,true) then
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,44394295) and CardsMatchingFilter(OppMon(),ShaddollFusionFilter)>0 then
		GlobalCardMode = 1
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Sum,51126152) and (HasID(AIHand(),13647631,true)
		or (HasID(AIST(),76136345,true) and OPTCheck(76136345))
		or HasID(AIST(),82732705,true)) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Sum,24919805) and FieldCheck(10)>0 and HasID(AIST(),13647631,true) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Act,44394295) and ExpressUseShaddollFusion() then
		GlobalCardMode = 1
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Act,76136345,nil,nil,LOCATION_SZONE) and UseSwitchyard() then
		OPTSet(76136345)
		ExpressCardMode = 1
		return {COMMAND_ACTIVATE,CurrentIndex}
	end
	if HasID(Sum,24919805) and not HasID(AIHand(),4939890,true) then
		return {COMMAND_SUMMON,CurrentIndex}
	end
	if HasID(Rep,49032236,FilterPosition,POS_ATTACK) and (OppHasStrongestMonster() or MP2Check()) then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	if HasID(Rep,49032236,FilterPosition,POS_DEFENCE) and not OppHasStrongestMonster() then
		return {COMMAND_CHANGE_POS,CurrentIndex}
	end
	return nil
end
function SetExpressXyzPriority(cards)
	for i=1,#cards do
		local c = cards[i]
		c.index = i
		c.prio = - c.attack
	end
end
function ExpressXyzSelection(cards,count)
	local result = nil
	SetExpressXyzPriority(cards)
	if cards and #cards>=count then
		table.sort(cards,function(a,b)return a.prio>b.prio end)
		result = {}
		for i=1,count do
			result[i] = cards[i].index
		end
	end
	return result
end
function ExpressXyzTarget(cards,mi)
	local result = nil
	result = ExpressXyzSelection(cards,mi)
	return result
end
function SuperiorDoraTarget(cards)
	if LocCheck(cards,LOCATION_OVERLAY) then
		return Add(cards,PRIO_DISCARD)
	end
	return GlobalTargetGet(cards,true)
end
function GangaridaiTarget(cards)
	if LocCheck(cards,LOCATION_OVERLAY) then
		return Add(cards,PRIO_DISCARD)
	end
	return BestTargets(cards,1,true)
end
function ExpressSuperpolyTarget(cards,mi)
	if LocCheck(cards,LOCATION_HAND) then
		return Add(cards,PRIO_TOGRAVE)
	end
	if LocCheck(cards,LOCATION_EXTRA) then
		return Add(cards,PRIO_TOFIELD)
	end
	return BestTargets(cards,mi,TARGET_TOGRAVE)
end
function ExpressCard(cards,min,max,id,c)
	if GlobalExpressSummon then
		GlobalExpressSummon = nil
		return ExpressXyzTarget(cards,min)
	end
	if id == 76136345 and ExpressCardMode == 1 then
		ExpressCardMode = nil
		return Add(cards,PRIO_TOGRAVE,max)
	end
	if id == 76136345 and ExpressCardMode == nil then
		return Add(cards,PRIO_TOHAND,max)
	end
	if id == 13647631 then
		if HasID(OppMon(),56832966,true) then
			GlobalTargetSet(Duel.GetFirstMatchingCard(function(c)
				return c:IsCode(56832966)
			end,player_ai,0,LOCATION_SZONE,nil))
			return GlobalTargetGet(cards,true)
		end
		return BestTargets(cards,max,true)
	end
	if id == 49032236 then
		return SuperiorDoraTarget(cards)
	end
	if id == 56910167 then
		return Add(cards,PRIO_DISCARD)
	end
	if id == 3814632 then
		return GangaridaiTarget(cards)
	end
	if id == 48130397 then
		return ExpressSuperpolyTarget(cards,min)
	end
	return nil
end
function RemovalCheckDora(target,category,type,chainlink,filter,opt)
	if Duel.GetCurrentChain() == 0 then return false end
	local cat={CATEGORY_DESTROY,CATEGORY_REMOVE,
	CATEGORY_TOGRAVE,CATEGORY_TOHAND,
	CATEGORY_TODECK,CATEGORY_CONTROL,CATEGORY_POSITION}
	if card and filter and (opt and not filter(card,opt)
	or opt==nil and not filter(card))
	then
		return false
	end
	if category then cat={category} end
	local a=1
	local b=Duel.GetCurrentChain()
	if chainlink then
		a=chainlink
		b=chainlink
	end
	for i=1,#cat do
		for j=a,b do
			local ex,cg = Duel.GetOperationInfo(j,cat[i])
			local e = Duel.GetChainInfo(j,CHAININFO_TRIGGERING_EFFECT)
			if ex and CheckNegated(j) and (type==nil
			or e and e:GetHandler():IsType(type))
			then
				if target==nil then 
					return cg
				end
				if cg and target then
					local card=false
					cg:ForEach(function(c) 
					local c=GetCardFromScript(c,Field())
					if CardsEqual(c,target) then
						card=c
					end  end) 
					return card
				end
			end
		end
	end
	return false
end
function ChainSuperiorDora(card)
	if RemovalCheckDora(card) then
		GlobalTargetSet(card,AIMon())
		return true
	end
	if HasID(OppMon(),56832966,true) then
		local materials = card.xyz_materials
		for i=1,#materials do
			if materials[i].id == 13647631 then
				return true
			end
		end
	end
	return false
end
function ExpressChainSuperpoly()
	if CardsMatchingFilter(OppMon(),FilterType,TYPE_SYNCHRO+TYPE_XYZ)>1 then
		return true
	end
	if CardsMatchingFilter(OppMon(),FilterAttribute,ATTRIBUTE_LIGHT+ATTRIBUTE_EARTH+ATTRIBUTE_DARK+ATTRIBUTE_WATER)>0 then
		return true
	end
	if CardsMatchingFilter(OppMon(),FilterSet,0x8)>0 then
		return true
	end
	return false
end
function ExpressSkillFilter(c)
	return FilterRank(c,10) and c.xyz_material_count>0
end
function QliphortAttackBonus(id,level,c)
	if level == 4 then
		if id == 90885155 or id == 64496451 
		or id == 13073850
		then
			return 1000
		elseif id == 37991342 or id == 91907707 then
			return 600
		end
	end
	if c and c:IsHasEffect(EFFECT_SET_BASE_ATTACK) then
		if id == 51126152 then
			return 3000
		elseif id == 13647631 then
			return 1400
		end
	end
	return 0
end
function ChainSkillDrain(card)
	if CardsMatchingFilter(AIMon(),ExpressSkillFilter)>0 then
		return false
	end
	local c = ChainCardNegation(card,false,false,FilterType,TYPE_MONSTER)
	if c then
		return true
	end
	if Duel.GetCurrentPhase() == PHASE_BATTLE then
		if Duel.GetTurnPlayer()==player_ai 
		and not OppHasStrongestMonster() 
		and CardsMatchingFilter(OppMon(),NegateBPCheck)>0 
		then
			return true
		end
		local source = Duel.GetAttacker()
		local target = Duel.GetAttackTarget()
		if source and target then
			if source:IsControler(player_ai) then
				target = Duel.GetAttacker()
				source = Duel.GetAttackTarget()
			end
			if target:IsControler(player_ai)
			and (source:IsPosition(POS_FACEUP_ATTACK) 
			and source:GetAttack() >= target:GetAttack() 
			and source:GetAttack() <= target:GetAttack()+QliphortAttackBonus(target:GetCode(),target:GetLevel(),target)
			and not (source:GetAttack() == target:GetAttack() 
			and QliphortAttackBonus(target:GetCode(),target:GetLevel(),target)==0)
			or source:IsPosition(POS_FACEUP_DEFENCE)
			and source:GetDefence() >= target:GetAttack() 
			and source:GetDefence() < target:GetAttack()+QliphortAttackBonus(target:GetCode(),target:GetLevel(),target))
			and target:IsPosition(POS_FACEUP_ATTACK) 
			then
				return true
			end
		end
	end
	return false
end
function ExpressChainChalice()
	local e = Duel.GetChainInfo(Duel.GetCurrentChain(), CHAININFO_TRIGGERING_EFFECT)
	if e then
		local c = e:GetHandler()
	end
	if c and (c:GetCode()==27243130 or c:GetCode()==37742478) then
		return false
	end
	local source = Duel.GetAttacker()
	local target = Duel.GetAttackTarget()
	if source and target then
		if source:IsControler(player_ai) then
			target = Duel.GetAttacker()
			source = Duel.GetAttackTarget()
		end
	end
	if Duel.GetCurrentPhase() == PHASE_DAMAGE and source and target then
		if source:GetAttack() >= target:GetAttack() 
		and source:GetAttack() <= target:GetAttack()+QliphortAttackBonus(target:GetCode(),target:GetLevel(),target)+400 
		and source:IsPosition(POS_FACEUP_ATTACK) and target:IsPosition(POS_FACEUP_ATTACK) and target:IsControler(player_ai)
		and (not target:IsHasEffect(EFFECT_IMMUNE_EFFECT) or target:IsSetCard(0xaa) and target:GetCode()~=27279764)
		then
			GlobalTargetSet(target,AIMon())
			return true
		end
	end
	return false
end
function ExpressChain(cards)
	if HasID(cards,24919805) then
		return {1,CurrentIndex}
	end
	if HasID(cards,49032236,ChainSuperiorDora) then
		return {1,CurrentIndex}
	end
	if HasID(cards,48130397,ExpressChainSuperPoly) then
		return {1,CurrentIndex}
	end
	if HasID(cards,25789292,ExpressChainChalice) then
		return {1,CurrentIndex}
	end
	if HasID(cards,13647631,FilterLocation,LOCATION_HAND) and FieldCheck(10)>0 then
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,74822425,ChainNegation) then
		return {1,CurrentIndex}
	end
	return nil
end
function ExpressOption(opt)
	for i=1,#opt do
		if opt[i] == 51126152 * 16 then
			return i
		end
	end
	return nil
end
function SuperiorDoraPosFilter(c)
	return c.attack >= 3200
end
function ExpressPosition(id,available)
	local result = nil
	if id == 49032236 and (CardsMatchingFilter(OppMon(),SuperiorDoraPosFilter)>0
		or AI.GetCurrentPhase() == PHASE_MAIN2 or Duel.GetTurnCount() ==1
		or not GlobalBPAllowed) then
		result = POS_FACEUP_DEFENCE
	end
	return result
end
function ExpressEffectYesNo(id,card)
	local result = nil
	if id == 76136345 or id == 13647631 or id == 74822425 then
		result = 1
	end
	return result
end
function NEKCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(AIHand(),51126152,true)
	end
	return true
end
function DerricCond(loc,c)
	if loc == PRIO_TOHAND then
		return not HasID(AIHand(),13647631,true)
	end
	if loc == PRIO_DISCARD then
		return DestroyCheck(OppField(),true)>0
	end
	return true
end
function BattrainGraveFilter(c)
	return c.id == 24919805
		and c.turnid == Duel.GetTurnCount()
end
function BattrainCond(loc,c)
	if loc == PRIO_GRAVE or loc == PRIO_DISCARD then
		return CardsMatchingFilter(AIGrave(),BattrainGraveFilter)==0
	end
	return true
end
function ExpressNagaCond(loc,c)
	if loc == PRIO_TOFIELD then
		return CardsMatchingFilter(OppMon(),ShaddollFusionFilter)>0
			or (HasID(AIHand(),24919805,true) and HasID(AIHand(),23434538,true))
	end
	return true
end
function ExpressNodenCond(loc,c)
	if loc == PRIO_TOFIELD then
		return CardsMatchingFilter(OppMon(),FilterType,TYPE_SYNCHRO+TYPE_XYZ)>1
	end
	return true
end
ExpressPriorityList={
[51126152] = {12,8,1,1,-1,1,0,1,1,1,NEKCond},
[13647631] = {11,7,1,1,-1,1,12,-1,1,1,DerricCond},
[24919805] = {1,1,1,1,12,-1,11,-1,1,1,Battraincond},
[76136345] = {1,1,1,1,-1,1,1,1,1,1,nil},
[74822425] = {1,1,9,3,1,1,1,1,1,1,ExpressNagaCond},
[49032236] = {1,1,1,1,-12,1,1,1,1,1,nil},
[19261966] = {1,1,10,4,1,1,1,1,1,1,nil},
[45170821] = {1,1,11,5,1,1,1,1,1,1,nil},
[22061412] = {1,1,12,6,1,1,1,1,1,1,nil},
[17412721] = {1,1,13,1,1,1,1,1,1,1,ExpressNodenCond},
}