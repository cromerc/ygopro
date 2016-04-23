--黒・魔・導・連・弾 
function c100000104.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000104.target)
	e1:SetOperation(c100000104.activate)
	c:RegisterEffect(e1)
end
function c100000104.fil(c)
	return c:IsFaceup() and c:GetCode()==46986414 and Duel.IsExistingTarget(c100000104.filter2,tp,LOCATION_MZONE,0,1,tp)
end
function c100000104.filter(c)
	return c:IsFaceup() and c:GetCode()==46986414
end
function c100000104.filter2(c)
	return c:IsFaceup() and c:GetCode()==38033121
end
function c100000104.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c100000104.fil,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c100000104.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc1=g1:GetFirst()
	e:SetLabelObject(tc1)
	Duel.SelectTarget(tp,c100000104.filter2,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c100000104.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=e:GetLabelObject()
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc2:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
	end
end
