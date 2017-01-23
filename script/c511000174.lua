--Disgraced Mage
function c511000174.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000174,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c511000174.condition)
	e1:SetOperation(c511000174.operation)
	c:RegisterEffect(e1)
	--no damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetCondition(c511000174.damcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c511000174.desreptg)
	c:RegisterEffect(e3)
end
function c511000174.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not bc:IsType(TYPE_TOKEN) and bc:GetLeaveFieldDest()==0
end
function c511000174.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetCode(EFFECT_SEND_REPLACE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetTarget(c511000174.reptg)
		e1:SetOperation(c511000174.repop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e1)
	end
end
function c511000174.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE and c:IsReason(REASON_BATTLE) end
	return true
end
function c511000174.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end
function c511000174.damcon(e)
	return e:GetHandler()==Duel.GetAttackTarget()
end
function c511000174.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:IsFaceup() and g:GetCount()>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(511000174,0)) then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		return true
	else return false end
end
