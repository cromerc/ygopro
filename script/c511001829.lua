--Photon Hurricane
function c511001829.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001829.target)
	e1:SetOperation(c511001829.activate)
	c:RegisterEffect(e1)
end
function c511001829.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c511001829.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return Duel.IsExistingMatchingCard(c511001829.filter,tp,0,LOCATION_ONFIELD,1,c) 
		and ct>0 end
	local sg=Duel.GetMatchingGroup(c511001829.filter,tp,0,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
end
function c511001829.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	local rg=Duel.GetMatchingGroup(c511001829.filter,tp,0,LOCATION_ONFIELD,nil)
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=rg:Select(tp,1,ct,nil)
	Duel.HintSelection(sg)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
