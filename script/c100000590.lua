--ダークネス
function c100000590.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000590.target)
	e1:SetOperation(c100000590.activate)
	c:RegisterEffect(e1)
	--RandomOpen
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000590,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000590.condition)
	e2:SetOperation(c100000590.operation)
	c:RegisterEffect(e2)
	--reset
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000590,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c100000590.target2)
	e3:SetOperation(c100000590.activate2)
	c:RegisterEffect(e3)
	--Destroy2
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c100000590.descon2)
	e4:SetOperation(c100000590.desop2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(1,0)
	e5:SetValue(c100000590.Value)
	c:RegisterEffect(e5)
end
function c100000590.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000590.filter,tp,0x13,0,1,nil,100000591)
		and Duel.IsExistingMatchingCard(c100000590.filter,tp,0x13,0,1,nil,100000592)
		and Duel.IsExistingMatchingCard(c100000590.filter,tp,0x13,0,1,nil,100000593)
		and Duel.IsExistingMatchingCard(c100000590.filter,tp,0x13,0,1,nil,100000594)
		and Duel.IsExistingMatchingCard(c100000590.filter,tp,0x13,0,1,nil,100000595) end
end
function c100000590.Value(e,re,tp)
	local c=re:GetHandler()
	return c:IsLocation(LOCATION_SZONE) and c:IsFacedown()
end
function c100000590.filter(c,code)
	return c:IsCode(code) and c:IsSSetable()
end
function c100000590.filter22(c,code)
	return c:IsCode(code) and c:IsFaceup()
end
function c100000590.defilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c100000590.tffilter(c)
	local code=c:GetCode()
	return c:IsSSetable() 
	and (code==100000591 or code==100000592 or code==100000593 or code==100000594 or code==100000595)
end
function c100000590.activate(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(100000590,RESET_EVENT+EVENT_CHAIN_END,0,1)
	local g=Duel.GetMatchingGroup(c100000590.defilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<5 then return end 
	Duel.BreakEffect()
	--darkness
	if Duel.GetMatchingGroupCount(c100000590.filter,tp,0x13,0,nil,100000591)==0 then return end 
	if Duel.GetMatchingGroupCount(c100000590.filter,tp,0x13,0,nil,100000592)==0 then return end 
	if Duel.GetMatchingGroupCount(c100000590.filter,tp,0x13,0,nil,100000593)==0 then return end 
	if Duel.GetMatchingGroupCount(c100000590.filter,tp,0x13,0,nil,100000594)==0 then return end 
	if Duel.GetMatchingGroupCount(c100000590.filter,tp,0x13,0,nil,100000595)==0 then return end 
	local sg=Duel.GetMatchingGroup(c100000590.tffilter,tp,0x13,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g1=sg:Select(tp,1,1,nil)
	sg:Remove(Card.IsCode,nil,g1:GetFirst():GetCode())
	ft=ft-1
	local g2=nil
	while ft>0 do
		g2=sg:Select(tp,1,1,nil)
		g1:Merge(g2)
		sg:Remove(Card.IsCode,nil,g2:GetFirst():GetCode())
		ft=ft-1
	end
	local tc=g1:GetFirst()
	while tc do 
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(tc,tp,1,REASON_RULE)
		--Duel.Remove(tc,POS_FACEDOWN,REASON_RULE)
		tc:RegisterFlagEffect(100000590,RESET_EVENT+0x1fe0000,0,1)
		tc=g1:GetNext()
	end
	g1=Duel.GetMatchingGroup(c100000590.setfilterset,tp,LOCATION_DECK,0,nil)
	local tcc=nil
	while g1:GetCount()>0 do 
		tcc=g1:RandomSelect(tp,1):GetFirst()
		g1:Remove(Card.IsCode,nil,tcc:GetCode())
		Duel.DisableShuffleCheck()
		Duel.SSet(tp,tcc)
		--Duel.MoveToField(tcc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,false)
	end
	--Duel.ConfirmCards(1-tp,g1)
end
function c100000590.rdfilter(c)
	return Duel.GetTurnCount()~=c:GetTurnID() and c:IsFacedown()
end
function c100000590.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000590.rdfilter,tp,LOCATION_SZONE,0,1,nil)
		and Duel.GetFlagEffect(tp,100000590)==0 
end
function c100000590.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsLocation(LOCATION_SZONE) or e:GetHandler():IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c100000590.rdfilter,tp,LOCATION_SZONE,0,nil)
	if g:GetCount()>0 then
		local sg=nil
		if e:GetHandler():IsHasEffect(100000703) 
		or Duel.GetMatchingGroupCount(c100000590.filter22,tp,LOCATION_MZONE,0,nil,60417395)>0 
		then sg=g:Select(tp,1,1,nil)
		else sg=g:RandomSelect(tp,1) end
		local tc=sg:GetFirst()
		if  tc:GetType()==TYPE_TRAP+TYPE_CONTINUOUS then
		Duel.ChangePosition(tc,POS_FACEUP)
		else
		Duel.ChangePosition(tc,POS_FACEUP)
		Duel.SendtoGrave(tc,REASON_EFFECT)	
		end
	end
end
function c100000590.filterset(c)
	return c:IsType(TYPE_TRAP) and c:IsFaceup()
end
function c100000590.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000590.filterset,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.RegisterFlagEffect(tp,100000590,RESET_PHASE+PHASE_END,0,1)
end
function c100000590.setfilterset(c)
	return c:GetFlagEffect(100000590)~=0 --and c:IsFacedown() 
end
function c100000590.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000590.filterset,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.ChangePosition(g,POS_FACEDOWN)
	g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,0,nil)
	local tc=g:GetFirst()
	e:GetHandler():RegisterFlagEffect(100000590,RESET_PHASE+PHASE_END,0,1)
	while tc do 
		Duel.SendtoHand(tc,tp,REASON_RULE)
		--Duel.Remove(tc,POS_FACEDOWN,REASON_RULE)
		tc:RegisterFlagEffect(100000590,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
	Duel.ShuffleHand(tp)
	local sgg=Duel.GetMatchingGroup(c100000590.setfilterset,tp,LOCATION_HAND,0,nil)
	tc=sgg:GetFirst()
	while tc do 
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(tc,tp,1,REASON_RULE)
		--Duel.Remove(tc,POS_FACEDOWN,REASON_RULE)
		tc:RegisterFlagEffect(100000590,RESET_EVENT+0x1fe0000,0,1)
		tc=sgg:GetNext()
	end
	--local sg=Duel.GetMatchingGroup(c100000590.setfilterset,tp,LOCATION_REMOVED,0,nil)
	local sg=Duel.GetMatchingGroup(c100000590.setfilterset,tp,LOCATION_DECK,0,nil)
	local tcc=nil
	while sg:GetCount()>0 do 
		tcc=sg:RandomSelect(tp,1):GetFirst()
		sg:RemoveCard(tcc)
		Duel.DisableShuffleCheck()
		Duel.MoveToField(tcc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,false)
	end
end
function c100000590.leavefilter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsType(TYPE_SPELL+TYPE_TRAP)
	 and c:GetPreviousControler()==tp and e:GetHandler():GetFlagEffect(100000590)==0
end
function c100000590.descon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000590.leavefilter,1,nil,e,tp)
end
function c100000590.desop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000590.defilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end