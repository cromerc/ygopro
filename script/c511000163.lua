--Plasma Eel
function c511000163.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000163,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000163.eqcon)
	e1:SetTarget(c511000163.eqtg)
	e1:SetOperation(c511000163.eqop)
	c:RegisterEffect(e1)
	--indes battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c511000163.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000163.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end 
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000163.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511000163.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			Duel.Equip(tp,c,tc,true)
			--Add Equip limit
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511000163.eqlimit)
			c:RegisterEffect(e1)
			local e2=Effect.CreateEffect(tc)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetCode(EFFECT_UNRELEASABLE_SUM)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e2)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			c:RegisterEffect(e3)
			--atkdown
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e4:SetCode(EVENT_PHASE+PHASE_END)
			e4:SetRange(LOCATION_SZONE)
			e4:SetCountLimit(1)
			e4:SetCondition(c511000163.atkcon)
			e4:SetOperation(c511000163.atkop)
			c:RegisterEffect(e4)
		else
			Duel.SendtoGrave(c,REASON_EFFECT)
		end
	end
end
function c511000163.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511000163.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(511000163)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(511000163,RESET_EVENT+0x1fe0000,0,0)
		e:SetLabelObject(e1)
		e:SetLabel(2)
	else
		local pe=e:GetLabelObject()
		local ct=e:GetLabel()
		e:SetLabel(ct+1)
		pe:SetValue(ct*-500)
	end
end