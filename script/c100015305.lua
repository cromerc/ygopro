--
function c100015305.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100015305.target)
	e1:SetOperation(c100015305.activate)
	c:RegisterEffect(e1)
end
function c100015305.mfilter1(c,e)
	return c:IsFaceup() and c:GetLevel()>0 and not c:IsImmuneToEffect(e) and c:IsReleasable()
end
function c100015305.mfilter2(c)
	return c:IsHasEffect(EFFECT_EXTRA_RITUAL_MATERIAL) and c:IsAbleToRemove()
end
function c100015305.mfilter3(c,e)
	return c:GetLevel()>0 and c:IsReleasable()
end
function c100015305.get_material(e,tp)
	local g1=Duel.GetMatchingGroup(c100015305.mfilter1,tp,LOCATION_MZONE,0,nil,e)
	local g2=Duel.GetMatchingGroup(c100015305.mfilter2,tp,LOCATION_GRAVE,0,nil)
	local g3=Duel.GetMatchingGroup(c100015305.mfilter3,tp,LOCATION_HAND,0,nil,e)
	g1:Merge(g2)
	g1:Merge(g3)
	return g1
end
function c100015305.filter(c,e,tp,m)
	if bit.band(c:GetType(),0x81)~=0x81 or not c:IsSetCard(0x400) 
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false) then return false end
	if m:IsContains(c) then
		m:RemoveCard(c)
		result=m:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
		m:AddCard(c)
	else
		result=m:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
	end
	return result
end
function c100015305.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=c100015305.get_material(e,tp)
		return Duel.IsExistingMatchingCard(c100015305.filter,tp,LOCATION_HAND,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100015305.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=c100015305.get_material(e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c100015305.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		mg:RemoveCard(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		--Destroy replace
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTarget(c100015305.desreptg)
		e1:SetOperation(c100015305.desrepop)		
		e1:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e1)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c100015305.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and tc:IsAbleToRemove() end
	if Duel.SelectYesNo(tp,aux.Stringid(100015305,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		return true
	else return false end
end
function c100015305.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end