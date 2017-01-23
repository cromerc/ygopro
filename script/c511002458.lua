--Divine Chalice
function c511002458.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002458.condition)
	e1:SetTarget(c511002458.target)
	e1:SetOperation(c511002458.activate)
	c:RegisterEffect(e1)
end
function c511002458.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511002458.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002458.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002458.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511002459,0,0x4011,1000,1000,3,RACE_AQUA,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c511002458.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE,tp)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511002459,0,0x4011,1000,1000,3,RACE_AQUA,ATTRIBUTE_WATER) then return end
	local token=Duel.CreateToken(tp,511002459)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
