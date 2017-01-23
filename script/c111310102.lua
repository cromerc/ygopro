--デストラクション・トリガー
function c111310102.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c111310102.condition)
	e1:SetTarget(c111310102.target)
	e1:SetOperation(c111310102.activate)
	c:RegisterEffect(e1)
end
function c111310102.filter(c,tp)
	return c:GetPreviousControler()==tp and bit.band(c:GetReason(),0x41)==0x41
end
function c111310102.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c111310102.filter,1,nil,tp)
end
function c111310102.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,1) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(5)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,5)
end
function c111310102.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,val=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,val,REASON_EFFECT)
end
