--Performapal Sky Magician
function c511009393.initial_effect(c)
	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(aux.chainreg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(28201945,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511009393.con)
	e3:SetOperation(c511009393.op)
	c:RegisterEffect(e3)
	
	--Spell change
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(81020646,0))
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c511009393.discon)
	e4:SetTarget(c511009393.distg)
	e4:SetOperation(c511009393.disop)
	c:RegisterEffect(e4)
	

	--Special Summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(35952884,1))
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c511009393.descon)
	e5:SetTarget(c511009393.destg)
	e5:SetOperation(c511009393.desop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e7)
end
function c511009393.con(e,tp,eg,ep,ev,re,r,rp)
	local c=re:GetHandler()
	return rp==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and e:GetHandler():GetFlagEffect(1)>0
end

function c511009393.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(300)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end


----Spell changing
function c511009393.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) 
end
function c511009393.thfilter(c)
	return c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and c:IsAbleToHand() and Duel.IsExistingMatchingCard(c511009393.actfilter,tp,LOCATION_HAND,0,1,nil,tp,eg,ep,ev,re,r,rp,c:GetCode())
end
function c511009393.actfilter(c,tp,eg,ep,ev,re,r,rp,code)
	local te=c:GetActivateEffect()
	if not te then return false end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) 
		and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
		and not c:getCode()==code
end
function c511009393.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511009393.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009393.thfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c511009393.thfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511009393.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		local sg=Duel.GetMatchingGroup(c511009393.actfilter,tp,LOCATION_HAND,0,nil,tp,eg,ep,ev,re,r,rp,tc:getCode())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
		local g=sg:Select(tp,1,1,nil)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			local tpe=tc:GetType()
			local te=tc:GetActivateEffect()
			if te then
				local con=te:GetCondition()
				local co=te:GetCost()
				local tg=te:GetTarget()
				local op=te:GetOperation()
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
	end
end

------------------------------------------

function c511009393.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511009393.desfilter(c)
	return c:IsFacedown() or c:IsType(TYPE_SPELL)
end

function c511009393.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c511009393.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009393.desfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	if g:GetCount()>0 and g:GetFirst():IsFaceup() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c511009393.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
		if tc:IsType(TYPE_SPELL) then Duel.Destroy(tc,REASON_EFFECT) end
	end
end

---------------------------------------------
