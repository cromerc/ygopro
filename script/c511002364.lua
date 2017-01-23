--Defender Hero
function c511002364.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002364.condition)
	e1:SetTarget(c511002364.target)
	e1:SetOperation(c511002364.activate)
	c:RegisterEffect(e1)
end
function c511002364.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp)
end
function c511002364.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x8)
end
function c511002364.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002364.filter,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511002364.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c511002364.filter,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(tc)
	end
end
