--Flash Tune
function c511002804.initial_effect(c)
	--Synchro monster, 1 tuner + n or more monsters
	function aux.AddSynchroProcedure(c,f1,f2,ct)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=ct
		mt.maxntct=99
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,ct,99))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,ct,99))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,ct,99))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	--Synchro monster, 1 tuner + 1 monster
	function Auxiliary.AddSynchroProcedure2(c,f1,f2)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,1,1))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,1,1))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,1,1))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511002804.condition)
	e1:SetTarget(c511002804.target)
	e1:SetOperation(c511002804.activate)
	c:RegisterEffect(e1)
end
function c511002804.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsType,nil,TYPE_SYNCHRO)
	return g:GetCount()==1
end
function c511002804.matfilter(c,lv,syncard,mclv)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local clv=c:GetSynchroLevel(syncard)
	return clv>0 and clv==lv-mclv and mt.tuner_filter and mt.tuner_filter(mc)
end
function c511002804.filter(c,e,tp,mc)
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local mclv=mc:GetSynchroLevel(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false)
		and Duel.IsExistingMatchingCard(c511002804.matfilter,tp,LOCATION_HAND,0,1,nil,c:GetLevel(),c,mclv) 
		and mt.sync and mt.minntct and mt.minntct==1 and mt.nontuner_filter and mt.nontuner_filter(mc)
		and mc:IsNotTuner() 
end
function c511002804.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(Card.IsType,nil,TYPE_SYNCHRO)
	local tc=g:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingMatchingCard(c511002804.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,tc) end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002804.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=eg:Filter(Card.IsType,nil,TYPE_SYNCHRO):GetFirst()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511002804.filter,tp,LOCATION_EXTRA,0,nil,e,tp,tc)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		local code=sc:GetOriginalCode()
		local mt=_G["c" .. code]
		local mclv=tc:GetSynchroLevel(sc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat=Duel.SelectMatchingCard(tp,c511002804.matfilter,tp,LOCATION_HAND,0,1,1,nil,sc:GetLevel(),sc,mclv)
		mat:AddCard(tc)
		sc:SetMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(sc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP_ATTACK)
		sc:CompleteProcedure()
	end
end
