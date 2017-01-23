--Draw Blast
function c511000450.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c511000450.condition)
	e1:SetTarget(c511000450.damtg)
	e1:SetOperation(c511000450.damop)
	c:RegisterEffect(e1)
end
function c511000450.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511000450.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511000450.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
