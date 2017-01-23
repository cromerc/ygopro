--機皇創世
function c100000068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c100000068.condition)
	e1:SetCost(c100000068.cost)
	e1:SetTarget(c100000068.target)
	e1:SetOperation(c100000068.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000068.decon)
	e2:SetTarget(c100000068.destg)
	e2:SetValue(c100000068.value)
	e2:SetOperation(c100000068.desop)
	c:RegisterEffect(e2)
end
function c100000068.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,false) and c:IsCode(63468625)
end
function c100000068.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000068.filter,tp,0x13,0,1,nil,e,tp)
end
function c100000068.costfilter(c,code)
	return c:GetCode()==code and c:IsFaceup() and c:IsAbleToRemoveAsCost()
end
function c100000068.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000068.costfilter,tp,LOCATION_GRAVE,0,1,nil,100000055)
 		and Duel.IsExistingMatchingCard(c100000068.costfilter,tp,LOCATION_GRAVE,0,1,nil,100000066)
		and Duel.IsExistingMatchingCard(c100000068.costfilter,tp,LOCATION_GRAVE,0,1,nil,100000067) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREMOVE)
	local g1=Duel.SelectMatchingCard(tp,c100000068.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,100000055)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c100000068.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,100000066)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c100000068.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,100000067)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c100000068.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000068.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000068.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,c100000068.filter,tp,0x13,0,1,1,nil,e,tp):GetFirst()
		if Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)==0 then return end
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(c100000068.eqlimit)
		e1:SetReset(RESET_EVENT+0x1fe0000)		
		c:RegisterEffect(e1)
	end
end
function c100000068.eqlimit(e,c)
	return c:GetCode()==63468625
end
c100000068.collection={
	[39648965]=true;[68140974]=true; --Wisel
	[75733063]=true;[31930787]=true; --Skiel
	[2137678]=true;[4545683]=true; --Granel
}
function c100000068.cosqli(c)
	return c:IsAbleToRemove() and (c:IsSetCard(0x300) or c100000068.collection[c:GetCode()])
end
function c100000068.cosqli2(c,e)
	return c==e:GetHandler():GetEquipTarget()
end
function c100000068.decon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c100000068.cosqli,c:GetControler(),LOCATION_GRAVE,0,1,nil)
end
function c100000068.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return eg:IsExists(c100000068.cosqli2,1,nil,e)
	end
	return Duel.SelectYesNo(tp,aux.Stringid(100000068,0))
end
function c100000068.value(e,c)
	return c==e:GetHandler():GetEquipTarget()
end
function c100000068.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(c:GetControler(),c100000068.cosqli,c:GetControler(),LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
