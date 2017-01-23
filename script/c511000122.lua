--Ancient Citty
function c511000122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000122,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511000122.spcost)
	e2:SetTarget(c511000122.sptg)
	e2:SetOperation(c511000122.spop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c511000122.respcon)
	e3:SetOperation(c511000122.respop)
	c:RegisterEffect(e3)
end
function c511000122.costfilter(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c511000122.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000122.costfilter,tp,LOCATION_SZONE,0,1,nil,511000125)
		and Duel.IsExistingMatchingCard(c511000122.costfilter,tp,LOCATION_SZONE,0,1,nil,511000123) 
		and Duel.IsExistingMatchingCard(c511000122.costfilter,tp,LOCATION_MZONE,0,1,nil,511000126) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511000122.costfilter,tp,LOCATION_SZONE,0,1,1,nil,511000125)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511000122.costfilter,tp,LOCATION_SZONE,0,1,1,nil,511000123)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g3=Duel.SelectMatchingCard(tp,c511000122.costfilter,tp,LOCATION_MZONE,0,1,1,nil,511000126)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SendtoGrave(g1,REASON_COST)
end
function c511000122.spfilter(c,e,tp)
	return c:IsCode(511000128) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511000122.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000122.spfilter,tp,0x13,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c511000122.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511000122.spfilter,tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000122.cfilter(c,e,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE) and c:IsCode(511000128) 
		 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000122.respcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000122.cfilter,1,nil,e,tp)
end
function c511000122.respop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c511000122.cfilter,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_PHASE+PHASE_END)
		e4:SetRange(LOCATION_GRAVE+LOCATION_REMOVED)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e4:SetCountLimit(1)
		e4:SetOperation(c511000122.spcop)
		tc:RegisterEffect(e4)
		tc=g:GetNext()
	end
end
function c511000122.spcop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511000122)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
end
