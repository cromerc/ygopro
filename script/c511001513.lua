--Mirror Barrier
function c511001513.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511001513.condition)
	e1:SetTarget(c511001513.target)
	e1:SetOperation(c511001513.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--negate and damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001513,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511001513.btcon)
	e3:SetTarget(c511001513.bttg)
	e3:SetOperation(c511001513.btop)
	c:RegisterEffect(e3)
end
function c511001513.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup()
end
function c511001513.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc==eg:GetFirst() end
	if chk==0 then return eg:GetFirst():IsCanBeEffectTarget(e) end
	e:GetHandler():SetTurnCounter(0)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001513.tgcon)
	e1:SetOperation(c511001513.tgop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Duel.GetAttacker():GetAttack())
end
function c511001513.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		if Duel.Equip(tp,c,tc) then
			Duel.NegateAttack()
			Duel.Damage(1-tp,Duel.GetAttacker():GetAttack(),REASON_EFFECT)
		end
	end
end
function c511001513.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511001513.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
function c511001513.btcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local bt=eg:GetFirst()
	return bt==eq
end
function c511001513.bttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Duel.GetAttacker():GetAttack())
end
function c511001513.btop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	Duel.Damage(1-tp,Duel.GetAttacker():GetAttack(),REASON_EFFECT)
end
