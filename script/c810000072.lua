--Power Connection
--scripted by: UnknownGuest
function c810000072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c810000072.activate)
	c:RegisterEffect(e1)
end
function c810000072.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(c810000072.filter)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c810000072.vfilter(c,race)
	return c:IsFaceup() and c:IsRace(race)
end
function c810000072.filter(e,c)
	return Duel.GetMatchingGroupCount(c810000072.vfilter,0,LOCATION_MZONE,LOCATION_MZONE,c,c:GetRace())*500
end
