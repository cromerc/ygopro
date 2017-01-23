--Star Level Shuffle
function c511001367.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001367.cost)
	e1:SetTarget(c511001367.target)
	e1:SetOperation(c511001367.activate)
	c:RegisterEffect(e1)
end
function c511001367.cfilter(c,e,tp)
	return c:GetLevel()>0 and c:IsAbleToGraveAsCost() and Duel.IsExistingTarget(c511001367.filter,tp,LOCATION_GRAVE,0,1,nil,c:GetLevel(),e,tp)
end
function c511001367.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001367.filter(c,lv,e,tp)
	return c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001367.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001367.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001367.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local lv=g:GetFirst():GetLevel()
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511001367.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001367.filter,tp,LOCATION_GRAVE,0,1,1,nil,lv,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
