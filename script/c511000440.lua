--Guardian Formation
function c511000440.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511000440.condition)
	e1:SetTarget(c511000440.target)
	e1:SetOperation(c511000440.activate)
	c:RegisterEffect(e1)
	if not c511000440.global_check then
		c511000440.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511000440.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000440.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511000440.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	local seq=d:GetSequence()
	return d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x52) and (seq>0 and Duel.CheckLocation(tp,LOCATION_MZONE,seq-1))
		or (seq<4 and Duel.CheckLocation(tp,LOCATION_MZONE,seq+1))
end
function c511000440.filter(c,e,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te or not te:IsActivatable(tp) then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:IsType(TYPE_SPELL) and (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
end
function c511000440.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local td=Duel.GetAttackTarget()
	if chk==0 then return td:IsOnField() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetTargetCard(td)
end
function c511000440.activate(e,tp,eg,ep,ev,re,r,rp)
	local td=Duel.GetAttackTarget()
	if td and Duel.NegateAttack() and td:IsFaceup() and td:IsRelateToEffect(e) then
		local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
		local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
		Duel.MoveSequence(td,nseq)
		local acg=Duel.GetMatchingGroup(c511000440.filter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp,eg,ep,ev,re,r,rp)
		if acg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(28265983,0)) then
			local tc=acg:Select(tp,1,1,nil):GetFirst()
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
			if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
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
end
