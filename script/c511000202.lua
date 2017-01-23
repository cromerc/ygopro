--Totem Pole
function c511000202.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(3)
	e1:SetOperation(c511000202.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000202,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetLabelObject(e1)
	e2:SetCondition(c511000202.condition)
	e2:SetTarget(c511000202.target)
	e2:SetOperation(c511000202.operation)
	c:RegisterEffect(e2)
end
function c511000202.op(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(3)
	if tp~=Duel.GetTurnPlayer() and Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and Duel.SelectYesNo(tp,aux.Stringid(511000202,0)) then
		Duel.NegateAttack()
		local ct=e:GetLabel()
		ct=ct-1
		e:SetLabel(ct)
		if ct<=0 then
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
function c511000202.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000202.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c511000202.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local ct=e:GetLabelObject():GetLabel()
	ct=ct-1
	e:GetLabelObject():SetLabel(ct)
	if ct<=0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
