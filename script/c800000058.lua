--ナンバーズ・ウォール
function c800000058.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCondition(c800000058.regcon)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)	
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c800000058.infilter)
	e2:SetValue(c800000058.indes)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Destroy2
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c800000058.descon2)
	e4:SetOperation(c800000058.desop2)
	c:RegisterEffect(e4)
end
function c800000058.csfilter(c)
	return not c:IsSetCard(0x48)
end
function c800000058.regcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c800000058.csfilter,tp,LOCATION_MZONE,0,1,nil) 
	and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,0,1,nil,0x48) 
end
function c800000058.infilter(e,c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_MONSTER)
end
function c800000058.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c800000058.cfilter(c,tp)
	return c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY) and c:IsSetCard(0x48)
end
function c800000058.descon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c800000058.cfilter,1,nil,tp)
end
function c800000058.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end