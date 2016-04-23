--おジャマンダラ
function c100000101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000101.cost)
	e1:SetTarget(c100000101.target)
	e1:SetOperation(c100000101.activate)
	c:RegisterEffect(e1)
end
function c100000101.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c100000101.tfilter(c,code,e,tp)
	return c:GetCode()==code and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsExistingTarget(c100000101.filter,tp,LOCATION_GRAVE,0,1,nil,12482652,e,tp) 
		and Duel.IsExistingTarget(c100000101.filter,tp,LOCATION_GRAVE,0,1,nil,42941100,e,tp) 
		and Duel.IsExistingTarget(c100000101.filter,tp,LOCATION_GRAVE,0,1,nil,79335209,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,0,3,0,0)
end
function c100000101.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=Duel.SelectMatchingCard(tp,c100000101.tfilter,tp,LOCATION_GRAVE,0,1,1,nil,12482652,e,tp) 	
	local sg2=Duel.SelectMatchingCard(tp,c100000101.tfilter,tp,LOCATION_GRAVE,0,1,1,nil,42941100,e,tp) 
	sg1:Merge(sg2)
	local sg3=Duel.SelectMatchingCard(tp,c100000101.tfilter,tp,LOCATION_GRAVE,0,1,1,nil,79335209,e,tp)
	sg1:Merge(sg3)
	Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP)
end
