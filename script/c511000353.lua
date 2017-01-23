--Dragon's Evil Eye
function c511000353.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e1:SetTarget(c511000353.target)
	e1:SetOperation(c511000353.activate)
	c:RegisterEffect(e1)
end
function c511000353.ctfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511000353.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511000353.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c511000353.ctfilter,tp,LOCATION_MZONE,0,nil)
		return ct>0 and Duel.IsExistingMatchingCard(c511000353.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct,c)
	end
	local g=Duel.GetMatchingGroup(c511000353.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000353.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(c511000353.ctfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c511000353.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	if ct>0 and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,ct,ct,nil)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
