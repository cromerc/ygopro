--Ｓｉｎ Ｔｕｎｅ
function c100000094.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c100000094.condition)
	e1:SetTarget(c100000094.target)
	e1:SetOperation(c100000094.activate)
	c:RegisterEffect(e1)
end
function c100000094.cfilter(c,tp)
	return c:IsSetCard(0x23)
end
function c100000094.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000094.cfilter,1,nil,tp)
end
function c100000094.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000094.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
