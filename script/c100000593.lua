--ダークネス ３
function c100000593.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCost(c100000593.cost2)
	e1:SetTarget(c100000593.destg2)
	e1:SetOperation(c100000593.desop)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000593.condition)
	e2:SetCost(c100000593.cost)
	e2:SetTarget(c100000593.destg)
	e2:SetOperation(c100000593.desop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c100000593.con)
	e3:SetTarget(c100000593.tg)
	e3:SetOperation(c100000593.op)
	c:RegisterEffect(e3)
end
function c100000593.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():GetFlagEffect(100000593)==0 end
	e:GetHandler():RegisterFlagEffect(100000593,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000593.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetMatchingGroupCount(c100000593.filter,tp,LOCATION_ONFIELD,0,nil,100000594)==0
		or Duel.GetMatchingGroupCount(c100000593.filter,tp,LOCATION_ONFIELD,0,nil,100000595)==0
		then return end
	if Duel.GetFlagEffect(tp,100000592)==0 and Duel.GetFlagEffect(tp,100000591)==0 
		then Duel.RegisterFlagEffect(tp,100000593,RESET_PHASE+PHASE_END,0,1) 
		e:GetHandler():RegisterFlagEffect(100000598,RESET_EVENT+0x1fe0000,0,1)
		end
	if Duel.GetFlagEffect(tp,100000593)==0 then return end
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(1000)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c100000593.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c100000593.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000593.filter,tp,LOCATION_ONFIELD,0,1,nil,100000594)
		and Duel.IsExistingMatchingCard(c100000593.filter,tp,LOCATION_ONFIELD,0,1,nil,100000595)
		and Duel.IsExistingMatchingCard(c100000591.filter,tp,LOCATION_ONFIELD,0,1,nil,100000590)
		and e:GetHandler():GetFlagEffect(100000593)==0 
end
function c100000593.cost(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return true end
		if Duel.GetFlagEffect(tp,100000592)==0 and Duel.GetFlagEffect(tp,100000591)==0 
		then Duel.RegisterFlagEffect(tp,100000593,RESET_PHASE+PHASE_END,0,1) end
end
function c100000593.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetFlagEffect(tp,100000593)==0 then return end
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(1000)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
		e:GetHandler():RegisterFlagEffect(100000598,RESET_EVENT+0x1fe0000,0,1)
end
function c100000593.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100000593)==0 then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c100000593.con(e,tp,eg,ep,ev,re,r,rp)
	local code=re:GetHandler():GetCode()
	return e:GetHandler():GetFlagEffect(100000598)~=0 and re and re:GetHandler()~=e:GetHandler() 
		and (code==100000591 or code==100000592 or code==100000593) and re:GetActiveType()==TYPE_CONTINUOUS+TYPE_TRAP 
end
function c100000593.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c100000593.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end