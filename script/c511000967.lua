--Junk Factory
function c511000967.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x43))
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000967,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000967.condition)
	e3:SetOperation(c511000967.operation)
	c:RegisterEffect(e3)
end
function c511000967.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if a:IsControler(1-tp) then a,d=d,a end
	if a:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return d and d:IsStatus(STATUS_BATTLE_DESTROYED) and not d:IsType(TYPE_TOKEN) and d:GetLeaveFieldDest()==0
		and a:IsSetCard(0x43)
end
function c511000967.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a,d=d,a end
	if d:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_SEND_REPLACE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetTarget(c511000967.reptg)
		e1:SetOperation(c511000967.repop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e1)
	end
end
function c511000967.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE and c:IsReason(REASON_BATTLE) end
	return true
end
function c511000967.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end
