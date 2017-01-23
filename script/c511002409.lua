--Scrap Garage
function c511002409.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511002409.condition)
	e1:SetTarget(c511002409.target)
	e1:SetOperation(c511002409.activate)
	c:RegisterEffect(e1)
end
function c511002409.cfilter(c,tp)
	return (c:IsSetCard(0x219) or c:IsCode(82556058)) and c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp
		and c:GetPreviousLocation()==LOCATION_MZONE and bit.band(c:GetPreviousPosition(),POS_FACEUP)~=0
end
function c511002409.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002409.cfilter,1,nil,tp)
end
function c511002409.filter(c,e,tp)
	return (c:IsSetCard(0x219) or c:IsCode(82556058)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002409.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002409.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511002409.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002409.filter,tp,LOCATION_GRAVE,0,ft,ft,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
