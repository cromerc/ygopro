--D/D Ghost
function c511009365.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14536035,1))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c511009365.tgtg)
	e1:SetOperation(c511009365.tgop)
	c:RegisterEffect(e1)
	
end
function c511009365.filter(c,code)
	return c:IsCode(code) and c:IsAbleToGrave()
end
function c511009365.tgfilter(c,tp)
	return (c:IsSetCard(0xae)  or c:IsSetCard(0xaf) ) and Duel.IsExistingMatchingCard(c511009365.filter,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c511009365.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511009365.tgfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009365.tgfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009365.tgfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler(),tp)
end
function c511009365.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c511009365.filter,tp,LOCATION_DECK,0,1,1,nil,tc:GetCode())
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
