--Relentless Attacks
function c511002405.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c511002405.condition)
	e1:SetTarget(c511002405.target)
	e1:SetOperation(c511002405.activate)
	c:RegisterEffect(e1)
end
function c511002405.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return eg:GetCount()==1 and tc:IsControler(tp) and bc and bc:IsReason(REASON_BATTLE) and bc:IsControler(1-tp)
end
function c511002405.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=eg:GetFirst()
	if chk==0 then return tg:IsOnField() end
	Duel.SetTargetCard(tg)
end
function c511002405.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.ChainAttack()
end
