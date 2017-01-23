--Kiteroid
function c513000115.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c513000115.op)
	c:RegisterEffect(e1)
	--no damage 2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000011,1))
	e2:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c513000115.con2)
	e2:SetCost(c513000115.cost2)
	e2:SetOperation(c513000115.op2)
	c:RegisterEffect(e2)
end
function c513000115.op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDiscardable() and ep==tp and Duel.GetAttackTarget()==nil and Duel.SelectYesNo(tp,aux.Stringid(81275309,0)) 
		and Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT+REASON_REPLACE+REASON_DISCARD) then
		Duel.ChangeBattleDamage(tp,0)
	end
end
function c513000115.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c513000115.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,513000115)==0 end
	Duel.RegisterFlagEffect(tp,513000115,0,0,0)
end
function c513000115.op2(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c513000115.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c513000115.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
