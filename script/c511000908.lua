--Debugger X
function c511000908.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000908,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511000908.condition)
	e1:SetTarget(c511000908.target)
	e1:SetOperation(c511000908.operation)
	c:RegisterEffect(e1)
end
function c511000908.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000909)
end
function c511000908.spfilter(c,e,tp)
	return c:IsCode(511000910) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000908.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000908.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000908.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000908.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000908.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsExistingMatchingCard(c511000908.cfilter,tp,LOCATION_ONFIELD,0,1,nil) then return end
	local tc=Duel.GetFirstMatchingCard(c511000908.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
