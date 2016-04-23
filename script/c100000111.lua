--スクラム・フォース
function c100000111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)	
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c100000111.spcon)
	e2:SetTarget(c100000111.tg)
	e2:SetValue(c100000111.tgval)
	c:RegisterEffect(e2)
end
function c100000111.filter(c)
	return c:IsPosition(POS_FACEUP_DEFENCE)
end
function c100000111.spcon(e,c)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c100000111.filter,c:GetControler(),LOCATION_MZONE,0,2,nil)
end
function c100000111.tg(e,c)
	return c:IsPosition(POS_FACEUP_DEFENCE)
end
function c100000111.tgval(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end