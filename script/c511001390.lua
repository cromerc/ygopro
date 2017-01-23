--Pinpoint Shot
function c511001390.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_TOHAND)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetTarget(c511001390.target)
	e1:SetOperation(c511001390.operation)
	c:RegisterEffect(e1)
end
function c511001390.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local ac=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(ac)
	e:GetHandler():SetHint(CHINT_CARD,ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c511001390.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_HAND,nil,ac)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
