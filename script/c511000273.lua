--Wotan's Judgment
function c511000273.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c511000273.cost)
    e1:SetCondition(c511000273.condition)
	e1:SetTarget(c511000273.target)
	e1:SetOperation(c511000273.activate)
	c:RegisterEffect(e1)
end
function c511000273.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToDeck()
end
function c511000273.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    local dg=Duel.GetDecktopGroup(tp,1)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000273.filter,tp,LOCATION_HAND,0,1,nil) and dg:GetFirst():IsAbleToHand() end
	local hg=Duel.SelectMatchingCard(tp,c511000273.filter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,hg)
	Duel.SendtoHand(dg,nil,REASON_COST)
	Duel.SendtoDeck(hg:GetFirst(),nil,0,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c511000273.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000273.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() end
end
function c511000273.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end
