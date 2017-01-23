--Fallen Angel's Bewitchment
function c511002280.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002280.condition)
	e1:SetTarget(c511002280.target)
	e1:SetOperation(c511002280.activate)
	c:RegisterEffect(e1)
end
function c511002280.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c511002280.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002280.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002280.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local p=1-Duel.GetTurnPlayer()
	if chk==0 then return Duel.IsExistingMatchingCard(nil,p,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511002280.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=1-Duel.GetTurnPlayer()
	local g=Duel.SelectMatchingCard(tp,nil,p,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(tc)
	end
end
