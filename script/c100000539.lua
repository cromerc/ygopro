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
	if chk==0 then return Duel.IsExistingTarget(c100000539.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c100000539.cfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000539.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000539.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c100000539.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=Duel.GetMatchingGroupCount(c100000539.cfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)*500
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
