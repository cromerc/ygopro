--Darkness Half
function c511001528.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511001528.condition)
	e1:SetTarget(c511001528.target)
	e1:SetOperation(c511001528.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001528.descon)
	e2:SetOperation(c511001528.desop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511001528.desop2)
	c:RegisterEffect(e3)
end
function c511001528.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001528.cfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511001528.filter(c,tp)
	local atk=c:GetAttack()
	return c:IsFaceup() and not Duel.IsExistingMatchingCard(c511001528.cfilter,tp,LOCATION_MZONE,0,1,nil,atk)
end
function c511001528.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001528.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001528.filter,tp,LOCATION_MZONE,0,1,nil,tp) 
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(1-tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(1-tp,511001529,0,0x4011,1000,1000,3,RACE_FIEND,ATTRIBUTE_DARK)end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511001528.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511001528.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.IsPlayerAffectedByEffect(1-tp,59822133) then return end
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1 
			and Duel.IsPlayerCanSpecialSummonMonster(1-tp,511001529,0,0x4011,1000,1000,3,RACE_FIEND,ATTRIBUTE_DARK) then
			for i=1,2 do
				local token=Duel.CreateToken(tp,511001529)
				Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
			end
			Duel.SpecialSummonComplete()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511001528.rcon)
		e1:SetValue(c511001528.value)
		tc:RegisterEffect(e1,true)
	end
end
function c511001528.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511001528.value(e,c)
	return c:GetBaseAttack()/2
end
function c511001528.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001528.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(), REASON_EFFECT)
end
function c511001528.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
