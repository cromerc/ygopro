--Ｓｐ－テールスイング
function c100100082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100082.con)
	e1:SetTarget(c100100082.target)
	e1:SetOperation(c100100082.activate)
	c:RegisterEffect(e1)
end
function c100100082.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>1
end
function c100100082.filter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_DINOSAUR) and c:IsLevelAbove(5)
		and Duel.IsExistingMatchingCard(c100100082.dfilter,tp,0,LOCATION_MZONE,1,nil,c:GetLevel())
end
function c100100082.dfilter(c,lv)
	return (c:IsFacedown() or c:IsLevelBelow(lv-1)) and c:IsAbleToHand()
end
function c100100082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c100100082.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c100100082.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local sg=Duel.GetMatchingGroup(c100100082.dfilter,tp,0,LOCATION_MZONE,nil,g:GetFirst():GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
end
function c100100082.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local sg=Duel.SelectMatchingCard(tp,c100100082.dfilter,tp,0,LOCATION_MZONE,1,2,nil,tc:GetLevel())
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
