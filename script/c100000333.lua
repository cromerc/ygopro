--Ｆａｉｒｙ Ｔａｌｅ最終章 忘却の妖月
function c100000333.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c100000333.tg)
	e2:SetOperation(c100000333.op)
	c:RegisterEffect(e2)	
	--unnegatable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetCondition(c100000333.accon)
	e3:SetOperation(c100000333.acop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	c:RegisterEffect(e4)
	if not c100000333.global_check then
		c100000333.global_check=true
		--check obsolete ruling
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c100000333.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c100000333.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
		--obsolete
		Duel.RegisterFlagEffect(tp,62765383,0,0,1)
		Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
	end
end
function c100000333.filter(c,tp)
	return c:IsCode(100000330) and c:GetActivateEffect():IsActivatable(tp)
end
function c100000333.accon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c100000333.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c100000333.filter,tp,0x13,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if Duel.GetFlagEffect(tp,62765383)>0 then
			if fc then Duel.Destroy(fc,REASON_RULE) end
			of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		else
			Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		end
		Duel.BreakEffect()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
function c100000333.pofilter1(c,e,tp)
	return c:GetPosition()==POS_FACEUP_ATTACK and c:GetPreviousPosition()>0x3
end
function c100000333.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return eg:IsContains(chkc) and c100000333.pofilter1(chkc) end
	if chk==0 then return eg:IsExists(c100000333.pofilter1,1,nil) end
	return true
end
function c100000333.spop2(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100000333.pofilter1,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	 tc=g:GetNext()
	end
end
function c100000333.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFlagEffect(tp,100000330)==0
end
function c100000333.posfilter(c,e)
	return bit.band(c:GetPreviousPosition(),POS_DEFENSE)~=0 and c:IsPosition(POS_FACEUP_ATTACK) 
		and (not e or c:IsRelateToEffect(e))
end
function c100000333.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c100000333.posfilter,1,nil) and rp==tp end
	Duel.SetTargetCard(eg)
end
function c100000333.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c100000333.posfilter,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
