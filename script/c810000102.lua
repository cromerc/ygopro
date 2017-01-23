--Magnet Reverse
--scripted by: UnknownGuest
function c810000102.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c810000102.sptg)
	e1:SetOperation(c810000102.spop)
	c:RegisterEffect(e1)
end
function c810000102.filter(c,e,tp,id)
	return (c:IsRace(RACE_MACHINE) or c:IsRace(RACE_ROCK)) and c:GetTurnID()==id and not c:IsReason(REASON_RETURN) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c810000102.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c810000102.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,Duel.GetTurnCount()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c810000102.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,Duel.GetTurnCount())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c810000102.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SpecialSummon(sg:GetFirst(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
