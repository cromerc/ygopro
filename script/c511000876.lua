--Synchro Ring
function c511000876.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCondition(c511000876.condition)
	e1:SetTarget(c511000876.target)
	e1:SetOperation(c511000876.activate)
	c:RegisterEffect(e1)
	if not c511000876.global_check then
		c511000876.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511000876.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000876.checkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED) then
		Duel.GetAttacker():RegisterFlagEffect(511000876,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	end
end
function c511000876.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp and ph>=0x08 and ph<=0x20
end
function c511000876.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
		and c:GetBattledGroupCount()>0 and c:GetFlagEffect(511000876)>0
end
function c511000876.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000876.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000876.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000876.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000876.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EXTRA_ATTACK)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e2)
	end
end
