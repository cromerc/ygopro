--Ultimate Stage Costume
function c511001908.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001908.target)
	e1:SetOperation(c511001908.operation)
	c:RegisterEffect(e1)
	--trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001908.descon)
	e2:SetOperation(c511001908.desop)
	c:RegisterEffect(e2)
	--retarget
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(511001908)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511001908.target)
	e3:SetOperation(c511001908.operation)
	c:RegisterEffect(e3)
end
function c511001908.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(511001908,true)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return res or Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001908.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511001908.rcon)
		e1:SetValue(3000)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCondition(c511001908.rcon2)
		e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		e3:SetValue(atk)
		tc:RegisterEffect(e3,true)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e4:SetValue(def)
		tc:RegisterEffect(e4,true)
	end
end
function c511001908.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511001908.rcon2(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and e:GetHandler()==Duel.GetAttacker() 
		and e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511001908.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001908.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),511001908,e,REASON_EFFECT,tp,tp,0)
end
