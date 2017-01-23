--Cliff Scream
function c511001630.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001630.condition)
	e1:SetTarget(c511001630.target)
	e1:SetOperation(c511001630.activate)
	c:RegisterEffect(e1)
end
function c511001630.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000
end
function c511001630.desfilter(c)
	return c:GetSequence()<5 and c:IsDestructable()
end
function c511001630.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001630.desfilter,tp,LOCATION_SZONE,LOCATION_SZONE,2,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c511001630.desfilter,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c511001630.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001630.desfilter,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,2,2,nil)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
