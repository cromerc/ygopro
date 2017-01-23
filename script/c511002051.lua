--Attack Guidance Armor
function c511002051.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c511002051.atktg)
	e1:SetOperation(c511002051.atkop)
	c:RegisterEffect(e1)
end
function c511002051.filter(c)
	return (not Duel.GetAttacker() or c~=Duel.GetAttacker()) and c~=Duel.GetAttackTarget()
end
function c511002051.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511002051.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511002051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		--Duel.ChangeAttackTarget(tc)
		Duel.CalculateDamage(Duel.GetAttacker(),tc)
	end
end
