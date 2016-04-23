-- Thousand Crisscross
-- Scripted by: UnknownGuest
function c511000048.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c511000048.condition)
	e1:SetOperation(c511000048.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000048,1))
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetLabel(2)
	e2:SetCountLimit(2)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c511000048.condition)
	e2:SetOperation(c511000048.operation)
	c:RegisterEffect(e2)	
end
function c511000048.condition(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	return Duel.GetLP(p)<2000
end
function c511000048.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	Duel.SetLP(tp,2000,REASON_EFFECT)
	local ct=e:GetLabel()
	ct=ct-1
	e:SetLabel(ct)
	if ct==0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
