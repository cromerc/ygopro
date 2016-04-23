--霊廟の守護者
function c5648.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c5648.condition)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18175965,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(c5648.spcon)
	e2:SetTarget(c5648.sptg)
	e2:SetOperation(c5648.spop)
	c:RegisterEffect(e2)
end
function c5648.condition(e,c)
	return c:IsRace(RACE_DRAGON)
end
function c5648.cfilter(c)
	return c:IsFaceup() and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsRace(RACE_DRAGON) and not c:IsCode(5648)
		and (c:IsReason(REASON_EFFECT) or (c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE)))
end
function c5648.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5648.cfilter,1,nil)
end
function c5648.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c5648.thfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_NORMAL) and c:IsAbleToHand() and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c5648.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)>0 then
		local g=eg:Filter(c5648.cfilter,nil)
		local mg=Duel.GetMatchingGroup(c5648.thfilter,tp,LOCATION_GRAVE,0,nil)
		if g:IsExists(Card.IsType,1,nil,TYPE_NORMAL) and mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(5648,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=mg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
