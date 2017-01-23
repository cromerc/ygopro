--Card of Desperation
function c511000784.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000784.target)
	e1:SetOperation(c511000784.activate)
	c:RegisterEffect(e1)
end
function c511000784.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,g:GetCount()-3)
end
function c511000784.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==3 then
		local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
