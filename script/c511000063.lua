--Double Type Rescue
function c511000063.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000063.condition)
	e1:SetTarget(c511000063.target)
	e1:SetOperation(c511000063.activate)
	c:RegisterEffect(e1)
end
function c511000063.filter(c)
	return c:GetOriginalRace()~=c:GetRace() and not c:IsHasEffect(EFFECT_REMOVE_RACE) and not c:IsHasEffect(EFFECT_CHANGE_RACE)
end
function c511000063.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_MONSTER)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
		and (g:GetClassCount(Card.GetRace)>=2 or g:IsExists(c511000063.filter,1,nil))
end
function c511000063.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000063.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==tp and chkc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	if chk==0 then return Duel.IsExistingTarget(c511000063.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000063.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000063.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)		
	end
end