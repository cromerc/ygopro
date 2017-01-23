--キャット・ワールド
function c100000175.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--ad up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c100000175.tg)
	e2:SetValue(c100000175.val)
	c:RegisterEffect(e2)
end
function c100000175.tg(e,c)
	return c:IsFaceup() and (c:IsSetCard(0x1305) or c:IsSetCard(0x2305))
end
function c100000175.val(e,c)
	return c:GetBaseAttack()
end
