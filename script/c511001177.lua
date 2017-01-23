--Infinity Tooth
function c511001177.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001177.target)
	e1:SetOperation(c511001177.operation)
	c:RegisterEffect(e1)
end
function c511001177.filter(c,tp)
	local ct=c:GetOverlayCount()
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and ct>0 and Duel.IsPlayerCanDiscardDeck(tp,ct+1)
end
function c511001177.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001177.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001177.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511001177.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		local ct=g:GetFirst():GetOverlayCount()
		if Duel.DiscardDeck(tp,ct,REASON_EFFECT) then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
