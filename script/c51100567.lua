--Judge Man (DM)
--Scripted by edo9300
function c51100567.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51100567,2))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e1:SetCondition(c51100567.condition)
	e1:SetCost(c51100567.cost)
	e1:SetTarget(c51100567.target)
	e1:SetOperation(c51100567.operation)
	c:RegisterEffect(e1)
	if not c51100567.global_check then
		c51100567.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c51100567.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c51100567.dm=true
function c51100567.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c51100567.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c51100567.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.GetFlagEffect(tp,51100567+1)==0 end
	Duel.PayLPCost(tp,1000)
	if Duel.GetTurnPlayer()==tp then
		Duel.RegisterFlagEffect(tp,51100567+1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,0,1)
	else
		Duel.RegisterFlagEffect(tp,51100567+1,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
	end
end
function c51100567.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c51100567.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end