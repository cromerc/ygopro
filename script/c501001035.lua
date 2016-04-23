---デーモン・イーター
function c501001035.initial_effect(c)
	c:SetUniqueOnField(1,0,501001035)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c501001035.spcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001035,0))
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c501001035.condition)
	e2:SetTarget(c501001035.target)
	e2:SetOperation(c501001035.operation)
	c:RegisterEffect(e2)
end	
function c501001035.sfilter(c)
	return c:IsFaceup()
	and c:IsRace(RACE_SPELLCASTER)
end
function c501001035.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c501001035.sfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c501001035.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetTurnPlayer()~=tp
end
function c501001035.filter(c)
	return c:IsDestructable()
	and c:IsFaceup()
end
function c501001035.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c501001035.filter,tp,LOCATION_MZONE,0,1,nil)
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	end
	local g=Duel.SelectTarget(tp,c501001035.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(tp,CATEGORY_DESTROY,g,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_GRAVE)
end	
function c501001035.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) 
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end	
