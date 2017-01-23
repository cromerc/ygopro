--BF－大旆のヴァーユ
function c511002219.initial_effect(c)
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
	
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89326990,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c511002219.target)
	e1:SetOperation(c511002219.operation)
	c:RegisterEffect(e1)
	--synchro limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
end
function c511002219.matfilter(c,lv,syncard,mclv)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:GetSynchroLevel(syncard)==lv-mclv and c:IsNotTuner() and c:IsAbleToRemove() 
		and mt.nontuner_filter and mt.nontuner_filter(c)
end
function c511002219.filter(c,e,tp,mc)
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local mclv=mc:GetSynchroLevel(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false)
		and Duel.IsExistingMatchingCard(c511002219.matfilter,tp,LOCATION_GRAVE,0,1,nil,c:GetLevel(),c,mclv) 
		and mt.sync and mt.minntct and mt.minntct==1 and mt.tuner_filter and mt.tuner_filter(mc)
end
function c511002219.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and c:IsAbleToRemove() 
		and Duel.IsExistingMatchingCard(c511002219.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002219.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511002219.filter,tp,LOCATION_EXTRA,0,nil,e,tp,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		local code=tc:GetOriginalCode()
		local mt=_G["c" .. code]
		local mclv=c:GetSynchroLevel(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat=Duel.SelectMatchingCard(tp,c511002219.matfilter,tp,LOCATION_GRAVE,0,1,1,nil,tc:GetLevel(),tc,mclv)
		mat:AddCard(c)
		tc:SetMaterial(mat)
		Duel.Remove(mat,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
