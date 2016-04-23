--レベル・クロス
function c100000076.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetCondition(c100000076.condition)
	e1:SetCost(c100000076.cost)	
	e1:SetTarget(c100000076.target)
	e1:SetOperation(c100000076.activate)
	c:RegisterEffect(e1)
end
function c100000076.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(4)
end
function c100000076.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c100000076.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000076.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c100000076.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000076.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000076.filter,tp,LOCATION_MZONE,0,1,nil) end
	return true
end
function c100000076.activate(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local dg=Duel.GetMatchingGroup(c100000076.filter,tp,LOCATION_MZONE,0,nil)		
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tdg=dg:Select(tp,1,1,nil)
	local tc=tdg:GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(tc:GetLevel()*2)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
end
