--罠蘇生
function c511001569.initial_effect(c)
	--copy trap
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0x1e1,0x1e1)
	e1:SetCost(c511001569.cost)
	e1:SetTarget(c511001569.target)
	e1:SetOperation(c511001569.operation)
	c:RegisterEffect(e1)
end
function c511001569.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c511001569.filter(c)
	return c:GetType()==0x4 and c:IsAbleToRemove() and c:CheckActivateEffect(false,false,false)~=nil
end
function c511001569.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511001569.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001569.filter,tp,0,LOCATION_GRAVE,1,nil) end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511001569.filter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511001569.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		local te=tc:CheckActivateEffect(false,false,false)
		if not te then return end
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		local co=te:GetCost()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
	end
end
