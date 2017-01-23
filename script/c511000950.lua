--Magic Charge
function c511000950.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCondition(c511000950.condition)
	e1:SetTarget(c511000950.target)
	e1:SetOperation(c511000950.operation)
	c:RegisterEffect(e1)
end
function c511000950.cfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:GetReasonPlayer()==1-tp 
		and c:IsType(TYPE_SPELL) and bit.band(c:GetPreviousPosition(),POS_FACEUP)~=0
end
function c511000950.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000950.cfilter,1,nil,tp)
end
function c511000950.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetParam(2000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,2000)
end
function c511000950.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Damage(1-tp,d,REASON_EFFECT,true)
	Duel.Damage(tp,d,REASON_EFFECT,true)
	Duel.RDComplete()
end
