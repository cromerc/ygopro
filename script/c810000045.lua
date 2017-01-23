-- Synchron Resonator
-- scripted by: UnknownGuest
function c810000045.initial_effect(c)
	-- special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c810000045.spcon)
	c:RegisterEffect(e1)
end
function c810000045.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c810000045.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000045.cfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
