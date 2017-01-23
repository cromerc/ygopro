--Ignition
function c511000651.initial_effect(c)
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000651.condition)
	e1:SetOperation(c511000651.activate)
	c:RegisterEffect(e1)
end
function c511000651.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():CancelToGrave(false)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511000651.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c511000651.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511000651.condition(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return ep~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.IsExistingMatchingCard(c511000651.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c511000651.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c511000651.repop)
end
