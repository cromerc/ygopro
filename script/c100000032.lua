--ダーク・アーキタイプ
function c100000032.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c100000032.condition)
	e1:SetTarget(c100000032.target)
	e1:SetOperation(c100000032.activate)
	c:RegisterEffect(e1)
end
function c100000032.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c100000032.filter(c,e,tp,dam)
	return c:IsAttackBelow(dam) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local dam=Duel.GetBattleDamage(tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000032.filter,tp,LOCATION_DECK,0,1,nil,e,tp,dam) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000032.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end	
	local dam=Duel.GetBattleDamage(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000032.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,dam)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
