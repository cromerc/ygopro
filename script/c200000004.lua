--勝利の方程式
function c200000004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c200000004.condition)
	e1:SetTarget(c200000004.target)
	e1:SetOperation(c200000004.activate)
	c:RegisterEffect(e1)
end
c200000004.illegal=true
function c200000004.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c200000004.spfilter(c,e,tp)
	return c:IsSetCard(0x48) and not c:IsSetCard(0x1048) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c200000004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c200000004.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(110000000,5))
	local code=Duel.AnnounceCard(tp)
	Duel.SetTargetParam(code)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c200000004.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)~=200000005 or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c200000004.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		if c:IsRelateToEffect(e) then
			c:CancelToGrave()
			Duel.Overlay(tc,Group.FromCards(c))
		end
		tc:CompleteProcedure()
	end
	Duel.RegisterFlagEffect(tp,200000004,0,0,0)
end
