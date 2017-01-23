--幻惑
function c100000504.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100000504.condition)
	e1:SetTarget(c100000504.target)
	c:RegisterEffect(e1)
	--half atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(c100000504.atkcon)
	e2:SetTarget(c100000504.atktg)
	e2:SetOperation(c100000504.atkop)
	c:RegisterEffect(e2)
end
function c100000504.cfilter(c)
	return c:IsSetCard(0x5008) and c:IsFaceup()
end
function c100000504.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000504.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000504.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	if c100000504.atktg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_ATKCHANGE)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
		e:SetOperation(c100000504.atkop)
		c100000504.atktg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e:SetOperation(nil)
	end
end
function c100000504.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c100000504.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetHandler():GetCardTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and (not g or not g:IsExists(Card.IsLocation,1,nil,LOCATION_MZONE)) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c100000504.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c100000504.rcon)
		e1:SetValue(c100000504.atkval)
		tc:RegisterEffect(e1,true)
	end
end
function c100000504.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c100000504.atkval(e,c)
	return c:GetAttack()/2
end
