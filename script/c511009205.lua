--Counterstrike Molt
--Scripted by eclair11
function c511009205.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511009205.condition)
	e1:SetTarget(c511009205.target)
	e1:SetOperation(c511009205.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	c:RegisterEffect(e2)
end
function c511009205.filter(c,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511009205.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009205.filter,1,nil,tp)
end
function c511009205.spfilter(c,e,sp,val)
	return c:IsRace(RACE_INSECT) and c:GetLevel()<val and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c511009205.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009205.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,tc:GetLevel()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511009205.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009205.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetLevel())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end