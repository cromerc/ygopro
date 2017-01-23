--Lengard
function c810000101.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c810000101.op)
	c:RegisterEffect(e1)
end
function c810000101.op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDestructable() and ep==tp and Duel.SelectYesNo(tp,aux.Stringid(93816465,1)) 
		and Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE) then
		Duel.ChangeBattleDamage(tp,0)
	end
end
