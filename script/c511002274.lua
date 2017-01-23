--Judgment of the Underworld Ruler
function c511002274.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c511002274.condition)
	e1:SetTarget(c511002274.target)
	e1:SetOperation(c511002274.activate)
	c:RegisterEffect(e1)
end
function c511002274.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and rp~=tp
end
function c511002274.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c511002274.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(0x10000000) and c:IsAbleToRemoveAsCost()
end
function c511002274.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsCode(68722455)
end
function c511002274.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	Duel.BreakEffect()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local g=Duel.GetMatchingGroup(c511002274.cfilter,tp,LOCATION_GRAVE,0,nil)
		local spg=Duel.GetMatchingGroup(c511002274.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
		if g:GetCount()>4 and spg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(62742651,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local rg=g:Select(tp,5,5,nil)
			Duel.Remove(g,POS_FACEUP,REASON_COST)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sp=spg:Select(tp,1,1,nil)
			Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
		end
	end	
end
