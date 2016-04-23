--Ｓｐ－カウントアップ
function c100100103.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100103.con)
	e1:SetTarget(c100100103.target)
	e1:SetOperation(c100100103.activate)
	c:RegisterEffect(e1)
end
function c100100103.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc:GetCounter(0x91)>1
end
function c100100103.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c100100103.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,Card.IsAbleToDeck,p,LOCATION_HAND,0,1,63,nil)
	if g:GetCount()==0 then return end
	local td=g:GetCount()*3
	Duel.SendtoGrave(g,nil,2,REASON_EFFECT)
	tc:RegisterFlagEffect(100100103,RESET_EVENT+RESET_CHAIN,0,1)
	if (12-tc:GetCounter(0x91))<td then tc:AddCounter(0x91,12-tc:GetCounter(0x91))
	else tc:AddCounter(0x91,td)	end
end
