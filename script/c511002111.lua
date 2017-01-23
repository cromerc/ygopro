--No.106 巨岩掌ジャイアント・ハンド
function c511002111.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63746411,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002111.condition)
	e1:SetCost(c511002111.cost)
	e1:SetTarget(c511002111.target)
	e1:SetOperation(c511002111.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50491121,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511002111.descon)
	e2:SetTarget(c511002111.destg)
	e2:SetOperation(c511002111.desop)
	c:RegisterEffect(e2)
	if not c511002111.global_check then
		c511002111.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002111.numchk)
		Duel.RegisterEffect(ge2,0)
	end
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511002111.indes)
	c:RegisterEffect(e3)
	if not c511002111.global_check then
		c511002111.global_check=true
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c511002111.numchk)
		Duel.RegisterEffect(ge3,0)
	end
end
c511002111.xyz_number=106
function c511002111.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsActiveType(TYPE_MONSTER)
		and Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)==LOCATION_MZONE
end
function c511002111.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002111.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c511002111.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511002111.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002111.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511002111.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c511002111.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsType(TYPE_EFFECT) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511002111.rcon)
		tc:RegisterEffect(e1,true)
	end
end
function c511002111.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511002111.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,63746411)
	Duel.CreateToken(1-tp,63746411)
end
function c511002111.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasCardTarget(Duel.GetAttacker())
end
function c511002111.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return a:IsOnField() end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,a,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,a:GetAttack())
end
function c511002111.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) 
		and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,tc:GetPreviousAttackOnField(),REASON_EFFECT)
	end
end
function c511002111.indes(e,c)
	return not c:IsSetCard(0x48)
end