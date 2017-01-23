--Angelic Mercy
function c511002325.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c511002325.target)
	e1:SetOperation(c511002325.activate)
	c:RegisterEffect(e1)
end
function c511002325.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c511002325.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002325.filter,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511002325.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c511002325.filter,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(tc)
	end
end
