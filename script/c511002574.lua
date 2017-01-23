--自由解放
function c511002574.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511002574.condition)
	e1:SetTarget(c511002574.target)
	e1:SetOperation(c511002574.activate)
	c:RegisterEffect(e1)
end
function c511002574.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp
end
function c511002574.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002574.cfilter,1,nil,tp)
end
function c511002574.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local tg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tg,tg:GetCount(),0,0)
end
function c511002574.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
