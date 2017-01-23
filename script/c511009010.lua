--Cosmic Space
-- !counter 0x1109 Life Star Counter
function c511009010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511009010.operation)
	c:RegisterEffect(e1)
	
	--remove counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(59907935,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetOperation(c511009010.rmop)
	c:RegisterEffect(e2)
	
	--add counter on summoned
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetDescription(aux.Stringid(511000129,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c511009010.target)
	e3:SetOperation(c511009010.activate)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
	
	--Destroy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_ADJUST)
	e6:SetRange(LOCATION_FZONE)	
	e6:SetOperation(c511009010.desop)
	c:RegisterEffect(e6)
end
function c511009010.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1109,tc:GetLevel(),REASON_EFFECT)
		tc:RegisterFlagEffect(511009010,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end



function c511009010.rmcountfilter(c)
	return c:GetCounter(0x1109)~=0
end

function c511009010.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009010.rmcountfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		tc:RemoveCounter(tp,0x1109,1,REASON_EFFECT)
		tc=g:GetNext()
	end
	local g2=Duel.GetMatchingGroup(c511009010.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g2,REASON_EFFECT)
end

function c511009010.filter(c,tp,ep)
	return c:IsFaceup()
end
function c511009010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511009010.filter,1,nil,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1109)
end
function c511009010.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511009010.filter,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1109,tc:GetLevel(),REASON_EFFECT)	
		tc:RegisterFlagEffect(511009010,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end

function c511009010.desfilter(c,g,pg)
	return c:IsFaceup() and c:GetCounter(0x1109)==0 and c:GetFlagEffect(511009010)~=0 and c:IsDestructable()
end
function c511009010.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009010.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
