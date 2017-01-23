--Ancient Armageddon Gear
function c511001537.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001537.target)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511001537.damcon)
	e2:SetTarget(c511001537.damtg)
	e2:SetOperation(c511001537.damop)
	c:RegisterEffect(e2)
end
function c511001537.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetOperation(c511001537.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,1)
	c:RegisterEffect(e1)
end
function c511001537.desop(e,tp,eg,ep,ev,re,r,rp)
	if tp~=Duel.GetTurnPlayer() then return end
	Duel.Destroy(e:GetHandler(),REASON_RULE)
end
function c511001537.damcon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsType,nil,TYPE_MONSTER)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc:IsReason(REASON_DESTROY) and tc:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511001537.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(Card.IsType,nil,TYPE_MONSTER)
	local tc=g:GetFirst()
	if chk==0 then return true end
	Duel.SetTargetPlayer(tc:GetPreviousControler())
	Duel.SetTargetParam(tc:GetPreviousAttackOnField())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tc:GetPreviousControler(),tc:GetPreviousAttackOnField())
end
function c511001537.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
