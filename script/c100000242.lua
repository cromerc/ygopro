--光子圧力界
function c100000242.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c100000242.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c100000242.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x55)
end
function c100000242.operation(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c100000242.filter,1,nil) then
		if (Duel.GetMatchingGroup(c100000242.filter,tp,LOCATION_MZONE,0,nil):GetCount()==0 or Duel.GetMatchingGroup(c100000242.filter,tp,0,LOCATION_MZONE,nil):GetCount()==0)
		 and Duel.SelectYesNo(tp,aux.Stringid(100000242,0)) then
			local td=eg:Filter(c100000242.filter,nil)
			local tc=td:GetFirst()
			local dam=0
			while tc do
				dam=tc:GetLevel()*100
				if Duel.GetMatchingGroup(c100000242.filter,tp,LOCATION_MZONE,0,nil):GetCount()==0 then			
					Duel.Damage(tp,dam,REASON_EFFECT) end
				if Duel.GetMatchingGroup(c100000242.filter,tp,0,LOCATION_MZONE,nil):GetCount()==0 then
					Duel.Damage(1-tp,dam,REASON_EFFECT) end
				tc=td:GetNext()
			end
		end
	end
end
