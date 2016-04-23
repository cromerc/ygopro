--Raid Raptors - Rise Falcon
function c51370056.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),4),3)
	c:EnableReviveLimit()
	--~ --cannot be battle target
	--~ local e1=Effect.CreateEffect(c)
	--~ e1:SetType(EFFECT_TYPE_FIELD)
	--~ e1:SetRange(LOCATION_MZONE)
	--~ e1:SetTargetRange(0,LOCATION_MZONE)
	--~ e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	--~ e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	--~ e1:SetTarget(c51370056.tg)
	--~ e1:SetValue(c51370056.btval)
	--~ c:RegisterEffect(e1)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c51370056.atkfilter)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e2)
	--adup
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCost(c51370056.atkcost)
	e3:SetTarget(c51370056.atktg)
	e3:SetOperation(c51370056.atkop)
	c:RegisterEffect(e3)
end
function c51370056.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c51370056.filter(c)
	return c:IsPreviousLocation(LOCATION_EXTRA)
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c51370056.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51370056.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c51370056.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c51370056.filter,tp,0,LOCATION_MZONE,nil)
		local atk=g:GetSum(Card.GetAttack)
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk)
			e1:SetReset(RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end



function c51370056.bttg(e,c)
	return c51370056.atkfilter(c,e:GetHandlerPlayer())
end
function c51370056.btval(e,c)
	return c==e:GetHandler()
end
function c51370056.atkfilter(e,c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c51370056.tg(e,c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_NORMAL)
end
function c51370056.btval(e,c)
	return c==e:GetHandler()
end
