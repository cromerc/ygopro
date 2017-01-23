--Cyber Tutubon
function c511009311.initial_effect(c)
	--become material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c511009311.condition)
	e2:SetOperation(c511009311.operation)
	c:RegisterEffect(e2)
end
function c511009311.condition(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c511009311.operation(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	if c:IsReason(REASON_RITUAL) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(96729612,0))
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+0x2fe0000+RESET_PHASE+PHASE_END)
		e1:SetTarget(c511009311.thtg)
		e1:SetOperation(c511009311.thop)
		c:RegisterEffect(e1)
	end
end
function c511009311.thfilter(c)
	return c:GetType()==0x82 and c:IsAbleToHand()
end
function c511009311.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009311.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c511009311.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511009311.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 and not g:GetFirst():IsHasEffect(EFFECT_NECRO_VALLEY) then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end