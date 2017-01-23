--Reckless Parasite
function c511001310.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001310.target)
	e1:SetOperation(c511001310.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_RACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c511001310.con)
	e2:SetValue(RACE_INSECT)
	c:RegisterEffect(e2)
	--cannot release
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c511001310.con)
	e3:SetTarget(c511001310.efilter)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e4)
end
function c511001310.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001310.spfilter(c,e,tp)
	return c:IsCode(27911549) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001310.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001310.filter,tp,0,LOCATION_DECK,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511001310.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001310.spfilter,tp,0,LOCATION_DECK,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
	end
end
function c511001310.con(e)
	return Duel.IsExistingMatchingCard(c511001310.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,27911549)
		and Duel.IsExistingMatchingCard(c511001310.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,511001310)
end
function c511001310.cfilter(c,code)
	return c:GetCode()==code and c:IsFaceup()
end
function c511001310.efilter(e,c)
	return c:IsRace(RACE_INSECT) and c:GetOriginalRace()~=c:GetRace() and c:GetOriginalRace()~=RACE_INSECT
end
