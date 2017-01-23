--Double Sensor Ship
function c511009085.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(3)
	e1:SetOperation(c511009085.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000202,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetLabelObject(e1)
	e2:SetCondition(c511009085.condition)
	e2:SetTarget(c511009085.target)
	e2:SetOperation(c511009085.operation)
	c:RegisterEffect(e2)
end
function c511009085.op(e,tp,eg,ep,ev,re,r,rp)
	if tp~=Duel.GetTurnPlayer() and Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) then
		local tg=Duel.GetAttacker()
		if Duel.IsExistingMatchingCard(c511009085.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,tg,tg:GetCode()) then
			if Duel.SelectYesNo(tp,aux.Stringid(511000202,0)) then
				e:GetHandler():RegisterFlagEffect(95100771,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
				Duel.NegateAttack()
			end
		end
	end
end
function c511009085.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511009085.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511009085.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return e:GetHandler():GetFlagEffect(95100771)==0 and tg:IsOnField() and tg:IsCanBeEffectTarget(e) and Duel.IsExistingMatchingCard(c511009085.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,tg,tg:GetCode()) end
	Duel.SetTargetCard(tg)
	e:GetHandler():RegisterFlagEffect(95100771,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511009085.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
