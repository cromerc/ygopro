--武神器－ムラクモ
function c805000017.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000017,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c805000017.condition)
	e1:SetCost(c805000017.cost)
	e1:SetTarget(c805000017.target)
	e1:SetOperation(c805000017.operation)
	c:RegisterEffect(e1)
end
function c805000017.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x86) and c:IsRace(RACE_BEASTWARRIOR)
end
function c805000017.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c805000017.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c805000017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c805000017.desfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c805000017.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(c805000017.desfilter,tp,0,LOCATION_ONFIELD,1,nil)
	 and Duel.GetFlagEffect(tp,805000017)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c805000017.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.RegisterFlagEffect(tp,805000017,RESET_PHASE+PHASE_END,0,1)
end
function c805000017.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
