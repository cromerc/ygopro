--Moon-light Black Sheep
function c511002220.initial_effect(c)	
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2729285,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c511002220.condition)
	e1:SetTarget(c511002220.target)
	e1:SetOperation(c511002220.operation)
	c:RegisterEffect(e1)
end
function c511002220.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp 
		and c:IsLocation(LOCATION_GRAVE) and r==REASON_FUSION
end
function c511002220.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511002220.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end

