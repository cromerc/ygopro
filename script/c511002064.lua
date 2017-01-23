--No.82 蟻岩土ブリリアント
function c511002064.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511002064,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002064.cost)
	e1:SetTarget(c511002064.target)
	e1:SetOperation(c511002064.operation)
	c:RegisterEffect(e1)
	if not c511002064.global_check then
		c511002064.global_check=true
		c511002064[0]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c511002064.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002064.clear)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c511002064.numchk)
		Duel.RegisterEffect(ge3,0)
	end
end
c511002064.xyz_number=82
function c511002064.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x215) or c:IsCode(31437713))
end
function c511002064.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002064.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002064.filter,tp,LOCATION_MZONE,0,1,nil) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
end
function c511002064.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002064.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetDescription(aux.Stringid(95100126,1))
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetCondition(c511002064.damcon)
		e1:SetTarget(c511002064.damtg)
		e1:SetOperation(c511002064.damop)
		e1:SetReset(RESET_EVENT+0x1130000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetOperation(c511002064.unop)
		e2:SetLabelObject(e1)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c511002064.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and c511002064[0]
end
function c511002064.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetHandler():GetAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
	e:Reset()
end
function c511002064.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,e:GetHandler():GetAttack(),REASON_EFFECT)
end
function c511002064.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(Card.IsCode,1,nil,511002065) then
		c511002064[0]=true
	end
end
function c511002064.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,31437713)
	Duel.CreateToken(1-tp,31437713)
end
function c511002064.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002064[0]=false
end
function c511002064.unop(e,tp,eg,ep,ev,re,r,rp)
	local ef=e:GetLabelObject()
	if ef and bit.band(r,REASON_DESTROY)==0 then
		ef:Reset()
		e:Reset()
	end
end
