--Gimmick Vengeance
function c511001827.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511001827)
	e1:SetCondition(c511001827.damcon)
	e1:SetTarget(c511001827.damtg)
	e1:SetOperation(c511001827.damop)
	c:RegisterEffect(e1)
	--act qp in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511001827.handcon)
	c:RegisterEffect(e2)
	if not c511001827.global_check then
		c511001827.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511001827.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511001827.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001827.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(c511001827.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511001827)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetOverlayCount())
			e1:SetOperation(c511001827.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001827,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end		
end
function c511001827.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetOverlayCount() then return end
	local val=0
	if e:GetLabel()>c:GetOverlayCount() then
		val=e:GetLabel()-c:GetOverlayCount()
	else
		val=c:GetOverlayCount()-e:GetLabel()
	end
	Duel.RaiseEvent(c,511001827,re,REASON_EFFECT,rp,tp,val)
	e:SetLabel(c:GetOverlayCount())
end
function c511001827.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(1-tp) and ev>0 and (not re or not re:GetHandler():IsType(TYPE_XYZ))
end
function c511001827.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x83)
end
function c511001827.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001827.damfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001827.damfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectTarget(tp,c511001827.damfilter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
end
function c511001827.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
	end
end
function c511001827.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==1
end
