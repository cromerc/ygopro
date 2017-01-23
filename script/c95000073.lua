--AF Prison Tower of Darkville
function c95000073.initial_effect(c)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetOperation(c95000073.op)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetOperation(c95000073.repop)
	c:RegisterEffect(e2)		
	--unaffectable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c95000073.ctcon2)
	c:RegisterEffect(e6)
	--cannot set
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_SSET)
	e7:SetRange(LOCATION_SZONE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetTargetRange(1,0)
	e7:SetTarget(c95000073.sfilter)
	c:RegisterEffect(e7)
	-- Add Action Card
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(95000073,0))
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetCondition(c95000073.condition)
	e8:SetTarget(c95000073.Acttarget)
	e8:SetOperation(c95000073.operation)
	c:RegisterEffect(e8)
	
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_SZONE)
	eb:SetTargetRange(LOCATION_SZONE,0)
	eb:SetTarget(c95000073.tgn)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)
end
function c95000073.ctcon2(e,re)
	return re:GetHandler()~=e:GetHandler()
end
--speed Duel Filter
function c95000073.SDfilter(c)
	return c:GetCode()==511004001
end
--vanilla mode filter
function c95000073.Vfilter(c)
	return c:GetCode()==511004002
end
function c95000073.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)	
	
	--check if number of card >20 if speed duel or >40 if other duel
	if Duel.IsExistingMatchingCard(c95000073.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) and Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
	Duel.Win(1-tp,0x55)
	end
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,e:GetHandler()):GetCount()<40 and not Duel.IsExistingMatchingCard(c95000073.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
	Duel.Win(1-tp,0x55)
	end
	
	--move to field
	if tc==nil then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if tc2==nil then
			local token=Duel.CreateToken(tp,95000073,nil,nil,nil,nil,nil,nil)		
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_FIELD)
			token:RegisterEffect(e1)
			Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SpecialSummonComplete()
		end
		-- add ability Yell when Vanilla mode activated
		-- if Duel.IsExistingMatchingCard(c95000073.Vfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
			-- c95000073.tableAction.push(95000200)
		-- end
	else
		Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_EFFECT)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end

function c95000073.sfilter(e,c,tp)
	return c:IsType(TYPE_FIELD) 
end
function c95000073.tgn(e,c)
	return c==e:GetHandler()
end


-- Add Action Card
function c95000073.Acttarget(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.Hint(HINT_SELECTMSG,tp,564)
local seed=0
if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then
local g=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND+LOCATION_SZONE,0,nil)
seed = g:GetFirst():GetCode()
else
local g=Duel.GetDecktopGroup(tp,1)
local tc=g:GetFirst()
seed=tc:GetCode()
end

math.randomseed( seed )

ac=math.random(1,#tableAction)
e:SetLabel(tableAction[ac])
end
function c95000073.operation(e,tp,eg,ep,ev,re,r,rp)
local dc=Duel.TossDice(tp,1)
if dc==2 or dc==3 or dc==4 or dc==6 then
e:GetHandler():RegisterFlagEffect(95000073,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
if dc==1 or dc==2 then
 if not Duel.IsExistingMatchingCard(c95000073.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		--- check action Trap
		if (e:GetLabel()==95000071 or e:GetLabel()==95000072) then
		local token=Duel.CreateToken(tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SpecialSummonComplete()
			if not Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) then
				Duel.SendtoGrave(token,nil,REASON_RULE) end
			local tc=token
			Duel.ConfirmCards(tp,tc)
			if tc:IsType(TYPE_TRAP) then
				local te=tc:GetActivateEffect()
				local tep=tc:GetControler()
			if not te then
				Duel.Destroy(tc,REASON_EFFECT)
			else
				local condition=te:GetCondition()
				local cost=te:GetCost()
				local target=te:GetTarget()
				local operation=te:GetOperation()
				if te:GetCode()==EVENT_FREE_CHAIN and not tc:IsStatus(STATUS_SET_TURN)
					and (not condition or condition(te,tep,eg,ep,ev,re,r,rp))
					and (not cost or cost(te,tep,eg,ep,ev,re,r,rp,0))
					and (not target or target(te,tep,eg,ep,ev,re,r,rp,0)) then
					Duel.ClearTargetCard()
					e:SetProperty(te:GetProperty())
					Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
					Duel.ChangePosition(tc,POS_FACEUP)
					if tc:GetType()==TYPE_TRAP then
						tc:CancelToGrave(false)
					end
					tc:CreateEffectRelation(te)
					if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
					if target then target(te,tep,eg,ep,ev,re,r,rp,1) end
					local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
					local tg=g:GetFirst()
					while tg do
						tg:CreateEffectRelation(te)
						tg=g:GetNext()
					end
					if operation then operation(te,tep,eg,ep,ev,re,r,rp) end
					tc:ReleaseEffectRelation(te)
					tg=g:GetFirst()
					while tg do
						tg:ReleaseEffectRelation(te)
						tg=g:GetNext()
					end
				else
					Duel.Destroy(tc,REASON_EFFECT)
				end
			end
		end
		
		else
		---Action Spell
			local token=Duel.CreateToken(tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
			Duel.SendtoHand(token,nil,REASON_EFFECT)
			Duel.SpecialSummonComplete()	
	end
	end
end
	if dc==5 or dc==6 then
	 if not Duel.IsExistingMatchingCard(c95000073.cfilter,1-tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
	--- check action Trap
	if (e:GetLabel()==95000071 or e:GetLabel()==95000072) then
	local token=Duel.CreateToken(1-tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
		Duel.MoveToField(token,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
		if not Duel.IsExistingTarget(Card.IsFaceup,1-tp,LOCATION_MZONE,0,1,nil) then
			Duel.SendtoGrave(token,nil,REASON_RULE) end
		local tc=token
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsType(TYPE_TRAP) then
			local te=tc:GetActivateEffect()
			local tep=tc:GetControler()
		if not te then
			Duel.Destroy(tc,REASON_EFFECT)
		else
			local condition=te:GetCondition()
			local cost=te:GetCost()
			local target=te:GetTarget()
			local operation=te:GetOperation()
			if te:GetCode()==EVENT_FREE_CHAIN and not tc:IsStatus(STATUS_SET_TURN)
				and (not condition or condition(te,tep,eg,ep,ev,re,r,rp))
				and (not cost or cost(te,tep,eg,ep,ev,re,r,rp,0))
				and (not target or target(te,tep,eg,ep,ev,re,r,rp,0)) then
				Duel.ClearTargetCard()
				e:SetProperty(te:GetProperty())
				Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
				Duel.ChangePosition(tc,POS_FACEUP)
				if tc:GetType()==TYPE_TRAP then
					tc:CancelToGrave(false)
				end
				tc:CreateEffectRelation(te)
				if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
				if target then target(te,tep,eg,ep,ev,re,r,rp,1) end
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				local tg=g:GetFirst()
				while tg do
					tg:CreateEffectRelation(te)
					tg=g:GetNext()
				end
				if operation then operation(te,tep,eg,ep,ev,re,r,rp) end
				tc:ReleaseEffectRelation(te)
				tg=g:GetFirst()
				while tg do
					tg:ReleaseEffectRelation(te)
					tg=g:GetNext()
				end
			else
				Duel.Destroy(tc,REASON_EFFECT)
			end
		end
	end
	
	else
	---Action Spell
		local token=Duel.CreateToken(1-tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
		Duel.SendtoHand(token,1-tp,REASON_EFFECT)
		Duel.SpecialSummonComplete()
		end	
		end
end

else 
if not Duel.IsExistingMatchingCard(c95000073.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		--- check action Trap
		if (e:GetLabel()==95000071 or e:GetLabel()==95000072) then
		local token=Duel.CreateToken(tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SpecialSummonComplete()
			if not Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) then
				Duel.SendtoGrave(token,nil,REASON_RULE) end
			local tc=token
			Duel.ConfirmCards(tp,tc)
			if tc:IsType(TYPE_TRAP) then
				local te=tc:GetActivateEffect()
				local tep=tc:GetControler()
			if not te then
				Duel.Destroy(tc,REASON_EFFECT)
			else
				local condition=te:GetCondition()
				local cost=te:GetCost()
				local target=te:GetTarget()
				local operation=te:GetOperation()
				if te:GetCode()==EVENT_FREE_CHAIN and not tc:IsStatus(STATUS_SET_TURN)
					and (not condition or condition(te,tep,eg,ep,ev,re,r,rp))
					and (not cost or cost(te,tep,eg,ep,ev,re,r,rp,0))
					and (not target or target(te,tep,eg,ep,ev,re,r,rp,0)) then
					Duel.ClearTargetCard()
					e:SetProperty(te:GetProperty())
					Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
					Duel.ChangePosition(tc,POS_FACEUP)
					if tc:GetType()==TYPE_TRAP then
						tc:CancelToGrave(false)
					end
					tc:CreateEffectRelation(te)
					if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
					if target then target(te,tep,eg,ep,ev,re,r,rp,1) end
					local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
					local tg=g:GetFirst()
					while tg do
						tg:CreateEffectRelation(te)
						tg=g:GetNext()
					end
					if operation then operation(te,tep,eg,ep,ev,re,r,rp) end
					tc:ReleaseEffectRelation(te)
					tg=g:GetFirst()
					while tg do
						tg:ReleaseEffectRelation(te)
						tg=g:GetNext()
					end
				else
					Duel.Destroy(tc,REASON_EFFECT)
				end
			end
		end
		
		else
		---Action Spell
			local token=Duel.CreateToken(tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
			Duel.SendtoHand(token,nil,REASON_EFFECT)
			Duel.SpecialSummonComplete()	
	end
	end
end

function c95000073.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c95000073.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil)
	and Duel.GetFlagEffect(e:GetHandlerPlayer(),95000073)==0
	and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c95000073.cfilter(c)
	return c:IsSetCard(0xac1)
end
tableAction = {
95000044,
95000045,
95000046,
95000071,
95000072,
95000143
} 
function c95000073.repop(e)
	local c=e:GetHandler()
		if c:GetFlagEffect(900000007)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_END)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetLabelObject(c)
		e1:SetOperation(c95000073.returnop)
		Duel.RegisterEffect(e1,0)
		c:RegisterFlagEffect(900000007,0,0,1)
	end
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
end
function c95000073.returnop(e)
	local c=e:GetLabelObject()
	local tp=c:GetControler()
	local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if not fc then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	if fc and fc:GetFlagEffect(195000073)==0 then
	--action card get
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95000073,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c95000073.condition)
	e1:SetTarget(c95000073.Acttarget)
	e1:SetOperation(c95000073.operation)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	fc:RegisterEffect(e1)
	--cannot set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SSET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetTargetRange(1,0)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetTarget(c95000073.sfilter)
	fc:RegisterEffect(e4)
	fc:RegisterFlagEffect(195000073,RESET_EVENT+0x1fe0000,0,1)
	end
end
