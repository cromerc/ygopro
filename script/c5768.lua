--トゥーン・マスク
function c5768.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c5768.target)
	e1:SetOperation(c5768.activate)
	c:RegisterEffect(e1)
end
function c5768.filter(c,e,tp)
	if not c:IsFaceup() then return false end
	local lv=c:GetLevel()
	if c:IsType(TYPE_XYZ) then
		lv=c:GetRank()
	end
	return Duel.IsExistingMatchingCard(c5768.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,lv)
end
function c5768.spfilter(c,e,tp,lv)
	return c:IsLevelBelow(lv) and c:IsType(TYPE_TOON) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c5768.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c:IsFaceup() then
			local lv=chkc:GetLevel()
			if chkc:IsType(TYPE_XYZ) then
				lv=chkc:GetRank()
			end
			return lv==e:GetLabel()
		end
		return false
	end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c5768.filter,tp,0,LOCATION_MZONE,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c5768.filter,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local lv=tc:GetLevel()
	if tc:IsType(TYPE_XYZ) then
		lv=tc:GetRank()
	end
	e:SetLabel(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c5768.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local lv=tc:GetLevel()
		if tc:IsType(TYPE_XYZ) then
			lv=tc:GetRank()
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c5768.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,lv)
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
