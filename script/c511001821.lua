--Necroid Synchro
function c511001821.initial_effect(c)
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
	--synchro effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
	e1:SetTarget(c511001821.sctg)
	e1:SetOperation(c511001821.scop)
	c:RegisterEffect(e1)
	if not c511001821.global_check then
		c511001821.global_check=true
		--double tuner
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(c511001821.op)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511001821.op(e,tp,eg,ep,ev,re,r,rp)
	--Double Tuners
	if c62242678 and not c62242678.dobtun then --Hot Red Dragon Archfiend King Calamity
		local mt=c62242678
		mt.tuner_filter=function(mc) return true end
		mt.nontuner_filter=function(mc) return mc and mc:IsAttribute(ATTRIBUTE_DARK) and mc:IsRace(RACE_DRAGON) 
			and mc:IsType(TYPE_SYNCHRO) end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		mt.dobtun=true
	end
	if c511001603 and not c511001603.dobtun then --Hot Red Dragon Archfiend King Calamity (Anime)
		local mt=c511001603
		mt.tuner_filter=function(mc) return true end
		mt.nontuner_filter=function(mc) return mc and mc:IsType(TYPE_SYNCHRO) end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		mt.dobtun=true
	end
	if c97489701 and not c97489701.dobtun then --Red Nova Dragon
		local mt=c97489701
		mt.tuner_filter=function(mc) return true end
		mt.nontuner_filter=function(mc) return mc and mc:IsCode(70902743) end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		mt.dobtun=true
	end
	if c16172067 and not c16172067.dobtun then --Red Dragon Archfiend Tyrant
		local mt=c16172067
		mt.tuner_filter=function(mc) return true end
		mt.nontuner_filter=function(mc) return true end
		mt.minntct=1
		mt.maxntct=99
		mt.sync=true
		mt.dobtun=true
	end
	if c93157004 and not c93157004.dobtun then --Vylon Omega
		local mt=c93157004
		mt.tuner_filter=function(mc) return true end
		mt.nontuner_filter=function(mc) return mc and mc:IsSetCard(0x30) end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		mt.dobtun=true
	end
end
function c511001821.filter(c,e,tp)
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	local tuner=Duel.GetMatchingGroup(c511001821.matfilter1,tp,LOCATION_GRAVE,0,nil,c)
	local nontuner=Duel.GetMatchingGroup(c511001821.matfilter2,tp,LOCATION_GRAVE,0,nil,c)
	if not c:IsType(TYPE_SYNCHRO) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false) 
		or not mt.sync then return false end
	if c:IsSetCard(0x301) then
		return nontuner:IsExists(c511001821.lvfilter2,1,nil,c,tuner)
	elseif mt.dobtun then
		return tuner:IsExists(c511001821.dtfilter1,1,nil,c,tuner,nontuner)
	else
		return tuner:IsExists(c511001821.lvfilter,1,nil,c,nontuner)
	end
end
function c511001821.dtfilter1(c,syncard,tuner,nontuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=syncard:GetLevel()
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	return tuner:IsExists(c511001821.dtfilter2,1,c,syncard,lv-tlv,nontuner,c)
end
function c511001821.dtfilter2(c,syncard,lv,nontuner,tuner1)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local tlv=c:GetSynchroLevel(syncard)
	if lv-tlv<=0 then return false end
	local nt=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,tuner1)
	nt=nt:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and nt:CheckWithSumEqual(Card.GetSynchroLevel,lv-tlv,mt.minntct,mt.maxntct,syncard)
end
function c511001821.lvfilter(c,syncard,nontuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=c:GetSynchroLevel(syncard)
	local slv=syncard:GetLevel()
	local nt=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and nt:CheckWithSumEqual(Card.GetSynchroLevel,slv-lv,mt.minntct,mt.maxntct,syncard)
end
function c511001821.lvfilter2(c,syncard,tuner)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	local lv=c:GetSynchroLevel(syncard)
	local slv=syncard:GetLevel()
	local nt=tuner:Filter(Card.IsCanBeSynchroMaterial,nil,syncard,c)
	return mt.minntct and mt.maxntct and nt:CheckWithSumEqual(Card.GetSynchroLevel,lv+slv,mt.minntct,mt.maxntct,syncard)
end
function c511001821.matfilter1(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_TUNER) and c:IsCanBeSynchroMaterial(syncard) and c:IsAbleToRemove() 
		and mt.tuner_filter and mt.tuner_filter(c)
end
function c511001821.matfilter2(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return c:IsType(TYPE_MONSTER) and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard) and c:IsAbleToRemove()
		and mt.nontuner_filter and mt.nontuner_filter(c)
end
function c511001821.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511001821.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001821.scop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001821.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		local code=tc:GetOriginalCode()
		local mt=_G["c" .. code]
		local tuner=Duel.GetMatchingGroup(c511001821.matfilter1,tp,LOCATION_GRAVE,0,nil,tc)
		local nontuner=Duel.GetMatchingGroup(c511001821.matfilter2,tp,LOCATION_GRAVE,0,nil,tc)
		local mat1
		if tc:IsSetCard(0x301) then
			nontuner=nontuner:Filter(c511001821.lvfilter2,nil,tc,tuner)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			mat1=nontuner:Select(tp,1,1,nil)
			local tlv=mat1:GetFirst():GetSynchroLevel(tc)
			tuner=tuner:Filter(Card.IsCanBeSynchroMaterial,nil,tc,mat1:GetFirst())
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			local mat2=tuner:SelectWithSumEqual(tp,Card.GetSynchroLevel,tc:GetLevel()+tlv,mt.minntct,mt.maxntct,tc)
			mat1:Merge(mat2)
		elseif mt.dobtun then
			mat1=Group.CreateGroup()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			local tuner1=tuner:FilterSelect(tp,c511001821.dtfilter1,1,1,nil,tc,tuner,nontuner):GetFirst()
			mat1:AddCard(tuner1)
			local tlv1=tuner1:GetSynchroLevel(tc)
			local tuner2=tuner:FilterSelect(tp,c511001821.dtfilter2,1,1,tuner1,tc,tc:GetLevel()-tlv1,nontuner,tuner1):GetFirst()
			mat1:AddCard(tuner2)
			local nt=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,tc,tuner1)
			nt=nt:Filter(Card.IsCanBeSynchroMaterial,nil,tc,tuner2)
			local tlv2=tuner2:GetSynchroLevel(tc)
			local m3=nt:SelectWithSumEqual(tp,Card.GetSynchroLevel,tc:GetLevel()-tlv1-tlv2,mt.minntct,mt.maxntct,tc)
			mat1:Merge(m3)
		else
			tuner=tuner:Filter(c511001821.lvfilter,nil,tc,nontuner)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			mat1=tuner:Select(tp,1,1,nil)
			local tlv=mat1:GetFirst():GetSynchroLevel(tc)
			nontuner=nontuner:Filter(Card.IsCanBeSynchroMaterial,nil,tc,mat1:GetFirst())
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
			local mat2=nontuner:SelectWithSumEqual(tp,Card.GetSynchroLevel,tc:GetLevel()-tlv,mt.minntct,mt.maxntct,tc)
			mat1:Merge(mat2)
		end
		tc:SetMaterial(mat1)
		Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP)
		--disable
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc:CompleteProcedure()
	end
end
