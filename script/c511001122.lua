--Graverobber
function c511001122.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001122.target)
	e1:SetOperation(c511001122.operation)
	c:RegisterEffect(e1)
	if not c511001122.global_check then
		c511001122.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511001122.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511001122.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511001122.filter(c,e,tp,eg,ep,ev,re,r,rp,chain)
	if c:IsType(TYPE_MONSTER) then
		if c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		else
			return c:IsAbleToHand()
		end
	else
		if not c:IsType(TYPE_FIELD) and Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return false end
		local te=c:GetActivateEffect()
		if te then
			local condition=te:GetCondition()
			local cost=te:GetCost()
			local target=te:GetTarget()
			if te:GetCode()==EVENT_CHAINING then
				if chain<=0 then return false end
				local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
				local tc=te2:GetHandler()
				local g=Group.FromCards(tc)
				local p=tc:GetControler()
				return (not condition or condition(te,tp,g,p,chain,te2,REASON_EFFECT,p)) and (not cost or cost(te,tp,g,p,chain,te2,REASON_EFFECT,p,0)) 
					and (not target or target(te,tp,g,p,chain,te2,REASON_EFFECT,p,0))
			elseif te:GetCode()==EVENT_ATTACK_ANNOUNCE then
				local a=Duel.GetAttacker()
				local p=Duel.GetTurnPlayer()
				if not a then return false end
				return (not condition or condition(te,tp,a,p,0,nil,0,p)) and (not cost or cost(te,tp,a,p,0,nil,0,p,0)) 
					and (not target or target(te,tp,a,p,0,nil,0,p,0))
			else
				return (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
					and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
			end
		else
			return c:IsSSetable()
		end
	end
end
function c511001122.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local chain=Duel.GetCurrentChain()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511001122.filter(chkc,e,tp,eg,ep,ev,re,r,rp,chain) end
	if chk==0 then return Duel.IsExistingTarget(c511001122.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp,eg,ep,ev,re,r,rp,chain) end
	chain=chain-1
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001122.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,eg,ep,ev,re,r,rp,chain)
end
function c511001122.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local tpe=tc:GetType()
	if tc:IsType(TYPE_MONSTER) then
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	else
		if not tc:IsType(TYPE_FIELD) and Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		if te then
			local tg=te:GetTarget()
			local co=te:GetCost()
			local op=te:GetOperation()
			e:SetCategory(te:GetCategory())
			e:SetProperty(te:GetProperty())
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.GetFlagEffect(tp,62765383)>0 then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				else
					Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				end
			end
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			if tc:IsType(TYPE_FIELD) and tc:GetSequence()~=5 then
				Duel.MoveSequence(tc,5)
			end
			Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
			tc:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
			if te:GetCode()==EVENT_CHAINING then
				local chain=Duel.GetCurrentChain()-1
				local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
				local tc=te2:GetHandler()
				local g=Group.FromCards(tc)
				local p=tc:GetControler()
				if co then co(te,tp,g,p,chain,te2,REASON_EFFECT,p,1) end
				if tg then tg(te,tp,g,p,chain,te2,REASON_EFFECT,p,1) end
			elseif te:GetCode()==EVENT_ATTACK_ANNOUNCE then
				local a=Duel.GetAttacker()
				local p=Duel.GetTurnPlayer()
				if co then co(te,tp,a,p,0,nil,0,p,1) end
				if tg then tg(te,tp,a,p,0,nil,0,p,1) end
			else
				if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
				if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
			end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if te:GetCode()==EVENT_CHAINING then
				local chain=Duel.GetCurrentChain()-1
				local te2=Duel.GetChainInfo(chain,CHAININFO_TRIGGERING_EFFECT)
				local tc=te2:GetHandler()
				local g=Group.FromCards(tc)
				local p=tc:GetControler()
				if op then op(te,tp,g,p,chain,te2,REASON_EFFECT,p) end
			elseif te:GetCode()==EVENT_ATTACK_ANNOUNCE then
				local a=Duel.GetAttacker()
				local p=Duel.GetTurnPlayer()
				if op then op(te,tp,a,p,0,nil,0,p) end
			else
				if op then op(te,tp,eg,ep,ev,re,r,rp) end
			end
			tc:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
				end
			end
		else
			Duel.SSet(tp,tc)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
