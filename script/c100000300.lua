--Ｔｈｅ Ｄｅｓｐａｉｒ Ｕｒａｎｕｓ
function c100000300.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c100000300.value)
	c:RegisterEffect(e1)
end
function c100000300.value(e,c)
	return Duel.GetMatchingGroupCount(Card.IsFaceup,e:GetHandler():GetControler(),LOCATION_SZONE,0,nil)*300
end
