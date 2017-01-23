--Transcendent Harmony of Duality
function c511002648.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002648.condition)
	e1:SetTarget(c511002648.target)
	e1:SetOperation(c511002648.activate)
	c:RegisterEffect(e1)
end
function c511002648.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,1686814)
end
function c511002648.filter(c)
	return c:IsFaceup() and (not c:IsType(TYPE_TUNER) or not c:IsSetCard(0x301))
end
function c511002648.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002648.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002648.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002648.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002648.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if not tc:IsType(TYPE_TUNER) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_ADD_TYPE)
			e1:SetValue(TYPE_TUNER)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetValue(c511002648.synlimit)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e4:SetCode(EFFECT_ADD_SETCODE)
		e4:SetValue(0x301)
		tc:RegisterEffect(e4)
	end
end
function c511002648.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x301)
end
