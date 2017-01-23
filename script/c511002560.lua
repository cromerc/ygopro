--Fake Form
function c511002560.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c511002560.condition)
	e1:SetTarget(c511002560.target)
	e1:SetOperation(c511002560.activate)
	c:RegisterEffect(e1)
end
function c511002560.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_MONSTER) and re
end
function c511002560.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=eg:FilterCount(Card.IsType,nil,TYPE_MONSTER)*400
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002560.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
