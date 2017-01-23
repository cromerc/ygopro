--Antikythira Gear
function c511001018.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001018.condition)
	e1:SetTarget(c511001018.target)
	e1:SetOperation(c511001018.activate)
	c:RegisterEffect(e1)
end
function c511001018.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==nil
end
function c511001018.filter(c)
	return c:IsControlerCanBeChanged() and c:IsAttackPos()
end
function c511001018.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local atr=Duel.GetAttacker()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001018.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001018.filter,tp,0,LOCATION_MZONE,1,atr) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511001018.filter,tp,0,LOCATION_MZONE,1,1,atr)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511001018.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.GetControl(tc,tp) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end
