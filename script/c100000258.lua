--カオス・フォーム
function c100000258.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c100000258.condition)
	e1:SetTarget(c100000258.target)
	e1:SetOperation(c100000258.operation)
	c:RegisterEffect(e1)
end
function c100000258.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c100000258.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000258.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c100000258.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c100000258.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_ATKCHANGE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetRange(LOCATION_SZONE)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetLabelObject(tc)
		e1:SetCondition(c100000258.condition2)
		e1:SetTarget(c100000258.target2)
		e1:SetOperation(c100000258.activate)
		c:RegisterEffect(e1)
		--Equip limit
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EQUIP_LIMIT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(c100000258.eqlimit)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetLabelObject(tc)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_EQUIP)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(c100000258.efilter)
		c:RegisterEffect(e3,true)
		--destroy
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e4:SetRange(LOCATION_SZONE)
		e4:SetCode(EVENT_LEAVE_FIELD)	
		e4:SetCondition(c100000258.descon)
		e4:SetOperation(c100000258.desop)	
		e4:SetLabelObject(tc)			
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
		if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and tp~=Duel.GetTurnPlayer() then
			if Duel.GetAttackTarget()==tc and Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER) then
				local atc=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
				local etc=atc:RandomSelect(tp,1)
				Duel.SetTargetCard(etc)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				e1:SetValue(etc:GetFirst():GetTextAttack())
				tc:RegisterEffect(e1)
				local e2=Effect.CreateEffect(e:GetHandler())
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_SET_DEFENSE)
				e2:SetReset(RESET_EVENT+0x1fe0000)
				e2:SetValue(etc:GetFirst():GetTextDefense())
				tc:RegisterEffect(e2)
			end
		end
	end
end
function c100000258.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c100000258.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c100000258.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetLabelObject() and Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c100000258.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER)	end
	local tc=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	local etc=tc:RandomSelect(tp,1)
	Duel.SetTargetCard(etc)
end
function c100000258.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end	
	local rc=Duel.GetFirstTarget()
	local tc=e:GetLabelObject()
	if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(rc:GetTextAttack())
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(rc:GetTextDefense())
		tc:RegisterEffect(e2)
	end
end
