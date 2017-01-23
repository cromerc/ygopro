--Superior Overlay
function c511001800.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001800.condition)
	e1:SetTarget(c511001800.target)
	e1:SetOperation(c511001800.activate)
	c:RegisterEffect(e1)
end
function c511001800.cfilter(c,ct)
	return c:IsType(TYPE_XYZ) and c:GetOverlayCount()>ct
end
function c511001800.ofilter(c)
	return c:IsType(TYPE_XYZ) and (c:GetOverlayCount()>0 or c:IsFaceup())
end
function c511001800.condition(e,tp,eg,ep,ev,re,r,rp)
	local og=Duel.GetMatchingGroup(c511001800.ofilter,tp,0,LOCATION_MZONE,nil)
	local ct=og:GetSum(Card.GetOverlayCount)
	return Duel.IsExistingMatchingCard(c511001800.cfilter,tp,LOCATION_MZONE,0,1,nil,ct)
end
function c511001800.filter(c)
	return c:IsType(TYPE_XYZ) and (c:GetOverlayCount()>0 or c:IsFaceup()) and c:IsDestructable()
end
function c511001800.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001800.filter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c511001800.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511001800.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001800.filter,tp,0,LOCATION_MZONE,nil)
	local dg=sg:Filter(Card.CheckRemoveOverlayCard,nil,1-tp,1,REASON_EFFECT)
	if dg:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(81330115,0)) then
		local g=dg:Select(1-tp,1,10,nil)
		sg:Sub(g)
		local tc=g:GetFirst()
		while tc do
			tc:RemoveOverlayCard(1-tp,1,1,REASON_EFFECT)
			tc=g:GetNext()
		end
	end
	Duel.Destroy(sg,REASON_EFFECT)
end
