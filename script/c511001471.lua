--Cursed Dollhouse
function c511001471.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001471,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_CONTROL_CHANGED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511001471.condition)
	e2:SetTarget(c511001471.target)
	e2:SetOperation(c511001471.operation)
	c:RegisterEffect(e2)
end
function c511001471.cfilter(c,tp)
	return c:IsCode(511001466) and c:IsControler(1-tp) and c:GetPreviousControler()==tp
end
function c511001471.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001471.cfilter,1,nil,tp)
end
function c511001471.spfilter(c,e,tp)
	return c:IsSetCard(0x220b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001471.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001471.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511001471.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001471.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
