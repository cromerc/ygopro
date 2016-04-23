--ギミック・パペット－ナイト・ジョーカー
function c800000007.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(800000007,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)	
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCost(c800000007.cost)
	e1:SetCondition(c800000007.condition)
	e1:SetTarget(c800000007.target)
	e1:SetOperation(c800000007.operation)
	c:RegisterEffect(e1)
end
function c800000007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,800000007)==0 end
	Duel.RegisterFlagEffect(tp,800000007,RESET_PHASE+PHASE_END,0,1)
end
function c800000007.spfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:IsPreviousLocation(LOCATION_MZONE) 
	and c:GetPreviousControler()==tp and c:IsSetCard(0x83) and c:IsLocation(LOCATION_GRAVE) 
end
function c800000007.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c800000007.spfilter,1,nil,tp)
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c800000007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end	
	local tc=eg:Filter(c800000007.spfilter,nil,tp):GetFirst()
	if tc==nil then return end	
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,0,0)
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c800000007.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
