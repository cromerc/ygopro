--Orichalcos Dexia
--By Jackmoonward
function c170000168.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--ATK Increase
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c170000168.adval)
	c:RegisterEffect(e2)
	--Shunoros Debuf
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetTarget(c170000168.target)
	e3:SetOperation(c170000168.operation)
	c:RegisterEffect(e3)
	--Destroyed when Shunoros leaves the field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c170000168.descon)
	c:RegisterEffect(e3)
end
function c170000168.adval(e,c)
	local ph=Duel.GetCurrentPhase()
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if ph==PHASE_DAMAGE_CAL or PHASE_DAMAGE or Duel.IsDamageCalculated() and c:IsRelateToBattle() then
		if a==c and d:IsAttackPos() then return d:GetAttack()+300 end
		if a==c and d:IsDefencePos() then return d:GetDefence()+300 end
		if d==c then return a:GetAttack()+300 end
		if not a==c and not d==c then return 0 end
	end
	if not ph==PHASE_DAMAGE_CAL or not PHASE_DAMAGE or not Duel.IsDamageCalculated() then return 0 end
end
function c170000168.filter(c)
	return c:IsFaceup() and c:IsCode(170000167) and c:GetAttack()~=0
end
function c170000168.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c170000168.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c170000168.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c170000168.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c170000168.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-e:GetHandler():GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c170000168.filter2(c)
	return c:IsFaceup() and c:IsCode(170000167)
end
function c170000168.descon(e)
	return not Duel.IsExistingMatchingCard(c170000168.filter2,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end