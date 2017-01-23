--Zero Hole
function c511002765.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002765.condition)
	e1:SetTarget(c511002765.target)
	e1:SetOperation(c511002765.activate)
	c:RegisterEffect(e1)
end
function c511002765.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_MONSTER) or not Duel.IsChainDisablable(ev) or ep==tp then return false end
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_SUMMON_SUCCESS,true)
	if res and re:GetCode()==EVENT_SUMMON_SUCCESS and teg:IsContains(re:GetHandler()) then
		return true
	end
	res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_FLIP_SUMMON_SUCCESS,true)
	if res and re:GetCode()==EVENT_FLIP_SUMMON_SUCCESS and teg:IsContains(re:GetHandler()) then
		return true
	end
	res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS,true)
	if res and re:GetCode()==EVENT_SPSUMMON_SUCCESS and teg:IsContains(re:GetHandler()) then
		return true
	end
	return false
end
function c511002765.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511002765.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
