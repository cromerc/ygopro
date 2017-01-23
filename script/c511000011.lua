--Kiteroid
function c511000011.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000011,0))
	e1:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511000011.con)
	e1:SetCost(c511000011.cost)
	e1:SetOperation(c511000011.op)
	c:RegisterEffect(e1)
	--no damage 2
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000011,1))
	e1:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511000011.con)
	e1:SetCost(c511000011.cost2)
	e1:SetOperation(c511000011.op)
	c:RegisterEffect(e1)
end
function c511000011.con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and Duel.GetAttackTarget()==nil
end
function c511000011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c511000011.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511000011.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511000011.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c511000011.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,511000011)==0 and e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.RegisterFlagEffect(tp,511000011,0,0,0)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
