--フォトン・デルタ・ウィング
function c100000240.initial_effect(c)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c100000240.con)
	c:RegisterEffect(e1)
end
function c100000240.filter(c)
	return c:IsFaceup() and c:GetCode()==100000240
end
function c100000240.con(e)
	return Duel.IsExistingMatchingCard(c100000240.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
