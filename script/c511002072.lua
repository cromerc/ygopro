--Photon Advancer
function c511002072.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511002072.atk)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_HAND)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetCondition(c511002072.spcon)
	c:RegisterEffect(e2)
end
function c511002072.cfilter(c)
	return c:IsFaceup() and c:IsCode(511002072)
end
function c511002072.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002072.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c511002072.atk(e,c)
	local sum=0
	local g=Duel.GetMatchingGroup(c511002072.cfilter,c:GetControler(),LOCATION_MZONE,0,c)
	local tc=g:GetFirst()
	while tc do
		sum=sum+tc:GetBaseAttack()
		tc=g:GetNext()
	end
	return sum
end
