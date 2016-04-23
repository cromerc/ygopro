--水神の護符
function c106001003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c106001003.activate)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)	
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c106001003.tg)
	e2:SetValue(c106001003.tgval)
	c:RegisterEffect(e2)
end
function c106001003.tg(e,c)
	return c:IsPosition(POS_FACEUP) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c106001003.tgval(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()	
end
function c106001003.activate(e,tp,eg,ep,ev,re,r,rp)	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetCondition(c106001003.spcon)
	e1:SetOperation(c106001003.spop)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
	Duel.RegisterEffect(e1,tp)
end
function c106001003.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()>=e:GetLabel()+4 and Duel.GetTurnPlayer()==tp
end
function c106001003.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end