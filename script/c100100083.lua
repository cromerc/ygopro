--Ｓｐ－調和の宝札
function c100100083.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100083.con)
	e1:SetCost(c100100083.cost)
	e1:SetTarget(c100100083.target)
	e1:SetOperation(c100100083.activate)
	c:RegisterEffect(e1)
end
function c100100083.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>2
end
function c100100083.filter(c)
	return c:IsType(TYPE_TUNER) and c:IsRace(RACE_DRAGON) and c:IsAttackBelow(1000) and c:IsDiscardable()
end
function c100100083.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100100083.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c100100083.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c100100083.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100100083.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
