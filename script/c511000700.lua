--Nightmare Xyz
function c511000700.initial_effect(c)
	function aux.AddXyzProcedure(c,f,lv,ct,alterf,desc,maxct,op)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f then
			mt.xyz_filter=function(mc) return mc and f(mc) end
		else
			mt.xyz_filter=function(mc) return true end
		end
		mt.minxyzct=ct
		if not maxct then
			mt.maxxyzct=ct
		else
			if maxct==5 and code~=14306092 and code~=63504681 and code~=23776077 then
				mt.maxxyzct=99
			else
				mt.maxxyzct=maxct
			end
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		if not maxct then maxct=ct end
		if alterf then
			e1:SetCondition(Auxiliary.XyzCondition2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetTarget(Auxiliary.XyzTarget2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetOperation(Auxiliary.XyzOperation2(f,lv,ct,maxct,alterf,desc,op))
		else
			e1:SetCondition(Auxiliary.XyzCondition(f,lv,ct,maxct))
			e1:SetTarget(Auxiliary.XyzTarget(f,lv,ct,maxct))
			e1:SetOperation(Auxiliary.XyzOperation(f,lv,ct,maxct))
		end
		e1:SetValue(SUMMON_TYPE_XYZ)
		c:RegisterEffect(e1)
	end
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCondition(c511000700.condition)
	e1:SetTarget(c511000700.target)
	e1:SetOperation(c511000700.activate)
	c:RegisterEffect(e1)
	if not c511000700.global_check then
		c511000700.global_check=true
		c511000700[0]=true
		c511000700[1]=true
		--check
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c511000700.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511000700.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000700.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and c511000700[tp]
end
function c511000700.cfilter(c)
	return c:IsSetCard(0x48) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP) 
		and bit.band(c:GetReason(),REASON_DESTROY)==REASON_DESTROY
end
function c511000700.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000700.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		c511000700[tc:GetPreviousControler()]=true
		tc=g:GetNext()
	end
end
function c511000700.clear(e,tp,eg,ep,ev,re,r,rp)
	c511000700[0]=false
	c511000700[1]=false
end
function c511000700.filter(c,e,tp)
	local ct=c.minxyzct
	return c:GetRank()<=4 and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_FIEND) and c:IsType(TYPE_XYZ) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>ct-1 
		and Duel.IsExistingMatchingCard(c511000700.filter2,tp,LOCATION_GRAVE,0,ct,nil,e,tp)
end
function c511000700.filter2(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:GetLevel()>0 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000700.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_EXTRA) and c511000700.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000700.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000700.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000700.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local ct=tc.minxyzct
		local ct2=tc.maxxyzct
		if ft<ct then return end
		if ft<ct2 then ct2=ft end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511000700.filter2,tp,LOCATION_GRAVE,0,ct,ct2,nil,e,tp)
		if g:GetCount()>0 then
			local tcx=g:GetFirst()
			while tcx do
				Duel.SpecialSummonStep(tcx,0,tp,tp,false,false,POS_FACEUP)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetValue(tc:GetRank())
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tcx:RegisterEffect(e1)
				tcx=g:GetNext()
			end
			Duel.SpecialSummonComplete()
			Duel.BreakEffect()
			tc:SetMaterial(g)
			Duel.Overlay(tc,g)
			Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			tc:CompleteProcedure()
		end
	end
end
