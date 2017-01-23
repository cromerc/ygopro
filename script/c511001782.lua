--パワー・ピカクス
function c511001782.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001782.target)
	e1:SetOperation(c511001782.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90246973,0))
	e3:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511001782.rmtg)
	e3:SetOperation(c511001782.rmop)
	c:RegisterEffect(e3)
end
function c511001782.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001782.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511001782.rmfilter(c,lv)
	return c:IsLevelBelow(lv) and c:IsAbleToRemove()
end
function c511001782.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ec=e:GetHandler():GetEquipTarget()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511001782.rmfilter(chkc,ec:GetLevel()) end
	if chk==0 then return Duel.IsExistingTarget(c511001782.rmfilter,tp,0,LOCATION_GRAVE,1,nil,ec:GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511001782.rmfilter,tp,0,LOCATION_GRAVE,1,1,nil,ec:GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511001782.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ec=c:GetEquipTarget()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
		local atk=tc:GetTextAttack()/2
		if atk<=0 then return end
		--Atk up
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c511001782.atcon)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end
function c511001782.atcon(e)
	local ec=e:GetHandler():GetEquipTarget()
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetAttackTarget() 
		and (ec==Duel.GetAttacker() or Duel.GetAttackTarget()==ec)
end
