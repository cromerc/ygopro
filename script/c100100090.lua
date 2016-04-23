--ゲート・ブロッカー
function c100100090.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(100100090)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100100090.tgn)
	c:RegisterEffect(e1)
end
function c100100090.tgn(e,c)
	return c==e:GetHandler()
end
