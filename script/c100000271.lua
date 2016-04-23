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
	local g=Duel.GetDecktopGroup(tp,1)
	return g:GetFirst():GetCode()==100000270 and g:GetFirst():IsFaceup()
end
function c100000271.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return false end
		local g=Duel.GetDecktopGroup(tp,3)
		local result=g:GetCount()>2
		return Duel.IsPlayerCanDraw(tp,3) and result
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000271.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetDecktopGroup(p,3)
	if g:Filter(Card.IsCode,nil,100000270):GetCount()==0 then return false end
	g:RemoveCard(g:Filter(Card.IsCode,nil,100000270):GetFirst())
	if g:GetCount()>1 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
