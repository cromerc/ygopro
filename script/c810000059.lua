-- Defending Sweeper
-- scripted by: UnknownGuest
function c810000059.initial_effect(c)
	-- Increase Level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c810000059.condition)
	c:RegisterEffect(e1)
end
function c810000059.filter(c)
	return c:IsFaceup() and c:IsCode(450000110)
end
function c810000059.condition(e)
	return Duel.IsExistingMatchingCard(c810000059.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.GetEnvironment()==450000110
end
