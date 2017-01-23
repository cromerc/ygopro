--Smoke Mirror
function c511002942.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002942.condition)
	e1:SetTarget(c511002942.target)
	e1:SetOperation(c511002942.activate)
	c:RegisterEffect(e1)
end
function c511002942.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,2,c,c:GetCode())
end
function c511002942.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) 
		and Duel.IsExistingMatchingCard(c511002942.cfilter,tp,LOCATION_GRAVE,0,1,nil,tp)
end
function c511002942.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c511002942.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511002942.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002942.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectMatchingCard(tp,c511002942.filter,tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_DEFENSE)
			e1:SetValue(g:GetFirst():GetAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
