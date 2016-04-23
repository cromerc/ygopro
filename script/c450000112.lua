--キャプテン・ウィング
function c450000112.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c450000112.pcon)
	c:RegisterEffect(e1)
end
function c450000112.filter(c)
	return c:IsFaceup() and c:IsCode(450000110)
end
function c450000112.pcon(e)
	return Duel.IsExistingMatchingCard(c450000112.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.GetEnvironment()==450000110
end
