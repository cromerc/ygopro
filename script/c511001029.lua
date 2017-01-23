--死蝶の誘い
function c511001029.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001029.cost)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c511001029.reccon)
	e2:SetTarget(c511001029.rectg)
	e2:SetOperation(c511001029.recop)
	c:RegisterEffect(e2)
	--maintain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetOperation(c511001029.mtop)
	c:RegisterEffect(e3)
end
function c511001029.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c511001029.egfilter(c,tp)
	return c:GetPreviousControler()==tp and c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511001029.reccon(e,tp,eg,ep,ev,re,r,rp)
	local g1=eg:IsExists(c511001029.egfilter,1,nil,tp)
	local g2=eg:IsExists(c511001029.egfilter,1,nil,1-tp)
	return g1 or g2
end
function c511001029.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=eg:IsExists(c511001029.egfilter,1,nil,tp)
	local g2=eg:IsExists(c511001029.egfilter,1,nil,1-tp)
	if chk==0 then return true end
	if g1 and not g2 then
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,1500)
	end
	if not g1 and g2 then
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(1500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1500)
	end
	if g1 and g2 then
		Duel.SetTargetPlayer(PLAYER_ALL)
		Duel.SetTargetParam(1500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,1500)
	end
end
function c511001029.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local dp,dam=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if dp~=PLAYER_ALL then
		Duel.Damage(dp,dam,REASON_EFFECT)
	else
		Duel.Damage(tp,dam,REASON_EFFECT)
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
function c511001029.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	if Duel.GetLP(tp)>=2000 and Duel.SelectYesNo(tp,aux.Stringid(21454943,7)) then
		Duel.PayLPCost(tp,2000)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
