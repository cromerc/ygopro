--好敵手の絆
function c100000185.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_DISABLED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)	
	e1:SetTarget(c100000185.target)
	e1:SetOperation(c100000185.operation)
	c:RegisterEffect(e1)
end
function c100000185.filter(c,tc)
	return c:IsControlerCanBeChanged()
end
function c100000185.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc==eg:GetFirst() end
	if chk==0 then return eg:GetFirst():IsFaceup() and eg:GetFirst():IsCanBeEffectTarget(e) 
		and eg:GetFirst():GetControler()==e:GetHandler():GetControler() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c100000185.filter,tp,0,LOCATION_MZONE,1,1,nil,Duel.GetAttackTarget())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c100000185.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c100000185.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c100000185.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c100000185.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	return tc and tc:IsReason(REASON_DESTROY)
end
function c100000185.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.GetControl(tc,tc:GetOwner())
	end
end
function c100000185.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()	
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.GetControl(tc,tp) then
		if c:IsLocation(LOCATION_SZONE) and not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Equip(tp,c,tc)
			--Add Equip limit
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c100000185.eqlimit)
			e1:SetLabelObject(tc)
			c:RegisterEffect(e1)
			--destroy
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e2:SetRange(LOCATION_SZONE)
			e2:SetCode(EVENT_LEAVE_FIELD)	
			e2:SetCondition(c100000185.descon)
			e2:SetOperation(c100000185.desop)				
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2)
			--Control
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
			e3:SetCode(EVENT_LEAVE_FIELD)
			e3:SetCondition(c100000185.descon2)
			e3:SetOperation(c100000185.desop2)			
			e3:SetLabelObject(tc)							
			e3:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e3)
			--cannot attack
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_EQUIP)
			e4:SetCode(EFFECT_CANNOT_ATTACK)			
			e4:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e4)
		end
	end
end