--同胞の絆
function c100000478.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
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
function c100000478.filter(c,att)
	return c:IsAttribute(att) and c:IsFaceup()
end
function c100000478.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
		and Duel.IsExistingMatchingCard(c100000478.filter,tp,LOCATION_MZONE,0,1,nil,c:GetAttribute())
end
function c100000478.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c100000478.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)  end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c100000478.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000478.spfilter,tp,LOCATION_DECK,0,2,2,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
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
