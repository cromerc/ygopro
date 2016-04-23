--Mirror Knight Calling
function c170000174.initial_effect(c)
   c:EnableReviveLimit()
   --Special Summon Tokens
   local e1=Effect.CreateEffect(c)
   e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
   e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
   e1:SetCode(EVENT_SPSUMMON_SUCCESS)
   e1:SetCondition(c170000174.spcon)
   e1:SetTarget(c170000174.target)
   e1:SetOperation(c170000174.operation)
   c:RegisterEffect(e1)
   --Renew Mirror Shields
   local e2=Effect.CreateEffect(c)
   e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
   e2:SetCode(EVENT_PHASE+PHASE_END)
   e2:SetProperty(EFFECT_FLAG_REPEAT)
   e2:SetRange(LOCATION_MZONE)
   e2:SetCountLimit(1)
   e2:SetOperation(c170000174.renop)
   c:RegisterEffect(e2)
end
function c170000174.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c170000174.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,4,tp,0)
end
function c170000174.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,170000175,0,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_DARK) then return end
	for i=1,4 do
		local token=Duel.CreateToken(tp,170000175)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		token:AddCounter(0x97,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetTarget(c170000174.reptg)
		e1:SetOperation(c170000174.repop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
        local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
        e2:SetCode(EVENT_DAMAGE_CALCULATING)
        e2:SetCondition(c170000174.atkcon)
        e2:SetOperation(c170000174.atkop)
        token:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
function c170000174.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil and e:GetHandler():GetCounter(0x97)~=0
end
function c170000174.atkop(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetAttackTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
	e1:SetValue(bc:GetAttack())
	e:GetHandler():RegisterEffect(e1)
end
function c170000174.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_BATTLE) and e:GetHandler():GetCounter(0x97)>0 end
	return true
end
function c170000174.repop(e,tp,eg,ep,ev,re,r,rp,chk)
	e:GetHandler():RemoveCounter(tp,0x97,1,REASON_EFFECT)
end
function c170000174.renop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,0,nil,170000175)
	local tc=g:GetFirst()
	while tc do
        if tc:GetCounter(0x97)==0 then
		tc:AddCounter(0x97,1)
        end
		tc=g:GetNext()
	end
end