--Sign Vehicle
function c511000827.initial_effect(c)
	--seal attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000827,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000827.cost)
	e1:SetTarget(c511000827.tg)
	e1:SetOperation(c511000827.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c511000827.con)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_MONSTER))
	c:RegisterEffect(e2)
end
function c511000827.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c511000827.filter(c)
	return c:IsFaceup() and not (c:IsHasEffect(EFFECT_CANNOT_ATTACK) or c:IsHasEffect(EFFECT_CANNOT_ATTACK_ANNOUNCE))
end
function c511000827.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511000827.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000827.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000827.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000827.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511000827.con(e)
	return e:GetHandler():IsDefensePos()
end
