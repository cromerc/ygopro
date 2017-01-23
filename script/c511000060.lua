--Secret Passage
function c511000060.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c511000060.attg)
	c:RegisterEffect(e2)
end
function c511000060.filter(c,atk)
	return c:IsFacedown() or c:GetAttack()<=atk
end
function c511000060.attg(e,c,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsLevelBelow(2) and c:IsRace(RACE_SPELLCASTER)
		and not c:IsHasEffect(EFFECT_CANNOT_ATTACK) and not not Duel.IsExistingMatchingCard(c511000060.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())
end