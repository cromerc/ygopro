--Samsara Seeding
function c511000805.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511000805.condition)
	e1:SetTarget(c511000805.target)
	e1:SetOperation(c511000805.operation)
	c:RegisterEffect(e1)
end
function c511000805.cfilter(c,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511000805.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000805.cfilter,1,nil,tp)
end
function c511000805.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsSSetable,tp,LOCATION_HAND,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and g:GetCount()>0 end
end
function c511000805.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsSSetable,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local sg=g:Select(tp,1,1,nil)
		Duel.SSet(tp,sg:GetFirst())
	end
end
