--Graveyard Rebound
function c513000080.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001629,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c513000080.con)
	e1:SetOperation(c513000080.op)
	c:RegisterEffect(e1)
end
function c513000080.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_DECK) and e:GetHandler():GetPreviousControler()==tp and bit.band(r,REASON_EFFECT)~=0
end
function c513000080.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c513000080.tdtg)
	e1:SetOperation(c513000080.tdop)
	if Duel.GetTurnPlayer()==tp then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c513000080.tdcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
	end
	e:GetHandler():RegisterEffect(e1)
end
function c513000080.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c513000080.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c513000080.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		Duel.RegisterFlagEffect(tp,513000080,RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetOperation(c513000080.operation)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c513000080.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_SPELL+TYPE_TRAP)
	if g:GetCount()<=0 then return end
	local tc=g:GetFirst()
	while tc do
		local te=tc:GetActivateEffect()
		if tc:GetFlagEffect(513000080)==0 and te then
			local e1=Effect.CreateEffect(tc)
			if te:GetCategory() then
				e1:SetCategory(te:GetCategory())
			end
			if te:GetProperty() then
				e1:SetProperty(te:GetProperty())
			end
			if te:GetDescription() then
				e1:SetDescription(te:GetDescription())
			end
			if tc:IsType(TYPE_SPELL) and not tc:IsType(TYPE_QUICKPLAY) then
				e1:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_ACTIVATE)
			else
				e1:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_ACTIVATE)
			end
			e1:SetCode(te:GetCode())
			e1:SetRange(LOCATION_GRAVE)
			e1:SetCondition(c513000080.accon)
			if te:GetCost() then
				e1:SetCost(te:GetCost())
			end
			e1:SetTarget(c513000080.actg)
			e1:SetOperation(c513000080.acop)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(513000080,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
		tc=g:GetNext()
	end
end
function c513000080.accon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local condition=te:GetCondition()
	return (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) 
		and Duel.GetFlagEffect(tp,513000080)>0
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c513000080.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local target=te:GetTarget()
	local tpe=c:GetType()
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or c:IsType(TYPE_FIELD)) 
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) end
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 and Duel.SendtoGrave(of,REASON_RULE)==0 then Duel.SendtoGrave(c,REASON_RULE) end
	end
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	c:CreateEffectRelation(te)
	if target then target(te,tp,eg,ep,ev,re,r,rp,1) end			
end
function c513000080.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local op=te:GetOperation()
	local tpe=c:GetType()
	if op then
		c:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
			c:CancelToGrave(false)
		end
		c:ReleaseEffectRelation(te)
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
	end
end
