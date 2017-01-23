--Ability Yeil
--scripted by andré and shad3
function c511004401.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511004401.op)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c511004401.handcon)
	c:RegisterEffect(e2)
end
function c511004401.op()
	Duel.RegisterFlagEffect(0,511004401,0,0,0)
end
function c511004401.handcon(tp)
	return tp~=Duel.GetTurnPlayer()
end
