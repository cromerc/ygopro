--Dual Gate
function c511001530.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001530.cost)
	e1:SetTarget(c511001530.target)
	e1:SetOperation(c511001530.activate)
	c:RegisterEffect(e1)
end
function c511001530.costfilter(c)
	return c:IsCode(511001530) and c:IsAbleToRemoveAsCost()
end
function c511001530.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingMatchingCard(c511001530.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=Duel.SelectMatchingCard(tp,c511001530.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	rg:AddCard(e:GetHandler())
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c511001530.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	e:GetHandler():CancelToGrave()
end
function c511001530.activate(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():CancelToGrave()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
