--Dragon Evolution
function c511000341.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c511000341.cost)
	e1:SetTarget(c511000341.target)
	e1:SetOperation(c511000341.activate)
	c:RegisterEffect(e1)
end
function c511000341.rfilter(c,e,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsRace(RACE_DRAGON) and Duel.IsExistingMatchingCard(c511000341.spfilter,tp,LOCATION_HAND,0,1,c,e,tp,lv)
end
function c511000341.spfilter(c,e,tp,lv)
	return c:IsRace(RACE_DRAGON) and c:GetLevel()==lv+1 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000341.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511000341.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c511000341.rfilter,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	local tc=Duel.SelectReleaseGroup(tp,c511000341.rfilter,1,1,nil,e,tp):GetFirst()
	local lv=tc:GetLevel()
	Duel.Release(tc,REASON_COST)
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000341.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000341.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,lv)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
