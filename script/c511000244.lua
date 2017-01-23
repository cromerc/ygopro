--Ultimate Ritual of the Forbidden Lord
function c511000244.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511000244.condition)
	e1:SetCost(c511000244.cost)
	e1:SetTarget(c511000244.target)
	e1:SetOperation(c511000244.activate)
	c:RegisterEffect(e1)
end
function c511000244.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,0x40)
	return g:GetClassCount(Card.GetCode)>=5
end
function c511000244.costfilter(c)
	return c:IsSetCard(0x40) and c:IsDiscardable()
end
function c511000244.tdfilter(c)
	return not c:IsAbleToDeckOrExtraAsCost()
end
function c511000244.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000244.costfilter,tp,LOCATION_HAND,0,2,nil) 
		and rg:GetCount()>0 and not rg:IsExists(c511000244.tdfilter,1,nil)end
	local g=Duel.GetMatchingGroup(c511000244.cfilter,tp,LOCATION_HAND,0,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(rg,nil,2,REASON_COST)
	Duel.DiscardHand(tp,c511000244.costfilter,2,2,REASON_COST+REASON_DISCARD)
end
function c511000244.filter(c,e,tp)
	return c:IsCode(13893596) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000244.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511000244.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511000244.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511000244.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c511000244.retcon)
		e1:SetOperation(c511000244.retop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc:CompleteProcedure()
	end
end
function c511000244.retfilter(c)
	return c:IsSetCard(0x40) and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_RETURN) and c:GetReasonEffect()
		and not c:GetReasonEffect():GetHandler():IsCode(13893596)
end
function c511000244.retcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000244.retfilter,1,nil)
end
function c511000244.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000244.retfilter,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
