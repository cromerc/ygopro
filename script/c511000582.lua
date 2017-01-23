--Spreading Spider Spawn
function c511000582.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000582.condition)
	e1:SetTarget(c511000582.tg)
	e1:SetOperation(c511000582.op)
	c:RegisterEffect(e1)
end
function c511000582.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c511000582.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000582.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000582.filter(c,e,tp)
	return c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000582.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511000582.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000582.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.SelectMatchingCard(tp,c511000582.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
