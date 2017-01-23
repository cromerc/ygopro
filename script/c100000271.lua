--Ｄ－ブースト
function c100000271.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000271.con)
	e1:SetTarget(c100000271.target)
	e1:SetOperation(c100000271.activate)
	c:RegisterEffect(e1)
end
function c100000271.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	return tc and tc:IsCode(100000270) and tc:IsFaceup()
end
function c100000271.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000271.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if not tc or not tc:IsCode(100000270) or not tc:IsFaceup() then return end
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(tc,nil,-2,REASON_EFFECT)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	tc:ReverseInDeck()
end
