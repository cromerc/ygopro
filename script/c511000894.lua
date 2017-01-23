--Chain of the Underworld
function c511000894.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c511000894.target)
	e1:SetOperation(c511000894.activate)
	c:RegisterEffect(e1)
end
function c511000894.filter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==1-tp and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false)
end
function c511000894.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511000894.filter,nil,e,tp)
	local tc=g:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c511000894.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP_ATTACK) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-700)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.SpecialSummonComplete()
	end
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
