--Captian Lock
--Scripted by GameMaster (GM)
function c511005604.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5265750,15653824,true,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e2)
	--selfdestroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511005604.descon)
	c:RegisterEffect(e3)
end
function c511005604.desfilter(c)
	 return c:IsFaceup() and c:GetAttack()>=1000  
end
function c511005604.descon(e)
	return  Duel.IsExistingMatchingCard(c511005604.desfilter,e:GetHandler():GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end