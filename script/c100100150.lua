--アクセル・ゾーン
function c100100150.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c100100150.condition)
	e1:SetOperation(c100100150.activate)
	c:RegisterEffect(e1)
end
function c100100150.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return rp~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE)
	 and re:GetHandler():IsSetCard(0x200) and tc and tc:GetCounter(0x91)<7
end
function c100100150.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if not tc then return end
	tc:RegisterFlagEffect(100100103,RESET_EVENT+RESET_CHAIN,0,1)
	tc:AddCounter(0x91,6)
end