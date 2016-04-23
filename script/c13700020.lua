--Quantum Cat
function c13700020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13700020.target)
	e1:SetOperation(c13700020.activate)
	c:RegisterEffect(e1)
end
function c13700020.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c13700020.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x1376) or c:IsSetCard(0x1377) or c:IsSetCard(0x1378))
end
function c13700020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c13700020.cfilter,tp,LOCATION_MZONE,0,nil)
		e:SetLabel(ct)
		return Duel.IsExistingMatchingCard(c13700020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,ct,c)
	end
	local ct=e:GetLabel()
	local sg=Duel.GetMatchingGroup(c13700020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,ct,0,0)
end
function c13700020.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c13700020.cfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c13700020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if g:GetCount()>=ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,ct,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
