--Elder of the Spirit Beast Tamers
function c13700018.initial_effect(c)
	--~ condition	
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	e1:SetCondition(c13700018.splimit)
	c:RegisterEffect(e1)
	--~ spsummon cost
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c13700018.sumsuc)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c13700018.sptg)
	e2:SetOperation(c13700018.spop)
	c:RegisterEffect(e2)
end
function c13700018.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,13700018,RESET_PHASE+PHASE_END,0,1)
end
function c13700018.splimit(e,c,tp,sumtp,sumpos)
	return Duel.GetFlagEffect(tp,13700018)~=0
end


function c13700018.filter(c)
	return c:IsSummonable(true,nil) and (c:IsSetCard(0x1376) or c:IsSetCard(0x1377))
end
function c13700018.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700018.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c13700018.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c13700018.filter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
