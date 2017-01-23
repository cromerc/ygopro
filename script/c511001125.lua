--Life Shaver
function c511001125.initial_effect(c)
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001125.target)
	e1:SetOperation(c511001125.activate)
	c:RegisterEffect(e1)
	if not c511001125.global_check then
		c511001125.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_SSET)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IMMEDIATELY_APPLY)
		ge1:SetOperation(c511001125.regop)
		Duel.RegisterEffect(ge1,0)
		--counter
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_TURN_END)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001125.ctop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001125.regop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsCode,nil,511001125)
	local tc=g:GetFirst()
	while tc do
		tc:ResetFlagEffect(511001125)
		tc:RegisterFlagEffect(511001124,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end
function c511001125.regfilter(c)
	return c:GetFlagEffect(511001124)>0 and c:GetOriginalCode()==511001125 and c:IsFacedown()
end
function c511001125.ctop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=e:GetOwner():GetOwner() then return end
	local g=Duel.GetMatchingGroup(c511001125.regfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511001125,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
end
function c511001125.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetHandler():GetFlagEffect(511001125)
	if chk==0 then return ct>0 and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_HAND,ct,e:GetHandler()) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,ct)
end
function c511001125.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardHand(p,nil,ct,ct,REASON_EFFECT+REASON_DISCARD)
end
