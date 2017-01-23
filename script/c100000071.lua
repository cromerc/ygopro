--師弟の絆
function c100000071.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000071.condition)
	e1:SetTarget(c100000071.target)
	e1:SetOperation(c100000071.activate)
	c:RegisterEffect(e1)
end
c100000071.dark_magician_list=true
function c100000071.cfilter(c)
	return c:IsFaceup() and c:IsCode(46986414)
end
function c100000071.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000071.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c100000071.filter(c,e,tp)
	return c:IsCode(38033121) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000071.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000071.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000071.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000071.filter,tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
