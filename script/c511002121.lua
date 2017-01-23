--Xyz Imprisonment
function c511002121.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002121.condition)
	e1:SetTarget(c511002121.target)
	e1:SetOperation(c511002121.activate)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76436988,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002121.damcon)
	e2:SetTarget(c511002121.damtg)
	e2:SetOperation(c511002121.damop)
	c:RegisterEffect(e2)
end
function c511002121.cfilter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsControler(1-tp) and (not e or c:IsRelateToEffect(e))
end
function c511002121.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002121.cfilter,1,nil,nil,tp)
end
function c511002121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
end
function c511002121.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=eg:Filter(c511002121.cfilter,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511002121.rcon)
		tc:RegisterEffect(e1,true)
		tc=g:GetNext()
	end
	c:RegisterFlagEffect(511002121,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c511002121.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511002121.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511002121)>0
end
function c511002121.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c511002121.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
