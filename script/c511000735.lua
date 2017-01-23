--Viper's Grudge
function c511000735.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(511000735,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c511000735.con)
	e3:SetTarget(c511000735.target)
	e3:SetOperation(c511000735.operation)
	c:RegisterEffect(e3)
end
function c511000735.cfilter(c,tp)
	return c:IsRace(RACE_REPTILE) and c:GetPreviousControler()==tp and c:GetPreviousLocation()==LOCATION_MZONE
end
function c511000735.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000735.cfilter,1,nil,tp)
end
function c511000735.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_REPTILE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000735.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000735.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000735.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000735.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
