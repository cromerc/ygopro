--Sea of Rebirth
function c513000007.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(513000007,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c513000007.spcon)
	e2:SetTarget(c513000007.sptg)
	e2:SetOperation(c513000007.spop)
	c:RegisterEffect(e2)
end
function c513000007.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c513000007.tgfilter(c,e,tp)
	return c:IsFaceup() and c:IsControler(1-tp) and (not e or c:IsRelateToEffect(e))
end
function c513000007.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c513000007.tgfilter,1,nil,nil,tp)
end
function c513000007.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000007.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c513000007.tgfilter,nil,nil,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct 
		and Duel.IsExistingMatchingCard(c513000007.filter,tp,LOCATION_DECK,0,ct,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.SetTargetCard(eg)
end
function c513000007.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local ct=eg:FilterCount(c513000007.tgfilter,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return end
	local g=Duel.GetMatchingGroup(c513000007.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,ct,ct,nil)
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
