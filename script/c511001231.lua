--Schrödinger's Cat
function c511001231.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DRAW)
	e2:SetCondition(c511001231.condition)
	e2:SetTarget(c511001231.target)
	e2:SetOperation(c511001231.activate)
	c:RegisterEffect(e2)
end
function c511001231.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DRAW and (not re or re:GetHandler():GetCode()~=511001231)
end
function c511001231.filter(c,tp)
	return c:IsControler(tp) and c:IsAbleToDeck() and c:IsLocation(LOCATION_HAND)
end
function c511001231.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and eg:IsExists(c511001231.filter,1,nil,tp) end
	local g=eg:Filter(c511001231.filter,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001231.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.IsPlayerCanDraw(tp) then return end
	local g=eg:Filter(c511001231.filter,nil,tp)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,g:GetCount(),REASON_EFFECT)
	end
end
