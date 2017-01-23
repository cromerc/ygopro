--Number Karma
function c511001792.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001792.damcon)
	e2:SetTarget(c511001792.damtg)
	e2:SetOperation(c511001792.damop)
	c:RegisterEffect(e2)
end
function c511001792.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x48)
end
function c511001792.damcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c511001792.cfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511001792.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,500)
end
function c511001792.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT,true)
	Duel.Damage(tp,500,REASON_EFFECT,true)
	Duel.RDComplete()
end
