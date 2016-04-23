--リトマスの死の剣士
function c100001010.initial_effect(c)
	c:EnableReviveLimit()

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c100001010.efilter)
	c:RegisterEffect(e1)

	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)

	--atk,def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetValue(c100001010.val)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_BASE_DEFENCE)
	c:RegisterEffect(e4)
end

function c100001010.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end

function c100001010.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP)
end

function c100001010.val(e,c)
	atk = 0
	if Duel.GetMatchingGroupCount(c100001010.filter,c:GetControler(),LOCATION_SZONE,LOCATION_SZONE,c) > 0 then
	atk = 3000
	end
	return atk
end