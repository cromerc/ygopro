--Revenge Soul
function c511000469.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000469.target)
	e1:SetOperation(c511000469.activate)
	c:RegisterEffect(e1)
end
function c511000469.filter(c,tid)
	return bit.band(c:GetReason(),REASON_BATTLE)~=0 and c:GetTurnID()==tid and c:IsAbleToHand() 
end
function c511000469.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c511000469.filter(chkc,tid) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000469.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511000469.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,tid)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511000469.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
