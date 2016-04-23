--アンブラル・アンフォーム
function c805000013.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000013,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c805000013.condition)
	e1:SetTarget(c805000013.target)
	e1:SetOperation(c805000013.operation)
	c:RegisterEffect(e1)
end
function c805000013.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsLocation(LOCATION_GRAVE)
		and e:GetHandler():IsReason(REASON_BATTLE) and Duel.GetFlagEffect(tp,805000013)==0
end
function c805000013.filter(c,e,tp)
	return c:IsSetCard(0x85) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c805000013.filter,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
	Duel.RegisterFlagEffect(tp,805000013,RESET_PHASE+PHASE_END,0,1)
end
function c805000013.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.SelectMatchingCard(tp,c805000013.filter,tp,LOCATION_DECK,0,2,2,nil,e,tp)
	if g:GetCount()>1 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
