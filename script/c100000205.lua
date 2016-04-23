--ギミック・パペット－ネクロ・ドール
function c100000205.initial_effect(c)
	--revive 
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)	
	e1:SetCondition(c100000205.condition)
	e1:SetCost(c100000205.cost)
	e1:SetTarget(c100000205.target)
	e1:SetOperation(c100000205.operation)
	c:RegisterEffect(e1)
end
function c100000205.cfilter(c,e,tp)
	return c:GetCode()==92418590 and c:IsAbleToRemoveAsCost() and c~=e:GetHandler()
end
function c100000205.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c100000205.cfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
end
function c100000205.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c100000205.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c100000205.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp) 	
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100000205.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and e:GetHandler():IsLocation(LOCATION_GRAVE) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.SetTargetCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100000205.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=e:GetHandler()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_GRAVE) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
