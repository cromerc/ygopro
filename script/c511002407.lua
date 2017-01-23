--Take Over
function c511002407.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002407.target)
	e1:SetOperation(c511002407.activate)
	c:RegisterEffect(e1)
	if not c511002407.global_check then
		c511002407.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		ge1:SetOperation(c511002407.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002407.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsFaceup,nil)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511002407+tc:GetSummonPlayer(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		tc=g:GetNext()
	end
end
function c511002407.filter(c,e,tp)
	return c:IsReleasableByEffect() and c:GetFlagEffect(511002407+tp)>0
		and Duel.IsExistingMatchingCard(c511002407.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetRace())
		and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or c:IsControler(tp))
end
function c511002407.spfilter(c,e,tp,race)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsRace(race)
end
function c511002407.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002407.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002407.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=Duel.SelectMatchingCard(tp,c511002407.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp):GetFirst()
	if tc and Duel.Release(tc,REASON_EFFECT)>0 then
		local race=tc:GetRace()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511002407.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetRace())
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
