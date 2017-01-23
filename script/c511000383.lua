--Rage of the Forbidden One
function c511000383.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000383.condition)
	e1:SetOperation(c511000383.activate)
	c:RegisterEffect(e1)
end
function c511000383.filter(c,code)
	return c:IsCode(code) and c:IsFaceup()
end
function c511000383.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000383.filter,tp,LOCATION_MZONE,0,1,nil,13893596)
end
function c511000383.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(0,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA)
	e1:SetTarget(c511000383.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000383.distarget(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_TRAP+TYPE_SPELL+TYPE_MONSTER)
end
