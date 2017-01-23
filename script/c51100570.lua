--Strike Ninja (DM)
--Scripted by edo9300
function c51100570.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41006930,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,51100570)
	e1:SetCost(c51100570.rmcost)
	e1:SetTarget(c51100570.rmtg)
	e1:SetOperation(c51100570.rmop)
	c:RegisterEffect(e1)
	--activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51100570,0))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e2:SetCondition(c51100570.condition)
	e2:SetCost(c51100570.accost)
	e2:SetTarget(c51100570.actg)
	e2:SetOperation(c51100570.acop)
	c:RegisterEffect(e2)
	if not c51100570.global_check then
		c51100570.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c51100570.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c51100570.dm=true
function c51100570.dm_custom_pass_ability(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetFlagEffect(c:GetControler(),51100570)==0 and e:GetHandler():GetFlagEffect(300)>0 and r~=1048650
end
function c51100570.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c51100570.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToRemoveAsCost()
end
function c51100570.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51100570.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c51100570.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.RegisterFlagEffect(e:GetHandler():GetControler(),51100570,RESET_PHASE+PHASE_END,0,1)
end
function c51100570.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c51100570.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c51100570.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(c)
		e1:SetCountLimit(1)
		e1:SetOperation(c51100570.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c51100570.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
function c51100570.condition(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetFlagEffect(300)>0
end
function c51100570.accost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsDiscardable,tp,LOCATION_HAND,0,e:GetHandler())>1 end
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end
function c51100570.filter(c)
	return c:IsFacedown() and c:CheckActivateEffect(false,false,false)~=nil
end
function c51100570.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c51100570.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51100570.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	local g=Duel.SelectTarget(tp,c51100570.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,e:GetHandler())
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ChangePosition(tc,POS_FACEUP)
	Duel.ClearTargetCard()
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of then Duel.Destroy(of,REASON_RULE) end
		of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
	end
	Duel.Hint(HINT_CARD,0,tc:GetCode())
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
end
function c51100570.acop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local op=te:GetOperation()
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