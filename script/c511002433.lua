--Flames of the Archfiend
function c511002433.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002433.condition)
	e1:SetTarget(c511002433.target)
	e1:SetOperation(c511002433.activate)
	c:RegisterEffect(e1)
end
function c511002433.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c511002433.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002433.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c511002433.filter(c)
	return c:IsFaceup() and not c:IsRace(RACE_FIEND)
end
function c511002433.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local c2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	if chk==0 then return true end
	local g=Group.CreateGroup()
	if c1 then g:AddCard(c1) end
	if c2 then g:AddCard(c2) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,1000)
end
function c511002433.activate(e,tp,eg,ep,ev,re,r,rp)
	local c1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local c2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	local g=Group.CreateGroup()
	if c1 then g:AddCard(c1) end
	if c2 then g:AddCard(c2) end
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
	Duel.Damage(1-tp,1000,REASON_EFFECT,true)
	Duel.Damage(tp,1000,REASON_EFFECT,true)
	Duel.RDComplete()
	local sg=Duel.GetMatchingGroup(c511002433.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
