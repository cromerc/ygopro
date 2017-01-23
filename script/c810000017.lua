-- Performapal Hammer Mammoth
-- scripted by: UnknownGuest
function c810000017.initial_effect(c)
	-- atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c810000017.target)
	e1:SetOperation(c810000017.operation)
	c:RegisterEffect(e1)
end
function c810000017.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c810000017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000017.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c810000017.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c810000017.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=Duel.GetMatchingGroup(c810000017.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end