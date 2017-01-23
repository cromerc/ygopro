--防覇龍ヘリオスフィア
function c511002741.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c511002741.atcon)
	c:RegisterEffect(e1)
end
function c511002741.atcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
