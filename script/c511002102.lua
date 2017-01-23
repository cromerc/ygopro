--Xyz Unity
function c511002102.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002102.target)
	e1:SetOperation(c511002102.operation)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98649372,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002102.postg)
	e2:SetOperation(c511002102.posop)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511002102.eqlimit)
	c:RegisterEffect(e3)
	--multi attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511002102.macon)
	e4:SetCost(c511002102.macost)
	e4:SetOperation(c511002102.maop)
	c:RegisterEffect(e4)
end
function c511002102.eqlimit(e,c)
	return c:IsType(TYPE_XYZ)
end
function c511002102.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511002102.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511002102.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002102.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511002102.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002102.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511002102.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipTarget():IsDefensePos() end
end
function c511002102.atkfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsType(TYPE_XYZ)
end
function c511002102.posop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.ChangePosition(eq,POS_FACEUP_ATTACK)
	local atk=0
	local g=Duel.GetMatchingGroup(c511002102.atkfilter,tp,LOCATION_MZONE,0,eq)
	local bc=g:GetFirst()
	while bc do
		atk=atk+bc:GetAttack()
		bc=g:GetNext()
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(atk)
	eq:RegisterEffect(e1)
end
function c511002102.macon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511002102.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToGraveAsCost()
end
function c511002102.macost(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return Duel.IsExistingMatchingCard(c511002102.cfilter,tp,LOCATION_MZONE,0,1,eq) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002102.cfilter,tp,LOCATION_MZONE,0,1,1,eq)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002102.maop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
