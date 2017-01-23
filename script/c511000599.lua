--Stardust Mirage
function c511000599.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c511000599.condition)
	e1:SetTarget(c511000599.target)
	e1:SetOperation(c511000599.activate)
	c:RegisterEffect(e1)
end
function c511000599.cfilter(c)
	return c:IsFaceup() and c:IsCode(44508094)
end
function c511000599.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000599.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000599.filter(c,tp,turn)
	return c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:GetTurnID()==turn
end
function c511000599.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000599.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA,0,1,nil,tp,Duel.GetTurnCount()) end
end
function c511000599.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetMatchingGroup(c511000599.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA,0,nil,tp,Duel.GetTurnCount())
	local tc=g:GetFirst()
	while tc do
		if tc:IsPreviousPosition(POS_FACEUP_ATTACK) then
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
		elseif tc:IsPreviousPosition(POS_FACEDOWN_ATTACK) then
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_ATTACK,true)
		elseif tc:IsPreviousPosition(POS_FACEUP_DEFENSE) then
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
		else
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
		end
		tc=g:GetNext()
	end
end
