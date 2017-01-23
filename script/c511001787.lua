--Mirage Target
function c511001787.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001787.condition)
	e1:SetCost(c511001787.cost)
	e1:SetTarget(c511001787.target)
	e1:SetOperation(c511001787.activate)
	c:RegisterEffect(e1)
end
function c511001787.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp)
end
function c511001787.cfilter(c)
	return c:IsSetCard(0x18) and c:IsAbleToGraveAsCost()
end
function c511001787.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001787.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001787.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001787.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	local atk=g:GetFirst():GetTextAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c511001787.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateAttack() then return end
	Duel.Recover(tp,Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM),REASON_EFFECT)
end
