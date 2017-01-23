--Ｓｐ－オーバー・チューン
function c100100114.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100114.con)
	e1:SetCost(c100100114.cost)
	e1:SetTarget(c100100114.target)
	e1:SetOperation(c100100114.operation)
	c:RegisterEffect(e1)
end
function c100100114.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>2
end
function c100100114.cfilter(c,e,tp)
	local lv=c:GetLevel()
	return lv>0 and Duel.IsExistingMatchingCard(c100100114.filter,tp,LOCATION_HAND,0,1,nil,lv,e,tp)
end
function c100100114.filter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100100114.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c100100114.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and Duel.CheckReleaseGroup(tp,c100100114.cfilter,1,nil,e,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c100100114.cfilter,1,1,nil,e,tp)
	local lv=rg:GetFirst():GetLevel()
	Duel.Release(rg,REASON_COST)
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100100114.operation(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100100114.filter,tp,LOCATION_HAND,0,1,1,nil,lv,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
