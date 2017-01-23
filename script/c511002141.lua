--The One to be Protected
function c511002141.initial_effect(c)
	--defup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511002141.condition)
	e1:SetCost(c511002141.cost)
	e1:SetTarget(c511002141.target)
	e1:SetOperation(c511002141.operation)
	c:RegisterEffect(e1)
end
function c511002141.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(1-tp)
end
function c511002141.cfilter(c,atk)
	return c:IsAbleToGraveAsCost() and c:GetAttack()>atk
end
function c511002141.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511002141.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511002141.cfilter,tp,LOCATION_DECK,0,1,nil,Duel.GetAttacker():GetAttack()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=Duel.SelectMatchingCard(tp,c511002141.cfilter,tp,LOCATION_DECK,0,1,1,nil,Duel.GetAttacker():GetAttack())
	local atk=sg:GetFirst():GetAttack()
	Duel.SendtoGrave(sg,REASON_COST)
	Duel.SetTargetParam(atk)
end
function c511002141.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if not d or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	d:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	d:RegisterEffect(e2)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetOperation(c511002141.damop)
	e3:SetLabel(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
	e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e3,tp)
end
function c511002141.damop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()>0 then
		Duel.Hint(HINT_CARD,0,511002141)
		Duel.Damage(tp,e:GetLabel(),REASON_EFFECT)
	end
end
