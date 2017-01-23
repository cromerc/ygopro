--H－C エクスカリバー
function c511000102.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,3),3)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(511000102,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000102.cost)
	e1:SetOperation(c511000102.operation)
	c:RegisterEffect(e1)
end
function c511000102.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000102.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		c:RegisterEffect(e1)
	end
end
