--Cat Shark
function c511002076.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2)
	c:EnableReviveLimit()
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002076.cost)
	e1:SetTarget(c511002076.target)
	e1:SetOperation(c511002076.operation)
	c:RegisterEffect(e1)
end
function c511002076.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002076.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsRankBelow(4)
end
function c511002076.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002076.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002076.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002076.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
