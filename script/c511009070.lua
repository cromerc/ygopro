--Full Throttle Soul
function c511009070.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PUBLIC)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511009070.con)
	e2:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c511009070.descon)
	e4:SetTarget(c511009070.destg)
	e4:SetOperation(c511009070.desop)
	c:RegisterEffect(e4)
end
function c511009070.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009070.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009070.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x21c)
end

function c511009070.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_DECK)
end
function c511009070.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009070.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
