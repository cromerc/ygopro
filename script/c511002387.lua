--ものマネ幻想師
function c511002387.initial_effect(c)
	--trigger
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(494922,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002387.tg)
	e1:SetOperation(c511002387.op)
	c:RegisterEffect(e1)
end
function c511002387.filter(c,e,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return end
	local cost=te:GetCost()
	local target=te:GetTarget()
	return te:GetCode()==EVENT_FREE_CHAIN and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0) or not cost(te,tp,eg,ep,ev,re,r,rp,0)) 
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) 
		and (not c:IsType(TYPE_CONTINUOUS+TYPE_EQUIP) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
end
function c511002387.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c511002387.filter(chkc,e,tp,eg,ep,ev,re,r,rp) end
	if chk==0 then return Duel.IsExistingTarget(c511002387.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	Duel.SelectTarget(tp,c511002387.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,eg,ep,ev,re,r,rp)
end
function c511002387.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) 
		and (not tc:IsType(TYPE_CONTINUOUS+TYPE_EQUIP) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
		local te=tc:GetActivateEffect()
		if not te then return end
		if tc:IsType(TYPE_CONTINUOUS+TYPE_EQUIP) then
			Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
		end
		local tg=te:GetTarget()
		local op=te:GetOperation()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
	end
end
