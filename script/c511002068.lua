--Sacrifice Rank-up
function c511002068.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002068.target)
	e1:SetOperation(c511002068.activate)
	c:RegisterEffect(e1)
end
function c511002068.filter1(c,e,tp)
	return c:GetOverlayGroup():IsExists(Card.IsAbleToRemoveAsCost,2,nil)
		and Duel.IsExistingMatchingCard(c511002068.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetRank()+1)
end
function c511002068.filter2(c,e,tp,rk)
	return c:GetRank()==rk and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002068.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511002068.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c511002068.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511002068.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local ovg=g:GetFirst():GetOverlayGroup()
	local sg=ovg:FilterSelect(tp,Card.IsAbleToRemoveAsCost,2,2,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002068.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c511002068.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetRank()+1):GetFirst()
	if sc then
		Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
	end
end
