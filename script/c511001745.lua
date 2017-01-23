--Power Darts Shooter
function c511001745.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001745,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511001745.target)
	e1:SetOperation(c511001745.operation)
	c:RegisterEffect(e1)
end
function c511001745.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x210)
end
function c511001745.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001745.filter(chkc) end
	if chk==0 then return e:GetHandler():IsReleasableByEffect() 
		and Duel.IsExistingTarget(c511001745.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511001745.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001745.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.Release(c,REASON_EFFECT)~=0 and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c511001745.atkcon)
		e1:SetValue(600)
		tc:RegisterEffect(e1)
	end
end
function c511001745.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x80
end
