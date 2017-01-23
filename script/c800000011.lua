-- All-Seeing Eye
-- scripted by: UnknownGuest
function c800000011.initial_effect(c)
	-- confirm
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c800000011.target)
	e1:SetOperation(c800000011.operation)
	c:RegisterEffect(e1)
end
function c800000011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and chkc:IsFacedown() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,g:GetCount(),g:GetCount(),nil)
end
function c800000011.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		Duel.ConfirmCards(tp,tc)
		tc=g:GetNext()
	end
end
