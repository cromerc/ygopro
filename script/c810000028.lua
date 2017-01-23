-- Amazoness Chain Master (Anime)
-- scripted by: UnknownGuest
function c810000028.initial_effect(c)
	-- get card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000028,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c810000028.condition)
	e1:SetCost(c810000028.cost)
	e1:SetOperation(c810000028.operation)
	c:RegisterEffect(e1)
end
function c810000028.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND+LOCATION_DECK)~=0
end
function c810000028.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c810000028.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK+LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local tg=g:Filter(Card.IsType,nil,TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=tg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,tp,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
		Duel.ShuffleDeck(1-tp)
	end
end
