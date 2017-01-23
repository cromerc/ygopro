--Chaos Alliance
function c511001660.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001660.condition)
	e1:SetTarget(c511001660.target)
	e1:SetOperation(c511001660.activate)
	c:RegisterEffect(e1)
end
function c511001660.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001660.filter(c,atk)
	return (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)) and c:IsFaceup() and c:GetAttack()<atk
end
function c511001660.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local atk=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil):GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001660.filter(chkc,atk) end
	if chk==0 then return Duel.IsExistingTarget(c511001660.filter,tp,LOCATION_MZONE,0,1,nil,atk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001660.filter,tp,LOCATION_MZONE,0,1,1,nil,atk)
end
function c511001660.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil):GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()<atk then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
