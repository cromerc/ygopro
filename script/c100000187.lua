--奈落の閃光
function c100000187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000187.condition)
	e1:SetTarget(c100000187.target)
	e1:SetOperation(c100000187.activate)
	c:RegisterEffect(e1)
end
function c100000187.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetAttack()>=2000
end
function c100000187.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tg,1,0,0)
end
function c100000187.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() and Duel.NegateAttack() then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
