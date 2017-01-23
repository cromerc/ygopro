--Earthbound Beginning
function c511002978.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002978.condition)
	e1:SetTarget(c511002978.target)
	e1:SetOperation(c511002978.activate)
	c:RegisterEffect(e1)
	if not c511002978.global_check then
		c511002978.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511002978.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002978.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511002978.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil and Duel.GetLP(tp)<=3000
end
function c511002978.filter(c,tp)
	local te=c:GetActivateEffect()
	if not te then return false end
	return c:IsType(TYPE_FIELD) and te:IsActivatable(tp)
end
function c511002978.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002978.filter,tp,LOCATION_DECK,0,1,nil,tp) end
end
function c511002978.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511002978.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c511002978.con)
	e2:SetOperation(c511002978.op)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c511002978.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev/2)
end
function c511002978.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511002978.op(e,tp,eg,ep,ev,re,r,rp)
	local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	if Duel.GetFlagEffect(tp,62765383)>0 then
		if fc then Duel.Destroy(fc,REASON_RULE) end
		fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if fc then Duel.Destroy(fc,REASON_RULE) end
	else
		fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
	end
	local sg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_FIELD)
	local chc=sg:GetFirst()
	while chc do
		local te=chc:GetActivateEffect()
		if te and not te:IsActivatable(tp) then
			te:SetProperty(te:GetProperty()+EFFECT_FLAG_DAMAGE_STEP)
		end
		chc=sg:GetNext()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c511002978.filter,tp,LOCATION_DECK,0,1,1,nil,tp)
	if g:GetCount()>0 and not Duel.GetFieldCard(tp,LOCATION_SZONE,5) then
		local tc=g:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,te,0,tp,tp,Duel.GetCurrentChain())
	end
	chc=sg:GetFirst()
	while chc do
		local te=chc:GetActivateEffect()
		if te and te:IsActivatable(tp) then
			te:SetProperty(te:GetProperty()-EFFECT_FLAG_DAMAGE_STEP)
		end
		chc=sg:GetNext()
	end
end
