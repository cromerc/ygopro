--Monster Replace
function c511000461.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000461.target)
	e1:SetOperation(c511000461.activate)
	c:RegisterEffect(e1)
end
function c511000461.filter(c,e,tp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,c,TYPE_MONSTER)
	local tg=g:GetMaxGroup(Card.GetAttack)
	return c:IsAbleToHand() and tg:IsExists(Card.IsCanBeSpecialSummoned,1,nil,e,0,tp,false,false,c:GetPosition(),tp)
end
function c511000461.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000461.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000461.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511000461.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511000461.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local pos=tc:GetPosition()
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 then
			local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,tc,TYPE_MONSTER)
			local tg=g:GetMaxGroup(Card.GetAttack)
			if tg:GetCount()>1 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				tg=tg:FilterSelect(tp,Card.IsCanBeSpecialSummoned,1,1,nil,e,0,tp,false,false,pos,tp)
			end
			Duel.SpecialSummon(tg,0,tp,tp,false,false,pos)
		end
	end
end
