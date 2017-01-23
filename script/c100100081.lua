--Ｓｐ－デステニー·ドロー
function c100100081.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100100081.cost)
	e1:SetTarget(c100100081.target)
	e1:SetOperation(c100100081.activate)
	c:RegisterEffect(e1)
end
function c100100081.filter(c)
	return c:IsSetCard(0xc008) and c:IsDiscardable()
end
function c100100081.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if chk==0 then return Duel.IsExistingMatchingCard(c100100081.filter,tp,LOCATION_HAND,0,1,nil)
		and tc and tc:IsCanRemoveCounter(tp,0x91,2,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	tc:RemoveCounter(tp,0x91,2,REASON_COST)	
	Duel.DiscardHand(tp,c100100081.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c100100081.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100100081.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
