--Blade Barrier
function c511002663.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c511002663.target)
	e1:SetOperation(c511002663.activate)
	c:RegisterEffect(e1)
end
function c511002663.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c511002663.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	Duel.Damage(1-tp,800,REASON_EFFECT)
end
