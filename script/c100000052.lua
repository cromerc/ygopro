--ワイゼルＡ 
function c100000052.initial_effect(c)
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c100000052.sdcon2)
	c:RegisterEffect(e1)
end
function c100000052.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000052.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c100000052.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end