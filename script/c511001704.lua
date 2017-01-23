--No Cheaters Allowed
function c511001704.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511001704.target1)
	e1:SetOperation(c511001704.operation1)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001704,1))
	e1:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c511001704.condition)
	e2:SetTarget(c511001704.target2)
	e2:SetOperation(c511001704.operation2)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511001704.sdcon)
	c:RegisterEffect(e3)
end
function c511001704.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xe6) and c:IsType(TYPE_SYNCHRO)
end
function c511001704.ofilter(c)
	return c:GetSummonLocation()==LOCATION_HAND
end
function c511001704.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001704.cfilter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511001704.ofilter,tp,0,LOCATION_MZONE,1,nil) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511001704.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(c511001704.cfilter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511001704.ofilter,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511001704.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function c511001704.operation1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if e:GetLabel()==1 then
		local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
function c511001704.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_MZONE,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
function c511001704.sdcon(e)
	return not Duel.IsExistingMatchingCard(c511001704.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
