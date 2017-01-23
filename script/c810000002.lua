-- Dark Spell Regeneration
-- scripted by: UnknownGuest
function c810000002.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c810000002.condition)
	e1:SetTarget(c810000002.target)
	e1:SetOperation(c810000002.activate)
	c:RegisterEffect(e1)
end
function c810000002.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c810000002.filter(c,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then
		ft=ft-1
	end
	return c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil 
		and (ft>0 or c:IsType(TYPE_FIELD))
end
function c810000002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then
		ft=ft-1
	end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c810000002.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c810000002.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	Duel.SelectTarget(tp,c810000002.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
end
function c810000002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
		local p=tc:GetControler()
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
			if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(of,REASON_RULE) end
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		tc:CreateEffectRelation(te)
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
		Duel.SendtoGrave(tc,REASON_EFFECT,1-tp)
	end
end
