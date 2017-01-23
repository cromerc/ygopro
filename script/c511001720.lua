--Baggy Pants Lavasaurus
function c511001720.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001720,1))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c511001720.thtg)
	e1:SetOperation(c511001720.thop)
	c:RegisterEffect(e1)
end
function c511001720.thfilter(c)
	return c:GetLevel()==5 and c:IsAbleToHand()
end
function c511001720.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511001720.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001720.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	else
		local cg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(tp)
	end
end
