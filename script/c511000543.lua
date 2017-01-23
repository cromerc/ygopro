--Summon Capture
function c511000543.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_TOHAND)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000543.target)
	e1:SetOperation(c511000543.activate)
	c:RegisterEffect(e1)
end
function c511000543.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
end
function c511000543.filter(c)
	return c:IsSummonable(true,nil)
end
function c511000543.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(p,g)
		local tg2=g:Filter(Card.IsType,nil,TYPE_MONSTER)
		local tg=tg2:Filter(c511000543.filter,nil)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local sg=tg:Select(p,1,1,nil)
			Duel.Summon(tp,sg:GetFirst(),true,nil)
		end
		Duel.ShuffleHand(1-p)
	end
end
