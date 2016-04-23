--Scripted by Eerie Code
--Odd-Eyes Advent
function c6866.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,6866+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c6866.target)
	e1:SetOperation(c6866.activate)
	c:RegisterEffect(e1)
end

function c6866.matcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1 and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c6866.filter(c,e,tp,m)
	if bit.band(c:GetType(),0x81)~=0x81
		or not c:IsRace(RACE_DRAGON) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=nil
	if c.mat_filter then
		mg=m:Filter(c.mat_filter,c)
	else
		mg=m:Clone()
		mg:RemoveCard(c)
	end
	return mg:CheckWithSumGreater(Card.GetRitualLevel,c:GetLevel(),c)
end
function c6866.matfilter1(c)
	return c:IsType(TYPE_PENDULUM) and c:GetLevel()>0 and c:IsReleasable()
end
function c6866.matfilter2(c)
	return c:IsSetCard(0x99) and c:GetLevel()>0 and c:IsAbleToGraveAsCost()
end
function c6866.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		--local mg1=Duel.GetMatchingGroup(c6866.matfilter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		local mg1=Duel.GetRitualMaterial(tp):Filter(Card.IsType,nil,TYPE_PENDULUM)
		if c6866.matcon(e,tp,eg,ep,ev,re,r,rp) then
			local mg2=Duel.GetMatchingGroup(c6866.matfilter2,tp,LOCATION_EXTRA,0,nil)
			mg1:Merge(mg2)
		end
		return Duel.IsExistingMatchingCard(c6866.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp,mg1)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c6866.activate(e,tp,eg,ep,ev,re,r,rp)
	--if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg1=Duel.GetRitualMaterial(tp):Filter(Card.IsType,nil,TYPE_PENDULUM)
	if c6866.matcon(e,tp,eg,ep,ev,re,r,rp) then
		local mg2=Duel.GetMatchingGroup(c6866.matfilter2,tp,LOCATION_EXTRA,0,nil)
		mg1:Merge(mg2)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c6866.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,mg1)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		if tc.mat_filter then
			mg1=mg1:Filter(tc.mat_filter,nil)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local mat=mg1:SelectWithSumGreater(tp,Card.GetRitualLevel,tc:GetLevel(),tc)
		tc:SetMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
