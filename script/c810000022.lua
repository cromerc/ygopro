-- Zeta Reticulant (Anime)
-- scripted by: UnknownGuest
function c810000022.initial_effect(c)
	-- token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000022,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c810000022.condition)
	e1:SetTarget(c810000022.target)
	e1:SetOperation(c810000022.operation)
	c:RegisterEffect(e1)
end
function c810000022.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c810000022.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c810000022.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,64382841,0,0x4011,500,300,2,RACE_FIEND,ATTRIBUTE_DARK) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,64382841)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
