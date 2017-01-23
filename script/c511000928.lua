--Synchro Stream
function c511000928.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511000928.condition)
	e1:SetTarget(c511000928.target)
	e1:SetOperation(c511000928.activate)
	c:RegisterEffect(e1)
end
function c511000928.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000928.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000928.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil)
end
function c511000928.eqlimit(e,c)
	return c:IsType(TYPE_SYNCHRO)
end
function c511000928.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000928.cfilter(chkc) end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingTarget(c511000928.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000928.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000928.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		c:CancelToGrave()
		--atk up
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DAMAGE_CALCULATING)
		e2:SetRange(LOCATION_SZONE)
		e2:SetOperation(c511000928.atkup)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--Equip limit
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_EQUIP_LIMIT)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetValue(c511000928.eqlimit)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	end
end
function c511000928.atkup(e,tp,eg,ep,ev,re,r,rp)
	local eqc=e:GetHandler():GetEquipTarget()
	if eqc==Duel.GetAttacker() and Duel.IsExistingMatchingCard(c511000928.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,eqc) then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c511000928.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,eqc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(g:GetFirst():GetAttack())
		eqc:RegisterEffect(e1)
	end
end
