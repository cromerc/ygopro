--Reverse-Time
function c511002170.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c511002170.condition)
	e1:SetTarget(c511002170.target)
	e1:SetOperation(c511002170.activate)
	c:RegisterEffect(e1)
end
function c511002170.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and Duel.GetTurnPlayer()~=tp  
end
function c511002170.filter(c,tid)
	return c:GetTurnID()==tid and c:IsAbleToRemove()
end
function c511002170.filter2(c,tid)
	return c:GetTurnID()==tid and c:IsReason(REASON_DESTROY) and c:IsType(TYPE_MONSTER)
end
function c511002170.tpchk(c,tp)
	return c:GetPreviousControler()==tp
end
function c511002170.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.IsExistingMatchingCard(c511002170.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tid) 
		or (Duel.IsExistingMatchingCard(c511002170.filter2,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tid)) end
	local sg=Duel.GetMatchingGroup(c511002170.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tid)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c511002170.activate(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	local sg=Duel.GetMatchingGroup(c511002170.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tid)
	if sg:GetCount()>0 then
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
	local g=Duel.GetMatchingGroup(c511002170.filter2,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,tid)
	if g:GetCount()>0 then
		local g1=g:Filter(c511002170.tpchk,nil,tp)
		local g2=g:Filter(c511002170.tpchk,nil,1-tp)
		local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
		if g1:GetCount()>ft1 then
			g1=g1:Select(tp,ft1,ft1,nil)
		end
		if g2:GetCount()>ft2 then
			g2=g2:Select(1-tp,ft2,ft2,nil)
		end
		g1:Merge(g2)
		local tc=g1:GetFirst()
		while tc do
			Duel.MoveToField(tc,tc:GetPreviousControler(),tc:GetPreviousControler(),LOCATION_MZONE,tc:GetPreviousPosition(),true)
			tc=g1:GetNext()
		end
	end
end
