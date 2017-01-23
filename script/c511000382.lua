--Defense Seal Wall
function c511000382.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000382.condition)
	e1:SetOperation(c511000382.activate)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c511000382.condition)
	e2:SetOperation(c511000382.activate)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511000382.descon)
	e3:SetOperation(c511000382.desop)
	c:RegisterEffect(e3)
end
function c511000382.cfilter(c)
	return c:IsCode(13893596) and c:IsFaceup()
end
function c511000382.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c511000382.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000382.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if tc and tc:IsRelateToBattle() and Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
function c511000382.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCode,1,nil,13893596)
end
function c511000382.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
