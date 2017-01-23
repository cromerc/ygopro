--Pride Shout
function c511000037.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Damage LP
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000037,0))
	e2:SetCategory(CATEGORY_BATTLE_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c511000037.condition)
	e2:SetTarget(c511000037.target)
	e2:SetOperation(c511000037.operation)
	c:RegisterEffect(e2)
end
function c511000037.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker():GetAttack()==0 and Duel.GetAttacker():IsControler(tp)
end
function c511000037.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttacker()
	if chk==0 then return tc:IsOnField() end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetDefense())
end
function c511000037.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetDefense(),REASON_EFFECT)
	end
end
