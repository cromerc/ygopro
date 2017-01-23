--D - Soul
--fixed by MLD
function c511009035.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511009035.condition)
	e1:SetCost(c511009035.cost)
	e1:SetTarget(c511009035.target)
	e1:SetOperation(c511009035.activate)
	c:RegisterEffect(e1)
end
function c511009035.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511009035.cfilter(c)
	return c:GetAttack()>0 and c:IsSetCard(0xc008) and c:IsAbleToRemoveAsCost()
end
function c511009035.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc008) 
end
function c511009035.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511009035.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511009035.filter(chkc) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511009035.cfilter,tp,LOCATION_GRAVE,0,1,nil) 
			and Duel.IsExistingTarget(c511009035.filter,tp,LOCATION_MZONE,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c511009035.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g:GetFirst():GetAttack()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009035.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetParam(atk)
end
function c511009035.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
