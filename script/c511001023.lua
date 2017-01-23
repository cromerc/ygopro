--エンシェントサンシャイン
function c511001023.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001023.cost)
	e1:SetCondition(c511001023.condition)
	e1:SetTarget(c511001023.target)
	e1:SetOperation(c511001023.operation)
	c:RegisterEffect(e1)
end
function c511001023.cfilter(c)
	return  c:IsCode(25862681) and c:IsAbleToRemoveAsCost()
end
function c511001023.confilter(c)
	return c:IsFaceup() and c:IsCode(20210570)
end
function c511001023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001023.cfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil) 
		and Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0  end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511001023.cfilter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511001023.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001023.confilter,tp,LOCATION_MZONE,0,1,nil) 
end
function c511001023.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2100)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2100)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511001023.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Damage(p,d,REASON_EFFECT) then
		Duel.BreakEffect()
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,nil)
		Duel.Destroy(sg,REASON_EFFECT)	
	end
end
