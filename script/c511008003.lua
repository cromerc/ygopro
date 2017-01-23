--Soul Barter
--Scripted by Snrk
function c511008003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511008003.cost)
	e1:SetTarget(c511008003.target)
	e1:SetOperation(c511008003.activate)
	c:RegisterEffect(e1)
end
function c511008003.filter1(c,e,tp)
	return c:IsAbleToGraveAsCost()
end
function c511008003.filter2(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511008003.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511008003.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	local g=Duel.SelectMatchingCard(tp,c511008003.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_COST)
		e:SetLabelObject(g:GetFirst())
	end
end
function c511008003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	-- if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c511008003.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
	Duel.IsExistingMatchingCard(c511008003.filter2,tp,LOCATION_GRAVE,0,1,e:GetLabelObject(),e,tp) end
	Duel.SetOperationInfo(0,OPERATION_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511008003.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511008003.filter2,tp,LOCATION_GRAVE,0,1,1,e:GetLabelObject(),e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end