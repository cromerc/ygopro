--Spirit Wave Barrier
function c511000981.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000981.target)
	c:RegisterEffect(e1)
	--negate and destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000981,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000981.con)
	e2:SetTarget(c511000981.tg)
	e2:SetOperation(c511000981.op)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000981.sdescon)
	e3:SetOperation(c511000981.sdesop)
	c:RegisterEffect(e3)
end
function c511000981.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():SetTurnCounter(0)
end
function c511000981.con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function c511000981.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511000981.op(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at:IsAttackable() then
		if Duel.NegateAttack() then
			Duel.Destroy(at,REASON_EFFECT)
		end
	end
end
function c511000981.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511000981.sdesop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		Duel.Destroy(c,REASON_RULE)
	end
end
