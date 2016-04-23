--エンジェル・ストリングス
function c111011501.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c111011501.target)
	e1:SetOperation(c111011501.activate)
	c:RegisterEffect(e1)
end
function c111011501.mfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x83) and c:IsType(TYPE_XYZ)
end
function c111011501.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsType(TYPE_XYZ)
end
function c111011501.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c111011501.mfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c111011501.mfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c111011501.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c111011501.mfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c111011501.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local mat=Duel.GetMatchingGroup(c111011501.filter,tp,LOCATION_GRAVE,0,nil,e,tp)	
	if tc:IsRelateToEffect(e) and mat:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local mat1=mat:Select(tp,1,1,nil):GetFirst()
		if Duel.SpecialSummon(mat1,0,tp,tp,false,false,POS_FACEUP) then
			Duel.BreakEffect()
			local mg=tc:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(mat1,mg)
			end
			Duel.Overlay(mat1,tc)
		end
	end
end
