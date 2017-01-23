--ワイズ・コア
function c100000055.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c100000055.spcon)
	e1:SetTarget(c100000055.sptg)
	e1:SetOperation(c100000055.spop)
	c:RegisterEffect(e1)
	--battle indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetValue(c100000055.valcon)
	c:RegisterEffect(e3)
end
function c100000055.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c100000055.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT)
end
function c100000055.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,5,tp,0x13)
end
function c100000055.filter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c100000055.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	local g1=Duel.GetMatchingGroup(c100000055.filter,tp,0x13,0,nil,68140974,e,tp)
	local g2=Duel.GetMatchingGroup(c100000055.filter,tp,0x13,0,nil,100000051,e,tp)
	local g3=Duel.GetMatchingGroup(c100000055.filter,tp,0x13,0,nil,100000052,e,tp)
	local g4=Duel.GetMatchingGroup(c100000055.filter,tp,0x13,0,nil,100000053,e,tp)
	local g5=Duel.GetMatchingGroup(c100000055.filter,tp,0x13,0,nil,100000054,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=5 and g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 
		and g4:GetCount()>0 and g5:GetCount()>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc1=g1:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,POS_FACEUP)
		local tc2=g2:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEUP)
		local tc3=g3:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummonStep(tc3,0,tp,tp,false,false,POS_FACEUP)
		local tc4=g4:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummonStep(tc4,0,tp,tp,false,false,POS_FACEUP)
		local tc5=g5:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummonStep(tc5,0,tp,tp,false,false,POS_FACEUP)
		Duel.SpecialSummonComplete()
	end
end
