--Rank-Down-Magic Hope Fall
function c511000225.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c511000225.target)
	e1:SetOperation(c511000225.activate)
	c:RegisterEffect(e1)
end
function c511000225.filter(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_XYZ) and c:GetPreviousControler()==tp and c:IsSetCard(0x48)
		and Duel.IsExistingMatchingCard(c511000225.sfilter,tp,LOCATION_EXTRA,0,1,nil,rk,e,tp) 
		and c:IsCanBeEffectTarget(e)
end
function c511000225.sfilter(c,rk,e,tp)
	if c.rum_limit_code then return false end
	return c:GetRank()<rk and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511000225.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and eg:IsExists(c511000225.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=eg:FilterSelect(tp,c511000225.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000225.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=Duel.SelectMatchingCard(tp,c511000225.sfilter,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank(),e,tp):GetFirst()
		if sc then
			Duel.Overlay(sc,Group.FromCards(tc))
			Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
	end
end
