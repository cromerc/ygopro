--Jinzo (DM)
--Scripted by edo9300
function c511000572.initial_effect(c)
	--cannot trigger
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0xa,0xa)
	e1:SetTarget(c511000572.distg)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetTarget(c511000572.distg)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c511000572.disop)
	c:RegisterEffect(e3)
	--disable trap monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c511000572.distg)
	c:RegisterEffect(e4)
	--negate and destroy
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(51100567,10))
	e8:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetCode(EVENT_CHAINING)
	e8:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e8:SetCountLimit(1,511000572)
	e8:SetCost(c511000572.cost)
	e8:SetCondition(c511000572.condition)
	e8:SetTarget(c511000572.target)
	e8:SetOperation(c511000572.activate)
	c:RegisterEffect(e8)
	if not c511000572.global_check then
		c511000572.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000572.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000572.dm=true
function c511000572.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000572.distg(e,c)
	return c:IsType(TYPE_TRAP)
end
function c511000572.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) then
		Duel.NegateEffect(ev)
	end
end
function c511000572.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,51100567)==0 end
	if Duel.GetTurnPlayer()==tp then
		Duel.RegisterFlagEffect(tp,51100567,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,0,1)
	else
		Duel.RegisterFlagEffect(tp,51100567,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
	end
end
function c511000572.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and e:GetHandler():GetFlagEffect(300)>0
end
function c511000572.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ng=Group.CreateGroup()
	local dg=Group.CreateGroup()
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		ng:AddCard(tc)
		if tc:IsType(TYPE_TRAP) and tc:IsRelateToEffect(te) then
			dg:AddCard(tc)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c511000572.distg2(c)
	return c:IsType(TYPE_TRAP)
end
function c511000572.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Group.CreateGroup()
	for i=1,ev do
		Duel.NegateActivation(i)
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		if tc:IsRelateToEffect(e) and tc:IsRelateToEffect(te) and tc:IsControler(1-tp) then
			dg:AddCard(tc)
		end
	end
	local g=Duel.GetMatchingGroup(c511000572.distg2,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.Destroy(g,REASON_EFFECT)
end
