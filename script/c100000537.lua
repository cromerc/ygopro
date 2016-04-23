--ワルキューレ・アルテスト
function c100000537.initial_effect(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000537,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c100000537.target)
	e2:SetOperation(c100000537.operation)
	c:RegisterEffect(e2)
end
function c100000537.sfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c100000537.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsType(TYPE_MONSTER) end
	if chk==0 then return Duel.IsExistingTarget(c100000537.sfilter,1-tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c100000537.sfilter,1-tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c100000537.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsAbleToRemove() then
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=1 then	return end
		local ba=tc:GetBaseAttack()
		local reset_flag=RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(reset_flag)
		e2:SetCode(EFFECT_SET_ATTACK)
		e2:SetValue(ba)
		c:RegisterEffect(e2)
	end
end

