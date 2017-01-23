--Hero's Backup
function c511002398.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002398.condition)
	e1:SetTarget(c511002398.target)
	e1:SetOperation(c511002398.activate)
	c:RegisterEffect(e1)
end
function c511002398.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp and ph>=0x08 and ph<=0x20 
		and (ph~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c511002398.filter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c511002398.filter2,tp,0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function c511002398.filter2(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk+1000)
end
function c511002398.rfilter(c)
	return c:IsSetCard(0x3008) and c:IsAbleToRemove()
end
function c511002398.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002398.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511002398.filter,tp,LOCATION_MZONE,0,1,nil,tp) 
		and Duel.IsExistingMatchingCard(c511002398.rfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002398.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local g=Duel.GetMatchingGroup(c511002398.rfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511002398.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local tg=Duel.SelectMatchingCard(tp,c511002398.rfilter,tp,LOCATION_GRAVE,0,1,1,nil):GetFirst()
		if tg and Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)>0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(tg:GetAttack())
			tc:RegisterEffect(e1)
		end
	end
end
