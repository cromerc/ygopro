--Parallel Twister
function c511000754.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000754.target)
	e1:SetOperation(c511000754.activate)
	c:RegisterEffect(e1)
end
function c511000754.dfilter(c,s)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable() and Duel.IsExistingMatchingCard(c511000754.dfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,s)
end
function c511000754.dfilter2(c,s)
	return c:IsDestructable() and c~=s
end
function c511000754.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000754.dfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler(),e:GetHandler()) end
	local dg=Duel.GetMatchingGroup(c511000754.dfilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,0,0)
end
function c511000754.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,c511000754.dfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),e:GetHandler())
	if Duel.Destroy(dg,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg2=Duel.SelectMatchingCard(tp,c511000754.dfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,dg:GetFirst(),e:GetHandler())
		Duel.Destroy(dg2,REASON_EFFECT)
	end
end
