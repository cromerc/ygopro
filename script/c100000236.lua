--トライアングル・フォース
function c100000236.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100000236.activate)
	c:RegisterEffect(e1)
end
function c100000236.filter(c,tp)
	return c:GetCode()==100000236 and c:GetActivateEffect():IsActivatable(tp)
end
function c100000236.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c100000236.filter,tp,LOCATION_DECK,0,nil,tp)
	Duel.BreakEffect()
	if dg:GetCount()>1 and Duel.GetLocationCount(tp,LOCATION_SZONE)>1
	 and Duel.SelectYesNo(tp,aux.Stringid(100000236,0)) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c100000236.filter,tp,LOCATION_DECK,0,2,2,nil,tp)
		if g:GetCount()>1 then
			local tc=g:GetFirst()
			local tc2=g:GetNext()
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.MoveToField(tc2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end