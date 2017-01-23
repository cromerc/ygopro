--Numeron Xyz Revision
function c95000027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c95000027.condition)
	e1:SetTarget(c95000027.target)
	e1:SetOperation(c95000027.activate)
	c:RegisterEffect(e1)
end
c95000027.mark=2
function c95000027.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and eg:GetCount()==1 and (Duel.GetCurrentChain()==0 or (Duel.GetFlagEffect(tp,95000027)>0 and Duel.GetCurrentChain()==1))
end
function c95000027.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c95000027.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_DECK)
end
function c95000027.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	local sg=Duel.GetMatchingGroup(c95000027.filter,tp,0,LOCATION_DECK,nil,e,tp)
	if sg:GetCount()<=0 then return end
	Duel.ConfirmCards(tp,sg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=sg:Select(tp,1,1,nil):GetFirst()
	Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)
end
