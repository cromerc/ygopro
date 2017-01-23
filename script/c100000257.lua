--カオス・コア
function c100000257.initial_effect(c)
	c:EnableCounterPermit(0x93)
	--be target
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetDescription(aux.Stringid(3657444,0))
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCondition(c100000257.ctcon)
	e1:SetCost(c100000257.ctcost)
	e1:SetTarget(c100000257.cttg)
	e1:SetOperation(c100000257.ctop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c100000257.con)
	e2:SetCost(c100000257.cost)
	e2:SetOperation(c100000257.op)
	c:RegisterEffect(e2)
end
function c100000257.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c100000257.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c100000257.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000257.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,6007213)
		and Duel.IsExistingMatchingCard(c100000257.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,32491822)
		and Duel.IsExistingMatchingCard(c100000257.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,69890967) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c100000257.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,6007213)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c100000257.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,32491822)	
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g3=Duel.SelectMatchingCard(tp,c100000257.cfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,69890967)	
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c100000257.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanAddCounter(0x93,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x93)
end
function c100000257.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x93,3)
	end
end
function c100000257.con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at==e:GetHandler()
end
function c100000257.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x93,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x93,1,REASON_COST)	
end
function c100000257.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		c:RegisterEffect(e2)
	end
end
