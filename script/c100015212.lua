--
function c100015212.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterEqualFunction(Card.GetLevel,2),2)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetDescription(aux.Stringid(100015212,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c100015212.cost)
	e1:SetTarget(c100015212.target)
	e1:SetOperation(c100015212.operation)
	c:RegisterEffect(e1)
end
function c100015212.cost(e,tp,eg,ep,ev,re,r,rp,chk)	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()	
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	if tc and tc:IsAbleToRemoveAsCost() then 
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	else 
	return false 
	end	
end
function c100015212.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,0,0)
end
function c100015212.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE+LOCATION_REMOVED,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
	end
end