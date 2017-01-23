--ベアーズ・ブート・キャンプ
function c100000238.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000238.condition)
	e1:SetTarget(c100000238.target)
	e1:SetOperation(c100000238.activate)
	c:RegisterEffect(e1)
end
function c100000238.filter(c,e,tp)
	return c:GetCode()==67136033 and c:IsFaceup()
end
function c100000238.condition(e)
	return Duel.IsExistingMatchingCard(c100000238.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c100000238.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_BEASTWARRIOR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000238.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000238.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000238.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000238.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local c=e:GetHandler()	
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end