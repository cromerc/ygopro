--Commande Duel 3
function c95200003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c95200003.activate)
	c:RegisterEffect(e1)
end
function c95200003.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetDecktopGroup(tp,1)
	local g2=Duel.GetDecktopGroup(1-tp,1)
	if g1:GetCount()<=0 or g2:GetCount()<=0 then return end
	Duel.ConfirmDecktop(tp,1)
	Duel.ConfirmDecktop(1-tp,1)
	local tc=g1:GetFirst()
	if tc:IsType(TYPE_MONSTER) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	tc=g2:GetFirst()
	if tc:IsType(TYPE_MONSTER) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
	
	