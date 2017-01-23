--Sacred Stone of Ojhat
function c511000166.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000166,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000166.spcon)
	c:RegisterEffect(e1)
	--pos limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000166.con)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
end
function c511000166.spfilter(c,code)
	return c:IsCode(code) and c:IsFaceup()
end
function c511000166.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000166.spfilter,tp,LOCATION_MZONE,0,1,nil,43730887)
		and Duel.IsExistingMatchingCard(c511000166.spfilter,tp,LOCATION_MZONE,0,1,nil,70124586)
end
function c511000166.con(e)
	return Duel.IsExistingMatchingCard(c511000166.spfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,43730887)
		and Duel.IsExistingMatchingCard(c511000166.spfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,70124586)
end
