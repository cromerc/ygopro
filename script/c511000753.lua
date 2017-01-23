--Junk Splash
function c511000753.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000753.target)
	e1:SetOperation(c511000753.activate)
	c:RegisterEffect(e1)
end
function c511000753.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x43)
end
function c511000753.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000753.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local dam=Duel.GetMatchingGroupCount(c511000753.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*500
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	if dam>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam) end
end
function c511000753.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c511000753.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*500
	Duel.Damage(p,dam,REASON_EFFECT)
end
