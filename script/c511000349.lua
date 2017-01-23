--Awakening from Beyond
function c511000349.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000349.target)
	e1:SetOperation(c511000349.activate)
	c:RegisterEffect(e1)
end
function c511000349.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511000349.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511000349.tgfilter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,2) and Duel.IsExistingTarget(c511000349.tgfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=Duel.SelectTarget(tp,c511000349.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,2)
end
function c511000349.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if Duel.Draw(p,d,REASON_EFFECT) then
		if tc and tc:IsRelateToEffect(e) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
