--Wicked Trample
function c511000837.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage amp
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c511000837.dcon)
	e2:SetOperation(c511000837.dop)
	c:RegisterEffect(e2)
end
function c511000837.dcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c511000837.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,ev*2)
end
