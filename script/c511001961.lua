--BF－精鋭のゼピュロス
function c511001961.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100021,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c511001961.cost)
	e1:SetTarget(c511001961.target)
	e1:SetOperation(c511001961.operation)
	c:RegisterEffect(e1)
end
function c511001961.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then
		if ft<0 then return false end
		if ft==0 then
			return Duel.IsExistingMatchingCard(Card.IsAbleToHandAsCost,tp,LOCATION_MZONE,0,1,nil)
		else
			return Duel.IsExistingMatchingCard(Card.IsAbleToHandAsCost,tp,LOCATION_ONFIELD,0,1,nil)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	if ft==0 then
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHandAsCost,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.SendtoHand(g,nil,REASON_COST)
	else
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHandAsCost,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.SendtoHand(g,nil,REASON_COST)
	end
end
function c511001961.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,400)
end
function c511001961.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.Damage(tp,400,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_MSET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetOperation(c511001961.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EVENT_SSET)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EVENT_CHANGE_POS)
		e3:SetCondition(c511001961.descon2)
		c:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EVENT_SPSUMMON_SUCCESS)
		e4:SetCondition(c511001961.descon3)
		c:RegisterEffect(e4)
	end
end
function c511001961.filter2(c)
	return bit.band(c:GetPreviousPosition(),POS_FACEUP)~=0 and bit.band(c:GetPosition(),POS_FACEDOWN)~=0
end
function c511001961.descon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001961.filter2,1,nil)
end
function c511001961.descon3(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsFacedown,1,nil)
end
function c511001961.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
