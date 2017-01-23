--Forbidden Beast Watsumu
function c511000393.initial_effect(c)
	--add to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000393,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000393.condition)
	e1:SetTarget(c511000393.target)
	e1:SetOperation(c511000393.operation)
	c:RegisterEffect(e1)
end
function c511000393.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE) and Duel.IsPlayerAffectedByEffect(tp,511000380)
end
function c511000393.filter(c)
	return c:IsSetCard(0x201) and c:IsLevelBelow(3) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c511000393.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511000393.filter,tp,LOCATION_GRAVE,0,0,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c511000393.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerAffectedByEffect(tp,511000380) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
