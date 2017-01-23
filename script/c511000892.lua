--Mimesis
function c511000892.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511000892.condition)
	e1:SetTarget(c511000892.target)
	e1:SetOperation(c511000892.activate)
	c:RegisterEffect(e1)
end
function c511000892.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup() and tc:IsRace(RACE_INSECT)
end
function c511000892.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000892.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then
		if tc:IsLevelBelow(4) then
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and tc:IsAbleToHand()
		else
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and tc:IsAbleToHand() 
				and Duel.IsExistingMatchingCard(c511000892.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		end
	end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000892.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c511000892.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			Duel.ChangeAttackTarget(g:GetFirst())
		end
	end
end
