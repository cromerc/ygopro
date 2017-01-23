--Discord Counter
function c511001106.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001106.condition)
	e1:SetTarget(c511001106.target)
	e1:SetOperation(c511001106.activate)
	c:RegisterEffect(e1)
end
function c511001106.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:GetSummonType()==SUMMON_TYPE_SYNCHRO and ep~=tp
end
function c511001106.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return eg:GetFirst():IsAbleToExtra() end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
end
function c511001106.mgfilter(c,e,tp,sync)
	return not c:IsLocation(LOCATION_GRAVE) or c:IsControler(1-tp)
		or bit.band(c:GetReason(),0x80008)~=0x80008 or c:GetReasonCard()~=sync
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001106.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft=1 end
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)==0 or sumtype~=SUMMON_TYPE_SYNCHRO or mg:GetCount()==0 
		or mg:GetCount()>ft or mg:IsExists(c511001106.mgfilter,1,nil,e,1-tp,tc) then
		sumable=false
	end
	if sumable then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,1-tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e3,tp)
end
