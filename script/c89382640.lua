--Spell Textbook
function c89382640.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c89382640.cost)
	e1:SetTarget(c89382640.target)
	e1:SetOperation(c89382640.activate)
	c:RegisterEffect(e1)
	end
	function c89382640.cfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c89382640.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	hg:RemoveCard(e:GetHandler())
	if chk==0 then return hg:GetCount()>0 and hg:FilterCount(c89382640.cfilter,nil)==hg:GetCount() end
	Duel.SendtoGrave(hg,REASON_COST)
end
function c89382640.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c89382640.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	tc=g:GetFirst()
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,tc)
	Duel.ShuffleHand(tp)
	if not tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD+TYPE_MONSTER+TYPE_TRAP) and tc:CheckActivateEffect(false,false,false)~=nil then
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	tc:CreateEffectRelation(te)
	if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	local a=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)~=nil then
	etc=a:GetFirst()
	while etc do
	etc:CreateEffectRelation(te)
	etc=a:GetNext()
    end
	else end
	if op==te:GetOperation() then op(te,tp,eg,ep,ev,re,r,rp) end
	tc:ReleaseEffectRelation(te)
	etc=g:GetFirst()
	while etc do
	etc:ReleaseEffectRelation(te)
	etc=g:GetNext()
	end
	Duel.BreakEffect()
	if tc:IsLocation(LOCATION_ONFIELD) then 
	Duel.SendtoGrave(tc,REASON_EFFECT)
	end
    else
	if tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS) and not tc:IsType(TYPE_TRAP) then
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
	local b=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)~=nil then
	local etc=b:GetFirst()
	while etc do
	etc:CreateEffectRelation(te)
	etc=b:GetNext()
	end
	else end
	if op then op(te,tp,eg,ep,ev,re,r,rp) end
	tc:ReleaseEffectRelation(te)
	etc=g:GetFirst()
	while etc do
	etc:ReleaseEffectRelation(te)
	etc=g:GetNext()
    end
    else
    if tc:IsType(TYPE_FIELD) then
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	if co then co(e,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	if tc:IsType(TYPE_FIELD)then
	local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	if of then Duel.Destroy(of,REASON_RULE) end
	else
	if tc:IsType(TYPE_SPELL)  and tc:CheckActivateEffect(false,false,false)==nil  then
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.SendtoGrave(tc,REASON_EFFECT)
    end
	end
	end
	end
	end
	
	