--Parasite Generator
--fixed by MLD
function c511009347.initial_effect(c)	
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c511009347.condition)
	e1:SetTarget(c511009347.target)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7570,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetTarget(c511009347.sptg)
	e2:SetOperation(c511009347.spop)
	c:RegisterEffect(e2)
	--counted as 2 for parasite Queen
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(511009347)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsCode,6205579))
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c511009347.indtg)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	Duel.AddCustomActivityCounter(51109347,ACTIVITY_NORMALSUMMON,c511009347.counterfilter)
	Duel.AddCustomActivityCounter(51109347,ACTIVITY_SPSUMMON,c511009347.counterfilter)
end
--OCG Parasite collection
c511009347.collection={
	[6205579]=true;
}
function c511009347.counterfilter(c)
	return not (c511009347.collection[c:GetCode()] or c:IsSetCard(0x410))
end
function c511009347.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCustomActivityCount(51109347,tp,ACTIVITY_SPSUMMON)>0 
		or Duel.GetCustomActivityCount(51109347,tp,ACTIVITY_NORMALSUMMON)>0
end
function c511009347.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c511009347.sptg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,94) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c511009347.spop)
		c511009347.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c511009347.spfilter(c,e,tp)
	return c:IsCode(6205579) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009347.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511009347.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) 
		and e:GetHandler():GetFlagEffect(511009347)==0 end
	e:GetHandler():RegisterFlagEffect(511009347,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511009347.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if not e:GetHandler():IsRelateToEffect(e) or ft<=0 then return end
	local fid=e:GetHandler():GetFieldID()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009347.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		g:GetFirst():RegisterFlagEffect(51109347,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		Duel.BreakEffect()
		ft=ft-1
		if ft>0 then
			if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
			local sg=Duel.SelectMatchingCard(tp,c511009347.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,ft,ft,nil,e,tp)
			Duel.HintSelection(sg)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			local tc=sg:GetFirst()
			while tc do
				tc:RegisterFlagEffect(51109347,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
				tc=sg:GetNext()
			end
			g:Merge(sg)
		end
		g:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(g)
		e1:SetCondition(c511009347.retcon)
		e1:SetOperation(c511009347.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511009347.retfilter(c,fid)
	return c:GetFlagEffectLabel(51109347)==fid
end
function c511009347.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511009347.retfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511009347.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511009347.retfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
end
function c511009347.indtg(e,c)
	return c511009347.collection[c:GetCode()] or c:IsSetCard(0x410)
end
