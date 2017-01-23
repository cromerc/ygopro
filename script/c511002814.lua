--罅割れゆく斧
function c511002814.initial_effect(c)
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002814.condition)
	e1:SetTarget(c511002814.target)
	e1:SetOperation(c511002814.activate)
	c:RegisterEffect(e1)
	if not c511002814.global_check then
		c511002814.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetCode(EVENT_LEAVE_FIELD)
		ge1:SetOperation(c511002814.resetop)
		Duel.RegisterEffect(ge1,0)
		--counter
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_TURN_END)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002814.ctop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002814.resfilter(c)
	return c:GetOriginalCode()==511002814
end
function c511002814.resetop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002814.resfilter,tp,0xf7,0xf7,nil)
	local tc=g:GetFirst()
	while tc do
		tc:ResetFlagEffect(511002814)
		tc=g:GetNext()
	end
end
function c511002814.regfilter(c,tp)
	return c:GetOriginalCode()==511002814 and c:IsFacedown()
end
function c511002814.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002814.regfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511002814,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end
function c511002814.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511002814.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local ct=c:GetFlagEffect(511002814)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return ct>0 and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetTargetParam(ct)
end
function c511002814.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-ct*500)
		tc:RegisterEffect(e1)
	end
end
