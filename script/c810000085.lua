--Release Lease
--scripted by: UnknownGuest
function c810000085.initial_effect(c)
	-- add
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c810000085.cost)
	e1:SetCondition(c810000085.condition)
	e1:SetTarget(c810000085.target)
	e1:SetOperation(c810000085.activate)
	c:RegisterEffect(e1)
end
function c810000085.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
end
function c810000085.filter(c)
	return c:GetLevel()==3 and c:IsAbleToHand()
end
function c810000085.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil)
		and Duel.IsExistingMatchingCard(c810000085.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	local tc=sg:GetFirst()
	Duel.Release(tc,REASON_COST)
end
function c810000085.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000085.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c810000085.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c810000085.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
