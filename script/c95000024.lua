--Numeron Chaos Ritual
function c95000024.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DELAYED_QUICKEFFECT)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c95000024.condition)
	e1:SetTarget(c95000024.target)
	e1:SetOperation(c95000024.activate)
	c:RegisterEffect(e1)
end
c95000024.mark=0
function c95000024.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp and c:IsControler(tp)
		and c:IsCode(95000022)
end
function c95000024.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c95000024.cfilter,1,nil,tp)
end
function c95000024.filter(c,e,tp)
	return c:IsCode(95000025) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c95000024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c95000024.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c95000024.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c95000024.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
