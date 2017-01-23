--シューティング・スター・ドラゴン
function c513000012.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,aux.FilterBoolFunction(Card.IsType,TYPE_SYNCHRO),aux.FilterBoolFunction(Card.IsCode,44508094))
	c:EnableReviveLimit()
	--opponent's turn synchro
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(575512,0))
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_MAIN_END)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000012.syncon)
	e1:SetTarget(c513000012.syntg)
	e1:SetOperation(c513000012.synop)
	c:RegisterEffect(e1)
	--multi attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24696097,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c513000012.mtcon)
	e2:SetOperation(c513000012.mtop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24696097,1))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c513000012.discon)
	e3:SetTarget(c513000012.distg)
	e3:SetOperation(c513000012.disop)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(24696097,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c513000012.bancon)
	e4:SetCost(c513000012.bancost)
	e4:SetOperation(c513000012.banop)
	c:RegisterEffect(e4)
	--Return
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(24696097,3))
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCountLimit(1)
	e5:SetTarget(c513000012.rettg)
	e5:SetOperation(c513000012.retop)
	c:RegisterEffect(e5)
end
function c513000012.syncon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c513000012.syntg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSynchroSummonable(nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_EXTRA)
end
function c513000012.synop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SynchroSummon(tp,c,nil)
	end
end
function c513000012.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5
end
function c513000012.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.ConfirmDecktop(tp,5)
	local g=Duel.GetDecktopGroup(tp,5)
	local ct=g:FilterCount(Card.IsType,nil,TYPE_TUNER)
	Duel.ShuffleDeck(tp)
	if ct>=2 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e1:SetValue(ct-1)
		c:RegisterEffect(e1)
	end
end
function c513000012.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	if re:IsHasCategory(CATEGORY_NEGATE)
		and Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0
end
function c513000012.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c513000012.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c513000012.bancon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c513000012.bancost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST+REASON_TEMPORARY)
end
function c513000012.banop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(513000012,RESET_EVENT+0x1fe0000,0,0)
	if Duel.GetAttacker() and Duel.SelectYesNo(tp,94) then Duel.NegateAttack()
	else
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCountLimit(1)
		e1:SetOperation(c513000012.negop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c513000012.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:GetFlagEffect(513000012)>0 end
end
function c513000012.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.ReturnToField(e:GetHandler())
	end
end
function c513000012.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
