--Overlay Accel
function c511000684.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000684.condition)
	e2:SetCost(c511000684.cost)
	e2:SetOperation(c511000684.operation)
	c:RegisterEffect(e2)
end
function c511000684.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsType(TYPE_XYZ)
end
function c511000684.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	eg:GetFirst():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000684.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetEffectCount(EFFECT_EXTRA_ATTACK)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(ct+1)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e2)
end
