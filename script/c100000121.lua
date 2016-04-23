--開運ミラクルストーン
function c100000121.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c100000121.tg)
	e2:SetValue(c100000121.val)
	c:RegisterEffect(e2)
	--attack res
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c100000121.target)
	c:RegisterEffect(e3)
end
function c100000121.tg(e,c)
	return c:IsSetCard(0x302)
end
function c100000121.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x302)
end
function c100000121.val(e,c)
	return Duel.GetMatchingGroupCount(c100000121.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*1000
end
function c100000121.target(e,c)
	return c:IsStatus(STATUS_SUMMON_TURN) and c:IsSetCard(0x302) and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)~=0 
end
