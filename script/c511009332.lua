--Album of Memories
function c511009332.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetOperation(c511009332.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000202,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetLabelObject(e1)
	e2:SetCondition(c511009332.condition)
	e2:SetTarget(c511009332.target)
	e2:SetOperation(c511009332.operation)
	c:RegisterEffect(e2)
end
function c511009332.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xa9)
end
function c511009332.op(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(0)
	if tp~=Duel.GetTurnPlayer() and Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and Duel.IsExistingMatchingCard(c511009332.filter,tp,LOCATION_GRAVE,0,1,nil) then
		if Duel.SelectYesNo(tp,aux.Stringid(511000202,0)) then
			Duel.NegateAttack()
			local ct=e:GetLabel()
			ct=ct+1
			e:SetLabel(ct)
		end
	end
end
function c511009332.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and not e:GetHandler():IsStatus(STATUS_CHAINING) and e:GetLabel()<=Duel.GetMatchingGroupCount(c511009332.filter,tp,LOCATION_GRAVE,0,nil)
end
function c511009332.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c511009332.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local ct=e:GetLabelObject():GetLabel()
	ct=ct+1
	e:GetLabelObject():SetLabel(ct)
	
end
