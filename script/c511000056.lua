--Double Ripple
function c511000056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000056.target)
	e1:SetOperation(c511000056.activate)
	c:RegisterEffect(e1)
end
function c511000056.filter1(c,tp)
	local lv1=c:GetLevel()
	return c:IsFaceup() and lv1>0 and c:IsType(TYPE_TUNER)
		 and Duel.IsExistingTarget(c511000056.filter2,tp,LOCATION_MZONE,0,1,nil,lv1)
end
function c511000056.filter2(c,lv1)
	local lv2=c:GetLevel()
	return c:IsFaceup() and lv2>0 and lv1+lv2==7 and not c:IsType(TYPE_TUNER) 
end
function c511000056.spfilter1(c,e,tp,lv)
	return c:GetCode()==2403771 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000056.spfilter2(c,e,tp,lv)
	return c:GetCode()==25862681 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000056.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return false end
	local sg1=Duel.GetMatchingGroup(c511000056.spfilter1,tp,LOCATION_EXTRA,0,nil,e,tp)
	local sg2=Duel.GetMatchingGroup(c511000056.spfilter2,tp,LOCATION_EXTRA,0,nil,e,tp)
	if chk==0 then
		if sg1:GetCount()==0 then return false end
		local mg,mlv=sg1:GetMinGroup(Card.GetLevel)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and Duel.IsExistingTarget(c511000056.filter1,tp,LOCATION_MZONE,0,1,nil,tp,mlv)
	end
	if chk==0 then
		if sg2:GetCount()==0 then return false end
		local mg,mlv=sg2:GetMinGroup(Card.GetLevel)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and Duel.IsExistingTarget(c511000056.filter1,tp,LOCATION_MZONE,0,1,nil,tp,mlv)
	end
	local mg,mlv=sg1:GetMinGroup(Card.GetLevel)
	local mg,mlv=sg2:GetMinGroup(Card.GetLevel)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectTarget(tp,c511000056.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp,mlv)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectTarget(tp,c511000056.filter2,tp,LOCATION_MZONE,0,1,1,nil,g1:GetFirst():GetLevel(),mlv)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g1,2,0,0)
	sg1:Merge(sg2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg1,2,0,0)
end
function c511000056.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==0 then return end
	Duel.SendtoGrave(tg,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.BreakEffect()
	local s1=Duel.GetFirstMatchingCard(c511000056.spfilter1,tp,LOCATION_EXTRA,0,nil,e,tp)
	Duel.SpecialSummonStep(s1,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	local s2=Duel.GetFirstMatchingCard(c511000056.spfilter2,tp,LOCATION_EXTRA,0,nil,e,tp)
	Duel.SpecialSummonStep(s2,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	Duel.SpecialSummonComplete()
end