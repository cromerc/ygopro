--Spacetime Trancendency
function c511000657.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000657.cost)
	e1:SetTarget(c511000657.target)
	e1:SetOperation(c511000657.activate)
	c:RegisterEffect(e1)
end
function c511000657.cfilter(c)
	return c:IsRace(RACE_DINOSAUR) and c:IsAbleToRemoveAsCost()
end
function c511000657.filter(c,lv,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingMatchingCard(c511000657.cfilter,c:GetControler(),LOCATION_GRAVE,0,c:GetLevel(),nil)
end
function c511000657.filter2(c,lv,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv
end
function c511000657.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511000657.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=Duel.GetMatchingGroupCount(c511000657.cfilter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511000657.filter,tp,LOCATION_HAND,0,1,nil,lv,e,tp) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local sp=Duel.GetMatchingGroup(c511000657.filter,tp,LOCATION_HAND,0,nil,lv,e,tp)
	local tgmax=sp:GetMaxGroup(Card.GetLevel)
	local tgmin=sp:GetMinGroup(Card.GetLevel)
	local maxlv=tgmax:GetFirst():GetLevel()
	local minlv=tgmin:GetFirst():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000657.cfilter,tp,LOCATION_GRAVE,0,minlv,maxlv,nil)
	local ct=g:GetCount()
	local add=0
	lv=Duel.GetMatchingGroupCount(c511000657.cfilter,tp,LOCATION_GRAVE,0,nil)
	while not Duel.IsExistingMatchingCard(c511000657.filter2,tp,LOCATION_HAND,0,1,nil,ct,e,tp) and Duel.IsExistingMatchingCard(c511000657.filter,tp,LOCATION_HAND,0,1,nil,ct+lv,e,tp) do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g2=Duel.SelectMatchingCard(tp,c511000657.cfilter,tp,LOCATION_GRAVE,0,1,maxlv-ct,nil)
		ct=ct+g2:GetCount()
		g:Merge(g2)
	end
	Duel.SetTargetParam(ct)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000657.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or lv<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000657.filter2,tp,LOCATION_HAND,0,1,1,nil,lv,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
		Duel.SpecialSummonComplete()
	end
end
