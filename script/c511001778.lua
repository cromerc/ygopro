--牙鮫帝シャーク・カイゼル
function c511001778.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,4)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(69610924,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511001778.cost)
	e1:SetOperation(c511001778.operation)
	c:RegisterEffect(e1)
end
function c511001778.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001778.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=(c:GetMaterialCount()-c:GetOverlayCount())*1000
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
