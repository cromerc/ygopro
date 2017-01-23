--Baton of the Hero
function c511000849.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c511000849.condition)
	e1:SetOperation(c511000849.activate)
	c:RegisterEffect(e1)
end
function c511000849.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()<PHASE_MAIN2
end
function c511000849.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c511000849.operation)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000849.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttackTarget()~=nil then
		local ats=eg:GetFirst():GetAttackableTarget()
		local at=Duel.GetAttackTarget()
		if ats:GetCount()==0 or (at and ats:GetCount()==1) then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=ats:Select(tp,1,1,nil)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
