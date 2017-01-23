--Elemental Mirage
function c511000491.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511000491.condition)
	e1:SetTarget(c511000491.target)
	e1:SetOperation(c511000491.operation)
	c:RegisterEffect(e1)
end
function c511000491.cfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:GetPreviousLocation()==LOCATION_MZONE 
	and bit.band(c:GetPreviousPosition(),POS_FACEUP)~=0 and c:GetReasonPlayer()==1-tp and c:IsSetCard(0x3008)
end
function c511000491.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000491.cfilter,1,nil,tp)
end
function c511000491.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c511000491.filter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:GetReasonPlayer()==1-tp and c:GetPreviousLocation()==LOCATION_MZONE
end
function c511000491.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000491.filter,nil,tp)
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
