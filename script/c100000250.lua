--レベルダウン！
function c100000250.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000250.tg)
	e1:SetOperation(c100000250.activate)
	c:RegisterEffect(e1)
end
function c100000250.filter(c)
	return c:IsSetCard(0x41) and c:GetLevel()>2
end
function c100000250.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000250.filter,tp,LOCATION_HAND,0,1,nil) end
end
function c100000250.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000250.filter,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100000250,0))
		local sg=g:Select(tp,1,1,nil)
		local tc=sg:GetFirst()
		Duel.ConfirmCards(1-tp,sg)
		if tc:GetLocation()==LOCATION_HAND then Duel.ShuffleHand(tp) end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(-2)
		tc:RegisterEffect(e1)
	end
end
