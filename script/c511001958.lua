--Gate Vehicle
function c511001958.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001958.condition)
	e1:SetOperation(c511001958.operation)
	c:RegisterEffect(e1)
end
function c511001958.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()	
end
function c511001958.operation(e,tp,eg,ep,ev,re,r,rp)
	local ats=eg:GetFirst():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if ats:FilterCount(aux.TRUE,at)<=0 then return end
	if Duel.SelectYesNo(tp,aux.Stringid(511001958,0)) then
		local g=ats:Select(tp,1,1,at)
		Duel.Hint(HINT_CARD,0,511001958)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
