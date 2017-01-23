--幻魔の殉教者
function c511002835.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002835.condition)
	e1:SetCost(c511002835.cost)
	e1:SetTarget(c511002835.target)
	e1:SetOperation(c511002835.activate)
	c:RegisterEffect(e1)
end
function c511002835.filter(c)
	local code=c:GetCode()
	return c:IsFaceup() and (code==6007213 or code==32491822)
end
function c511002835.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002835.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511002835.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,2,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,2,2,e:GetHandler())
    Duel.SendtoGrave(g,REASON_EFFECT)
end
function c511002835.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93224849,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c511002835.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,93224849,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then
		for i=1,3 do
			local token=Duel.CreateToken(tp,93224849)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
		Duel.SpecialSummonComplete()
	end
end
