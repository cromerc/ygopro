--Extra Blast
function c511002538.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511002538.condition)
	e1:SetTarget(c511002538.target)
	e1:SetOperation(c511002538.activate)
	c:RegisterEffect(e1)
end
function c511002538.filter(c,tp)
	return c:GetPreviousControler()==1-tp and bit.band(c:GetReason(),0x41)==0x41 
		and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511002538.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002538.filter,1,nil,tp)
end
function c511002538.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c511002538.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
