--Numeron Direct
function c511000276.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000276.con)
	e1:SetTarget(c511000276.tg)
	e1:SetOperation(c511000276.op)
	c:RegisterEffect(e1)
end
function c511000276.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000275)
end
function c511000276.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000276.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(511000275)
end
function c511000276.filter(c,e,tp)
	return c:IsAttackBelow(1000) and c:IsSetCard(0x1ff) and c:IsType(TYPE_XYZ) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000276.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511000276.filter,tp,LOCATION_EXTRA,0,4,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000276.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c511000276.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()<=3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,4,4,nil)
	if sg:GetCount()>0 then
		local fid=e:GetHandler():GetFieldID()
		local tc=sg:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(51100276,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
			tc=sg:GetNext()
		end
		Duel.SpecialSummonComplete()
		sg:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(sg)
		e1:SetCondition(c511000276.rmcon)
		e1:SetOperation(c511000276.rmop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000276.rmfilter(c,fid)
	return c:GetFlagEffectLabel(51100276)==fid
end
function c511000276.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511000276.rmfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511000276.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511000276.rmfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
end
