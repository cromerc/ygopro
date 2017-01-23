--Spell Sanctuary
function c511000171.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000171.activate)
	c:RegisterEffect(e1)
	--cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c511000171.aclimit)
	c:RegisterEffect(e2)
	--quick-play
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511000171.operation)
	c:RegisterEffect(e3)
end
function c511000171.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000171.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=Duel.GetMatchingGroup(c511000171.filter,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(24140059,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g1:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	local g2=Duel.GetMatchingGroup(c511000171.filter,1-tp,LOCATION_DECK,0,nil)
	if g2:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(24140059,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g2:Select(1-tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,sg)
	end
end
function c511000171.spfilter(c)
	local te=c:GetActivateEffect()
	return te and (c:IsLocation(LOCATION_HAND) or (c:IsLocation(LOCATION_SZONE) and c:IsFacedown())) 
		and c:IsType(TYPE_SPELL) and not c:IsType(TYPE_QUICKPLAY)
end
function c511000171.aclimit(e,re,tp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_SPELL) then return false end
	local c=re:GetHandler()
	return c:IsLocation(LOCATION_SZONE) and c:IsStatus(STATUS_SET_TURN) and c:GetFlagEffect(511000171)~=0
end
function c511000171.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(c511000171.spfilter,c:GetControler(),LOCATION_SZONE+LOCATION_HAND,LOCATION_SZONE+LOCATION_HAND,nil)
	if g:GetCount()<=0 then return end
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511000171)==0 then
			tc:RegisterFlagEffect(511000171,EVENT_ADJUST,0,1)
			local e1=Effect.CreateEffect(c)
			e1:SetCode(EFFECT_ADD_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(TYPE_QUICKPLAY)
			e1:SetReset(RESET_EVENT+EVENT_ADJUST,1)
			tc:RegisterEffect(e1)
			local te=tc:GetActivateEffect()
			if tc:GetFlagEffect(511000172)==0 and te then
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_QUICK_O)
				e2:SetCode(te:GetCode())
				e2:SetRange(LOCATION_SZONE+LOCATION_HAND)
				e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
				e2:SetCondition(c511000171.accon)
				if te:GetCost() then
					e2:SetCost(te:GetCost())
				end
				e2:SetTarget(c511000171.actg)
				e2:SetOperation(c511000171.acop)
				tc:RegisterEffect(e2)
				tc:RegisterFlagEffect(511000172,nil,0,1)
			end
		end
		tc=g:GetNext()
	end		
end
function c511000171.spsan(c)
	return c:IsFaceup() and not c:IsStatus(STATUS_DISABLED) and c:IsCode(511000171)
end
function c511000171.accon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local condition=te:GetCondition()
	return (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) 
		and Duel.IsExistingMatchingCard(c511000171.spsan,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil)
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000171.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local con=false
	if Duel.GetTurnPlayer()~=c:GetControler() then
		con=not c:IsStatus(STATUS_SET_TURN) and c:IsFacedown() and not c:IsLocation(LOCATION_HAND)
	else
		if Duel.GetCurrentChain()>0 or not (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) then
			if c:IsLocation(LOCATION_HAND) then
				con=(Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or c:IsType(TYPE_FIELD))
			elseif c:IsLocation(LOCATION_SZONE) then
				con=not c:IsStatus(STATUS_SET_TURN) and c:IsFacedown()
			end
		end
	end
	local te=c:GetActivateEffect()
	local target=te:GetTarget()
	local tpe=c:GetType()
	if chk==0 then return con and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) end
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 and Duel.SendtoGrave(of,REASON_RULE)==0 then Duel.SendtoGrave(c,REASON_RULE) end
	end
	if c:IsLocation(LOCATION_ONFIELD) and c:IsFacedown() then
		Duel.ChangePosition(c,POS_FACEUP)
	else
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	c:CreateEffectRelation(te)
	if target then target(te,tp,eg,ep,ev,re,r,rp,1) end			
end
function c511000171.acop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local op=te:GetOperation()
	local tpe=c:GetType()
	if op then
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
			c:CancelToGrave(false)
		end
		c:ReleaseEffectRelation(te)
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
	end
end
