--Boss Duel
function c95000000.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c95000000.stcon)
	e1:SetOperation(c95000000.stop)
	c:RegisterEffect(e1)
	--no summon limit
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetTargetRange(1,0)
	e3:SetValue(99)
	c:RegisterEffect(e3)
	--grave to hand
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_REMOVED)
	e4:SetCountLimit(1)
	e4:SetOperation(c95000000.thop)
	c:RegisterEffect(e4)
	--cannot lose for draw
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_DRAW_COUNT)
	e5:SetTargetRange(1,0)
	e5:SetValue(c95000000.value)
	e5:SetCondition(c95000000.deckcon)
	e5:SetRange(LOCATION_REMOVED)
	c:RegisterEffect(e5)
	--rearrange
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_PREDRAW)
	e6:SetRange(LOCATION_REMOVED)
	e6:SetCountLimit(1)
	e6:SetCondition(c95000000.ordercon)
	e6:SetOperation(c95000000.orderop)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_CHAIN_SOLVED)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_ADJUST)
	e8:SetRange(LOCATION_REMOVED)
	e8:SetCondition(c95000000.ordercon)
	e8:SetOperation(c95000000.orderop)
	c:RegisterEffect(e8)
	--cannot banish
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_REMOVE)
	e9:SetRange(LOCATION_REMOVED)
	e9:SetOperation(c95000000.banop)
	c:RegisterEffect(e9)
	--protection
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e11)
	local e12=e10:Clone()
	e12:SetCode(EFFECT_CANNOT_TO_DECK) 
	c:RegisterEffect(e12)
	local e13=e10:Clone()
	e13:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e13)
	--replace
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e14:SetCode(EFFECT_SEND_REPLACE)
	e14:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e14:SetRange(LOCATION_REMOVED)
	e14:SetTarget(c95000000.reptg)
	e14:SetValue(c95000000.repval)
	e14:SetOperation(c95000000.repop)
	c:RegisterEffect(e14)
	--opponent effect
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e15:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e15:SetCode(EVENT_ADJUST)
	e15:SetRange(LOCATION_REMOVED)
	e15:SetCountLimit(1)
	e15:SetOperation(c95000000.effop)
	c:RegisterEffect(e15)
end
function c95000000.stcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
function c95000000.stfilter(c)
    return not c:IsSetCard(0xbde)
end
function c95000000.afilter0(c)
    return c.mark and c.mark==0
end
function c95000000.afilter1(c)
    return c.mark and c.mark==1
end
function c95000000.afilter2(c)
    return c.mark and c.mark==2
end
function c95000000.afilter3(c)
    return c.mark and c.mark==3
end
function c95000000.stop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,95000000) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		local hct=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		Duel.Hint(HINT_CARD,0,95000000)
		local g=Duel.GetMatchingGroup(c95000000.stfilter,tp,0xff,0,c)
		if g:GetCount()>0 then
			Duel.SendtoDeck(g,nil,-2,REASON_RULE)
		end
		local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoDeck(hg,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		--arrange time
		local g0=Duel.GetMatchingGroup(c95000000.afilter0,tp,LOCATION_DECK,0,nil)
		local g1=Duel.GetMatchingGroup(c95000000.afilter1,tp,LOCATION_DECK,0,nil)
		local g2=Duel.GetMatchingGroup(c95000000.afilter2,tp,LOCATION_DECK,0,nil)
		local g3=Duel.GetMatchingGroup(c95000000.afilter3,tp,LOCATION_DECK,0,nil)
		local tc3=g3:GetFirst()
		while tc3 do
			Duel.MoveSequence(tc3,0)
			tc3=g3:GetNext()
		end
		local tc2=g2:GetFirst()
		while tc2 do
			Duel.MoveSequence(tc2,0)
			tc2=g2:GetNext()
		end
		local tc1=g1:GetFirst()
		while tc1 do
			Duel.MoveSequence(tc1,0)
			tc1=g1:GetNext()
		end
		local tc0=g0:GetFirst()
		while tc0 do
			Duel.MoveSequence(tc0,0)
			tc0=g0:GetNext()
		end
		Duel.Draw(tp,hct,REASON_EFFECT)
	end
end
function c95000000.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then 
		Duel.Hint(HINT_CARD,0,95000000)
		Duel.SendtoHand(g,nil,REASON_RULE)
	end
end
function c95000000.value(e,c)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_DECK,0)
end
function c95000000.deckcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetDrawCount(tp)>Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
end
function c95000000.ordercon(e,tp,eg,ep,ev,re,r,rp)
	local ct=1
	local g=Duel.GetDecktopGroup(tp,ct)
	local gn=Duel.GetDecktopGroup(tp,ct+1)
	local tc1=g:GetFirst()
	if not tc1 then return false end
	if gn:GetCount()<2 then return false end
	gn:Sub(g)
	local tc2=gn:GetFirst()
	local markchk=tc1.mark
	while tc2 do
		if markchk>tc2.mark then
			return true
		elseif markchk<tc2.mark then
			markchk=tc2.mark
		end
		ct=ct+1
		g=Duel.GetDecktopGroup(tp,ct)
		gn=Duel.GetDecktopGroup(tp,ct+1)
		gn:Sub(g)
		tc2=gn:GetFirst()
	end
	return false
end
function c95000000.orderop(e,tp,eg,ep,ev,re,r,rp)
	local g0=Duel.GetMatchingGroup(c95000000.afilter0,tp,LOCATION_DECK,0,nil)
	local g1=Duel.GetMatchingGroup(c95000000.afilter1,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(c95000000.afilter2,tp,LOCATION_DECK,0,nil)
	local g3=Duel.GetMatchingGroup(c95000000.afilter3,tp,LOCATION_DECK,0,nil)
	local tc3=g3:GetFirst()
	while tc3 do
		Duel.MoveSequence(tc3,0)
		tc3=g3:GetNext()
	end
	local tc2=g2:GetFirst()
	while tc2 do
		Duel.MoveSequence(tc2,0)
		tc2=g2:GetNext()
	end
	local tc1=g1:GetFirst()
	while tc1 do
		Duel.MoveSequence(tc1,0)
		tc1=g1:GetNext()
	end
	local tc0=g0:GetFirst()
	while tc0 do
		Duel.MoveSequence(tc0,0)
		tc0=g0:GetNext()
	end
end
function c95000000.banfilter(c,tp)
	return not c:IsType(TYPE_TOKEN) and c:GetOwner()==tp and c:GetOriginalCode()~=95000000
end
function c95000000.banop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c95000000.banfilter,nil,tp)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,r+REASON_DESTROY+REASON_RETURN)
	end
end
function c95000000.repfilter(c,tp)
	return c:GetOwner()==tp and c:GetOriginalCode()~=95000000 and c:GetDestination()==LOCATION_REMOVED
end
function c95000000.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c95000000.repfilter,1,nil,tp) end
	local g=eg:Filter(c95000000.repfilter,nil,tp)
	local tc=g:GetFirst()
	while tc do
		tc:SetStatus(STATUS_DESTROY_CONFIRMED,true)
		tc=g:GetNext()
	end
	g:KeepAlive()
	e:SetLabel(r)
	e:SetLabelObject(g)
	return true
end
function c95000000.repval(e,c)
	return c95000000.repfilter(c,e:GetHandlerPlayer())
end
function c95000000.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tc=g:GetFirst()
	while tc do
		tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
		tc=g:GetNext()
	end
	local rs=e:GetLabel()
	Duel.Destroy(g,rs+REASON_REPLACE)
end
function c95000000.effop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then return end
	local a=Duel.GetFlagEffect(1-tp,951)==0
	local b=Duel.GetFlagEffect(1-tp,952)==0
	local c=Duel.GetFlagEffect(1-tp,953)==0
	if not a and not b and not c then return end
	if not Duel.SelectYesNo(1-tp,aux.Stringid(95000000,0)) then return end
	local op=0
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(76922029,0))
	if a and b and c then
		op=Duel.SelectOption(1-tp,aux.Stringid(95000000,1),aux.Stringid(95000000,2),aux.Stringid(95000000,3))
	elseif a and b then
		op=Duel.SelectOption(1-tp,aux.Stringid(95000000,1),aux.Stringid(95000000,2))
	elseif b and c then
		op=Duel.SelectOption(1-tp,aux.Stringid(95000000,2),aux.Stringid(95000000,3))
		op=op+1
	elseif a and c then
		op=Duel.SelectOption(1-tp,aux.Stringid(95000000,1),aux.Stringid(95000000,3))
		if op==1 then op=op+1 end
	elseif a then
		Duel.SelectOption(1-tp,aux.Stringid(95000000,1))
		op=0
	elseif b then
		Duel.SelectOption(1-tp,aux.Stringid(95000000,2))
		op=1
	else
		Duel.SelectOption(1-tp,aux.Stringid(95000000,3))
		op=2
	end
	Duel.Hint(HINT_CARD,0,95000000)
	if op==0 then
		Duel.RegisterFlagEffect(1-tp,951,nil,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetCondition(c95000000.atkcon)
		e1:SetValue(c95000000.atkval)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,1-tp)
	elseif op==1 then
		Duel.RegisterFlagEffect(1-tp,952,nil,0,1)
		--
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PREDRAW)
		e2:SetCondition(c95000000.con)
		e2:SetOperation(c95000000.op)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,1-tp)
	else
		Duel.RegisterFlagEffect(1-tp,953,nil,0,1)
		local opt=Duel.SelectOption(1-tp,aux.Stringid(95000000,4),aux.Stringid(95000000,5))
		local p=(opt==0 and 1-tp or tp)
		Duel.Recover(p,4000,REASON_RULE)
	end
end
function c95000000.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x80
end
function c95000000.atkval(e,c)
	return c:GetAttack()*2
end
function c95000000.con(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetDrawCount(tp)>0
end
function c95000000.op(e,tp,eg,ep,ev,re,r,rp)
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
	_replace_count=_replace_count+1
	if _replace_count>_replace_max then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
