--英雄の掛橋－ビヴロスト
function c100000539.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000539.target)
	e1:SetOperation(c100000539.activate)
	c:RegisterEffect(e1)
end
function c100000539.filter(c)
	return c:IsFaceup() and (c:GetCode()==100000533 or c:GetCode()==100000534 or c:GetCode()==100000537 or c:GetCode()==100000538) 
end
function c100000539.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000539.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000539.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000539.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000539.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		--atk
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(c100000539.value)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e2)
	end
end
function c100000539.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100000539.value(e,c)
	return Duel.GetMatchingGroupCount(c100000539.filter,c:GetControler(),0,LOCATION_REMOVED,nil)*500
end
