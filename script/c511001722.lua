--Fuda Aratame
function c511001722.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001722.activate)
	c:RegisterEffect(e1)
end
function c511001722.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c511001722.filter)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
end
function c511001722.filter(e,c)
	return c:IsSetCard(0xe6)
end
