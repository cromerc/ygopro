--Plunder Decoy
function c511002745.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002745.condition)
	e1:SetTarget(c511002745.target)
	e1:SetOperation(c511002745.activate)
	c:RegisterEffect(e1)
end
function c511002745.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp)
end
function c511002745.filter(c)
	return c:IsControlerCanBeChanged() and c:IsFaceup() and c:IsLevelBelow(4)
end
function c511002745.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002745.filter,tp,0,LOCATION_MZONE,1,Duel.GetAttacker()) end
	local g=Duel.GetMatchingGroup(c511002745.filter,tp,0,LOCATION_MZONE,Duel.GetAttacker())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511002745.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c511002745.filter,tp,0,LOCATION_MZONE,1,1,Duel.GetAttacker())
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.GetControl(tc,tp)
	end
end
