--ゼロ・フォース
function c511001873.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c511001873.condition)
	e1:SetTarget(c511001873.target)
	e1:SetOperation(c511001873.operation)
	c:RegisterEffect(e1)
end
function c511001873.cfilter(c,tp)
	return c:GetPreviousControler()==tp and c:GetControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511001873.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001873.cfilter,nil,tp)
	local tc=g:GetFirst()
	return g:GetCount()==1
end
function c511001873.filter(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk)
end
function c511001873.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511001873.cfilter,nil,tp)
	local tc=g:GetFirst()
	if chk==0 then return tc 
		and Duel.IsExistingMatchingCard(c511001873.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tc:GetAttack()) end
	Duel.SetTargetCard(tc)
end
function c511001873.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstTarget()
	if tg and tg:IsRelateToEffect(e) then
		Duel.ConfirmCards(1-tp,tg)
		local g=Duel.GetMatchingGroup(c511001873.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tg:GetAttack())
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
	end
end
