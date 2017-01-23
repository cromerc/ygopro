--Emergency Evasion
function c511001750.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001750.condition)
	e1:SetTarget(c511001750.target)
	e1:SetOperation(c511001750.activate)
	c:RegisterEffect(e1)
end
function c511001750.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511001750.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511001750.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,e:GetHandler())
	if g:GetCount()>0 and Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)>0 then
		local rg=Duel.GetOperatedGroup()
		rg:KeepAlive()
		local tc=rg:GetFirst()
		while tc do
			tc:RegisterFlagEffect(511001750,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			tc=rg:GetNext()
		end
		if Duel.GetTurnPlayer()==tp then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_SPSUMMON_PROC_G)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetRange(0xff)
			e1:SetCountLimit(1)
			e1:SetLabelObject(rg)
			e1:SetCondition(c511001750.drcon1)
			e1:SetOperation(c511001750.drop1)
			e1:SetReset(RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_SUMMON_SUCCESS)
		e2:SetCondition(c511001750.drcon2)
		e2:SetOperation(c511001750.drop2)
		e2:SetLabelObject(rg)
		e2:SetRange(0xff)
		e2:SetReset(RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EVENT_SPSUMMON_SUCCESS)
		e3:SetCondition(c511001750.drcon3)
		c:RegisterEffect(e3)
		local e4=e2:Clone()
		e4:SetCode(EVENT_CHAIN_END)
		c:RegisterEffect(e4)
		local e5=e2:Clone()
		e5:SetCode(EVENT_ATTACK_ANNOUNCE)
		c:RegisterEffect(e5)
		local e6=e2:Clone()
		e6:SetCode(EVENT_DAMAGE_STEP_END)
		c:RegisterEffect(e6)
		local e7=e2:Clone()
		e7:SetCode(EVENT_PHASE+PHASE_END)
		e7:SetCountLimit(1)
		c:RegisterEffect(e7)
	end
end
function c511001750.drcon1(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsPlayerCanDraw(tp,1) and c:GetFlagEffect(511001749)==0
end
function c511001750.retfilter(c,tp,tpe)
	return c:GetFlagEffect(511001750)>0 and c:IsLocation(LOCATION_REMOVED) and c:IsType(tpe) 
		and (Duel.GetLocationCount(tp,c:GetPreviousLocation())>0 or c:IsType(TYPE_FIELD))
end
function c511001750.drop1(e,tp,eg,ep,ev,re,r,rp,c,og)
	local g=e:GetLabelObject()
	c:RegisterFlagEffect(511001749,RESET_PHASE+PHASE_END,0,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.Hint(HINT_CARD,0,511001750)
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		local tpe=0
		if tc:IsType(TYPE_MONSTER) then
			tpe=TYPE_MONSTER
		elseif tc:IsType(TYPE_SPELL) then
			tpe=TYPE_SPELL
		elseif tc:IsType(TYPE_TRAP) then
			tpe=TYPE_TRAP
		else
			return
		end
		if g:IsExists(c511001750.retfilter,1,nil,tp,tpe) then
			local rg=g:FilterSelect(tp,c511001750.retfilter,1,1,nil,tp,tpe)
			Duel.HintSelection(rg)
			local rc=rg:GetFirst()
			if bit.band(rc:GetType(),TYPE_FIELD) then
				local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if of then Duel.Destroy(of,REASON_RULE) end
				of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 and Duel.SendtoGrave(of,REASON_RULE)==0 then
					Duel.SendtoGrave(rc,REASON_RULE)
				end
			end
			if rc:GetPreviousLocation()==LOCATION_MZONE then
				Duel.ReturnToField(rc)
			else
				Duel.MoveToField(rc,tp,tp,rc:GetPreviousLocation(),rc:GetPreviousPosition(),true)
			end
		end
		Duel.ShuffleHand(tp)
	end
	return
end
function c511001750.drcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsPlayerCanDraw(tp,1) and e:GetHandler():GetFlagEffect(511001749)==0
end
function c511001750.drcon3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsPlayerCanDraw(tp,1) and e:GetHandler():GetFlagEffect(511001749)==0 and Duel.GetCurrentChain()==0
end
function c511001750.drop2(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectYesNo(tp,aux.Stringid(30461781,0)) then return end
	local g=e:GetLabelObject()
	e:GetHandler():RegisterFlagEffect(511001749,RESET_PHASE+PHASE_END,0,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	Duel.Hint(HINT_CARD,0,511001750)
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		local tpe=0
		if tc:IsType(TYPE_MONSTER) then
			tpe=TYPE_MONSTER
		elseif tc:IsType(TYPE_SPELL) then
			tpe=TYPE_SPELL
		elseif tc:IsType(TYPE_TRAP) then
			tpe=TYPE_TRAP
		else
			return
		end
		if g:IsExists(c511001750.retfilter,1,nil,tp,tpe) then
			local rg=g:FilterSelect(tp,c511001750.retfilter,1,1,nil,tp,tpe)
			Duel.HintSelection(rg)
			local rc=rg:GetFirst()
			if bit.band(rc:GetType(),TYPE_FIELD) then
				local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if of then Duel.Destroy(of,REASON_RULE) end
				of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if of and Duel.Destroy(of,REASON_RULE)==0 and Duel.SendtoGrave(of,REASON_RULE)==0 then
					Duel.SendtoGrave(rc,REASON_RULE)
				end
			end
			if rc:GetPreviousLocation()==LOCATION_MZONE then
				Duel.ReturnToField(rc)
			else
				Duel.MoveToField(rc,tp,tp,rc:GetPreviousLocation(),rc:GetPreviousPosition(),true)
			end
		end
		Duel.ShuffleHand(tp)
	end
end
