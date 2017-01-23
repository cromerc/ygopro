--Command Duel
function c95200000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(0x5f)
	e1:SetOperation(c95200000.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCountLimit(1)
	e2:SetOperation(c95200000.start)
	e2:SetRange(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--unaffectable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c95200000.ctcon2)
	c:RegisterEffect(e6)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_SINGLE)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_REMOVED)
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
function c95200000.ctcon2(e,re)
	return re:GetOwner()~=e:GetOwner()
end
function c95200000.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,95200000) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		Duel.Hint(HINT_CARD,0,95200000)
	end
	if c:GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c95200000.start(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,95200000)
	local ac=math.random(1,c95200000.commct)
	local code=c95200000.command[ac]
	local p=Duel.GetTurnPlayer()
	if Duel.GetLocationCount(p,LOCATION_SZONE)<=0 then return end
	local tc=Duel.CreateToken(p,code)
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of then Duel.Destroy(of,REASON_RULE) end
		of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
	end
	Duel.MoveToField(tc,p,p,LOCATION_SZONE,POS_FACEUP,true)
	Duel.Hint(HINT_CARD,0,tc:GetCode())
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(95200000,0))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(95200000,0))
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
	Duel.SendtoDeck(tc,nil,-2,REASON_RULE)
end
c95200000.command = {
	95200001,95200002,95200003,95200004,95200005,95200006,95200007,95200008,95200009,
	95200010,95200011,95200012,95200013,95200014,95200015,95200016,95200017,95200018,
	95200019,95200020,95200021,95200022,95200023,95200024,95200025,95200101,95200102}
c95200000.commct=27
