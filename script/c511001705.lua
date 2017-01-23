--Commitment to Tomorrow
function c511001705.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001705.condition)
	e1:SetTarget(c511001705.target)
	e1:SetOperation(c511001705.activate)
	c:RegisterEffect(e1)
	if not c511001705.global_check then
		c511001705.global_check=true
		c511001705[0]=0
		c511001705[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511001705.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
		ge4:SetOperation(c511001705.clear)
		Duel.RegisterEffect(ge4,0)
	end
end
function c511001705.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsSetCard,nil,0x48)
	local tc=g:GetFirst()
	while tc do
		c511001705[tc:GetPreviousControler()]=c511001705[tc:GetPreviousControler()]+tc:GetPreviousAttackOnField()
		tc=g:GetNext()
	end
end
function c511001705.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001705[0]=0
	c511001705[1]=0
end
function c511001705.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001705.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x48)
end
function c511001705.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001705.filter(chkc) end
	if chk==0 then return c511001705[tp]>0 and Duel.IsExistingTarget(c511001705.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001705.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001705.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511001705[tp])
		tc:RegisterEffect(e1)
	end
end
