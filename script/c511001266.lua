--Sacred Arrow
function c511001266.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001266,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetTarget(c511001266.damtg)
	e2:SetOperation(c511001266.damop)
	c:RegisterEffect(e2)
	if not c511001266.global_check then
		c511001266.global_check=true
		c511001266[0]=0
		c511001266[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		ge1:SetCode(EVENT_DESTROY)
		ge1:SetOperation(c511001266.op)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001266.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001266.chkfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_GRAVE) 
		and c:GetPreviousControler()==tp
end
function c511001266.op(e,tp,eg,ep,ev,re,r,rp)
	local ct1=eg:FilterCount(c511001266.chkfilter,nil,tp)
	local ct2=eg:FilterCount(c511001266.chkfilter,nil,1-tp)
	if ct1>0 then
		c511001266[0]=c511001266[0]+ct1
	end
	if ct2>0 then
		c511001266[1]=c511001266[1]+ct2
	end
end
function c511001266.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001266[0]=0
	c511001266[1]=0
end
function c511001266.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,c511001266[0]*400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,c511001266[1]*400)
end
function c511001266.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Damage(tp,c511001266[0]*400,REASON_EFFECT,true)
	Duel.Damage(1-tp,c511001266[1]*400,REASON_EFFECT,true)
	Duel.RDComplete()
end
