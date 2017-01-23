--Dark Tyranno
function c511001717.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c511001717.con)
	c:RegisterEffect(e1)
end
function c511001717.con(e)
	return not Duel.IsExistingMatchingCard(Card.IsAttackPos,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
