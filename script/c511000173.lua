--Vampiric Leech
function c511000173.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_BP_FIRST_TURN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	--reg
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetOperation(c511000173.regop)
	c:RegisterEffect(e2)
	--change battle position
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000173,1))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000173.poscon)
	e3:SetCost(c511000173.poscost)
	e3:SetOperation(c511000173.posop)
	c:RegisterEffect(e3)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(511000173)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
	if not c511000173.global_check then
		c511000173.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CANNOT_ATTACK)
		ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		ge1:SetCondition(c511000173.atkcon)
		ge1:SetTarget(c511000173.atktg)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000173.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetAttackTarget() then return end
	c:RegisterFlagEffect(511000174,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000173.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c511000173.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000174)>0
end
function c511000173.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(c511000173.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		c:RegisterEffect(e1)
	end
end
function c511000173.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsAttackPos() then
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
	end
end
function c511000173.atkcon(e)
	return Duel.GetTurnCount()==1
end
function c511000173.atktg(e,c)
	return not c:IsHasEffect(511000173)
end
