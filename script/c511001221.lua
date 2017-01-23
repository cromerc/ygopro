--Spell Spice Caraway
function c511001221.initial_effect(c)
	--recover&damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_DAMAGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001221.target)
	e1:SetOperation(c511001221.operation)
	c:RegisterEffect(e1)
end
function c511001221.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,200)
end
function c511001221.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,200,REASON_EFFECT)
	Duel.Recover(tp,200,REASON_EFFECT)
end
