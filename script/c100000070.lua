--未来破壊
function c100000070.initial_effect(c)
	--discard deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetProperty(EFFECT_FLAG_REPEAT)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100000070.recop)
	c:RegisterEffect(e1)
end
function c100000070.recop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)
	Duel.DiscardDeck(tp,g,REASON_EFFECT)
end
