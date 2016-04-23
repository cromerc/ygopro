--Scripted by Eerie Code
--Abyss Actor - Pretty Heroine
function c700000017.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Reduce ATK (P)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
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
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetHintTiming(TIMING_BATTLE_END,TIMING_BATTLE_END)
	e3:SetLabel(0)
	e3:SetCondition(c700000017.macon)
	e3:SetTarget(c700000017.matg)
	e3:SetOperation(c700000017.maop)
	c:RegisterEffect(e3)
	--Set labels
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_BATTLE_DESTROYING)
	ge1:SetRange(LOCATION_PZONE)
	ge1:SetOperation(c700000017.checkop)
	c:RegisterEffect(ge1)
	local ge2=Effect.CreateEffect(c)
	ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge2:SetCode(EVENT_TURN_END)
	ge2:SetRange(LOCATION_MZONE)
	ge2:SetLabelObject(e3)
	ge2:SetOperation(c700000017.resetop)
	c:RegisterEffect(ge2)
	local ge3=Effect.CreateEffect(c)
	ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	ge3:SetRange(LOCATION_MZONE)
	ge3:SetLabelObject(e3)
	ge3:SetOperation(c700000017.damageop)
	c:RegisterEffect(ge3)
end

function c700000017.pacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp and Duel.GetCurrentPhase()==PHASE_BATTLE 
end
function c700000017.pafil(c)
	return c:IsFaceup() and c:GetFlagEffect(700000017)>0 and c:GetAttack()>0
end
function c700000017.patg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700000017.pafil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000017.pafil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c700000017.pafil,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g:GetFirst(),1,0,0)
end
function c700000017.paop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-tc:GetFlagEffectLabel(700000017))
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end

function c700000017.macon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE and e:GetLabel()>0 
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
	if tc:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(tc:GetBaseAttack()-e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end

function c700000017.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	if tc:IsFaceup() and bc:IsSetCard(0x1511) and bc:GetPreviousControler()==tp then
		tc:RegisterFlagEffect(700000017,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,Duel.GetBattleDamage(tp),0)
	end
end
function c700000017.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
function c700000017.damageop(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ep~=tp or ph<0x08 or ph>0x20 then return end
	local sum=e:GetLabelObject():GetLabel()+ev
	e:GetLabelObject():SetLabel(sum)
end