--ヴォルカニック・アーマー
function c100000292.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000292.condition)
	e2:SetTarget(c100000292.target)
	e2:SetOperation(c100000292.operation)
	c:RegisterEffect(e2)
end
function c100000292.filter(c,tp)
	return c:IsRace(RACE_PYRO) and c:GetControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c100000292.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000292.filter,1,nil,tp) 
end
function c100000292.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,500)
end
function c100000292.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end