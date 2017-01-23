--Triangle Warrior
function c511000096.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000096.spcon)
	e1:SetOperation(c511000096.spop)
	c:RegisterEffect(e1)
end
function c511000096.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>1 and Duel.GetLocationCount(tp,LOCATION_MZONE,tp)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000097,0xf,0x4011,1200,1200,2,RACE_WARRIOR,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE,1-tp)
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
end
function c511000096.spop(e,tp,eg,ep,ev,re,r,rp,c)
	for i=1,2 do
		local token=Duel.CreateToken(tp,511000097)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
end
