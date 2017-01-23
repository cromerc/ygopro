--Lifeline from the Graveyard
function c511000346.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000346.sptg)
	e1:SetOperation(c511000346.spop)
	c:RegisterEffect(e1)
end
function c511000346.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000346.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511000346.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000346.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
	local g1=g:GetFirst():GetLevel()*100
	local g2=g:GetNext():GetLevel()*100
	if Duel.CheckLPCost(tp,g1+g2) then
		Duel.PayLPCost(tp,g1+g2)
	else
		Duel.Damage(tp,g1+g2,REASON_COST)
	end
end
function c511000346.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
