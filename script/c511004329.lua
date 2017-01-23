--Mystic Lamp
--scripted by andré
function c511004329.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c511004329.operation)
	c:RegisterEffect(e1)
end
function c511004329.atktg(e,c)
	return c:GetFieldID()<=e:GetLabel() and c:IsCode(99510761)
end
function c511004329.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
		local mg,fid=g:GetMaxGroup(Card.GetFieldID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c511004329.atktg)
		e1:SetValue(700)
		e1:SetLabel(fid)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end