--Level Mirroring
function c511001304.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001304.target)
	e1:SetOperation(c511001304.activate)
	c:RegisterEffect(e1)
end
function c511001304.filter(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsFaceup() and Duel.IsExistingMatchingCard(c511001304.lvfilter,tp,0,LOCATION_MZONE,1,nil,lv)
end
function c511001304.lvfilter(c,lv)
	return c:GetLevel()>0 and c:GetLevel()~=lv and c:IsFaceup()
end
function c511001304.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001304.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001304.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001304.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c511001304.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c511001304.lvfilter,tp,0,LOCATION_MZONE,1,1,nil,tc:GetLevel())
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(g:GetFirst():GetLevel())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
	end
end
