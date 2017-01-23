--Guidance to Ore
function c511000611.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(511000611,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c511000611.target)
	e3:SetOperation(c511000611.operation)
	c:RegisterEffect(e3)
end
function c511000611.cfilter(c,e,tp)
	return c:IsRace(RACE_ROCK) and c:IsControler(tp) and c:IsReason(REASON_DESTROY)
		and bit.band(c:GetPreviousRaceOnField(),RACE_ROCK)~=0
		and Duel.IsExistingMatchingCard(c511000611.filter,tp,LOCATION_DECK,0,1,nil,c:GetCode(),e,tp)
end
function c511000611.filter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000611.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c511000611.cfilter,1,nil,e,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511000611.cfilter2(c,e,tp)
	return c:IsRace(RACE_ROCK) and c:IsControler(tp) and c:IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c511000611.filter,tp,LOCATION_DECK,0,1,nil,c:GetCode(),e,tp)
end
function c511000611.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local sg=eg:Filter(c511000611.cfilter2,nil,e,tp)
	if sg:GetCount()==1 then
		local tc=sg:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000611.filter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode(),e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local tc=sg:GetFirst()
		if not tc then return end
		local code=tc:GetCode()
		tc=sg:GetNext()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000611.filter,tp,LOCATION_DECK,0,1,1,nil,code,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
