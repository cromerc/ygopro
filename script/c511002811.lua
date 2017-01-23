--Performance Resurrection - Reborn Force
function c511002811.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002811.condition)
	e1:SetOperation(c511002811.activate)
	c:RegisterEffect(e1)
	if not c511002811.global_check then
		c511002811.global_check=true
		c511002811[0]=true
		c511002811[1]=true
		--check
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511002811.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002811.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002811.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511002811[tp]
end
function c511002811.cfilter(c)
	return c:IsSetCard(0x9f) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) 
		and bit.band(c:GetReason(),REASON_DESTROY)==REASON_DESTROY
end
function c511002811.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002811.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		c511002811[tc:GetPreviousControler()]=true
		tc=g:GetNext()
	end
end
function c511002811.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002811[0]=false
	c511002811[1]=false
end
function c511002811.activate(e,tp,eg,ep,ev,re,r,rp)
	--reflect
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(aux.damcon1)
	e1:SetOperation(c511002811.damop)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local ph=Duel.GetCurrentPhase()
	if ph>=0x08 and ph<=0x20 then
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
function c511002811.damop(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511002811.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c511002811.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cid==e:GetLabel()
end
