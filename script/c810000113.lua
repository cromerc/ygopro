--Jelly Hole
--scripted by: UnknownGuest
function c810000113.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c810000113.discon)
	e1:SetTarget(c810000113.distg)
	e1:SetOperation(c810000113.disop)
	c:RegisterEffect(e1)
end
function c810000113.cfilter(c,tp)
	return c:GetSummonPlayer()==tp and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c810000113.discon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c810000113.cfilter,1,nil,1-tp)
end
function c810000113.filter1(c)
	return c:IsFaceup() and not c:IsDisabled() and (c:IsLocation(LOCATION_SZONE) or c:IsType(TYPE_EFFECT))
end
function c810000113.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000113.filter1,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c810000113.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c810000113.filter1,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	if not tc then return end
	local c=e:GetHandler()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
