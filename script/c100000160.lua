--クリアー・キューブ
function c100000160.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_REMOVE_ATTRIBUTE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100000160.ratg)
	e1:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e1)	
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000160,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c100000160.spcon)
	e2:SetTarget(c100000160.sptg)
	e2:SetOperation(c100000160.spop)
	c:RegisterEffect(e2)
end
function c100000160.ratg(e)
	return e:GetHandler()
end
function c100000160.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c100000160.filter(c,e,tp)
	return c:IsCode(100000160) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000160.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000160.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	if e:GetHandler():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,e:GetHandler())
		Duel.ShuffleHand(tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000160.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000160.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end