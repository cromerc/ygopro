--Raccoon Reversal
function c511002579.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002579.condition)
	e1:SetTarget(c511002579.target)
	e1:SetOperation(c511002579.operation)
	c:RegisterEffect(e1)
end
function c511002579.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) 
		and (d:IsCode(17441953) or d:IsCode(31991800) or d:IsCode(92729410) or d:IsCode(28118128) or d:IsCode(39972129)) 
end
function c511002579.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,tg:GetAttack())
end
function c511002579.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc and tc:IsRelateToBattle() and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED)
		and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
	end
end
