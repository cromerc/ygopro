--Card of Variation
function c511000654.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000654.target)
	e1:SetOperation(c511000654.activate)
	c:RegisterEffect(e1)
end
function c511000654.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511000654.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c511000654.op)
	Duel.RegisterEffect(e1,tp)
end
function c511000654.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511000654)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 and Duel.SelectYesNo(tp,aux.Stringid(511000654,1)) then
		local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	else
		Duel.Damage(tp,3000,REASON_EFFECT)
	end
end
