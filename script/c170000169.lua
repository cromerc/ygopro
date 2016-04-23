--Orichalcos Aristeros
--By Jackmoonward
function c170000169.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--change battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c170000169.cbcon)
	e2:SetOperation(c170000169.cbop)
	c:RegisterEffect(e2)
	--Shunoros Debuf
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetTarget(c170000169.target)
	e3:SetOperation(c170000169.operation)
	c:RegisterEffect(e3)
	--Destroyed when Shunoros leaves the field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c170000169.descon)
	c:RegisterEffect(e3)
end
function c170000169.cbcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c170000169.cbop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.ChangeAttackTarget(c)
local b=Duel.GetAttacker()
local def=b:GetAttack()+300
e:SetLabel(def)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_DEFENCE_FINAL)
e1:SetValue(def)
e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_DAMAGE)
c:RegisterEffect(e1)
end
function c170000169.filter(c)
	return c:IsFaceup() and c:IsCode(170000167) and c:GetAttack()~=0
end
function c170000169.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c170000169.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c170000169.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c170000169.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c170000169.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-e:GetHandler():GetDefence())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c170000169.filter2(c)
	return c:IsFaceup() and c:IsCode(170000167) 
end
function c170000169.descon(e)
	return not Duel.IsExistingMatchingCard(c170000169.filter2,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
