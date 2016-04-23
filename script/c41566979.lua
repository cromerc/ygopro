--Graverobber
function c41566979.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c41566979.target)
	e1:SetOperation(c41566979.operation)
	c:RegisterEffect(e1)
end
function c41566979.filter1(c,e,tp,eg,ep,ev,re,r,rp)
	return c:CheckActivateEffect(false,true,false)~=nil or c:IsType(TYPE_MONSTER)
end
function c41566979.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return Duel.IsExistingTarget(c41566979.filter,tp,0,LOCATION_GRAVE,1,nil) end
e:SetProperty(EFFECT_FLAG_CARD_TARGET)
e:SetCategory(0)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local mt=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.SelectTarget(tp,c41566979.filter1,tp,0,LOCATION_GRAVE,1,1,nil)
	end
end
function c41566979.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local tpe=tc:GetType()
	if bit.band(tpe,TYPE_MONSTER)~=0 then
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	end
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD+TYPE_MONSTER)==0  then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	    te=tc:GetActivateEffect()
	    tg=te:GetTarget()
		co=te:GetCost()
	    op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		tc:CreateEffectRelation(te)
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		local etc=g:GetFirst()
		while etc do
			etc:CreateEffectRelation(te)
			etc=g:GetNext()
		end
		if op==te:GetOperation() then op(te,tp,eg,ep,ev,re,r,rp) end
		tc:ReleaseEffectRelation(te)
		etc=g:GetFirst()
		while etc do
			etc:ReleaseEffectRelation(te)
			etc=g:GetNext()
     	end
     	Duel.SendtoGrave(tc,REASON_EFFECT)
else
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		tpe=tc:GetType()
	    te=tc:GetActivateEffect()
	    tg=te:GetTarget()
		 co=te:GetCost()
		 op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		tc:CreateEffectRelation(te)
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		local etc=g:GetFirst()
		while etc do
			etc:CreateEffectRelation(te)
			etc=g:GetNext()
		end
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		tc:ReleaseEffectRelation(te)
		etc=g:GetFirst()
		while etc do
			etc:ReleaseEffectRelation(te)
			etc=g:GetNext()
		end
	else
		if bit.band(tpe,TYPE_FIELD)~=0 then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
		if co then co(e,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
			if of then Duel.Destroy(of,REASON_RULE) end
		end
		end
	end
	end