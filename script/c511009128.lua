--Decago Knight
function c511009128.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(95100664,0))
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetCondition(c511009128.condition)
    e1:SetTarget(c511009128.target)
    e1:SetOperation(c511009128.operation)
    c:RegisterEffect(e1)
end
function c511009128.cfilter(c)
	return c:IsCode(511009128)
end
function c511009128.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009128.cfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c511009128.filter1(c)
	return c:IsCode(511009128) and c:IsAbleToDeck()
end
function c511009128.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511009128.filter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c511009128.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009128.filter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
