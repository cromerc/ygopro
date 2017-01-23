--コストダウン
function c511002540.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002540.tg)
	e1:SetOperation(c511002540.op)
	c:RegisterEffect(e1)
end
function c511002540.filter(c)
	return c:GetLevel()>2
end
function c511002540.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002540.filter,tp,LOCATION_HAND,0,1,nil) end
end
function c511002540.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002540.filter,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(67196946,1))
		local sg=g:Select(tp,1,1,nil)
		local tc=sg:GetFirst()
		Duel.ConfirmCards(1-tp,sg)
		if tc:IsLocation(LOCATION_HAND) then Duel.ShuffleHand(tp) end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(-2)
		tc:RegisterEffect(e1)
	end
end
