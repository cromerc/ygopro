--Dauntless Challenge
--Scripted by Snrk
function c511008023.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511008023.atkcon)
	e1:SetOperation(c511008023.atkop)
	c:RegisterEffect(e1)
end
--activate
function c511008023.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if not a or not at then return end
	return a:IsControler(tp) and a:GetAttack()<=at:GetAttack()
end
function c511008023.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not at:IsRelateToBattle() then return end
	--double attack
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(a:GetAttack()*2)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	a:RegisterEffect(e1)
	--destroy spell
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c511008023.descon)
	e2:SetTarget(c511008023.destg)	  
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	e2:SetOperation(c511008023.desop)
	Duel.RegisterEffect(e2,tp)
end
--destroy spell
function c511008023.sfilter(c)
	return c:IsFacedown() or c:IsType(TYPE_SPELL)
end
function c511008023.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsControler(tp) and at:IsControler(1-tp) and a:IsOnField() and at and a:IsRelateToBattle() and not at:IsRelateToBattle() then return true end
	return false
end
function c511008023.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c511008023.sfilter(chkc) end
	if chk==0 then return true end
end
function c511008023.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local target=Duel.SelectMatchingCard(tp,c511008023.sfilter,tp,0,LOCATION_SZONE,1,1,nil)
	if not g then return end
	local g=target:GetFirst()
	if g:IsFacedown() then Duel.ConfirmCards(tp,g) end
	if g:IsType(TYPE_SPELL) then Duel.Destroy(g,REASON_EFFECT) end
end