--Sand Fortress
function c511000467.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000467.atkcon)
	e2:SetOperation(c511000467.atkop)
	c:RegisterEffect(e2)
	if not c511000467.global_check then
		c511000467.global_check=true
		--move
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_SSET)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IMMEDIATELY_APPLY)
		ge1:SetOperation(c511000467.setop)
		Duel.RegisterEffect(ge1,0)
		--move
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge2:SetCode(EVENT_CHAINING)
		ge2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IMMEDIATELY_APPLY)
		ge2:SetOperation(c511000467.setop)
		Duel.RegisterEffect(ge2,0)
		--check obsolete ruling
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_DRAW)
		ge3:SetOperation(c511000467.checkop)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511000467.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c511000467.setop(e,tp,eg,ep,ev,re,r,rp)
	local g
	if not eg then g=Group.FromCards(re:GetHandler()):Filter(Card.IsCode,nil,511000467)
	else g=eg:Filter(Card.IsCode,nil,511000467) end
	local tc=g:GetFirst()
	while tc do
		local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if Duel.GetFlagEffect(tp,62765383)>0 then
			if fc then Duel.Destroy(fc,REASON_RULE) end
			of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		else
			Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		end
		Duel.MoveSequence(tc,5)
		tc=g:GetNext()
	end
end
function c511000467.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and ep==tp
end
function c511000467.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(51100467)==0 then
		c:RegisterFlagEffect(51100467,RESET_EVENT+0x1fe0000,0,0)
		e:SetLabel(0)
	end
	local dam=e:GetLabel()
	Duel.ChangeBattleDamage(tp,0)
	e:SetLabel(dam+ev)
	if e:GetLabel()>=3000 then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
