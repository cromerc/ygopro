-- Goddess Erda's Guidance
-- Scripted by UnknownGuest
function c511000188.initial_effect(c)
    -- activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c511000188.setcost)
    e1:SetTarget(c511000188.settg)
    e1:SetOperation(c511000188.setop)
    c:RegisterEffect(e1)
end
function c511000188.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c511000188.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c511000188.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
    Duel.DiscardHand(tp,c511000188.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c511000188.filter(c)
    return c:IsType(TYPE_TRAP) and c:IsSSetable(true)
end
function c511000188.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if not e:GetHandler():IsLocation(LOCATION_SZONE) then
		ft=ft-1
	end
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511000188.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000188.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c511000188.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c511000188.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
	end
end
