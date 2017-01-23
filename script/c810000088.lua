--Pillager
--scripted by: UnknownGuest
function c810000088.initial_effect(c)
	--get card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000088,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c810000088.operation)
	c:RegisterEffect(e1)
end
function c810000088.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local tg=g:Filter(Card.IsType,nil,TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=tg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,tp,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
	end
end
