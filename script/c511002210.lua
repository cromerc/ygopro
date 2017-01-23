--シャーマン・コール
function c511002210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002210.condition)
	e1:SetOperation(c511002210.activate)
	c:RegisterEffect(e1)
end
function c511002210.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0x26)
end
function c511002210.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002210.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c511002210.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002210.cfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
