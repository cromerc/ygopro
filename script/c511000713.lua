--Rear-Guard Action
function c511000713.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511000713.condition)
	e1:SetTarget(c511000713.target)
	e1:SetOperation(c511000713.activate)
	c:RegisterEffect(e1)
end
function c511000713.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and Duel.GetTurnPlayer()~=tp  
end
function c511000713.cfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()<atk
end
function c511000713.filter(c)
	local atk=c:GetAttack()
	return c:IsFaceup() and not Duel.IsExistingMatchingCard(c511000713.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,atk)
end
function c511000713.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511000713.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000713.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000713.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000713.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if tc:IsDefensePos() then
			Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
		end
		if Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)==0 then
			Duel.Damage(tp,tc:GetAttack(),REASON_BATTLE)
		else
			local g=Duel.SelectMatchingCard(1-tp,nil,1-tp,0,LOCATION_MZONE,1,1,nil)
			local tg=g:GetFirst()
			Duel.CalculateDamage(tc,tg)
		end
	end
end
