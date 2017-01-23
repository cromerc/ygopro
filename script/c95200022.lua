--Commande Duel 22
function c95200022.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c95200022.activate)
	c:RegisterEffect(e1)
end
function c95200022.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetOverlayGroup(tp,1,1)
	if g:GetCount()~=0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
