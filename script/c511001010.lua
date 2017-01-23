--Speed Roid Shave Boomerang
function c511001010.initial_effect(c)
	--lose ATK
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001010,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001010.condition)
	e1:SetTarget(c511001010.target)
	e1:SetOperation(c511001010.operation)
	c:RegisterEffect(e1)
end
function c511001010.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c511001010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:GetAttack()>=300 end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAttackAbove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,300) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsAttackAbove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,300)
end
function c511001010.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.ChangePosition(c,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(-300)
			tc:RegisterEffect(e1)
		end
	end
end
