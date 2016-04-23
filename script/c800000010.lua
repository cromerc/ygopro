--Heroic Challenger - Ambush Soldier
function c800000010.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c800000010.cost)
	e1:SetCondition(c800000010.condition)
	e1:SetTarget(c800000010.target)
	e1:SetOperation(c800000010.operation)
	c:RegisterEffect(e1)
end
function c800000010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and Duel.GetFlagEffect(tp,800000010)==0 end
	Duel.Release(e:GetHandler(),REASON_COST)
	Duel.RegisterFlagEffect(tp,800000010,RESET_PHASE+PHASE_END,0,1)
end
function c800000010.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c800000010.filter(c,e,tp)
	return c:IsSetCard(0x6f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
	 and not c:IsCode(800000010) and not c:IsType(TYPE_XYZ)
end
function c800000010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c800000010.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c800000010.lvfilter(c)
	return c:IsSetCard(0x6f) and not c:IsType(TYPE_XYZ)
end
function c800000010.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c800000010.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,2,2,nil,e,tp)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(g,1,tp,tp,false,false,POS_FACEUP_DEFENCE)
		local dg=Duel.GetMatchingGroup(c800000010.lvfilter,tp,LOCATION_MZONE,0,nil)
		if dg:GetCount()>0 and e:GetHandler():IsLocation(LOCATION_GRAVE) 
		and e:GetHandler():IsAbleToRemoveAsCost() and Duel.SelectYesNo(tp,aux.Stringid(100000000,2)) then
			Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
			local tc=dg:GetFirst()
			while tc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetValue(1)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
				tc=dg:GetNext()
			end			
		end
	end
end
