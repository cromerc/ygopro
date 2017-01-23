-- Twin Gunfighter
-- scripted by: UnknownGuest
function c810000025.initial_effect(c)
	-- damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c810000025.condition)
	e1:SetTarget(c810000025.target)
	e1:SetOperation(c810000025.operation)
	c:RegisterEffect(e1)
end
function c810000025.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker()
end
function c810000025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetHandler():GetAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,dam)
end
function c810000025.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,e:GetHandler():GetAttack(),REASON_EFFECT)
end
