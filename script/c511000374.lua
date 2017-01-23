--Cursed Waters Level 3
function c511000374.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000374.condition)
	e1:SetOperation(c511000374.activate)
	c:RegisterEffect(e1)
end
function c511000374.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c511000374.check()
	return Duel.IsExistingMatchingCard(c511000374.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
function c511000374.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511000374.check()
end
function c511000374.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(c511000374.sumfilter))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000374.sumfilter(c)
	return c:GetLevel()<=3
end
