--Barrier Ninjitsu Art of Hazy Extinguishing
function c511001518.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001518.actcon)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(c511001518.damval)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511001518.descon)
	e3:SetOperation(c511001518.desop)
	c:RegisterEffect(e3)
end
function c511001518.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c511001518.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001518.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001518.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 and rp~=e:GetHandlerPlayer() and val<=800 then
		return 0
	end
	return val
end
function c511001518.desfilter(c,tp)
	return c:IsSetCard(0x2b) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousControler()==tp
end
function c511001518.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001518.desfilter,1,nil,tp)
end
function c511001518.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
