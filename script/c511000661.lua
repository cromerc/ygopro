--Roid Reinforcements
function c511000661.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000661.cost)
	e1:SetTarget(c511000661.target)
	e1:SetOperation(c511000661.operation)
	c:RegisterEffect(e1)
end
function c511000661.costfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c511000661.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511000661.filter(c)
	return c:IsSetCard(0x16) and c:IsAbleToHand()
end
function c511000661.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local rt=Duel.GetTargetCount(c511000661.filter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511000661.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) and rt>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local cg=Duel.SelectMatchingCard(tp,c511000661.costfilter,tp,LOCATION_HAND,0,1,rt,nil)
	Duel.SendtoGrave(cg,REASON_COST+REASON_DISCARD)
	Duel.SetTargetParam(cg:GetCount())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,e:GetLabel(),0,0)
end
function c511000661.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tg=Duel.GetMatchingGroup(c511000661.filter,tp,LOCATION_GRAVE,0,nil)
	if tg:GetCount()>=ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sel=tg:Select(tp,ct,ct,nil)
		Duel.SendtoHand(sel,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sel)
	end
end
