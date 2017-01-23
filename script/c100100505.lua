--Ｓｐ－トルネード
function c100100505.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100505.condition)
	e1:SetTarget(c100100505.target)
	e1:SetOperation(c100100505.activate)
	c:RegisterEffect(e1)
end
function c100100505.cfilter(c)
	return c:GetSequence()~=5
end
function c100100505.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return Duel.IsExistingMatchingCard(c100100505.cfilter,tp,0,LOCATION_SZONE,3,nil)
		and tc and tc:GetCounter(0x91)>1
end
function c100100505.filter(c)
	return c:IsDestructable() and c:GetSequence()~=5
end
function c100100505.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and c100100505.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100100505.filter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100100505.filter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100100505.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
