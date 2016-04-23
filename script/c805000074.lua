--剣現する武神
function c805000074.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c805000074.target)
	e1:SetOperation(c805000074.activate)
	c:RegisterEffect(e1)
end
function c805000074.filter1(c)
	return c:IsSetCard(0x86) and c:IsAbleToHand()
end
function c805000074.filter2(c)
	return c:IsSetCard(0x86) and c:IsAbleToGrave()
end
function c805000074.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return (chkc:IsLocation(LOCATION_GRAVE) or chkc:IsLocation(LOCATION_REMOVED)) end
	if chk==0 then return Duel.IsExistingTarget(c805000074.filter1,tp,LOCATION_GRAVE,0,1,nil)
	 or	Duel.IsExistingTarget(c805000074.filter2,tp,LOCATION_REMOVED,0,1,nil) end
	local opt=0
	if Duel.IsExistingTarget(c805000074.filter1,tp,LOCATION_GRAVE,0,1,nil)
	 and Duel.IsExistingTarget(c805000074.filter2,tp,LOCATION_REMOVED,0,1,nil) then
		opt=Duel.SelectOption(tp,aux.Stringid(110000000,5),aux.Stringid(110000000,6))
	else 
		if not Duel.IsExistingTarget(c805000074.filter1,tp,LOCATION_GRAVE,0,1,nil) then
			opt=Duel.SelectOption(tp,aux.Stringid(110000000,6))+1
		else opt=Duel.SelectOption(tp,aux.Stringid(110000000,5)) end
	end
	e:SetLabel(opt)
	if opt==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c805000074.filter1,tp,LOCATION_GRAVE,0,1,1,nil)
	else Duel.SelectTarget(tp,c805000074.filter2,tp,LOCATION_REMOVED,0,1,1,nil) end
end
function c805000074.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if e:GetLabel()==0 then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end