--Emperor's Armor
function c511000697.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000697.target)
	e1:SetOperation(c511000697.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetCondition(c511000697.atkcon)
	e3:SetValue(c511000697.atkval)
	c:RegisterEffect(e3)
	--Save Monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetTarget(c511000697.destg)
	e4:SetOperation(c511000697.desop)
	c:RegisterEffect(e4)
end
function c511000697.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000697.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000697.atkcon(e)
	local eq=e:GetHandler():GetEquipTarget()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and (Duel.GetAttacker()==eq or Duel.GetAttackTarget()==eq) and Duel.GetAttackTarget()~=nil 
end
function c511000697.atkval(e,c)
	local eq=e:GetHandler():GetEquipTarget()
	return eq:GetBattleTarget():GetAttack()
end
function c511000697.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tg=c:GetEquipTarget()
	if chk==0 then return c and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and tg and tg:IsReason(REASON_BATTLE) end
	return Duel.SelectYesNo(tp,aux.Stringid(511000697,0))
end
function c511000697.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=c:GetEquipTarget()
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
	local bt=tg:GetBattleTarget()
	local ph=Duel.GetCurrentPhase()
	if Duel.GetTurnPlayer()==tp and ph>=0x08 and ph<=0x20 and Duel.GetTurnPlayer()==tp then
		if Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,bt) and Duel.SelectYesNo(tp,aux.Stringid(511000697,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
			local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,bt):GetFirst()
			local atk1=tg:GetAttack()
			local atk2=g:GetAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(atk2)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tg:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_ATTACK)
			e2:SetValue(atk1)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			g:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetCode(EFFECT_EXTRA_ATTACK)
			e3:SetValue(1)
			e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
			tg:RegisterEffect(e3)
		end
	end
end
