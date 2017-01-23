--Clairvoyance
function c511009397.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009397.target)
	e1:SetOperation(c511009397.activate)
	c:RegisterEffect(e1)
end
function c511009397.filter(c)
	return c:IsFacedown() 
end
function c511009397.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_SZONE) and c511009397.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009397.filter,tp,0,LOCATION_SZONE,1,nil) and Duel.IsPlayerCanDraw(tp,2) and Duel.IsPlayerCanDraw(1-tp,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,c511009397.filter,tp,0,LOCATION_SZONE,1,1,nil)
end
function c511009397.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsFaceup() then return end
	local op=Duel.SelectOption(tp,71,72)
	Duel.ConfirmCards(tp,tc)
	if (op==0 and tc:IsType(TYPE_SPELL)) or (op==1 and tc:IsType(TYPE_TRAP)) then
		if Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 then
			Duel.Draw(tp,2,REASON_EFFECT)
		end
	else
		if Duel.SelectYesNo(1-tp,aux.Stringid(3717252,0)) then
			Duel.Draw(1-tp,2,REASON_EFFECT)
		end
	end
	
end
