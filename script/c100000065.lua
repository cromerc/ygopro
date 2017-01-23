--グランエルＣ 
function c100000065.initial_effect(c)
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c100000065.sdcon2)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCountLimit(1)
	e2:SetTarget(c100000065.tg)
	e2:SetValue(c100000065.valcon)
	c:RegisterEffect(e2)
end
function c100000065.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000065.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c100000065.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)==0
end
function c100000065.tg(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c100000065.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
