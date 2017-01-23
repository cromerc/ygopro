--Legendary Knight Timaeus
function c170000202.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Timaeus the Knight of Destiny
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c170000202.condition)
	e2:SetTarget(c170000202.target)
	e2:SetOperation(c170000202.operation)
	c:RegisterEffect(e2)
end
function c170000202.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c170000202.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,1,nil) end
end
function c170000202.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasableByEffect,tp,LOCATION_MZONE,0,1,10,nil)
	if g:GetCount()>0 then
		local sum=g:GetSum(Card.GetAttack)
		Duel.Release(g,REASON_EFFECT)
		Duel.RaiseEvent(e:GetHandler(),170000202,e,REASON_EFFECT,tp,tp,sum)
	end
end
