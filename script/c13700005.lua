--Necloth Exomirror
function c13700005.initial_effect(c)
	aux.Unicore(c,aux.FilterBoolFunction(Card.IsCode,13700022))--Unicore(4)
	aux.Brionac(c,aux.FilterBoolFunction(Card.IsCode,13700014))--Brionac(6)
	aux.Gungnir(c,aux.FilterBoolFunction(Card.IsCode,13700028))--Gungnir(7)
	aux.Valkyrus(c,aux.FilterBoolFunction(Card.IsCode,13700044))--Valkyrus(8)
	aux.Trishula(c,aux.FilterBoolFunction(Card.IsCode,13700003))--Trishula(9)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13700005,2))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c13700005.condition)
	e1:SetCost(c13700005.cost)
	e1:SetTarget(c13700005.target2)
	e1:SetOperation(c13700005.operation2)
	c:RegisterEffect(e1)
end
--~ Savage
function c13700005.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c13700005.filter2(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c13700005.cost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c13700005.filter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c13700005.filter2,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13700005.sfilter(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c13700005.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700005.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13700005.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13700005.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
