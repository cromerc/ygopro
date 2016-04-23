--Five Brothers Explosion
function c804000089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c804000089.target1)
	e1:SetOperation(c804000089.operation)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c804000089.spcon)
	e3:SetTarget(c804000089.sptg)
	e3:SetOperation(c804000089.spop)
	c:RegisterEffect(e3)
end
function c804000089.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c804000089.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroupCount(c804000089.filter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil)*500
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(g)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g)
end
function c804000089.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c804000089.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()~=tp
end
function c804000089.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroupCount(c804000089.filter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)*500
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(g)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g)
end
function c804000089.spop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

