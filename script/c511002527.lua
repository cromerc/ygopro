--カオス・インフィニティ
function c511002527.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511002527.target)
	e1:SetOperation(c511002527.activate)
	c:RegisterEffect(e1)
end
function c511002527.spfilter(c,e,tp)
	return c:IsSetCard(0x13) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511002527.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(Card.IsDefensePos,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c511002527.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) 
		and Duel.IsExistingMatchingCard(c511002527.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c511002527.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDefensePos,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	Duel.ChangePosition(g,0,0,POS_FACEUP_ATTACK,POS_FACEDOWN_ATTACK)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g1=Duel.GetMatchingGroup(c511002527.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c511002527.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg2=g2:Select(tp,1,1,nil)
	sg1:Merge(sg2)
	local tc=sg1:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
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
		tc:RegisterFlagEffect(511002527,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		tc=sg1:GetNext()
	end
	Duel.SpecialSummonComplete()
	sg1:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002527.descon)
	e1:SetOperation(c511002527.desop)
	e1:SetLabelObject(sg1)
	Duel.RegisterEffect(e1,tp)
end
function c511002527.desfilter(c,fid)
	return c:GetFlagEffect(511002527)>0
end
function c511002527.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511002527.desfilter,1,nil) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511002527.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=e:GetLabelObject()
	local dg=sg:Filter(c511002527.desfilter,nil)
	sg:DeleteGroup()
	if dg:GetCount()>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
