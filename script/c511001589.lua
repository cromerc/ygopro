--Uluru's Guardian
function c511001589.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001589,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001589.negcon)
	e1:SetCost(c511001589.cbcost)
	e1:SetTarget(c511001589.negtg)
	e1:SetOperation(c511001589.negop)
	c:RegisterEffect(e1)
end
function c511001589.cfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c511001589.cbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001589.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001589.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511001589.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(c) then return false end
	return Duel.IsChainNegatable(ev) or Duel.IsChainDisablable(ev)
end
function c511001589.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511001589.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	Duel.NegateActivation(ev)
	Duel.NegateEffect(ev)
	Duel.NegateRelatedChain(tc,RESET_TURN_SET)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetValue(RESET_TURN_SET)
	e2:SetReset(RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
	if tc:IsType(TYPE_TRAPMONSTER) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
		e3:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
