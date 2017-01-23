--Galaxy Shockwave
--銀河衝撃
--  By Shad3
--fixed by MLD
function c511005089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511005089.atkcon)
	e1:SetTarget(c511005089.target)
	e1:SetOperation(c511005089.activate)
	c:RegisterEffect(e1)
end
function c511005089.filter(c)
	return c:IsSetCard(0x7b) and c:IsFaceup()
end
function c511005089.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511005089.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511005089.filter,tp,LOCATION_MZONE,0,1,nil) end
	local tc=Duel.SelectTarget(tp,c511005089.filter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	local bc=tc:GetBattleTarget()
	if Duel.GetAttacker() and tc:IsRelateToBattle() and bc and bc:IsFaceup() and tc:GetAttack()==bc:GetAttack() 
		and c511005089.atkcost(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(4002,0)) then
		c511005089.atkcost(e,tp,eg,ep,ev,re,r,rp,1)
		Duel.SetTargetParam(1)
	end
end
function c511005089.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local label=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local fid=c:GetFieldID()
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_ATKCHANGE)
		e1:SetType(EFFECT_TYPE_QUICK_O)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_FREE_CHAIN)
		e1:SetRange(0xff)
		e1:SetHintTiming(TIMING_DAMAGE_STEP)
		e1:SetCondition(c511005089.atkcon)
		e1:SetCost(c511005089.atkcost)
		e1:SetTarget(c511005089.atktg)
		e1:SetOperation(c511005089.atkop)
		e1:SetLabelObject(tc)
		e1:SetLabel(fid)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetOperation(c511005089.resetop)
		e2:SetLabelObject(e1)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e3:SetCode(EVENT_CHANGE_POS)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetCondition(c511005089.resetcon)
		e3:SetOperation(c511005089.resetop)
		e3:SetLabelObject(e1)
		tc:RegisterEffect(e3)
		if label==1 then
			tc:RegisterFlagEffect(fid,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,1)
			c511005089.atkop(e,tp,eg,ep,ev,re,r,rp)
		end
	end
end
function c511005089.resetcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:IsFacedown()
end
function c511005089.resetop(e,tp,eg,ep,ev,re,r,rp)
	local ce=e:GetLabelObject()
	if ce then
		ce:Reset()
	end
	e:Reset()
end
function c511005089.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511005089.cfilter(c)
	return c:IsSetCard(0x7b) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c511005089.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511005089.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511005089.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511005089.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and tc:IsRelateToBattle() and tc:GetBattleTarget() and tc:GetBattleTarget():IsFaceup() 
		and tc:GetAttack()==tc:GetBattleTarget():GetAttack() and tc:GetFlagEffect(e:GetLabel())==0 end
	Duel.SetTargetCard(tc)
	tc:RegisterFlagEffect(e:GetLabel(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c511005089.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local bc=tc:GetBattleTarget()
	if not tc or not tc:IsRelateToEffect(e) or not bc:IsRelateToBattle() then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1500)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	bc:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_DISABLE_EFFECT)
	bc:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCode(EFFECT_TYPE_SINGLE)
	e4:SetType(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c511005089.imval)
	e4:SetReset(RESET_PHASE+PHASE_DAMAGE)
	bc:RegisterEffect(e4)
end
function c511005089.imval(e,re)
	return re:GetOwner()~=e:GetOwner()
end
