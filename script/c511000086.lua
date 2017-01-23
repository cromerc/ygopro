--Bounce Spell
function c511000086.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000086.target)
	e1:SetOperation(c511000086.activate)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511000086.condition)
	e2:SetTarget(c511000086.target2)
	e2:SetOperation(c511000086.activate2)
	c:RegisterEffect(e2)
end
function c511000086.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsFaceup() and c:IsAbleToChangeControler()
end
function c511000086.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511000086.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c511000086.filter,tp,0,LOCATION_SZONE,1,e:GetHandler()) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetCurrentChain()==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511000086.filter,tp,0,LOCATION_SZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511000086.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsType(TYPE_PENDULUM) then
			local token=Duel.CreateToken(tp,tc:GetOriginalCode())
			Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SendtoDeck(tc,nil,-2,REASON_EFFECT)
		else
			local tpe=tc:GetType()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if of then Duel.Destroy(of,REASON_RULE) end
				of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
		end
	end
end
function c511000086.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>0
end
function c511000086.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c511000086.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c511000086.filter,tp,0,LOCATION_SZONE,1,e:GetHandler()) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511000086.filter,tp,0,LOCATION_SZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511000086.activate2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsType(TYPE_PENDULUM) then
			local token=Duel.CreateToken(tp,tc:GetOriginalCode())
			Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SendtoDeck(tc,nil,-2,REASON_EFFECT)
		else
			local tpe=tc:GetType()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if of then Duel.Destroy(of,REASON_RULE) end
				of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
			if tc==re:GetHandler() then
				local op=re:GetOperation()
				if op then
					Duel.ChangeChainOperation(ev,c511000086.repop(tp,op))
				end
			end
		end
	end
end
function c511000086.repop(tp2,op)
	return function(e,tp,eg,ep,ev,re,r,rp)
		op(e,tp2,eg,ep,ev,re,r,rp)
	end
end
