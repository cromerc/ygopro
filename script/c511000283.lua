--Purity of the Cemetery
function c511000283.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000283,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000283.damcon)
	e2:SetOperation(c511000283.damop)
	c:RegisterEffect(e2)
	--selfdes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511000283.sdcon2)
	c:RegisterEffect(e3)
end
function c511000283.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511000283.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c511000283.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511000283.filter,tp,0,LOCATION_GRAVE,nil)
	local dam=g:GetCount()*100
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
function c511000283.sdcon2(e)
	return Duel.IsExistingMatchingCard(c511000283.filter,e:GetHandler():GetControler(),LOCATION_GRAVE,0,1,nil)
end
