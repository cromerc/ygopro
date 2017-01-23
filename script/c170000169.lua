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
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c170000169.descon)
	e4:SetOperation(c170000169.desop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE)
	e5:SetCondition(c170000169.atcon)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c170000169.atfilter(c)
	return c:IsFaceup() and c:IsCode(7634581)
end
function c170000169.atcon(e)
	return Duel.IsExistingMatchingCard(c170000169.atfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
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
	e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e1:SetValue(def)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e1)
end
function c170000169.filter(c)
	return c:IsFaceup() and c:IsCode(7634581) and c:GetAttack()~=0
end
function c170000169.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c170000169.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c170000169.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c170000169.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-e:GetHandler():GetDefense())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c170000169.desfilter(c,tp)
	return c:IsCode(7634581) and c:IsPreviousPosition(POS_FACEUP)
end
function c170000169.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c170000169.desfilter,1,nil,tp)
end
function c170000169.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
