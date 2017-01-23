--Performapal Camelose
function c511001160.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001160,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001160.prcon)
	e2:SetTarget(c511001160.prtg)
	e2:SetOperation(c511001160.prop)
	c:RegisterEffect(e2)
	--lose atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001160,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetTarget(c511001160.atktg)
	e3:SetOperation(c511001160.atkop)
	c:RegisterEffect(e3)
end
function c511001160.prcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE and Duel.GetCurrentChain()==0
end
function c511001160.prtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001160.prop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLE_CONFIRM)
		e2:SetOperation(c511001160.op)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e2)
	end
end
function c511001160.op(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetAttackTarget()
	if t~=nil then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		t:RegisterEffect(e1)
	end
end
function c511001160.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetHandler():GetReasonCard()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsFaceup() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c511001160.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
