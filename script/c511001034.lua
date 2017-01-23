--石の心臓
function c511001034.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c511001034.condition)
	e1:SetTarget(c511001034.target)
	e1:SetOperation(c511001034.operation)
	c:RegisterEffect(e1)
end
function c511001034.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return a:IsSetCard(0x70) and at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511001034.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chkc then return chkc==a end
	if chk==0 then return a:IsOnField() and a:IsCanBeEffectTarget(e)  end
	Duel.SetTargetCard(a)
end
function c511001034.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChainAttack()
	end
end

