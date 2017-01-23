--Sneak Exploder
function c511002548.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002548.condition)
	e1:SetTarget(c511002548.target)
	c:RegisterEffect(e1)
	--destroy&damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26302522,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002548.descon)
	e2:SetTarget(c511002548.destg)
	e2:SetOperation(c511002548.desop)
	c:RegisterEffect(e2)
end
function c511002548.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==0
end
function c511002548.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(511002548,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,0,1)
end
function c511002548.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and e:GetHandler():GetFlagEffect(511002548)>0
end
function c511002548.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function c511002548.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	if Duel.SendtoGrave(c,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end
