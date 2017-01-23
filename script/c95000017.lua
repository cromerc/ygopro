--Numeron Calling
function c95000017.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000017.target)
	e1:SetOperation(c95000017.activate)
	c:RegisterEffect(e1)
end
c95000017.mark=0
function c95000017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,95000018,0,0x4011,2000,0,0,0,0) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,4,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,0,0)
end
function c95000017.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>3 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,95000018,0,0x4011,2000,0,0,0,0) then
		for i=1,4 do
			local token=Duel.CreateToken(tp,95000017+i)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(c)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_RACE)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(c)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e2,true)
			token:SetStatus(STATUS_NO_LEVEL,true)
			local e3=Effect.CreateEffect(token)
			e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e3:SetCode(EVENT_DAMAGE_STEP_END)
			e3:SetOperation(c95000017.atkop)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e3)
		end
		Duel.SpecialSummonComplete()
	end
end
function c95000017.filter(c,e)
	return c:IsFaceup() and c:IsType(TYPE_TOKEN) and not c:IsImmuneToEffect(e) and c:IsSetCard(0x48)
end
function c95000017.atkop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c95000017.filter,tp,LOCATION_MZONE,0,nil,e)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
