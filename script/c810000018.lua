-- Infernity Climber
-- scripted by: UnknownGuest
function c810000018.initial_effect(c)
	-- to deck top
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c810000018.condition)
	e1:SetTarget(c810000018.target)
	e1:SetOperation(c810000018.operation)
	c:RegisterEffect(e1)
end
function c810000018.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c810000018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c810000018.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_EFFECT)
	end
end
