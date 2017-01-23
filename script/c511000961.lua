--Doom Ray
function c511000961.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000961.condition)
	e1:SetTarget(c511000961.target)
	e1:SetOperation(c511000961.operation)
	c:RegisterEffect(e1)
end
function c511000961.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==nil
end
function c511000961.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)*800
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,dam)
end
function c511000961.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)*800
	Duel.Damage(1-tp,d,REASON_EFFECT,true)
	Duel.Damage(tp,d,REASON_EFFECT,true)
	Duel.RDComplete()
end
