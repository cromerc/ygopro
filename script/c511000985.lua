--Dragon Dance
function c511000985.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000985.condition)
	e1:SetCost(c511000985.cost)
	e1:SetTarget(c511000985.target)
	e1:SetOperation(c511000985.activate)
	c:RegisterEffect(e1)
end
function c511000985.condition(e,tp,eg,ep,ev,re,r,rp)
	if tp==Duel.GetTurnPlayer() then return false end
	local at=Duel.GetAttackTarget()
	return at and at:IsFaceup() and at:IsType(TYPE_XYZ) and at:IsRace(RACE_DRAGON)
end
function c511000985.cfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAbleToRemoveAsCost()
end
function c511000985.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511000985.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511000985.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c511000985.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
	local sum=rg:GetSum(Card.GetAttack)
	Duel.SetTargetParam(sum)
end
function c511000985.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local sum=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if a:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-sum)
		a:RegisterEffect(e1)
	end
end
