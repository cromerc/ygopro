--同胞の絆
function c100000478.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000478.cost)
	e1:SetTarget(c100000478.target)
	e1:SetOperation(c100000478.activate)
	c:RegisterEffect(e1)
end
function c100000478.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c100000478.cfilter(c,e,tp)
	local gr=c:GetRace()
	return Duel.IsExistingMatchingCard(c100000478.spfilter,tp,LOCATION_DECK,0,2,nil,gr,e,tp)
end
function c100000478.spfilter(c,gr,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(gr) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c100000478.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100000478.cfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c100000478.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000478.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000478.spfilter2(c,gr,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(gr) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c100000478.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=1 then return end
	local c=e:GetHandler()
	local slv=tc:GetRace()
	local sg=Duel.GetMatchingGroup(c100000478.spfilter,tp,LOCATION_DECK,0,nil,slv,e,tp)
	if sg:GetCount()<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=sg:Select(tp,2,2,nil)
	local tc=g:GetFirst()
	while tc do
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		--cannot release
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UNRELEASABLE_SUM)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		tc:RegisterEffect(e3)
		end
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
