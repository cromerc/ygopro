--Triangle Warrior
function c511000096.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetDescription(aux.Stringid(511000096,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c511000096.target)
	e1:SetOperation(c511000096.activate)
	c:RegisterEffect(e1)
end
function c511000096.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>1 and Duel.GetLocationCount(tp,LOCATION_MZONE,tp)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000097,0xf,0x4011,1200,1200,2,RACE_WARRIOR,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENCE,1-tp) 
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000096.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511000097,0xf,0x4011,1200,1200,2,RACE_WARRIOR,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENCE,1-tp) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,511000097)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENCE)
	end
	Duel.SpecialSummonComplete()
end
