--Scripted by Eerie Code
--Chasing Wings
function c700000022.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c700000022.condition)
	e1:SetTarget(c700000022.target)
	e1:SetOperation(c700000022.activate)
	c:RegisterEffect(e1)
end

function c700000022.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c700000022.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000022.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_SZONE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetTarget(c700000022.indtg)
		e1:SetValue(1)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
		e2:SetRange(LOCATION_SZONE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetCondition(c700000022.descon)
		e2:SetTarget(c700000022.destg)
		e2:SetOperation(c700000022.desop)
		c:RegisterEffect(e2)
	end
end

function c700000022.indtg(e,c)
	return e:GetHandler():GetFirstCardTarget()==c
end

function c700000022.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetFirstCardTarget()
	local ak=Duel.GetAttacker()
	return Duel.GetAttackTarget()==c and ak:IsLevelAbove(5)
end
function c700000022.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ak=Duel.GetAttacker()
	if chk==0 then return ak:IsOnField() and ak:IsDestructable() end
	Duel.SetTargetCard(ak)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ak,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,nil,0,0,ak:GetAttack())
end
function c700000022.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	local ak=Duel.GetAttacker()
	if c:IsRelateToEffect(e) and ak:IsRelateToEffect(e) and tc:IsFaceup() and Duel.Destroy(ak,REASON_EFFECT)>0 then
		local atk=ak:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end