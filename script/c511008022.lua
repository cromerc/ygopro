--Golden Form
--Scripted by Snrk
--fixed by MLD
function c511008022.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511008022.condition)
	e1:SetTarget(c511008022.target)
	e1:SetOperation(c511008022.activate)
	c:RegisterEffect(e1)
end
function c511008022.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and bit.band(tc:GetPreviousPosition(),POS_DEFENSE)~=0 and tc:IsPosition(POS_FACEUP_ATTACK)
end
function c511008022.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsFaceup() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c511008022.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
	end
end
