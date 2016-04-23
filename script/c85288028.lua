--Roll of Fate
function c85288028.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c85288028.target)
	e1:SetOperation(c85288028.operation)
	c:RegisterEffect(e1)
end
function c85288028.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1,6) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c85288028.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local dice=Duel.TossDice(tp,1)
	if dice==1 then
	Duel.Draw(tp,1,REASON_EFFECT) 
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	elseif dice==2 then
	Duel.Draw(tp,2,REASON_EFFECT) 
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
	elseif dice==3 then
	Duel.Draw(tp,3,REASON_EFFECT) 
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
	elseif dice==4 then
	Duel.Draw(tp,4,REASON_EFFECT)
	Duel.BreakEffect() 
	Duel.DiscardDeck(tp,4,REASON_EFFECT)
	elseif dice==5 then
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,5,REASON_EFFECT)
	else
	Duel.Draw(tp,6,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,6,REASON_EFFECT)
	end
	end