--Chaos Return
function c511001793.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001793.condition)
	e1:SetCost(c511001793.cost)
	e1:SetTarget(c511001793.target)
	e1:SetOperation(c511001793.activate)
	c:RegisterEffect(e1)
end
function c511001793.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001793.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabelObject(Duel.GetAttacker())
	Duel.HintSelection(Group.FromCards(Duel.GetAttacker()))
	Duel.NegateAttack()
end
function c511001793.filter(c,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:IsType(TYPE_SPELL) and (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
end
function c511001793.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511001793.filter(chkc,tp,eg,ep,ev,re,r,rp) end
	if chk==0 then return Duel.IsExistingTarget(c511001793.filter,tp,LOCATION_GRAVE,0,1,nil,tp,eg,ep,ev,re,r,rp) 
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	Duel.SelectTarget(tp,c511001793.filter,tp,LOCATION_GRAVE,0,1,1,nil,tp,eg,ep,ev,re,r,rp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c511001793.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001793.tgfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		if tc and tc:IsRelateToEffect(e) then
			local tpe=tc:GetType()
			local te=tc:GetActivateEffect()
			if not te then return end
			local con=te:GetCondition()
			local co=te:GetCost()
			local tg=te:GetTarget()
			local op=te:GetOperation()
			if (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
				and (not target or target(te,tp,eg,ep,ev,re,r,rp,0)) then
				Duel.ClearTargetCard()
				e:SetCategory(te:GetCategory())
				e:SetProperty(te:GetProperty())
				if bit.band(tpe,TYPE_FIELD)~=0 then
					local of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
					if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
				end
				Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
				Duel.Hint(HINT_CARD,0,tc:GetCode())
				tc:CreateEffectRelation(te)
				if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
					tc:CancelToGrave(false)
				end
				if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
				if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if g then
					local etc=g:GetFirst()
					while etc do
						etc:CreateEffectRelation(te)
						etc=g:GetNext()
					end
				end
				Duel.BreakEffect()
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
		local a=e:GetLabelObject()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(a:GetEffectCount(EFFECT_EXTRA_ATTACK)+1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_MUST_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_FIRST_ATTACK)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		a:RegisterEffect(e1)
	end
end
