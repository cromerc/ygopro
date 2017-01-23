--Damage Interest
function c511000463.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511000463.condition)
	e1:SetTarget(c511000463.target)
	e1:SetOperation(c511000463.activate)
	c:RegisterEffect(e1)
end
function c511000463.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp) and ep==tp and Duel.GetAttackTarget()==nil
end
function c511000463.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ev*2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ev*2)
end
function c511000463.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
