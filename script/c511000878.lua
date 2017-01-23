--Magical Pigeon
function c511000878.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000878.cost)
	e1:SetTarget(c511000878.target)
	e1:SetOperation(c511000878.operation)
	c:RegisterEffect(e1)
end
function c511000878.cfilter(c)
	return c:IsFaceup() and c:IsCode(38033121) and c:IsAbleToHandAsCost()
end
function c511000878.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000878.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000878.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c511000878.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000879,0,0x4011,0,0,1,RACE_WINDBEAST,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511000878.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000879,0,0x4011,0,0,1,RACE_WINDBEAST,ATTRIBUTE_WIND) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,511000879)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
		Duel.SpecialSummonComplete()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetOperation(c511000878.desop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511000878.desfilter(c)
	return c:IsFaceup() and c:IsCode(511000879) and c:IsDestructable()
end
function c511000878.spfilter(c,e,tp)
	return c:IsCode(38033121) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000878.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511000878.desfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.SelectMatchingCard(tp,c511000878.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
