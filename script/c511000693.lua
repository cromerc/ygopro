--Hand Control
function c511000693.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000693.target)
	e1:SetOperation(c511000693.operation)
	c:RegisterEffect(e1)
	if not c511000693.global_check then
		c511000693.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511000693.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000693.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511000693.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	e:GetHandler():SetHint(CHINT_CARD,ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c511000693.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_HAND,nil,ac)
	local tc=g:GetFirst()
	if tc then
		local te=tc:GetActivateEffect()
		if te then
			local tpe=tc:GetType()
			local con=te:GetCondition()
			local co=te:GetCost()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			if (con and not con(te,1-tp,eg,ep,ev,re,r,rp)) or (co and not co(te,1-tp,eg,ep,ev,re,r,rp,0)) or (tg and not tg(te,1-tp,eg,ep,ev,re,r,rp,0)) 
				or (not tc:IsType(TYPE_FIELD) and Duel.GetLocationCount(1-tp,LOCATION_SZONE)<=0) then return end
			Duel.ClearTargetCard()
			if bit.band(tpe,TYPE_FIELD)~=0 then
				local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
				if Duel.GetFlagEffect(tp,62765383)>0 then
					if fc then Duel.Destroy(fc,REASON_RULE) end
					of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				else
					Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
					if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				end
			end
			Duel.MoveToField(tc,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
			tc:CreateEffectRelation(te)
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
				tc:CancelToGrave(false)
			end
			if co then co(te,1-tp,eg,ep,ev,re,r,rp,1) end
			if tg then tg(te,1-tp,eg,ep,ev,re,r,rp,1) end
			Duel.BreakEffect()
			local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
			if g then
				local etc=g:GetFirst()
				while etc do
					etc:CreateEffectRelation(te)
					etc=g:GetNext()
				end
			end
			if op then op(te,1-tp,eg,ep,ev,re,r,rp) end
			tc:ReleaseEffectRelation(te)
			if etc then	
				etc=g:GetFirst()
				while etc do
					etc:ReleaseEffectRelation(te)
					etc=g:GetNext()
				end
			end
		else
			if tc:IsSummonable(true,nil) then
				Duel.Summon(1-tp,tc,true,nil)
			end
		end
	end
end
