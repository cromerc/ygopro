--Training Wheels
function c511000664.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000664.target)
	e1:SetOperation(c511000664.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511000664.eqlimit)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e3)
	--banish
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000664,0))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511000664.condition)
	e4:SetTarget(c511000664.tg)
	e4:SetOperation(c511000664.op)
	c:RegisterEffect(e4)
end
function c511000664.eqlimit(e,c)
	return c:IsCode(45945685)
end
function c511000664.filter(c)
	return c:IsFaceup() and c:IsCode(45945685)
end
function c511000664.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000664.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000664.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000664.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000664.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsControler(tp) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c511000664.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil and eg:GetFirst()==e:GetHandler():GetEquipTarget()
end
function c511000664.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,0,0)
end
function c511000664.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=c:GetEquipTarget()
	if Duel.Remove(eq,eq:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)~=0 and Duel.Remove(c,c:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetRange(LOCATION_REMOVED)
		e1:SetCountLimit(1)
		if Duel.GetTurnPlayer()==tp then
			if Duel.GetCurrentPhase()==PHASE_DRAW then
				e1:SetLabel(Duel.GetTurnCount())
			else
				e1:SetLabel(Duel.GetTurnCount()+2)
			end
		else
			e1:SetLabel(Duel.GetTurnCount()+1)
		end
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511000664.retcon)
		e1:SetOperation(c511000664.retop)
		eq:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e2:SetRange(LOCATION_REMOVED)
		e2:SetCountLimit(1)
		if Duel.GetTurnPlayer()==tp then
			if Duel.GetCurrentPhase()==PHASE_DRAW then
				e2:SetLabel(Duel.GetTurnCount())
			else
				e2:SetLabel(Duel.GetTurnCount()+2)
			end
		else
			e2:SetLabel(Duel.GetTurnCount()+1)
		end
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetCondition(c511000664.retcon)
		e2:SetOperation(c511000664.retop2)
		e2:SetLabelObject(eq)
		c:RegisterEffect(e2)
	end
end
function c511000664.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetLabel()
end
function c511000664.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetHandler())
	e:Reset()
end
function c511000664.retop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.Equip(tp,e:GetHandler(),e:GetLabelObject())
	e:Reset()
end
