--Owner's Seal (Anime)
--scripted by: UnknownGuest
function c810000071.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000071.target)
	e1:SetOperation(c810000071.activate)
	c:RegisterEffect(e1)
end
function c810000071.filter(c)
	return c:GetControler()~=c:GetOwner()
end
function c810000071.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000071.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c810000071.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsImmuneToEffect(e) then
			tc:ResetEffect(EFFECT_SET_CONTROL,RESET_CODE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_CONTROL)
			e1:SetValue(tc:GetOwner())
			e1:SetReset(RESET_EVENT+0xec0000)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
