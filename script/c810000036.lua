-- Blaster Ogre
-- scripted by: UnknownGuest
function c810000036.initial_effect(c)
	-- destroy & damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000036,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetTarget(c810000036.target)
	e1:SetOperation(c810000036.operation)
	c:RegisterEffect(e1)
end
function c810000036.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsDestructable()
end
function c810000036.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chck:IsControler(1-tp) and c810000036.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c810000036.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c810000036.filter,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c810000036.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c810000036.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
	local tg=g:GetMaxGroup(Card.GetAttack)
	local dam=tg:GetFirst():GetAttack()/2
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local sg=tg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			local dam1=sg:GetFirst():GetAttack()/2
			if Duel.Destroy(sg,REASON_EFFECT)~=0 then
				Duel.Damage(1-tp,dam1,REASON_EFFECT)
			end
		else
			if Duel.Destroy(tg,REASON_EFFECT)~=0 then
				Duel.Damage(1-tp,dam,REASON_EFFECT)
			end
		end
	end
end
