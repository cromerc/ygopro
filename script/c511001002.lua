--Smash Ace
function c511001002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001002.target)
	e1:SetOperation(c511001002.operation)
	c:RegisterEffect(e1)
end
function c511001002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)~=0 end
end
function c511001002.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if not tc then return end
	if tc:IsType(TYPE_MONSTER) then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
end
