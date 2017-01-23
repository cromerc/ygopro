--Poisonous Viper
function c511002284.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46128076,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002284.condition)
	e1:SetTarget(c511002284.target)
	e1:SetOperation(c511002284.operation)
	c:RegisterEffect(e1)
end
function c511002284.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511002284.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,500)
end
function c511002284.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Damage(e:GetHandlerPlayer(),d,REASON_EFFECT)
end
