--Recovery Chute
function c511002029.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002029.condition)
	e1:SetTarget(c511002029.target)
	e1:SetOperation(c511002029.activate)
	c:RegisterEffect(e1)
end
function c511002029.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511002029.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x213) and c:IsLevelBelow(4) and c:IsAbleToHand() 
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,c)
end
function c511002029.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511002029.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local g1=Duel.SelectTarget(tp,c511002029.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g2=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g2,1,0,0)
end
function c511002029.activate(e,tp,eg,ep,ev,re,r,rp)
	local ex,g1=Duel.GetOperationInfo(0,CATEGORY_TOHAND)
	local ex,g2=Duel.GetOperationInfo(0,CATEGORY_ATKCHANGE)
	local tc1=g1:GetFirst()
	local tc2=g2:GetFirst()
	if tc1 and tc2 and tc1:IsFaceup() and tc1:IsRelateToEffect(e) and tc2:IsFaceup() and tc2:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc1:GetAttack())
		if tc2:RegisterEffect(e1) then
			Duel.SendtoHand(tc1,nil,REASON_EFFECT)
		end
	end
end
