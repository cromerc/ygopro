--銀幕の鏡壁
function c513000002.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DAMAGE_STEP)
	e1:SetCondition(c513000002.condition)
	e1:SetTarget(c513000002.target)
	e1:SetOperation(c513000002.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c513000002.operation)
	c:RegisterEffect(e2)
	--atkchange
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c513000002.atktg)
	e3:SetValue(c513000002.atkval)
	c:RegisterEffect(e3)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
	e2:SetLabelObject(g)
	e3:SetLabelObject(g)
end
function c513000002.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c513000002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetLabelObject():Clear()
end
function c513000002.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a and a:IsControler(1-tp) and a:IsFaceup() and a:IsLocation(LOCATION_MZONE) then
		e:GetLabelObject():AddCard(a)
		if a:GetFlagEffect(513000002)==0 then
			a:RegisterFlagEffect(513000002,RESET_EVENT+0x1fe0000,0,1)
		end
	end
end
function c513000002.atktg(e,c)
	return c:GetFlagEffect(513000002)~=0 and e:GetLabelObject():IsContains(c)
end
function c513000002.atkval(e,c)
	return c:GetAttack()/2
end
