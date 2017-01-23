--Hidden Fangs of Revenge
function c511002876.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002876.condition)
	e1:SetTarget(c511002876.target)
	e1:SetOperation(c511002876.activate)
	c:RegisterEffect(e1)
end
function c511002876.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511002876.cfilter(c)
	return c:IsDefensePos() and c:IsDestructable()
end
function c511002876.filter(c)
	return (c:IsFacedown() or c:IsDefensePos()) and c:IsDestructable()
end
function c511002876.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002876.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511002876.filter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511002876.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511002876.filter,tp,LOCATION_ONFIELD,0,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local sum=dg:GetSum(Card.GetDefense)
		local a=Duel.GetAttacker()
		if sum>a:GetAttack() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
			e1:SetOperation(c511002876.damop)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
			Duel.RegisterEffect(e1,tp)
			if a:IsControler(tp) then a=Duel.GetAttackTarget() end
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			a:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_EFFECT)
			e3:SetValue(RESET_TURN_SET)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			a:RegisterEffect(e3)
			Duel.BreakEffect()
			Duel.Destroy(a,REASON_EFFECT)
		end
	end
end
function c511002876.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
