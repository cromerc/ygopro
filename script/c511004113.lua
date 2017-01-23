--Voltage Summon
--scripted by:urielkama
function c511004113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004113.target)
	e1:SetOperation(c511004113.activate)
	c:RegisterEffect(e1)
end
function c511004113.filter(c)
	return c:IsReleasableByEffect() and c:IsCode(511004125)
end
function c511004113.spfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511004113.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=Duel.GetMatchingGroup(c511004113.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return sg:GetCount()>0 and Duel.IsExistingMatchingCard(c511004113.spfilter,tp,LOCATION_DECK,0,sg:GetCount(),nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511004113.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511004113.filter,tp,LOCATION_MZONE,0,nil)
	if Duel.Release(sg,REASON_EFFECT)>0 then
		sg=Duel.GetOperatedGroup()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511004113.spfilter,tp,LOCATION_DECK,0,sg:GetCount(),sg:GetCount(),nil,e,tp)
		if g:GetCount()>0 then
	    local tc=g:GetFirst()
	    while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_BASE_ATTACK)
		e3:SetValue(0)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_SET_BASE_DEFENSE)
		tc:RegisterEffect(e4)
		tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
		end
	end
end