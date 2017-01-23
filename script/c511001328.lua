--Flute of Hamelin
function c511001328.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001328.target)
	e1:SetOperation(c511001328.activate)
	c:RegisterEffect(e1)
end
function c511001328.filter(c,tid)
	return c:GetTurnID()==tid and c:IsType(TYPE_MONSTER) and not c:IsReason(REASON_RETURN)
end
function c511001328.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511001328.filter(chkc,tid) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511001328.filter,tp,LOCATION_GRAVE,0,1,nil,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001328.filter,tp,LOCATION_GRAVE,0,1,1,nil,tid)
end
function c511001328.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND+LOCATION_DECK,LOCATION_HAND+LOCATION_DECK,nil,tc:GetCode())
		if g:GetCount()>0 then
			Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
		end
	end
end
