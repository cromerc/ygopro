--Amazoness Arena
function c511001731.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001731.target)
	e1:SetOperation(c511001731.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511001731.chkop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001731,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(511001731)
	e3:SetCost(c511001731.damcost)
	e3:SetTarget(c511001731.damtg)
	e3:SetOperation(c511001731.damop)
	c:RegisterEffect(e3)
end
function c511001731.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,600)
end
function c511001731.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,600,REASON_EFFECT)
	Duel.Recover(1-tp,600,REASON_EFFECT)
end
function c511001731.chkop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.GetAttacker() then return end
	Duel.RaiseSingleEvent(e:GetHandler(),511001731,e,r,rp,Duel.GetAttacker():GetControler(),0)
end
function c511001731.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,100) end
	Duel.PayLPCost(tp,100)
end
function c511001731.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(100)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,100)
end
function c511001731.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
