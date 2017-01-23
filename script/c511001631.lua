--Revelation of Hope
function c511001631.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001631.cost)
	e1:SetTarget(c511001631.tg)
	e1:SetOperation(c511001631.op)
	c:RegisterEffect(e1)
end
function c511001631.cfilter(c,e,tp)
	return c:IsRace(RACE_DRAGON) and not c:IsType(TYPE_XYZ) and c:GetLevel()>0 and c:IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c511001631.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetLevel())
end
function c511001631.spfilter(c,e,tp,lv)
	return c:GetRank()==lv and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511001631.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001631.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001631.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001631.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local lv=g:GetFirst():GetLevel()
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001631.op(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c511001631.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv):GetFirst()
	if sc then
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
