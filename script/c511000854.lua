--Overlay Unit Reborn
function c511000854.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000854.target)
	e1:SetOperation(c511000854.activate)
	c:RegisterEffect(e1)
end
function c511000854.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and bit.band(c:GetPreviousLocation(),LOCATION_OVERLAY)~=0
end
function c511000854.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c511000854.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c511000854.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000854.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	if g:GetCount()>1 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
