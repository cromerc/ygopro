--Small Resistance
function c511002941.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002941.condition)
	e1:SetTarget(c511002941.target)
	e1:SetOperation(c511002941.activate)
	c:RegisterEffect(e1)
end
function c511002941.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002941.filter(c)
	return c:IsLevelBelow(4) and c:GetLevel()>0 and c:IsAttackBelow(1000)
end
function c511002941.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511002941.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511002941.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.SelectTarget(tp,c511002941.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c511002941.activate(e,tp,eg,ep,ev,re,r,rp)
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
