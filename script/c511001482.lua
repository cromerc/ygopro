--Shifting Land
function c511001482.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001482.lpop)
	c:RegisterEffect(e1)
	--copy	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511001482.lpop)
	c:RegisterEffect(e2)
end
function c511001482.lpop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local sum=0
	if g:GetCount()>0 then
		sum=g:GetSum(Card.GetAttack)
	end
	Duel.SetLP(tp,sum,REASON_EFFECT)
	Duel.BreakEffect()
end
