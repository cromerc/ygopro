--Battle Tuning
function c511001654.initial_effect(c)
	--synchro effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
	e1:SetCondition(c511001654.sccon)
	e1:SetTarget(c511001654.sctg)
	e1:SetOperation(c511001654.scop)
	c:RegisterEffect(e1)
end
function c511001654.sccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511001654.spfilter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false) 
		and Duel.IsExistingMatchingCard(c511001654.filter,tp,LOCATION_MZONE,0,1,nil,c,c:GetLevel())
end
function c511001654.filter(c,sync,lv)
	return c:IsFaceup() and c:GetSynchroLevel(sync)==lv and c:IsType(TYPE_TUNER)
		and c:IsCanBeSynchroMaterial(sync)
end
function c511001654.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingMatchingCard(c511001654.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001654.scop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	local g=Duel.GetMatchingGroup(c511001654.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mg=Duel.SelectMatchingCard(tp,c511001654.filter,tp,LOCATION_MZONE,0,1,1,nil,sc,sc:GetLevel())
		sc:SetMaterial(mg)
		Duel.SendtoGrave(mg,REASON_MATERIAL+REASON_SYNCHRO)
		Duel.BreakEffect()
		Duel.SpecialSummon(sc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
