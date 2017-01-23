-- Psychic Wave
-- scripted by: UnknownGuest
function c511000532.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000532.cost)
	e1:SetCondition(c511000532.condition)
	e1:SetTarget(c511000532.target)
	e1:SetOperation(c511000532.operation)
	c:RegisterEffect(e1)
end
function c511000532.costfilter(c)
	return c:IsCode(77585513) and c:IsAbleToGraveAsCost()
end
function c511000532.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000532.costfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000532.costfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000532.cfilter(c)
	return c:IsFaceup() and c:IsAttackPos() and c:IsCode(9418534)
end
function c511000532.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000532.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000532.filter(c)
	return c:IsFaceup() and c:IsCode(9418534)
end
function c511000532.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000532.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000532.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000532.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local d=g:GetFirst():GetAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(d)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,d)
end
function c511000532.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
