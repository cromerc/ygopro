--Release Change
function c511000982.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000982.target)
	e1:SetOperation(c511000982.activate)
	c:RegisterEffect(e1)
end
function c511000982.filter(c,e,tp)
	return c:IsReleasableByEffect()
		and Duel.IsExistingMatchingCard(c511000982.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetLevel())
end
function c511000982.spfilter(c,e,tp,lv)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv
end
function c511000982.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c511000982.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c511000982.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	Duel.SelectTarget(tp,c511000982.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000982.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.Release(tc,REASON_EFFECT)~=0 then
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c511000982.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetLevel())
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
