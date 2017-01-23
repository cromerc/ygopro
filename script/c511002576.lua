--Dark Computer Virus
function c511002576.initial_effect(c)
	--effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002576.cost)
	e1:SetTarget(c511002576.target)
	e1:SetOperation(c511002576.activate)
	c:RegisterEffect(e1)
end
function c511002576.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_MACHINE)
end
function c511002576.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511002576.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511002576.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511002576.tcfilter(tc,ec,tp,eg,ep,ev,re,r,rp)
	local te=ec:GetActivateEffect()
	if te then
		local tg=te:GetTarget()
		return tg and tg(te,tp,eg,ep,ev,re,r,rp,0,tc)
	end
	return false
end
function c511002576.ecfilter(c,tp,eg,ep,ev,re,r,rp)
	return c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and c:GetCardTargetCount()==1 
		and Duel.IsExistingMatchingCard(c511002576.tcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c:GetFirstCardTarget(),c,tp,eg,ep,ev,re,r,rp)
end
function c511002576.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002576.ecfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,tp,eg,ep,ev,re,r,rp) end
end
function c511002576.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(43641473,0))
	local g=Duel.SelectMatchingCard(tp,c511002576.ecfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,tp,eg,ep,ev,re,r,rp)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local tg=Duel.SelectMatchingCard(tp,c511002576.tcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc:GetFirstCardTarget(),tc,tp,
			eg,ep,ev,re,r,rp):GetFirst()
		tc:CancelCardTarget(tc:GetFirstCardTarget())
		tc:SetCardTarget(tg)
	end
end
