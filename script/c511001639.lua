--Junk Changer
function c511001639.initial_effect(c)
	--shift lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001639,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001639.condition)
	e1:SetOperation(c511001639.operation)
	c:RegisterEffect(e1)
end
function c511001639.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x43)
end
function c511001639.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001639.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c511001639.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(76922029,0))
		local op=Duel.SelectOption(tp,aux.Stringid(82693917,0),aux.Stringid(17643265,0))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		if op==0 then
			e1:SetValue(1)
		else
			e1:SetValue(-1)
		end
		c:RegisterEffect(e1)
	end
end
