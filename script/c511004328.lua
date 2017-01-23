--hunting net
--scripted by andré
function c511004328.initial_effect(c)
	--place on spell field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511004328.condition)
	e1:SetTarget(c511004328.target)
	e1:SetOperation(c511004328.operation)
	c:RegisterEffect(e1)
end
function c511004328.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_ONFIELD)
end
function c511004328.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	return ex and tg~=nil and tc+tg:FilterCount(c511004328.filter,nil)-tg:GetCount()>0
end
function c511004328.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c511004328.operation(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	local og=tg:Filter(c511004328.filter,nil)
	local oc=og:GetFirst()
	while oc and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 do
		Duel.MoveToField(oc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		oc:AddCounter(0x1107,1)
		oc=og:GetNext()
	end
end