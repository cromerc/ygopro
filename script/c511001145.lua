--Spell Textbook
function c511001145.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001145.cost)
	e1:SetTarget(c511001145.target)
	e1:SetOperation(c511001145.activate)
	c:RegisterEffect(e1)
	if not c511001145.global_check then
		c511001145.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511001145.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511001145.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511001145.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()==0 or g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c511001145.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001145.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
	local g=Duel.GetDecktopGroup(p,1)
	local tc=g:GetFirst()
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.ConfirmCards(1-p,tc)
	Duel.ShuffleHand(p)
	if (Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or tc:IsType(TYPE_FIELD)) and tc:IsType(TYPE_SPELL) 
		and tc:CheckActivateEffect(false,false,false)~=nil then
		local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
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
		Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
		tc:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 and not tc:IsHasEffect(EFFECT_REMAIN_FIELD) then
			tc:CancelToGrave(false)
		end
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if g then
			local etc=g:GetFirst()
			while etc do
				etc:CreateEffectRelation(te)
				etc=g:GetNext()
			end
		end
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		tc:ReleaseEffectRelation(te)
		if etc then	
			etc=g:GetFirst()
			while etc do
				etc:ReleaseEffectRelation(te)
				etc=g:GetNext()
			end
		end
	end	
end
