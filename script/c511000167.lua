--Dark wall of wind
--scripted by GameMaster (GM)
function c511000167.initial_effect (c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000167.activate)
	c:RegisterEffect(e1)
end
function c511000167.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511000167.damop)
	e1:SetReset(RESET_PHASE+PHASE_END)
   	Duel.RegisterEffect(e1,tp)
end

function c511000167.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker():IsControler(1-tp) and not Duel.GetAttackTarget() then Duel.ChangeBattleDamage(tp,0) end
end

