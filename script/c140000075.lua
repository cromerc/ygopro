--Adamantine Sword Revival
function c140000075.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c140000075.condition)
	e1:SetCost(c140000075.cost)
	e1:SetTarget(c140000075.target)
	e1:SetOperation(c140000075.activate)
	c:RegisterEffect(e1)
end
function c140000075.cfilter(c,tp)
	return c:IsRace(RACE_DRAGON) and c:IsPreviousLocation(LOCATION_GRAVE)
end
function c140000075.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c140000075.cfilter,nil)
	return g:GetCount()==1
end
function c140000075.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:Filter(c140000075.cfilter,nil):GetFirst()
	if chk==0 then return tc:IsReleasable() end
	Duel.SetTargetCard(tc)
	Duel.Release(tc,REASON_COST)
end
function c140000075.filter(c,e,tp)
	return c:IsCode(140000076) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c140000075.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c140000075.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c140000075.activate(e,tp,eg,ep,ev,re,r,rp)
	local cc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(cc:GetPreviousControler(),LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c140000075.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,cc:GetPreviousControler(),true,false,POS_FACEUP_ATTACK)>0 then
		Duel.RaiseSingleEvent(tc,140000075,e,REASON_EFFECT,tp,tp,cc:GetPreviousAttackOnField())
	end
end
