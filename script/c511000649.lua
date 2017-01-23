--Purse with a Hole
function c511000649.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetHintTiming(0,TIMING_TOHAND)
	e1:SetCondition(c511000649.condition)
	e1:SetTarget(c511000649.target)
	e1:SetOperation(c511000649.activate)
	c:RegisterEffect(e1)
end
function c511000649.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>5
end
function c511000649.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)-5)
end
function c511000649.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	if g:GetCount()>0 then
		while Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>5 do
			Duel.BreakEffect()
			local sg=g:RandomSelect(p,1)
			Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
			g:RemoveCard(sg:GetFirst())
		end
	end
end
