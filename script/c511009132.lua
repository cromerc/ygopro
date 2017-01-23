--Cup Meatball Cayenne
function c511009132.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100658,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511009132.condition)
	e1:SetTarget(c511009132.target)
	e1:SetOperation(c511009132.operation)
	c:RegisterEffect(e1)
end
function c511009132.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp
	 and bit.band(c:GetPreviousLocation(),LOCATION_ONFIELD)~=0
end
function c511009132.filter(c)
	return c:IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511009132.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511009132.filter,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009132.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009132.filter,tp,0,LOCATION_HAND,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
