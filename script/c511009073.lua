--Descend Dragon Magician
function c511009073.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54936498,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTarget(c511009073.tg)
	e1:SetOperation(c511009073.op)
	c:RegisterEffect(e1)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54936498,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(c511009073.operation)
	c:RegisterEffect(e1)
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c511009073.efcon)
	e1:SetOperation(c511009073.efop)
	c:RegisterEffect(e1)
end
function c511009073.filter(c)
	return c:IsFaceup() and not c:IsRace(RACE_DRAGON)
end
function c511009073.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009073.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009073.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511009073.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009073.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_DRAGON)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end

function c511009073.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_DRAGON)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

function c511009073.efcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c511009073.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetCondition(c511009073.atkcon)
	e3:SetValue(rc:GetAttack()*2)
	rc:RegisterEffect(e3)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		rc:RegisterEffect(e2,true)
	end
end
function c511009073.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	local bc=e:GetHandler():GetBattleTarget()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and bc and bc:IsRace(RACE_DRAGON)
end