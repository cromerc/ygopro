--Fool's Dice
function c511002924.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c511002924.condition)
	e1:SetCost(c511002924.cost)
	e1:SetTarget(c511002924.target)
	e1:SetOperation(c511002924.activate)
	c:RegisterEffect(e1)
end
function c511002924.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:GetPreviousControler()~=tp
end
function c511002924.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(2) and c:IsDiscardable()
end
function c511002924.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002924.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c511002924.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c511002924.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return true end
	local dam=tc:GetLevel()*200
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002924.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
