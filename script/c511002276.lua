--サイバー・ダイナソー
function c511002276.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c511002276.dircon)
	c:RegisterEffect(e1)
end
function c511002276.dircon(e)
	local tp=e:GetHandlerPlayer()
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP) 
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==1 
		and not Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil)
end
