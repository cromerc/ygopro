--Cross Heart
function c511001870.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511001870.condition)
	e1:SetTarget(c511001870.target)
	e1:SetOperation(c511001870.operation)
	c:RegisterEffect(e1)
end
function c511001870.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511001870.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsControlerCanBeChanged() and tc:IsControler(1-tp) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,tc,1,0,0)
end
function c511001870.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
