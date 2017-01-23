--The Phantom Knights of Around Burn
function c511009328.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44968459,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009328.condition)
	e1:SetCost(c511009328.cost)
	e1:SetTarget(c511009328.target)
	e1:SetOperation(c511009328.activate)
	c:RegisterEffect(e1)	
	if not c511009328.global_check then
		c511009328.global_check=true
		c511009328[0]=0
		c511009328[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c511009328.op)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511009328.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511009328.cfilter(c)
	return c:IsSetCard(0x10db) and c:IsAbleToRemoveAsCost()
end
function c511009328.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009328.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c511009328.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c511009328.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c511009328.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009328.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(dg,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetOperation(c511009328.damop)
	e1:SetReset(RESET_PHASE+PHASE_BATTLE)
	Duel.RegisterEffect(e1,tp)
end
function c511009328.chkfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) 
		and c:GetPreviousControler()==tp
end
function c511009328.op(e,tp,eg,ep,ev,re,r,rp)
	if eg==nil or eg:GetCount()<=0 then return end
	local ph=Duel.GetCurrentPhase()
	if ph>=0x08 and ph<=0x20 then
		local ct1=eg:FilterCount(c511009328.chkfilter,nil,tp)
		local ct2=eg:FilterCount(c511009328.chkfilter,nil,1-tp)
		if ct1>0 then
			c511009328[tp]=c511009328[tp]+ct1
		end
		if ct2>0 then
			c511009328[1-tp]=c511009328[1-tp]+ct2
		end
	end
end
function c511009328.clear(e,tp,eg,ep,ev,re,r,rp)
	c511009328[0]=0
	c511009328[1]=0
end
function c511009328.damop(e,tp,eg,ep,ev,re,r,rp)
	if c511009328[0]>0 or c511009328[1]>0 then
		Duel.Hint(HINT_CARD,0,511009328)
		Duel.Damage(tp,c511009328[tp]*800,REASON_EFFECT)
		Duel.Damage(1-tp,c511009328[1-tp]*800,REASON_EFFECT)
	end
end
