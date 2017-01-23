--Flower Judgment
function c511001533.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001533.condition)
	e1:SetTarget(c511001533.target)
	e1:SetOperation(c511001533.activate)
	c:RegisterEffect(e1)
end
function c511001533.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001533.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0
end
function c511001533.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001533.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001533.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001533.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001533.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local ct=tc:GetOverlayCount()
		tc:RemoveOverlayCard(tp,ct,ct,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(ct*800)
		tc:RegisterEffect(e1)
	end
end
