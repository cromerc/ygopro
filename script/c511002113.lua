--Different Dimension Barrier - Lost Force
function c511002113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002113.condition)
	e1:SetTarget(c511002113.target)
	e1:SetOperation(c511002113.activate)
	c:RegisterEffect(e1)
	if not c511002113.global_check then
		c511002113.global_check=true
		c511002113[0]=true
		c511002113[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_LEAVE_FIELD)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511002113.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002113.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002113.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsType(TYPE_MONSTER) and not c:IsReason(REASON_BATTLE)
end
function c511002113.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511002113.cfilter,1,nil,tp) then
		c511002113[tp]=true
	end
	if eg:IsExists(c511002113.cfilter,1,nil,1-tp) then
		c511002113[1-tp]=true
	end
end
function c511002113.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002113[0]=false
	c511002113[1]=false
end
function c511002113.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and c511002113[tp]
end
function c511002113.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() end
	Duel.SetTargetCard(tg)
	local dam=tg:GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002113.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if Duel.NegateAttack() then
			Duel.BreakEffect()
			Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
		end
	end
end
