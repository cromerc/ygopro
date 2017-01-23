--ギミック・パペット－シザー・アーム
function c511002865.initial_effect(c)
	--double lv
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002865.cost)
	e1:SetOperation(c511002865.operation)
	c:RegisterEffect(e1)
end
function c511002865.filter(c)
	return c:IsType(TYPE_EQUIP) and c:GetEquipTarget()~=nil and c:IsDestructable() and c:IsAbleToGraveAsCost()
end
function c511002865.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002865.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511002865.filter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Destroy(g,REASON_COST)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002865.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c:GetLevel()*2)
		c:RegisterEffect(e1)
	end
end
