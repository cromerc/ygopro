--Power Analysis
function c511001883.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001883.condition)
	e1:SetTarget(c511001883.target)
	e1:SetOperation(c511001883.activate)
	c:RegisterEffect(e1)
end
function c511001883.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001883.filter(c,tp)
	return c:IsRace(RACE_MACHINE) and c:IsFaceup() 
		and Duel.IsExistingMatchingCard(c511001883.filter2,tp,0,LOCATION_MZONE,1,c,c:GetAttack())
end
function c511001883.filter2(c,atk)
	return c:IsFaceup() and c:GetAttack()~=atk
end
function c511001883.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001883.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001883.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001883.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c511001883.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectMatchingCard(tp,c511001883.filter2,tp,0,LOCATION_MZONE,1,1,nil,tc:GetAttack())
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(g:GetFirst():GetAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
