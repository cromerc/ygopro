--カオス・コア
function c100000257.initial_effect(c)
	c:EnableCounterPermit(0x93)
	--send to grave	
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100000257.condition)
	e1:SetCost(c100000257.cost)
	e1:SetOperation(c100000257.operation)
	c:RegisterEffect(e1)	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c100000257.condition2)
	e2:SetCost(c100000257.cost2)
	e2:SetTarget(c100000257.target)
	e2:SetOperation(c100000257.operation2)
	c:RegisterEffect(e2)
end
function c100000257.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d==e:GetHandler() and d:IsAttackPos() and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c100000257.filter(c,code)
	return c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c100000257.cost(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chk==0 then return Duel.IsExistingMatchingCard(c100000257.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,6007213)
	 and Duel.IsExistingMatchingCard(c100000257.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,32491822)
	 and Duel.IsExistingMatchingCard(c100000257.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,69890967) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c100000257.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,6007213)
	local g2=Duel.SelectMatchingCard(tp,c100000257.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,32491822)	
	g1:Merge(g2)
	local g3=Duel.SelectMatchingCard(tp,c100000257.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,69890967)	
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c100000257.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x93,3)
end
function c100000257.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0 and (Duel.GetAttackTarget()==e:GetHandler() or Duel.GetAttacker()==e:GetHandler()) and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c100000257.cost2(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x93,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveCounter(tp,0x93,1,REASON_COST)	
end
function c100000257.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
end
function c100000257.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetBattleDamage(tp)>0 then
		Duel.ChangeBattleDamage(tp,0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetCountLimit(1)
		e1:SetValue(c100000257.valcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e:GetHandler():RegisterEffect(e1)
	end
end
function c100000257.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
