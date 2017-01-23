--リペア・パペット
function c100000209.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c100000209.target)
	e1:SetOperation(c100000209.activate)
	c:RegisterEffect(e1)
end
function c100000209.cfilter(c,e,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE)
		and c:IsLevelBelow(4) and Duel.IsExistingMatchingCard(c100000209.filter,tp,LOCATION_DECK,0,1,nil,c:GetCode(),e,tp) 
		and (c:IsSetCard(0x83) or c:IsCode(3167573) or c:IsCode(71564150) or c:IsCode(41442341) 
		or c:IsCode(54098121) or c:IsCode(51119924))
end
function c100000209.filter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000209.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c100000209.cfilter,1,nil,e,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000209.cfilter2(c,e,tp)
	return c:IsLevelBelow(4) and (c:IsSetCard(0x83) or c:IsCode(3167573) or c:IsCode(71564150) or c:IsCode(41442341) 
		or c:IsCode(54098121) or c:IsCode(51119924)) and c:IsControler(tp) and c:IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c100000209.filter,tp,LOCATION_DECK,0,1,nil,c:GetCode(),e,tp)
end
function c100000209.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local sg=eg:Filter(c100000209.cfilter2,nil,e,tp)
	if sg:GetCount()==1 then
		local tc=sg:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100000209.filter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode(),e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local tc=sg:GetFirst()
		if not tc then return end
		tc=sg:GetNext()
		if tc then
			code=bit.bor(code,tc:GetCode())
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100000209.filter,tp,LOCATION_DECK,0,1,1,nil,code,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
