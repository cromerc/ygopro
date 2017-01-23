--スクラム・フォース
function c100000111.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)	
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c100000111.con)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsDefensePos))
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c100000111.con(e)
	return Duel.IsExistingMatchingCard(Card.IsDefensePos,e:GetHandlerPlayer(),LOCATION_MZONE,0,2,nil)
end
