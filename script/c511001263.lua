--Monster Pie
function c511001263.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c511001263.condition)
	e1:SetTarget(c511001263.target)
	e1:SetOperation(c511001263.operation)
	c:RegisterEffect(e1)
end
function c511001263.filter(c,tp)
	return c:GetPreviousControler()~=tp
end
function c511001263.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x205)
end
function c511001263.condition(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c511001263.filter,nil,tp)
	return ct>0 and Duel.IsExistingMatchingCard(c511001263.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001263.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c511001263.filter,nil,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>ct-1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001264,0,0x4011,1000,1000,3,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c511001263.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c511001263.filter,nil,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>ct-1 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001264,0,0x4011,1000,1000,3,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
		for i=1,ct do
			local token=Duel.CreateToken(tp,511001264)
			Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_DESTROY)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetOperation(c511001263.damop)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e2,true)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511001263.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,1000,REASON_EFFECT)
end
