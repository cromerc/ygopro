--ワルキューレの抱擁
function c100000529.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100000529.cost)
	e1:SetTarget(c100000529.target)
	e1:SetOperation(c100000529.activate)
	c:RegisterEffect(e1)
end
function c100000529.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and (c:GetCode()==100000533 or c:GetCode()==100000534 or c:GetCode()==100000537 or c:GetCode()==100000538) 
end
function c100000529.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000529.filter,tp,LOCATION_MZONE,0,1,nil) end
	local dg=Duel.GetMatchingGroup(c100000529.filter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=dg:Select(tp,1,1,nil)
	Duel.ChangePosition(sg,POS_FACEUP_DEFENCE)
end
function c100000529.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c100000529.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,nil)
	if dg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local des=dg:Select(tp,1,1,nil)
		Duel.Remove(des,POS_FACEUP,REASON_EFFECT)
	end
end
