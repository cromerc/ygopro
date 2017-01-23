--Tomahawk Cannon
function c511002056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002056.condition)
	e1:SetTarget(c511002056.target)
	e1:SetOperation(c511002056.activate)
	c:RegisterEffect(e1)
end
function c511002056.filter(c)
	return c:IsFaceup() and c:IsCode(10389142)
end
function c511002056.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002056.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.GetAttacker():IsControler(1-tp)
end
function c511002056.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511002056.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and Duel.NegateAttack() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
