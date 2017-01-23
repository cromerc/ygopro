--ザ・ヘブンズ・ロード
function c100000109.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000109.condition)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000109,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c100000109.spcost)
	e2:SetTarget(c100000109.sptg)
	e2:SetOperation(c100000109.spop)
	c:RegisterEffect(e2)	
end
function c100000109.cfilter(c)
	return c:IsSetCard(0x5) and c:GetLevel()>=7
end
function c100000109.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000109.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c100000109.costfilter(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsAbleToGraveAsCost()
end
function c100000109.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000109.costfilter,tp,LOCATION_SZONE,0,1,nil,100000107)
		and Duel.IsExistingMatchingCard(c100000109.costfilter,tp,LOCATION_SZONE,0,1,nil,100000108)
		and e:GetHandler():IsAbleToGraveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c100000109.costfilter,tp,LOCATION_SZONE,0,1,1,nil,100000107)
	local g2=Duel.SelectMatchingCard(tp,c100000109.costfilter,tp,LOCATION_SZONE,0,1,1,nil,100000108)
	g1:Merge(g2)
	g1:AddCard(e:GetHandler())
	Duel.SendtoGrave(g1,REASON_COST)
end
function c100000109.spfilter(c,e,tp)
	return c:IsCode(5861892) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c100000109.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000109.spfilter,tp,0x13,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000109.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c100000109.spfilter,tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
