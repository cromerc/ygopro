--Action Card - Avoid
function c95000044.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCondition(c95000044.condition)
	e1:SetOperation(c95000044.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000044.handcon)
	c:RegisterEffect(e2)
end
function c95000044.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()~=nil
end
function c95000044.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000044.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end


