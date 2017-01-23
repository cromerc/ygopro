--Baby Spider
function c511000545.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(5)
	e1:SetCondition(c511000545.lvcon)
	c:RegisterEffect(e1)
end
function c511000545.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000545)>0
end
