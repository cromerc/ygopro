--Construct Element
function c511002395.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002395.target)
	e1:SetOperation(c511002395.activate)
	c:RegisterEffect(e1)
end
function c511002395.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra() and c:IsSetCard(0x3008)
end
function c511002395.spfilter(c,e,tp,lv)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x3008) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
end
function c511002395.lvfilter(c,lv)
	return c:GetLevel()==lv
end
function c511002395.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002395.filter,tp,LOCATION_MZONE,0,1,nil) end
	local sg=Duel.GetMatchingGroup(c511002395.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c511002395.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511002395.filter,tp,LOCATION_MZONE,0,nil)
	if Duel.SendtoDeck(sg,nil,0,REASON_EFFECT)>0 then
		local spg=Group.CreateGroup()
		local tc=sg:GetFirst()
		while tc do
			local sumg=Duel.GetMatchingGroup(c511002395.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
			sumg:Sub(spg)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local gc=sumg:FilterSelect(tp,c511002395.lvfilter,1,1,nil,tc:GetPreviousLevelOnField()):GetFirst()
			if gc then
				spg:AddCard(gc)
			end
			tc=sg:GetNext()
		end
		if spg:GetCount()>0 then
			Duel.SpecialSummon(spg,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		end
	end
end
