--Hand Vice
function c511002558.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002558.condition)
	e1:SetTarget(c511002558.target)
	e1:SetOperation(c511002558.activate)
	c:RegisterEffect(e1)
end
c511002558.collection={
	[28003512]=true;[52800428]=true;[62793020]=true;[68535320]=true;[95929069]=true;
	[22530212]=true;[21414674]=true;[63746411]=true;[55888045]=true;
}
function c511002558.cfilter(c)
	return c:IsFaceup() and c511002558.collection[c:GetCode()]
end
function c511002558.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c511002558.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002558.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local dam=tg:GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002558.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if Duel.NegateAttack() then
			Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
		end
	end
end
