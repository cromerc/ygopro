--カオス・ブラスト
function c100000072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000072.condition)
	e1:SetTarget(c100000072.target)
	e1:SetOperation(c100000072.activate)
	c:RegisterEffect(e1)
end
function c100000072.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000072.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c100000072.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:GetLevel()<=3 and c:IsRace(RACE_MACHINE) and c:IsAbleToGrave()
end
function c100000072.filter(c)
	return c:IsFaceup() and c:GetLevel()<5 and c:IsDestructable() and not c:IsType(TYPE_XYZ)
end
function c100000072.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c100000072.tgfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000072.tgfilter,tp,LOCATION_DECK,0,3,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
	if chkc then return chkc:IsOnField() and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(c100000072.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c100000072.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.ShuffleDeck(c:GetControler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100000072.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
