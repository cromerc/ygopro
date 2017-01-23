--Harmonic Geoglyph
function c511000744.initial_effect(c)
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
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000744.target)
	e1:SetOperation(c511000744.activate)
	c:RegisterEffect(e1)
end
function c511000744.filter(c,e,tp)
	local lv=c:GetLevel()
	if lv%2~=0 then return false end
	local matnum=(lv/2)-1
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local tuner=Duel.GetMatchingGroup(c511000744.matfilter1,tp,LOCATION_MZONE,0,nil,c)
	local nontuner=Duel.GetMatchingGroup(c511000744.matfilter2,tp,0,LOCATION_MZONE+LOCATION_GRAVE,nil,c)
	if not c:IsType(TYPE_SYNCHRO) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false) 
		or not mt.sync then return false end
	return nontuner:GetCount()>=matnum and mt.minntct and mt.minntct<=matnum and mt.maxntct>=matnum
		and tuner:GetCount()>0
end
function c511000744.matfilter1(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_TUNER) and c:IsCanBeSynchroMaterial(syncard) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) 
		and mt.tuner_filter and mt.tuner_filter(c)
end
function c511000744.matfilter2(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()>=6 and not c:IsType(TYPE_TUNER) 
		and mt.nontuner_filter and mt.nontuner_filter(c) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) 
end
function c511000744.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511000744.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000744.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	local g=Duel.GetMatchingGroup(c511000744.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		local code=tc:GetOriginalCode()
		local mt=_G["c" .. code]
		local tuner=Duel.GetMatchingGroup(c511000744.matfilter1,tp,LOCATION_MZONE,0,nil,tc)
		local nontuner=Duel.GetMatchingGroup(c511000744.matfilter2,tp,0,LOCATION_MZONE+LOCATION_GRAVE,nil,tc)
		local lv=tc:GetLevel()
		local matnum=(lv/2)-1
		local mat1=tuner:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat2=nontuner:Select(tp,matnum,matnum,nil)
		mat1:Merge(mat2)
		tc:SetMaterial(mat1)
		Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
