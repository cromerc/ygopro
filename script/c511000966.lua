--Paternal Junk
function c511000966.initial_effect(c)
	--atk - Maternal
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000966.valcon1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--atk - Kid
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000966.valcon2)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
end
function c511000966.vfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511000966.valcon1(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c511000966.vfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,511000965)
end
function c511000966.valcon2(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c511000966.vfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,511000964)
end
