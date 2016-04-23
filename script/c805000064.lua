--垂直着陸
function c805000064.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c805000064.sptg)
	e1:SetOperation(c805000064.spop)
	c:RegisterEffect(e1)
end
function c805000064.filter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and not c:IsType(TYPE_TOKEN)
end
function c805000064.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetFlagEffect(tp,805000064)~=0 then return false end
		return Duel.CheckReleaseGroup(tp,c805000064.filter,1,nil)
	end
	local ct=Duel.GetMatchingGroupCount(c805000064.filter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.SelectReleaseGroup(tp,c805000064.filter,1,ct,nil)
	Duel.Release(g,REASON_COST)
	e:SetLabel(g:GetCount())
	Duel.RegisterFlagEffect(tp,805000064,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,g:GetCount(),tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,g:GetCount(),tp,0)
end
function c805000064.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,0x4011,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then return end
	for i=1,ct do
		local token=Duel.CreateToken(tp,31533705)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
