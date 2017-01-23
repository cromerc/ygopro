--Action Card - High Dive
function c95000138.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_DISABLED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c95000138.target)
	e1:SetOperation(c95000138.operation)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000138.handcon)
	c:RegisterEffect(e2)
end
function c95000138.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end

function c95000138.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc==eg:GetFirst() end
	if chk==0 then return eg:GetFirst():IsFaceup() and eg:GetFirst():IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(eg:GetFirst())
end
function c95000138.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetFlagEffect(94770493)==0 then
		tc:RegisterFlagEffect(94770493,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLE_START)
		e2:SetCountLimit(1)
		e2:SetOperation(c95000138.atkop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c95000138.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetOwner())
	e1:SetDescription(aux.Stringid(19221310,1))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdgcon)
	e1:SetTarget(c95000138.destg)
	e1:SetOperation(c95000138.desop)
	e:GetHandler():RegisterEffect(e1)
end
function c95000138.filter(c)
	return c:IsAttackPos() and c:IsDestructable()
end
function c95000138.destg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c95000138.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c95000138.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c95000138.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c95000138.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
