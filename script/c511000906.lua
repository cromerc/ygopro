--Synchro Sonic
function c511000906.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000906.tg)
	e1:SetOperation(c511000906.op)
	c:RegisterEffect(e1)
end
function c511000906.ctfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000906.desfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511000906.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(c511000906.ctfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return ct>0 and Duel.IsExistingMatchingCard(c511000906.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local g=Duel.GetMatchingGroup(c511000906.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000906.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c511000906.ctfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c511000906.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	if ct>0 and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,1,ct,c)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
