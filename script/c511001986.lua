--Demon Moncarch
function c511001986.initial_effect(c)
	--copy Spell
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100047,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511001986.condition)
	e1:SetCost(c511001986.cost)
	e1:SetTarget(c511001986.target)
	e1:SetOperation(c511001986.operation)
	c:RegisterEffect(e1)
end
function c511001986.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c511001986.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToRemoveAsCost() and c:CheckActivateEffect(false,true,false)~=nil
end
function c511001986.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001986.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(95100047,1))
	local g=Duel.SelectMatchingCard(tp,c511001986.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local te=g:GetFirst():CheckActivateEffect(false,true,true)
	c511001986[Duel.GetCurrentChain()]=te
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001986.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local te=c511001986[Duel.GetCurrentChain()]
	if chkc then
		local tg=te:GetTarget()
		return tg(e,tp,eg,ep,ev,re,r,rp,0,true)
	end
	if chk==0 then return true end
	if not te then return end
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511001986.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=c511001986[Duel.GetCurrentChain()]
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
