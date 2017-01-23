-- Synchro Blast
-- Scripted by: UnknownGuest
function c511000159.initial_effect(c)
	-- activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- inflict 500
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000159,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000159.damcon)
	e2:SetOperation(c511000159.damop)
	c:RegisterEffect(e2)
end
function c511000159.damcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(tp) and a~=e:GetHandler() and a:IsType(TYPE_SYNCHRO)
end
function c511000159.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end