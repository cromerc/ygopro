--Den of Dragons
function c511000338.initial_effect(c)	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511000338.condition)
	e1:SetTarget(c511000338.target)
	e1:SetOperation(c511000338.operation)
	c:RegisterEffect(e1)
end
function c511000338.cfilter(c,tp)
	return c:IsRace(RACE_DRAGON) and c:GetPreviousControler()==tp and c:GetLevel()>0
end
function c511000338.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000338.cfilter,nil,tp)
	local tc=g:GetFirst()
	return g:GetCount()==1
end
function c511000338.spfilter(c,e,tp,lv)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv
end
function c511000338.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:Filter(c511000338.cfilter,nil,tp):GetFirst()
	local lv=tc:GetLevel()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000338.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,lv) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000338.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:Filter(c511000338.cfilter,nil,tp):GetFirst()
	local lv=tc:GetLevel()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000338.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,lv)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
