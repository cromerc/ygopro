--Self Tribute
function c511001872.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001872.condition)
	e1:SetCost(c511001872.cost)
	e1:SetTarget(c511001872.target)
	e1:SetOperation(c511001872.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511001872.condition2)
	c:RegisterEffect(e2)
end
function c511001872.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	if tc:IsControler(1-tp) then
		tc=Duel.GetAttackTarget()
		bc=Duel.GetAttacker()
	end
	if not tc or not bc or tc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then return false end
	e:SetLabelObject(tc)
	if bc==Duel.GetAttackTarget() and bc:IsDefensePos() then return false end
	if bc:IsPosition(POS_FACEUP_DEFENSE) and bc==Duel.GetAttacker() then
		if not bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return false end
		if bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
			if bc:GetEffectCount(EFFECT_DEFENSE_ATTACK)==1 then
				if tc:IsAttackPos() then
					if bc:GetDefense()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return bc:GetDefense()~=0
					else
						return bc:GetDefense()>=tc:GetAttack()
					end
				else
					return bc:GetDefense()>tc:GetDefense()
				end
			elseif bc:IsHasEffect(EFFECT_DEFENSE_ATTACK) then
				if tc:IsAttackPos() then
					if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
						return bc:GetAttack()~=0
					else
						return bc:GetAttack()>=tc:GetAttack()
					end
				else
					return bc:GetAttack()>tc:GetDefense()
				end
			end
		end
	else
		if tc:IsAttackPos() then
			if bc:GetAttack()==tc:GetAttack() and not bc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
				return bc:GetAttack()~=0
			else
				return bc:GetAttack()>=tc:GetAttack()
			end
		else
			return bc:GetAttack()>tc:GetDefense()
		end
	end
end
function c511001872.cfilter(c,e,tp)
	return c:IsOnField() and c:IsType(TYPE_MONSTER) and c:IsControler(tp) and (not e or c:IsRelateToEffect(e))
end
function c511001872.condition2(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if tg==nil then return false end
	local g=tg:Filter(c511001872.cfilter,nil,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return ex and tc+g:GetCount()-tg:GetCount()>0
end
function c511001872.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511001872.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject()
	if chk==0 then return g end
	Duel.SetTargetCard(g)
end
function c511001872.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511001872.cfilter,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
