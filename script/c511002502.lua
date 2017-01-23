--魔霧雨
function c511002502.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002502.target)
	e1:SetOperation(c511002502.activate)
	c:RegisterEffect(e1)
end
function c511002502.filter(c)
	return c:IsFaceup() and (c:IsCode(70781052) or c:IsCode(61370518) or c:IsRace(RACE_THUNDER))
end
function c511002502.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002502.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511002502.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002502.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local atk=tc:GetAttack()*3/10
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)		
		tc=g:GetNext()
	end
end
