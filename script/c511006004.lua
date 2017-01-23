--Training Grounds
function c511006004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetValue(SUMMON_TYPE_NORMAL)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCost(c511006004.cost)
	e2:SetTarget(c511006004.target)
	e2:SetOperation(c511006004.operation)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end

function c511006004.lvfilter(c,se)
	return c:GetLevel()>6 and c:IsSummonable(false,se)
end
function c511006004.discardfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c511006004.filter(c,se,tp)
	return c511006004.lvfilter(c,se) and Duel.IsExistingMatchingCard(c511006004.discardfilter,tp,LOCATION_HAND,0,2,c) 
end
function c511006004.filter2(c,se,tp)
	return c511006004.discardfilter(c) and Duel.IsExistingMatchingCard(c511006004.lvfilter,tp,LOCATION_HAND,0,1,c,se) 
end

function c511006004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local se=e:GetLabelObject()
	if chk==0 then return Duel.IsExistingMatchingCard(c511006004.filter,tp,LOCATION_HAND,0,1,nil,se,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c511006004.filter2,tp,LOCATION_HAND,0,1,1,nil,se,tp)
	Duel.SendtoGrave(g1,REASON_COST)
	local g2=Duel.SelectMatchingCard(tp,c511006004.filter2,tp,LOCATION_HAND,0,1,1,nil,se,tp)
	Duel.SendtoGrave(g2,REASON_COST)
end
function c511006004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local se=e:GetLabelObject()
	if chk==0 then return Duel.IsExistingMatchingCard(c511006004.lvfilter,tp,LOCATION_HAND,0,1,nil,se) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c511006004.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local se=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,c511006004.lvfilter,tp,LOCATION_HAND,0,1,1,nil,se):GetFirst()
	if tc then
		Duel.Summon(tp,tc,false,se)
	end
end