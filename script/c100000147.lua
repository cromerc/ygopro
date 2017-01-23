--ダーク・ウェーブ
function c100000147.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000147.target)
	e1:SetOperation(c100000147.activate)
	c:RegisterEffect(e1)
end
function c100000147.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and not c:IsType(TYPE_TUNER) 
end
function c100000147.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000147.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000147.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000147.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000147.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		tc:RegisterFlagEffect(100000147,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end