--Phoenix Gravitation
function c110000113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c110000113.condition)
	e1:SetTarget(c110000113.target)
	e1:SetOperation(c110000113.op)
	c:RegisterEffect(e1)
end
function c110000113.cfilter(c)
	return c:IsFaceup() and c:IsCode(110000104)
end
function c110000113.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c110000113.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c110000113.filter(c,e,tp)
	return c:IsType(0x10000000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c110000113.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c110000113.filter,tp,LOCATION_GRAVE,0,4,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,tp,LOCATION_GRAVE)
end
function c110000113.op(e,tp,eg,ep,ev,re,r,rp)	
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c110000113.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>=4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,4,4,nil)
		local tc=sg:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(110000113,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			tc=sg:GetNext()
		end
		Duel.SpecialSummonComplete()
		sg:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabelObject(sg)
		e1:SetOperation(c110000113.desop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c110000113.desfilter(c)
	return c:GetFlagEffect(110000113)>0
end
function c110000113.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c110000113.desfilter,nil)
	g:DeleteGroup()
	Duel.Destroy(tg,REASON_EFFECT)
end
