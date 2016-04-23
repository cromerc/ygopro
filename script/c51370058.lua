--Dimension Xyz
function c51370058.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c51370058.condition)
	e1:SetOperation(c51370058.activate)
	c:RegisterEffect(e1)
end
function c51370058.cfilter(c,tp)
	return Duel.IsExistingMatchingCard(c51370058.cfilter2,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,2,c,c:GetCode())
end
function c51370058.cfilter2(c,code)
	return c:GetCode()==code
end
function c51370058.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c51370058.cfilter,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp)
		and Duel.GetLP(tp)<=1000
end
function c51370058.xyzfilter(c,mg)
	local mg=Duel.GetMatchingGroup(c51370058.cfilter,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
	if c.xyz_count~=3 then return false end
	return c:IsXyzSummonable(mg)
end
function c51370058.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.SelectMatchingCard(tp,c51370058.cfilter,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,3,3,nil,e,tp)
	if tc:GetCount()==0 then return end
	local xyzg=Duel.GetMatchingGroup(c51370058.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,tc)
	end
end
