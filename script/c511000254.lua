--Dimension Fusion Destruction
function c511000254.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000254.target)
	e1:SetOperation(c511000254.activate)
	c:RegisterEffect(e1)
end
function c511000254.tffilter(c)
	local code=c:GetCode()
	return c:IsAbleToRemove()
	and (code==32491823 or code==69890969 or code==6007214)
end
function c511000254.tfilter(c,e,tp)
	return c:IsCode(511000253) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000254.filter(c,code)
	return c:IsCode(code) and c:IsAbleToRemove()
end
function c511000254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000254.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,6007214)
	 and Duel.IsExistingMatchingCard(c511000254.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,32491823)
	 and Duel.IsExistingMatchingCard(c511000254.filter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,69890969) 
	 and Duel.IsExistingMatchingCard(c511000254.tfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
end
function c511000254.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511000254.tffilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=sg:Select(tp,1,1,nil)
	sg:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	local ft=2
	local g2=nil
	while ft>0 do
		g2=sg:Select(tp,1,1,nil)
		g1:Merge(g2)
		sg:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
		ft=ft-1
	end
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local sg=Duel.SelectMatchingCard(tp,c511000254.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
	end
end