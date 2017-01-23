--ＢＦ－フェスティバル
function c511002626.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002626.condition)
	e1:SetTarget(c511002626.target)
	e1:SetOperation(c511002626.activate)
	c:RegisterEffect(e1)
end
function c511002626.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
function c511002626.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp) 
		and Duel.IsExistingMatchingCard(c511002626.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002626.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511002627,0x33,0x4011,0,0,1,RACE_WINDBEAST,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c511002626.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511002627,0x33,0x4011,0,0,1,RACE_WINDBEAST,ATTRIBUTE_DARK) then
		for i=1,3 do
			local token=Duel.CreateToken(tp,511002627)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
end
