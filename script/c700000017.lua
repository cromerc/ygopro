--Scripted by Eerie Code
--Abyss Actor - Pretty Heroine
function c700000017.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Reduce ATK (P)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_BATTLE_END)
	e2:SetCondition(c700000017.pacon)
	e2:SetTarget(c700000017.patg)
	e2:SetOperation(c700000017.paop)
	c:RegisterEffect(e2)
	--Reduce ATK (M)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetHintTiming(TIMING_BATTLE_END,TIMING_BATTLE_END)
	e3:SetCondition(c700000017.macon)
	e3:SetTarget(c700000017.matg)
	e3:SetOperation(c700000017.maop)
	c:RegisterEffect(e3)
	if not c700000017.global_check then
		c700000017.global_check=true
		c700000017[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c700000017.desop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
		ge2:SetOperation(c700000017.clear)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_BATTLE_DAMAGE)
		ge3:SetOperation(c700000017.damop)
		Duel.RegisterEffect(ge3,0)
	end
end
function c700000017.desop(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.GetAttackTarget()
	if not dc then return end
	local bc=dc:GetBattleTarget()
	if ep==tp then
		if bc:IsControler(tp) and bc:IsSetCard(0x10ec) and bc:IsStatus(STATUS_BATTLE_DESTROYED) 
			and not dc:IsStatus(STATUS_BATTLE_DESTROYED) then
			dc:RegisterFlagEffect(700000017+tp,RESET_EVENT+0x1fe0000,0,1,ev)
		end
		if dc:IsControler(tp) and dc:IsSetCard(0x10ec) and dc:IsStatus(STATUS_BATTLE_DESTROYED) 
			and not bc:IsStatus(STATUS_BATTLE_DESTROYED) then
			bc:RegisterFlagEffect(700000017+tp,RESET_EVENT+0x1fe0000,0,1,ev)
		end
	end
	if ep==1-tp then
		if bc:IsControler(1-tp) and bc:IsSetCard(0x10ec) and bc:IsStatus(STATUS_BATTLE_DESTROYED) 
			and not dc:IsStatus(STATUS_BATTLE_DESTROYED) then
			dc:RegisterFlagEffect(700000017+1-tp,RESET_EVENT+0x1fe0000,0,1,ev)
		end
		if dc:IsControler(1-tp) and dc:IsSetCard(0x10ec) and dc:IsStatus(STATUS_BATTLE_DESTROYED) 
			and not bc:IsStatus(STATUS_BATTLE_DESTROYED) then
			bc:RegisterFlagEffect(700000017+1-tp,RESET_EVENT+0x1fe0000,0,1,ev)
		end
	end
end
function c700000017.clear(e,tp,eg,ep,ev,re,r,rp)
	c700000017[0]=0
end
function c700000017.damop(e,tp,eg,ep,ev,re,r,rp)
	c700000017[0]=c700000017[0]+ev
end
function c700000017.pacon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and ph>=0x08 and ph<=0x20 
		and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) 
end
function c700000017.pafil(c)
	return c:IsFaceup() and c:GetFlagEffect(700000017)>0 and c:GetAttack()>0
end
function c700000017.patg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700000017.pafil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000017.pafil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c700000017.pafil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c700000017.paop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-tc:GetFlagEffectLabel(700000017+tp))
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c700000017.macon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20 and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) 
		and c700000017[0]>0
end
function c700000017.mafil(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c700000017.matg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700000017.mafil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000017.mafil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c700000017.mafil,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g:GetFirst(),1,0,0)
end
function c700000017.maop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(tc:GetBaseAttack()-c700000017[0])
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
