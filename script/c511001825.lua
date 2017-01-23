--Banish Reactor
function c511001825.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c511001825.condition)
	e1:SetTarget(c511001825.target)
	e1:SetOperation(c511001825.activate)
	c:RegisterEffect(e1)
end
function c511001825.cfilter(c,tp)
	return c:GetPreviousControler()==tp
end
function c511001825.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001825.cfilter,1,nil,tp)
end
function c511001825.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001825.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001825.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c511001825.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511001825.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
