--Magician's Selection
--scripted by: UnknownGuest
function c810000094.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c810000094.condition)
	e1:SetTarget(c810000094.target)
	e1:SetOperation(c810000094.activate)
	c:RegisterEffect(e1)
end
function c810000094.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup() and tc:IsRace(RACE_SPELLCASTER)
end
function c810000094.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c810000094.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000094.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c810000094.filter,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMinGroup(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c810000094.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local g=Duel.GetMatchingGroup(c810000094.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tg=g:GetMinGroup(Card.GetAttack)
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local sg=tg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			Duel.Destroy(sg,REASON_EFFECT)
		else Duel.Destroy(tg,REASON_EFFECT) end
	end
end
