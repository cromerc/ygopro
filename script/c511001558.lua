--水晶薔薇の女神
function c511001558.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001558,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c511001558.condition)
	e1:SetOperation(c511001558.operation)
	c:RegisterEffect(e1)
end
function c511001558.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not bc:IsType(TYPE_TOKEN) and bc:GetLeaveFieldDest()==0
end
function c511001558.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetCode(EFFECT_SEND_REPLACE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetTarget(c511001558.reptg)
		e1:SetOperation(c511001558.repop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e1)
	end
end
function c511001558.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE and c:IsReason(REASON_BATTLE) end
	return true
end
function c511001558.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
