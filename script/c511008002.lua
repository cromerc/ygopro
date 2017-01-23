--Small Resistance
--Scripted by Snrk
function c511008002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511008002.condition)
	e1:SetTarget(c511008002.target)
	e1:SetOperation(c511008002.activate)
	c:RegisterEffect(e1)
end
function c511008002.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511008002.filter(c)
	return c:IsLevelBelow(4) and c:GetLevel()>0 and c:IsAttackBelow(1000)
end
function c511008002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511008002.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511008002.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511008002.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c511008002.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if a and a:IsRelateToBattle() and tc and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		if atk<0 then atk=0 end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e1)
	end
end
