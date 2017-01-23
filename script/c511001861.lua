--Photon Shock
function c511001861.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000593,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001861.condition)
	e1:SetOperation(c511001861.activate)
	c:RegisterEffect(e1)
end
function c511001861.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return Duel.GetBattleDamage(tp)>0 and tc and tc:IsSetCard(0x55)
end
function c511001861.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511001861.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511001861.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-ep,ev,false)
end
