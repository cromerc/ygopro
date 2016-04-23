--天架ける星因士
function c501001058.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c501001058.cost)
	e1:SetTarget(c501001058.target)
	e1:SetOperation(c501001058.activate)
	c:RegisterEffect(e1)
end
function c501001058.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,501001058)==0 end
	Duel.RegisterFlagEffect(tp,501001058,RESET_PHASE+PHASE_END,0,1)
end
function c501001058.cfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x9a)
		and Duel.IsExistingMatchingCard(c501001058.spfilter,tp,LOCATION_DECK,0,1,nil,c:GetCode(),e,tp)
end
function c501001058.spfilter(c,code,e,tp)
	return c:GetCode()~=code and c:IsSetCard(0x9a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c501001058.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c501001058.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c501001058.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c501001058.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c501001058.spfilter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode(),e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c501001058.splimit)
		g:GetFirst():RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
function c501001058.splimit(e,c)
	return not c:IsSetCard(0x9a)
end
