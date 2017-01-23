--Overhaul
function c511000298.initial_effect(c)
local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000298,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000298.lvtg)
	e1:SetOperation(c511000298.lvop)
	c:RegisterEffect(e1)
end
function c511000298.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(1) and c:IsRace(RACE_MACHINE)
end
function c511000298.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000298.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511000298.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000298.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
