--Pooch Party
function c511001678.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001678.target)
	e1:SetOperation(c511001678.activate)
	c:RegisterEffect(e1)
end
function c511001678.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001679,0,0x4011,0,0,1,RACE_BEAST,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511001678.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001679,0,0x4011,0,0,1,RACE_BEAST,ATTRIBUTE_EARTH) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,511001679)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local de=Effect.CreateEffect(e:GetHandler())
			de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			de:SetRange(LOCATION_MZONE)
			de:SetCode(EVENT_PHASE+PHASE_END)
			de:SetCountLimit(1)
			de:SetOperation(c511001678.desop)
			de:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(de)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511001678.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
