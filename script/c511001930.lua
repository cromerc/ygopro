--Orichalcum Mirage
function c511001930.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001930.condition)
	e1:SetTarget(c511001930.target)
	e1:SetOperation(c511001930.activate)
	c:RegisterEffect(e1)
end
function c511001930.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511001930.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x70)
end
function c511001930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001930.filter,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511001930.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c511001930.filter,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	local tc=g:GetFirst()
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(tc)
	end
end
