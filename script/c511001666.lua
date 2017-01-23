--Numeron Xyz Revision
function c511001666.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c511001666.condition)
	e1:SetCost(c511001666.cost)
	e1:SetTarget(c511001666.target)
	e1:SetOperation(c511001666.activate)
	c:RegisterEffect(e1)
end
function c511001666.cfilter(c)
	return c:GetSequence()<5
end
function c511001666.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and eg:GetCount()==1 and (Duel.GetCurrentChain()==0 or (Duel.GetFlagEffect(tp,511001666)>0 and Duel.GetCurrentChain()==1)) 
		and eg:GetFirst():GetSummonType()==SUMMON_TYPE_XYZ 
		and not Duel.IsExistingMatchingCard(c511001666.cfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c511001666.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or eg:IsExists(Card.IsDestructable,1,nil) end
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_COST)
end
function c511001666.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c511001666.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001666.filter,tp,0,LOCATION_DECK,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_DECK)
end
function c511001666.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	local sg=Duel.GetMatchingGroup(c511001666.filter,tp,0,LOCATION_DECK,nil,e,tp)
	if sg:GetCount()<=0 then return end
	Duel.ConfirmCards(tp,sg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=sg:Select(tp,1,1,nil):GetFirst()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e2)
		Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)
	end
end
