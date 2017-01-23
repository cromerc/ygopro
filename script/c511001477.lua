--Ace of Wand
function c511001477.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c511001477.condition)
	e1:SetTarget(c511001477.target)
	e1:SetOperation(c511001477.activate)
	c:RegisterEffect(e1)
end
function c511001477.cfilter(c,eg)
	local tp=c:GetControler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE)
		and not eg:IsExists(c511001477.cfilter2,1,nil,tp)
end
function c511001477.cfilter2(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsControler(1-tp)
end
function c511001477.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001477.cfilter,1,nil,eg)
end
function c511001477.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511001477.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001477.cfilter,nil,eg)
	local p=g:GetFirst():GetControler()
	local sum=g:GetSum(Card.GetAttack)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		Duel.Recover(p,sum,REASON_EFFECT)
	else
		Duel.Damage(p,sum,REASON_EFFECT)
	end
end
