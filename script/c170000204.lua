--伝説の騎士 ヘルモス
function c170000204.initial_effect(c)
	c:EnableReviveLimit()
	--change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000047,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c170000204.cbcon)
	e1:SetOperation(c170000204.cbop)
	c:RegisterEffect(e1)
	--gain effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10032958,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c170000204.effcost)
	e2:SetTarget(c170000204.efftg)
	e2:SetOperation(c170000204.effop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(89770167,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c170000204.atcon)
	e3:SetCost(c170000204.atcost)
	e3:SetTarget(c170000204.attg)
	e3:SetOperation(c170000204.atop)
	c:RegisterEffect(e3)
end
function c170000204.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return c~=bt and bt:GetControler()==c:GetControler()
end
function c170000204.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c170000204.cfilter(c)
	return c:IsType(TYPE_EFFECT) and c:IsAbleToRemoveAsCost()
end
function c170000204.effcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000204.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c170000204.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetOriginalCode())
end
function c170000204.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetParam(e:GetLabel())
	e:SetLabel(0)
end
function c170000204.effop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if ac==0 then return end
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:CopyEffect(ac,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
	end
end
function c170000204.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c170000204.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c170000204.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c170000204.costfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c170000204.costfilter,tp,LOCATION_DECK,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:KeepAlive()
	e:SetLabelObject(g)
end
function c170000204.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(e:GetLabelObject())
	e:SetLabelObject(nil)
end
function c170000204.chkfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsLocation(LOCATION_REMOVED)
end
function c170000204.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c170000204.chkfilter,nil,e)
	if c:IsFaceup() and c:IsRelateToEffect(e) and tg:GetCount()>0then
		tg:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c170000204.val)
		e1:SetLabelObject(tg)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local tc=tg:GetFirst()
		while tc do
			tc:CreateEffectRelation(e1)
			tc=tg:GetNext()
		end
	end
end
function c170000204.val(e,c)
	local d=Duel.GetAttackTarget()
	if not d or d~=e:GetHandler() then return 0 end
	local g=e:GetLabelObject():Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	local atk=0
	while tc do
		if tc:GetAttack()>0 then
			atk=atk+tc:GetAttack()
		end
		tc=g:GetNext()
	end
	return atk
end
